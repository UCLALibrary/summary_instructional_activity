<cfset pageTitle = "Sponsored Classes Report">
<cfset up2snuff = 1>
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<!---cfinclude template="incBegin.cfm"--->
<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Library-Initiated Classes for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Library-Initiated Classes/Demonstrations FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr>
    <th scope="col" align="left">Name of Session (Librarian)</th>
    <th scope="col" align="left">Co-Pres</th>
    <th scope="col" align="left">Non-UC</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspClassReport" datasource="#APPLICATION.dsn#">
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

<cfif not up2snuff>
	<cfinclude template="incError.cfm">
<cfelse>
	<cfoutput query="Classes">
		<tr>
			<td align="left">#Classes.Title#&nbsp;(#Classes.Librarian#)</td>
			<td align="left"><cfif Len(Classes.CoLibs) gt 1>#Classes.CoLibs#<cfelse>&nbsp;</cfif></td>
			<td align="left"><cfif Classes.Non_UC>Yes<cfelse>&nbsp;</cfif></td>
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
</cfif>
</table>

<cfinclude template="incEnd.cfm">
