<cfquery name="Outreachs" datasource="#APPLICATION.dsn#">
	SELECT
		'Contact' = c.FirstName + ' ' + c.LastName,
		'Librarian' = l.FirstName + ' ' + l.LastName,
		ql.Quarter,
		Datepart(year, o.OutreachDT) AS the_year,
		CASE
			WHEN s.DepartmentID IS NULL THEN 'N/A'
			WHEN s.DepartmentID IN (196,197) THEN dl.Department + ' (' + s.other_multi_dept + ')'
			ELSE Coalesce(dl.Department, 'N/A')
		END AS Department,
		c.FacultyGroup,
		dbo.build_outcome(o.Outcome, o.OutcomeOther) AS Outcomes,
		dbo.build_method(o.Method, o.MethodOther) AS Methods,
		dbo.build_initiate(o.Initiate, o.InitiateOther) AS Initiates
	FROM
		dbo.Contact c
		LEFT JOIN dbo.LibrarianContactOutreach lco ON c.ContactID = lco.ContactID
		LEFT JOIN dbo.Librarian l ON lco.LibrarianID = l.LibrarianID
		LEFT JOIN dbo.Outreach o ON lco.OutreachID = o.OutreachID
		LEFT JOIN dbo.QuarterLookup ql ON o.QuarterID = ql.QuarterID
		LEFT JOIN dbo.DepartmentLookup dl ON o.DepartmentID = dl.DepartmentID
		LEFT JOIN dbo.SessionContact sc on c.ContactID = sc.ContactID
		LEFT JOIN dbo.Session s on sc.SessionID = s.SessionID
	WHERE
		<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
			(
				o.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year_out(o.OutreachID, o.QuarterID, #fiscalYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
			(
				o.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year_out(o.OutreachID, o.QuarterID, #FORM.FYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
			(
				o.QuarterID = #FORM.QuarterID# AND Datepart(Year, o.OutreachDT) = #FORM.CYear#
			)
		<cfelseif FORM.FYear neq 0>
			(
				(Datepart(Year, o.OutreachDT) = #FORM.FYear# AND Datepart(Month, o.OutreachDT) BETWEEN 7 AND 12)
				 OR (Datepart(Year, o.OutreachDT) = #FORM.FYear# + 1 AND Datepart(Month, o.OutreachDT) BETWEEN 1 AND 6)
			)
		<cfelseif FORM.CYear neq 0>
			(
				Datepart(Year, o.OutreachDT) = #FORM.CYear#
			)
		<cfelseif FORM.SessionDate neq "">
			o.OutreachDT between '#FORM.SessionDate# 00:00.0' and '#FORM.SessionDate# 23:59.9'
		<cfelse>
			(
				(Datepart(Year, o.OutreachDT) = #fiscalYear# AND Datepart(Month, o.OutreachDT) BETWEEN 7 AND 12)
				 OR (Datepart(Year, o.OutreachDT) = #fiscalYear# + 1 AND Datepart(Month, o.OutreachDT) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif IsDefined("FORM.OwnerID")>
			AND lco.LibrarianID = #FORM.OwnerID#
		</cfif>
		<cfif IsDefined("FORM.Presenters")>
			AND lco.LibrarianID in (#FORM.Presenters#)
		</cfif>
		<cfif IsDefined("FORM.Developers")>
			AND lco.LibrarianID in (#FORM.Developers#)
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND lco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND c.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND lco.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		c.LastName,
		c.FirstName,
		l.LastName,
		l.FirstName,
		o.QuarterID,
		o.Title
</cfquery>

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Outreach Report for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Outreach Report
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
  <tr>
    <th scope="col" align="left">Contact Name</th>
    <th scope="col" align="left">Librarian</th>
    <th scope="col" align="left">Date</th>
    <th scope="col" align="left">Department/Group</th>
    <th scope="col" align="left">Initated by</th>
    <th scope="col" align="left">Contact Method</th>
    <th scope="col" align="left">Outcome</th>
  </tr>

 <cfoutput query="Outreachs">
  <tr>
    <td align="left">#Outreachs.Contact#</td>
    <td align="left">#Outreachs.Librarian#</td>
    <td align="left">#Outreachs.the_year#&nbsp;#Outreachs.Quarter#</td>
    <td align="left">#Outreachs.Department#&nbsp;#Outreachs.FacultyGroup#</td>
    <td align="left"><cfif Outreachs.Initiates neq ''>#Outreachs.Initiates#<cfelse>&nbsp;</cfif></td>
    <td align="left"><cfif Outreachs.Methods neq ''>#Outreachs.Methods#<cfelse>&nbsp;</cfif></td>
    <td align="left"><cfif Outreachs.Outcomes neq ''>#Outreachs.Outcomes#<cfelse>&nbsp;</cfif></td>
  </tr>
 </cfoutput>
</table>