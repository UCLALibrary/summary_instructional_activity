<cfset pageTitle = "Class/Group Lectures Report">
<cfset up2snuff = 1>
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<!---cfinclude template="incBegin.cfm"--->
<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Instruction to Classes/Groups for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Instruction to Classes/Groups FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr>
    <th scope="col" align="left">Course Number &amp; Title (Name of Group) (Librarian)</th>
    <th scope="col" align="left">Faculty</th>
    <th scope="col" align="left">Format</th>
    <th scope="col" align="left">Co-Pres</th>
    <th scope="col" align="right">Non-UC</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspLectureReport" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#fiscalYear#" null="no">
		<cfprocresult name="Lectures">
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
	<cfoutput query="Lectures">
		<tr>
			<td align="left">#Lectures.Title#&nbsp;(#Lectures.GroupName#)&nbsp;(#Lectures.Librarian#)</td>
			<td align="left"><cfif Len(Lectures.Faculty) gt 1>#Lectures.Faculty#<cfelse>&nbsp;</cfif></td>
			<td align="left">#Lectures.DeliveryMode#</td>
			<td align="left"><cfif Len(Lectures.CoLibs) gt 1>#Lectures.CoLibs#<cfelse>&nbsp;</cfif></td>
			<td align="left"><cfif Lectures.Non_UC>Yes<cfelse>&nbsp;</cfif></td>
			<td align="right">#Lectures.Sessions#</td>
			<td align="right">#Lectures.People#</td>
		</tr>
		<cfset sessionCount = sessionCount + Lectures.Sessions>
		<cfset peopleCount = peopleCount + Lectures.People>
	</cfoutput>
	<tr style="font-weight:bold">
		<td align="left">Totals</td>
		<td align="left">&nbsp;</td>
		<td align="left">&nbsp;</td>
		<td align="left">&nbsp;</td>
		<td align="left">&nbsp;</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
	</tr>
</cfif>
</table>

<cfinclude template="incEnd.cfm">
