<cfscript>
	if ( IsDefined("FORM.submit") ) {
		m_start_date = FORM.start_date;
		m_end_date = FORM.end_date;
		m_query = true;
	}
	else {
		// either Reset was submitted, or didn't come to page through form
		// make sure variables are defined and initialized
		m_start_date = "";
		m_end_date = "";
		m_query = false;
	}
</cfscript>

<!--begin main content-->
<h1>Export Data</h1>

<p>Export all data into Excel.  Note that this can be quite slow, depending on the date range requested.</p>
<p>Start and end dates must be entered as <code>yyyy-mm-dd</code> format.  Dates are inclusive: 2016-01-01 to 2016-01-31 will get all data for January 2016,
while 2016-07-01 to 2016-07-01 will get data for July 1 2016 only.</p>
<p>Data is exported in Excel's HTML/MHTML format.  This may be sufficient but if not, you will need to use Excel's "Save as..." menu option to convert to true Excel format.</p>

<form name="reports" id="reports" action="export.cfm" method="post">
	<label for="start_date">Start date: </label>
	<!--- HTML input type=date not yet widely supported  in browsers 20160920 akohler --->
	<input type="text" name="start_date" id="start_date" placeholder="YYYY-MM-DD">
	<label for="end_date">End date: </label>
	<input type="text" name="end_date" id="end_date" placeholder="YYYY-MM-DD">
	<input name="submit" id="submit" type="submit" value="Get data">
</form>

<cfif m_query eq true>
	<cfinclude template="queryExportAllData.cfm">
	<!---<cfdump var="#qryExportAllData#">--->
	<!--- This could be done with cfspreadsheet in CF9... but local unitdev is CF8 only --->
	<cfsetting enablecfoutputonly="Yes">
	<cfsavecontent variable="ExcelExport">
	<cfoutput>
		<table>
			<tr>
				<th>SessionDateTime</th>
				<th>SessionType</th>
				<th>Title</th>
				<th>Departments</th>
				<th>CourseNumber</th>
				<th>CourseSection</th>
				<th>GroupName</th>
				<th>Description</th>
				<th>LearnerTypes</th>
				<th>LearnerCount</th>
				<th>SessionCount</th>
				<th>Duration</th>
				<th>Developers</th>
				<th>DeveloperUnits</th>
				<th>Presenters</th>
				<th>PresenterUnits</th>
				<th>FacContacts</th>
				<th>FacEmails</th>
				<th>Initiatives</th>
			</tr>
		<cfloop query="qryExportAllData">
			<tr>
				<td>#SessionDateTime#</td>
				<td>#SessionType#</td>
				<td>#Title#</td>
				<td>#Departments#</td>
				<td>#CourseNumber#</td>
				<td>#CourseSection#</td>
				<td>#GroupName#</td>
				<td>#Description#</td>
				<td>#LearnerTypes#</td>
				<td>#LearnerCount#</td>
				<td>#SessionCount#</td>
				<td>#Duration#</td>
				<td>#Developers#</td>
				<td>#DeveloperUnits#</td>
				<td>#Presenters#</td>
				<td>#PresenterUnits#</td>
				<td>#FacContacts#</td>
				<td>#FacEmails#</td>
				<td>#Initiatives#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
	</cfsavecontent>
	<!--- Datestamp for export filename ... DateTimeFormat added CF9+...--->
	<cfset m_export_filename = "export_" & DateFormat(Now(), "yyyymmdd") & "_" & TimeFormat(Now(), "HHmmss") & ".xls">
	<cfcontent type="application/vnd.msexcel">
	<cfheader name="Content-Disposition" value="inline; filename=#m_export_filename#">
	<cfoutput>#ExcelExport#</cfoutput>
</cfif>
