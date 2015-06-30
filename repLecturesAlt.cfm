<cfset pageTitle = "Class/Group Lectures Report">
<cfset up2snuff = 1>
<cfset fiscalYear = 0>
<!---cfmodule template="modFiscalYear.cfm" sDate = #Now()#--->
<cfset fiscalYear="2005">

<!---cfinclude template="incBegin.cfm"--->
<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Instruction to Classes/Groups for Fiscal Year">
  <caption align="center" style="font-weight:bold">
    Instruction to Classes/Groups FY <cfoutput>#fiscalYear#</cfoutput>
  </caption>
  <tr style="color: white; background-color: black;">
    <th scope="col" align="left">Unit</th>
    <th scope="col" align="left">Course Number &amp; Title: Name of Group (Faculty)</th>
    <th scope="col" align="left">Presenter(s)</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
  </tr>

<cftry>
	<cfstoredproc procedure="uspAltLectureReport" datasource="#APPLICATION.dsn#">
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
	<cfset grandSession = 0>
	<cfset grandPeople = 0>
	<cfset oldTitle = "">
	<cfset newTitle = "">
	<cfset first = 1>

	<cfoutput query="Lectures">
		<cfset newTitle=Lectures.Unit>
		<cfif newTitle neq oldTitle and sessionCount gt 0>
			<tr>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
			</tr>
			<tr class="total">
				<td align="left">subtotal</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="right">#sessionCount#</td>
				<td align="right">#peopleCount#</td>
			</tr>
			<tr>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
			</tr>
			<cfset grandSession = grandSession + sessionCount>
			<cfset grandPeople = grandPeople + peopleCount>
			<cfset sessionCount = 0>
			<cfset peopleCount = 0>
			<tr>
				<td align="left">#Lectures.Unit#</td>
		<cfelseif first>
			<tr>
				<td align="left">#Lectures.Unit#</td>
		<cfelse>
			<tr>
				<td align="left">&nbsp;</td>
		</cfif>
				<td align="left">#Lectures.Title#:&nbsp;#Lectures.GroupName#<cfif Len(Lectures.Faculty) gt 1>&nbsp;(#Lectures.Faculty#)<cfelse></cfif></td>
				<td align="left">#Lectures.Librarian#<cfif Len(Lectures.CoLibs) gt 1>&nbsp;#Lectures.CoLibs#<cfelse></cfif></td>
				<td align="right">#Lectures.Sessions#</td>
				<td align="right">#Lectures.People#</td>
			</tr>
		<cfset sessionCount = sessionCount + Lectures.Sessions>
		<cfset peopleCount = peopleCount + Lectures.People>
		<cfset first = 0>
		<cfset oldTitle = newTitle>
	</cfoutput>
	<cfset grandSession = grandSession + sessionCount>
	<cfset grandPeople = grandPeople + peopleCount>
			<tr>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
			</tr>
			<tr class="total">
				<td align="left">subtotal</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
				<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
			</tr>
			<tr>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
			</tr>
			<tr>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
			</tr>
			<tr class="total">
				<td align="left">Grand Totals</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="right"><cfoutput>#grandSession#</cfoutput></td>
				<td align="right"><cfoutput>#grandPeople#</cfoutput></td>
			</tr>

<cfinclude template="incEnd.cfm">
