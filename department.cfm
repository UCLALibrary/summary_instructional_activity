<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.DeptID") or not isNumeric(URL.DeptID)) {
		em = "Invalid or missing contact ID value";
	}
	else {
		DeptID = URL.DeptID;
		up2snuff = 1;
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variable for uspLookup stored procedure
		DeptID = URL.deptid;
	</cfscript>
	<cfset Lookup = "Department">
	<cfinclude template="uspGetLookup.cfm">
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfquery name="DepartmentSelected" dbtype="query">
			SELECT
				DepartmentID,
				Department
			FROM Department
			WHERE DepartmentID = <cfoutput>#DeptID#</cfoutput>
		</cfquery>
		<cfif Department.RecordCount eq 0>
			<cfset pageTitle = "No department found">
			<cfinclude template="incBegin.cfm">
			<span class="dataSectionTitle">Error!</span>
			<div class="data">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td class="first"><cfoutput>#pageTitle#</cfoutput></td>
				</tr>
			</table>
			</div>
		<cfelse>
			<cfscript>
		// initialize variables for uspGetSession stored procedure
				LibID = 0;
				SessID = 0;
				sDT = '';
				eDT = '';
				CntctID = 0;
				DeptID = DeptID;
				ActID = 0;
				LrCatID = 0;
				AffID = 0;
				QuartID = 0;
				Yr = 0;
				Hr = 0;
				UID = 0;
				FiscalY = 0;
				OutID = 0;
				ClassID = 0;
				ShowAll = 0;
			</cfscript>
			<cfinclude template="uspGetSession.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfscript>
// initialize variables for uspGetContact stored procedure
					LibID = 0;
					CntctID = 0;
					StatID = 0;
					DeptID = DepartmentSelected.DepartmentID;
					SessID = 0;
					ActID = 0;
					MatID = 0;
					UID = 0;
					sDT = '';
					eDT = '';
					FiscalY = 0;
					Set = '';
				</cfscript>
				<cfinclude template="uspGetContact.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfset pageTitle = DepartmentSelected.Department>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incSessions.cfm">
					<cfinclude template="incContacts.cfm">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">