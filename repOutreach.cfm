<cfset pageTitle = "Outreach Report">
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Outreach Report for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Outreach Report FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr>
    <th scope="col" align="left">Date</th>
    <th scope="col" align="left">Department/Group</th>
    <th scope="col" align="left">Course Name</th>
    <th scope="col" align="left">Contact Name</th>
    <th scope="col" align="left">Initated by</th>
    <th scope="col" align="left">Contact Method</th>
    <th scope="col" align="left">Outcome</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspOutreachReport" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#fiscalYear#" null="no">
		<cfprocresult name="Outreachs">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>

 <cfoutput query="Outreachs">
  <tr>
    <td align="left">#Outreachs.the_year#&nbsp;#Outreachs.Quarter#</td>
    <td align="left">#Outreachs.Department#&nbsp;#Outreachs.FacultyGroup#</td>
    <td align="left">#Outreachs.Title#</td>
    <td align="left">#Outreachs.Contact#</td>
    <td align="left">#Outreachs.Initiates#</td>
    <td align="left">#Outreachs.Methods#</td>
    <td align="left">#Outreachs.Outcomes#</td>
  </tr>
 </cfoutput>
</table>

<cfinclude template="incEnd.cfm">