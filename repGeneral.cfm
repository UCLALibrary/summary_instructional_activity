<cfset pageTitle = "Coordinators Report">
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<!---cfinclude template="incBegin.cfm"--->
<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Instruction Coordinators Report for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Instruction Coordinators Report FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr>
    <th scope="col" align="left">Quarter</th>
    <th scope="col" align="left">Title</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspGeneralReport" datasource="#APPLICATION.dsn#">
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
    <td align="left">#Tours.Quarter#</td>
    <td align="left">#Tours.Title#</td>
    <td align="right">#Tours.Sessions#</td>
    <td align="right">#Tours.People#</td>
  </tr>
  <cfset sessionCount = sessionCount + Tours.Sessions>
  <cfset peopleCount = peopleCount + Tours.People>
 </cfoutput>
  <tr style="font-weight:bold">
    <td align="left">Totals</td>
    <td align="left">&nbsp;</td>
    <td align="right"><cfoutput>#sessionCount#</cfoutput></td>
    <td align="right"><cfoutput>#peopleCount#</cfoutput></td>
  </tr>
</table>

<cfinclude template="incEnd.cfm">
