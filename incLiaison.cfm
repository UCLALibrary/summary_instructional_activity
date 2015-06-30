<cfset colSpan = 5>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>

<cfquery name="Liaison" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		a.Title,
		u.Unit,
		Coalesce(s.GroupName, 'N/A') AS GroupName,
		dbo.get_presenters_by_session(s.SessionID) AS CoLibs,
		dbo.total_sessions(s.SessionID) AS Sessions,
		dbo.count_attendees_by_session(s.SessionID) AS People,
		Coalesce(dbo.total_duration(s.SessionID), 0) AS Duration,
		dbo.get_display_time((Coalesce(dbo.total_duration(s.SessionID), 0))) AS display_dur,
		Coalesce(dbo.total_prep_time(s.SessionID), 0) AS PrepTime,
		dbo.get_display_time((Coalesce(dbo.total_prep_time(s.SessionID), 0))) AS display_prep
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID
		LEFT JOIN dbo.UnitLookup u ON sl.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
	WHERE
		a.ActivityTypeID = 6
		<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year(s.SessionID, s.QuarterID, #fiscalYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year(s.SessionID, s.QuarterID, #FORM.FYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND Datepart(Year, s.SessionDateTime) = #FORM.CYear#
			)
		<cfelseif FORM.FYear neq 0>
			AND
			(
				(Datepart(Year, s.SessionDateTime) = #FORM.FYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
				 OR (Datepart(Year, s.SessionDateTime) = #FORM.FYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		<cfelseif FORM.CYear neq 0>
			AND
			(
				Datepart(Year, s.SessionDateTime) = #FORM.CYear#
			)
		<cfelseif FORM.SessionDate neq "">
			AND s.SessionDateTime between '#FORM.SessionDate# 00:00.0' and '#FORM.SessionDate# 23:59.9'
		<cfelse>
			AND
			(
				(Datepart(Year, s.SessionDateTime) = #fiscalYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
				 OR (Datepart(Year, s.SessionDateTime) = #fiscalYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif FORM.OwnerID neq 0>
			AND sl.LibrarianID = #FORM.OwnerID#
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.ClassID neq 0>
			AND scl.ClassroomID = #FORM.ClassID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif FORM.LearnerCategoryID neq 0>
			AND s.LearnerCategoryID = #FORM.LearnerCategoryID#
		</cfif>
		<cfif FORM.AffiliationID neq 0>
			AND s.AffiliationID = #FORM.AffiliationID#
		</cfif>
		<cfif IsDefined("FORM.DeliveryModes") and FORM.DeliveryModes neq "">
			AND (a.DeliveryModes like '%#ListFirst(FORM.DeliveryModes,",")#%'
			<cfloop index="delivID" list="#ListRest(FORM.DeliveryModes,',')#" delimiters=",">
				OR a.DeliveryModes like '%#delivID#%'
			</cfloop>
			)
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND sl.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		u.Unit,
		a.Title,
		GroupName
</cfquery>

<cfset sessionCount = 0>
<cfset peopleCount = 0>
<cfset durCount = 0>
<cfset prepCount = 0>
<cfset grandSession = 0>
<cfset grandPeople = 0>
<cfset grandDur = 0>
<cfset grandPrep = 0>
<cfset oldTitle = "">
<cfset newTitle = "">
<cfset first = 1>

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Individual Liaisons for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Liaisons
    <cfoutput>
		<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
			<cfif FORM.QuarterID eq 1>Fall</cfif>
			<cfif FORM.QuarterID eq 2>Winter</cfif>
			<cfif FORM.QuarterID eq 3>Spring</cfif>
			<cfif FORM.QuarterID eq 4>Summer</cfif>
			&nbsp;FY&nbsp;#fiscalYear#/#fiscalYear + 1#
		<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
			<cfif FORM.QuarterID eq 1>Fall</cfif>
			<cfif FORM.QuarterID eq 2>Winter</cfif>
			<cfif FORM.QuarterID eq 3>Spring</cfif>
			<cfif FORM.QuarterID eq 4>Summer</cfif>
			&nbsp;FY&nbsp;#FORM.FYear#/#FORM.FYear + 1#
		<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
			<cfif FORM.QuarterID eq 1>Fall</cfif>
			<cfif FORM.QuarterID eq 2>Winter</cfif>
			<cfif FORM.QuarterID eq 3>Spring</cfif>
			<cfif FORM.QuarterID eq 4>Summer</cfif>
			&nbsp;#FORM.CYear#
		<cfelseif FORM.FYear neq 0>
			&nbsp;FY&nbsp;#FORM.FYear#/#FORM.FYear + 1#
		<cfelseif FORM.CYear neq 0>
			&nbsp;#FORM.CYear#
		<cfelseif FORM.SessionDate neq "">
			&nbsp;#FORM.SessionDate#
		<cfelse>
			&nbsp;FY&nbsp;#fiscalYear#/#fiscalYear + 1#
		</cfif>
    </cfoutput>
  </caption>
  <tr style="color: white; background-color: black;">
    <th scope="col" align="left">Unit</th>
    <th scope="col" align="left">Course Number &amp; Title: Name of Group</th>
    <th scope="col" align="left">Presenter(s)</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
	<cfif FORM.Duration>
		<th scope="col" align="right" nowrap>Duration</th>
	</cfif>
	<cfif FORM.PrepTime>
		<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
	</cfif>
  </tr>

	<cfoutput query="Liaison">
		<cfset newTitle=Liaison.Unit>
		<cfif newTitle neq oldTitle and sessionCount gt 0>
			<tr>
				<td align="left" colspan="#colSpan#">&nbsp;</td>
			</tr>
			<tr class="total">
				<td align="left">subtotal</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="right">#sessionCount#</td>
				<td align="right">#peopleCount#</td>
				<cfif FORM.Duration>
					<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
				</cfif>
				<cfif FORM.PrepTime>
					<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
				</cfif>
			</tr>
			<tr>
				<td align="left" colspan="#colSpan#">&nbsp;</td>
			</tr>
			<cfset grandSession = grandSession + sessionCount>
			<cfset grandPeople = grandPeople + peopleCount>
			<cfset grandDur = grandDur + durCount>
			<cfset grandPrep = grandPrep + prepCount>
			<cfset sessionCount = 0>
			<cfset peopleCount = 0>
			<cfset durCount = 0>
			<cfset prepCount = 0>
			<tr>
				<td align="left">#Liaison.Unit#</td>
		<cfelseif first>
			<tr>
				<td align="left">#Liaison.Unit#</td>
		<cfelse>
			<tr>
				<td align="left">&nbsp;</td>
		</cfif>
				<td align="left">#Liaison.Title#:&nbsp;#Liaison.GroupName#</td>
				<td align="left">#Liaison.CoLibs#</td>
				<td align="right">#Liaison.Sessions#</td>
				<td align="right">#Liaison.People#</td>
				<cfif FORM.Duration>
					<td align="right">#Liaison.display_dur#</th>
				</cfif>
				<cfif FORM.PrepTime>
					<td align="right">#Liaison.display_prep#</th>
				</cfif>
			</tr>
		<cfset sessionCount = sessionCount + Liaison.Sessions>
		<cfset peopleCount = peopleCount + Liaison.People>
		<cfset durCount = durCount + Liaison.Duration>
		<cfset prepCount = prepCount + Liaison.PrepTime>
		<cfset first = 0>
		<cfset oldTitle = newTitle>
	</cfoutput>
	<cfset grandSession = grandSession + sessionCount>
	<cfset grandPeople = grandPeople + peopleCount>
	<cfset grandDur = grandDur + durCount>
	<cfset grandPrep = grandPrep + prepCount>
	<cfoutput>
		<tr>
			<td align="left" colspan="#colSpan#">&nbsp;</td>
		</tr>
		<tr class="total">
			<td align="left">subtotal</td>
			<td align="left">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td align="right">#sessionCount#</td>
			<td align="right">#peopleCount#</td>
			<cfif FORM.Duration>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
			</cfif>
		</tr>
		<tr>
			<td align="left" colspan="#colSpan#">&nbsp;</td>
		</tr>
		<tr>
			<td align="left" colspan="#colSpan#">&nbsp;</td>
		</tr>
		<tr class="total">
			<td align="left">Grand Totals</td>
			<td align="left">&nbsp;</td>
			<td align="left">&nbsp;</td>
			<td align="right">#grandSession#</td>
			<td align="right">#grandPeople#</td>
			<cfif FORM.Duration>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#grandDur#></td>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#grandPrep#></td>
			</cfif>
		</tr>
	</cfoutput>
</table>
