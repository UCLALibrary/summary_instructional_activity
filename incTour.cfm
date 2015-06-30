<cfset colSpan = 6>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<cfquery name="Units" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		u.Unit,
		u.UnitID
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID --AND s.CreatedBy = sl.LibrarianID
		LEFT JOIN dbo.ActivityLibrarian al ON a.ActivityID = al.ActivityID
		LEFT JOIN dbo.Librarian l ON s.CreatedBy = l.LibrarianID
		LEFT JOIN dbo.UnitLookup u ON l.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
		LEFT JOIN dbo.SessionLearner slR ON s.SessionID = slR.SessionID
	WHERE
		a.ActivityTypeID = 1
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
		<cfif IsDefined("FORM.OwnerID")>
			AND s.CreatedBy = #FORM.OwnerID#
		</cfif>
		<cfif IsDefined("FORM.Presenters")>
			AND sl.LibrarianID in (#FORM.Presenters#)
		</cfif>
		<cfif IsDefined("FORM.Developers")>
			AND al.LibrarianID in (#FORM.Developers#)
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif IsDefined("FORM.LearnerCategoryID")>
			AND slR.LearnerCategoryID IN (#FORM.LearnerCategoryID#)
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
			AND l.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		u.Unit
</cfquery>

<cfset grandSession = 0>
<cfset grandPeople = 0>
<cfset grandDur = 0>
<cfset grandPrep = 0>

<table width="98%" summary="Orientations & Tours from SIA">
	<caption align="center" style="font-weight:bold">
		Orientations & Tours
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
</table>

<cfoutput query="Units">
	<cfset sessionCount = 0>
	<cfset peopleCount = 0>
	<cfset durCount = 0>
	<cfset prepCount = 0>

	<cfquery name="Tours" datasource="#APPLICATION.dsn#">
		SELECT DISTINCT
			a.Title,
			Coalesce(s.GroupName, 'N/A') AS GroupName,
			dbo.get_librarians_by_activity(a.ActivityID) AS Librarian,
			dbo.get_developers_by_session(a.ActivityID) AS Developers,
			dbo.get_presenters_by_session(s.SessionID) AS Presenters,
			s.FeedbackText,
			dbo.total_sessions(s.SessionID) AS Sessions,
			dbo.count_attendees_by_session(s.SessionID) AS People,
			dbo.build_learner_cats(S.SessionID) AS Learners,
			Coalesce(dbo.total_duration(s.SessionID), 0) AS Duration,
			dbo.get_display_time((Coalesce(dbo.total_duration(s.SessionID), 0))) AS display_dur,
			Coalesce(dbo.total_prep_time(s.SessionID), 0) AS PrepTime,
			dbo.get_display_time((Coalesce(dbo.total_prep_time(s.SessionID), 0))) AS display_prep
		FROM
			dbo.Activity a
			JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
			JOIN dbo.Session s ON sa.SessionID = s.SessionID
			LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID --AND s.CreatedBy = sl.LibrarianID
			LEFT JOIN dbo.ActivityLibrarian al ON a.ActivityID = al.ActivityID
			LEFT JOIN dbo.Librarian l ON s.CreatedBy = l.LibrarianID
			LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
			LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
			LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
			LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
			LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
			LEFT JOIN dbo.SessionLearner slR ON s.SessionID = slR.SessionID
		WHERE
			a.ActivityTypeID = 1
			AND l.UnitID = #Units.UnitID#
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
			<cfif IsDefined("FORM.OwnerID")>
				AND s.CreatedBy = #FORM.OwnerID#
			</cfif>
			<cfif IsDefined("FORM.Presenters")>
				AND sl.LibrarianID in (#FORM.Presenters#)
			</cfif>
			<cfif IsDefined("FORM.Developers")>
				AND al.LibrarianID in (#FORM.Developers#)
			</cfif>
			<cfif FORM.CntctID neq 0>
				AND sco.ContactID = #FORM.CntctID#
			</cfif>
			<cfif FORM.DepartmentID neq 0>
				AND s.DepartmentID = #FORM.DepartmentID#
			</cfif>
			<cfif IsDefined("FORM.LearnerCategoryID")>
				AND slR.LearnerCategoryID IN (#FORM.LearnerCategoryID#)
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
			<cfif FORM.FacultyGroup neq "">
				AND c.FacultyGroup = '#FORM.FacultyGroup#'
			</cfif>
		ORDER BY
			a.Title,
			GroupName
	</cfquery>

	<h3>#Units.Unit#</h3>
	<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Orientations & Tours for #Units.Unit#">
		<tr style="color: white; background-color: black;">
			<th scope="col" align="left">Course: Group Name</th>
			<th scope="col" align="left">Presenter(s)</th>
			<th scope="col" align="left">Developer(s)</th>
			<th scope="col" align="left">Learner Category</th>
			<th scope="col" align="right">Sessions</th>
			<th scope="col" align="right">People</th>
			<cfif FORM.Duration>
				<th scope="col" align="right" nowrap>Duration</th>
			</cfif>
			<cfif FORM.PrepTime>
				<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
			</cfif>
		</tr>
		<cfloop query="Tours">
			<tr>
				<td align="left">#Tours.Title#:&nbsp;#Tours.GroupName#</td>
				<td align="left">#Tours.Presenters#</td>
				<td align="left">#Tours.Developers#</td>
				<td align="left">#Tours.Learners#</td>
				<td align="right">#Tours.Sessions#</td>
				<td align="right">#Tours.People#</td>
				<cfif FORM.Duration>
					<td align="right">#Tours.display_dur#</th>
				</cfif>
				<cfif FORM.PrepTime>
					<td align="right">#Tours.display_prep#</th>
				</cfif>
			</tr>
			<cfif FORM.Feedback>
				<tr>
					<td align="left">Evaluation/Feedback</td>
					<td align="left" colspan="#feedSpan#">#Tours.FeedbackText#</td>
				</tr>
			</cfif>
			<cfset sessionCount = sessionCount + Tours.Sessions>
			<cfset peopleCount = peopleCount + Tours.People>
			<cfset durCount = durCount + Tours.Duration>
			<cfset prepCount = prepCount + Tours.PrepTime>
		</cfloop>
		<tr>
			<td align="left" colspan="#colSpan#">&nbsp;</td>
		</tr>
		<tr class="total">
			<td align="left">subtotal</td>
			<td align="left">&nbsp;</td>
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
	</table>
	<cfset grandSession = grandSession + sessionCount>
	<cfset grandPeople = grandPeople + peopleCount>
	<cfset grandDur = grandDur + durCount>
	<cfset grandPrep = grandPrep + prepCount>
</cfoutput>
<br/><br/>
<cfoutput>
	<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Orientations & Tours Grand Totals">
		<caption align="center" style="font-weight:bold">Grand Totals</caption>
		<tr style="color: white; background-color: black;">
			<th scope="col" align="left">Sessions</th>
			<th scope="col" align="left">People</th>
			<cfif FORM.Duration>
				<th scope="col" align="left">Duration</th>
			</cfif>
			<cfif FORM.PrepTime>
				<th scope="col" align="left">Dev/Prep. Time</th>
			</cfif>
		</tr>
		<tr class="total">
			<td align="right">#grandSession#</td>
			<td align="right">#grandPeople#</td>
			<cfif FORM.Duration>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#grandDur#></td>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#grandPrep#></td>
			</cfif>
		</tr>
	</table>
</cfoutput>
