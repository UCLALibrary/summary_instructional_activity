<cfquery name="Materials" datasource="#APPLICATION.dsn#">
	SELECT
		ql.Quarter,
		mtl.MaterialType AS Type,
		m.Title,
		l.LastName
	FROM
		dbo.Material m
		JOIN dbo.MaterialTypeLookup mtl ON m.MaterialTypeID = mtl.MaterialTypeID
		JOIN dbo.QuarterLookup ql ON m.QuarterID = ql.QuarterID
		JOIN dbo.MaterialLibrarian ml ON m.MaterialID = ml.MaterialID AND m.CreatedBy = ml.LibrarianID
		JOIN dbo.Librarian l ON ml.LibrarianID = l.LibrarianID
		LEFT JOIN dbo.MaterialContact mc ON m.MaterialID = mc.MaterialID
		LEFT JOIN dbo.Contact c ON mc.ContactID = c.ContactID
	WHERE
		<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
			(
				m.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year_mat(m.MaterialID, m.QuarterID, #fiscalYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
			(
				m.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year_mat(m.MaterialID, m.QuarterID, #FORM.FYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
			(
				m.QuarterID = #FORM.QuarterID# AND Datepart(Year, m.CompletionDT) = #FORM.CYear#
			)
		<cfelseif FORM.FYear neq 0>
			(
				(Datepart(Year, m.CompletionDT) = #FORM.FYear# AND Datepart(Month, m.CompletionDT) BETWEEN 7 AND 12)
				 OR (Datepart(Year, m.CompletionDT) = #FORM.FYear# + 1 AND Datepart(Month, m.CompletionDT) BETWEEN 1 AND 6)
			)
		<cfelseif FORM.CYear neq 0>
			(
				Datepart(Year, m.CompletionDT) = #FORM.CYear#
			)
		<cfelseif FORM.SessionDate neq "">
			m.CompletionDT between '#FORM.SessionDate# 00:00.0' and '#FORM.SessionDate# 23:59.9'
		<cfelse>
			(
				(Datepart(Year, m.CompletionDT) = #fiscalYear# AND Datepart(Month, m.CompletionDT) BETWEEN 7 AND 12)
				 OR (Datepart(Year, m.CompletionDT) = #fiscalYear# + 1 AND Datepart(Month, m.CompletionDT) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND mc.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND c.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif IsDefined("FORM.Developers")>
			AND l.LibrarianID in (#FORM.Developers#)
		</cfif>
	ORDER BY
		m.QuarterID,
		l.LastName,
		m.Title
</cfquery>

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Materials Report for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Materials Report
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
    <th scope="col" align="left">Quarter</th>
    <th scope="col" align="left">Type</th>
    <th scope="col" align="left">Title</th>
    <th scope="col" align="left">Developer</th>
  </tr>

 <cfoutput query="Materials">
  <tr>
    <td align="left">#Materials.Quarter#</td>
    <td align="left">#Materials.Type#</td>
    <td align="left">#Materials.Title#</td>
    <td align="left">#Materials.LastName#</td>
  </tr>
 </cfoutput>
</table>