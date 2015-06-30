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
