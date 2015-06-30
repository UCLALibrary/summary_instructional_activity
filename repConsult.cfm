<cfset pageTitle = "Small Group Consultations Report">
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Small Group Consultations for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Small Group Consultations FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr>
    <th scope="col" align="left">User Category</th>
    <th scope="col" align="left">Librarian</th>
    <th scope="col" align="left">Electronic</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspConsultReport" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#fiscalYear#" null="no">
		<cfprocresult name="Classes">
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
	<cfoutput query="Classes">
		<tr>
			<td align="left">#Classes.LearnerCategory#</td>
			<td align="left">#Classes.Librarian#</td>
			<td align="left">&nbsp;</td>
			<td align="right">#Classes.Sessions#</td>
			<td align="right">#Classes.People#</td>
		</tr>
		<cfset sessionCount = sessionCount + Classes.Sessions>
		<cfset peopleCount = peopleCount + Classes.People>
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
