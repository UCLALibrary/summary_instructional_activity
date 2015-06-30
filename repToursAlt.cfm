<cfset pageTitle = "Orientations/Tours Report">
<cfset fiscalYear = 0>
<!---cfmodule template="modFiscalYear.cfm" sDate = #Now()#--->
<cfset fiscalYear="2005">
<cfinclude template="incBeginReport.cfm">

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Orientations & Tours for Fiscal Year">
	<caption align="center" style="font-weight:bold">
		Orientations & Tours FY <cfoutput>#fiscalYear#</cfoutput>
	</caption>
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Unit</th>
		<th scope="col" align="left">Course: Group Name</th>
		<th scope="col" align="left">Presenter(s)</th>
		<th scope="col" align="right">Sessions</th>
		<th scope="col" align="right">People</th>
	</tr>

	<cftry>
		<cfstoredproc procedure="uspAltTourReport" datasource="#APPLICATION.dsn#">
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
	<cfset grandSession = 0>
	<cfset grandPeople = 0>
	<cfset oldTitle = "">
	<cfset newTitle = "">
	<cfset first = 1>

	<cfoutput query="Tours">
		<cfset newTitle=Tours.Unit>
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
				<td align="left">#Tours.Unit#</td>
		<cfelseif first>
			<tr>
				<td align="left">#Tours.Unit#</td>
		<cfelse>
			<tr>
				<td align="left">&nbsp;</td>
		</cfif>
				<td align="left">#Tours.Title#:&nbsp;#Tours.GroupName#</td>
				<td align="left">#Tours.Librarian#<cfif Len(Tours.CoLibs) gt 1>&nbsp;#Tours.CoLibs#<cfelse></cfif></td>
				<td align="right">#Tours.Sessions#</td>
				<td align="right">#Tours.People#</td>
			</tr>
		<cfset sessionCount = sessionCount + Tours.Sessions>
		<cfset peopleCount = peopleCount + Tours.People>
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
</table>

<cfinclude template="incEnd.cfm">