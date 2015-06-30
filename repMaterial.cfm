<cfset pageTitle = "Materials Report">
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Materials Report for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Materials Report FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr>
    <th scope="col" align="left">Quarter</th>
    <th scope="col" align="left">Type</th>
    <th scope="col" align="left">Title</th>
    <th scope="col" align="left">Developer</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspMaterialReport" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#fiscalYear#" null="no">
		<cfprocresult name="Materials">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>

 <cfoutput query="Materials">
  <tr>
    <td align="left">#Materials.Quarter#</td>
    <td align="left">#Materials.Type#</td>
    <td align="left">#Materials.Title#</td>
    <td align="left">#Materials.LastName#</td>
  </tr>
 </cfoutput>
</table>

<cfinclude template="incEnd.cfm">