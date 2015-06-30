<cfset pageTitle = "Orientations/Tours Report">
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<!---cfinclude template="incBegin.cfm"--->
<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Orientations & Tours for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Orientations & Tours FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr>
    <th scope="col" align="left">Group Name (Librarian)</th>
    <th scope="col" align="left">Co-Pres</th>
    <th scope="col" align="left">Non-UC</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspTourReport" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#fiscalYear#" null="no">
		<cfprocresult name="Tours">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>

 <cfset sessionCount = 0>
 <cfset peopleCount = 0>

 <cfoutput query="Tours">
  <tr>
    <td align="left">#Tours.GroupName#&nbsp;(#Tours.Librarian#)</td>
    <td align="left"><cfif Len(Tours.CoLibs) gt 1>#Tours.CoLibs#<cfelse>&nbsp;</cfif></td>
    <td align="left"><cfif Tours.Non_UC>Yes<cfelse>&nbsp;</cfif></td>
    <td align="right">#Tours.Sessions#</td>
    <td align="right">#Tours.People#</td>
  </tr>
  <cfset sessionCount = sessionCount + Tours.Sessions>
  <cfset peopleCount = peopleCount + Tours.People>
 </cfoutput>
  <tr style="font-weight:bold">
    <td align="left">Totals</td>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="right"><cfoutput>#sessionCount#</cfoutput></td>
    <td align="right"><cfoutput>#peopleCount#</cfoutput></td>
  </tr>
</table>

<cfinclude template="incEnd.cfm">
<!---

possible report filters:
	librarian [sl.LibrarianID] (required for level 1, optional otherwise)
	contact [sco.ContactID]
	classroom [scl.ClassroomID]
	quarter/year [s.QuarterID,s.SessionDateTime]
	date [s.SessionDateTime]
	department [s.DepartmentID]
	learner category [s.LearnerCategoryID]
	affiliation [s.AffiliationID]
	activity type [a.ActivityTypeID]
	delivery mode [a.DeliveryModeID]
	material type [m.MaterialTypeID]

SELECT DISTINCT
	a.ActivityID,
	a.Title,
	Coalesce(s.GroupName, 'N/A') AS GroupName,
	dbo.get_librarians_by_group(a.ActivityID, s.GroupName) AS Librarian,
	dbo.get_copresenters_by_group(a.ActivityID, s.GroupName) AS CoLibs,
	'Non_UC' =
		CASE
			WHEN s.AffiliationID = 3 THEN 1
			ELSE 0
		END,
	dbo.count_sessions_by_group(a.ActivityID, s.GroupName) AS Sessions,
	dbo.count_attendees_by_group(a.ActivityID, s.GroupName) AS People
FROM
	dbo.Activity a
	JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
	JOIN dbo.Session s ON sa.SessionID = s.SessionID
	LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID
	LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
	LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
	LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
	LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
WHERE
	a.ActivityTypeID = 1
	AND
	(
		(DATEPART(year, s.SessionDateTime) = @FiscalY AND DATEPART(month, s.SessionDateTime) BETWEEN 7 AND 12)
		 OR (DATEPART(year, s.SessionDateTime) = @FiscalY + 1 AND DATEPART(month, s.SessionDateTime) BETWEEN 1 AND 6)
	)
	AND sl.LibrarianID = @LibID
	--if contact
	AND sco.ContactID = @CnctID
	--if classroom
	AND scl.ClassroomID = @ClassID
	--if

ORDER BY
	s.GroupName

--->