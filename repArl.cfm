<cfset pageTitle = "ARL Report">
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>

<cfinclude template="incBeginReport.cfm">

<span class="formSectionTitle">ARL Report FY <cfoutput>#fiscalYear#</cfoutput></span>

<!-- orientations/tours -->
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Orientations & Tours for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Orientations & Tours
  </caption>
  <tr>
    <th scope="col" align="left">Group Name</th>
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
    <td align="left">#Tours.GroupName#</td>
    <td align="right">#Tours.Sessions#</td>
    <td align="right">#Tours.People#</td>
  </tr>
  <cfset sessionCount = sessionCount + Tours.Sessions>
  <cfset peopleCount = peopleCount + Tours.People>
 </cfoutput>
  <tr style="font-weight:bold">
    <td align="left">Totals</td>
    <td align="right"><cfoutput>#sessionCount#</cfoutput></td>
    <td align="right"><cfoutput>#peopleCount#</cfoutput></td>
  </tr>
</table>

<!-- classes/groups -->
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Instruction to Classes/Groups for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Instruction to Classes/Groups
  </caption>
  <tr>
    <th scope="col" align="left">Course Number &amp; Title (Name of Group)</th>
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

<cfoutput query="Lectures">
	<tr>
		<td align="left">#Lectures.Title#&nbsp;(#Lectures.GroupName#)</td>
		<td align="right">#Lectures.Sessions#</td>
		<td align="right">#Lectures.People#</td>
	</tr>
	<cfset sessionCount = sessionCount + Lectures.Sessions>
	<cfset peopleCount = peopleCount + Lectures.People>
</cfoutput>
<tr style="font-weight:bold">
	<td align="left">Totals</td>
	<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
	<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
</tr>
</table>

<!-- smal groups -->
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Small Group Consultations for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Small Group Consultations
  </caption>
  <tr>
    <th scope="col" align="left">Lecture Title</th>
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
			<td align="left">#Classes.Title#</td>
			<td align="right">#Classes.Sessions#</td>
			<td align="right">#Classes.People#</td>
		</tr>
		<cfset sessionCount = sessionCount + Classes.Sessions>
		<cfset peopleCount = peopleCount + Classes.People>
	</cfoutput>

	<tr style="font-weight:bold">
		<td align="left">Totals</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
	</tr>
</table>

<cfinclude template="incEnd.cfm">
