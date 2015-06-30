<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error";
	up2snuff = 0;
	em = 'Error!';
	// check required variables
	if (not isDefined("URL.UID") or not isNumeric(URL.UID))
	{
		em = "Invalid or missing unit ID value";
	}
	else
	{
		UID = URL.UID;
		up2snuff = 1;
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
		// initialize variable for uspLookup stored procedure
		UID = UID;
	</cfscript>
	<cfset Lookup = "Unit">
	<cfinclude template="uspGetLookup.cfm">
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfquery name="UnitSelected" dbtype="query">
			SELECT
				UnitID,
				Unit
			FROM
				Unit
			WHERE
				UnitID = <cfoutput>#UID#</cfoutput>
		</cfquery>
		<cfif Unit.RecordCount eq 0>
			<cfset pageTitle = "No unit found">
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
				// initialize variables for uspGetLibrarian stored procedure
				LibID = 0;
				UID = UID;
				DeptID = 0;
				CntctID = 0;
				ActID = 0;
				SessID = 0;
				MatID = 0;
				Set = '';
				DevPres = 0;
			</cfscript>
			<cfinclude template="uspGetLibrarian.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfscript>
					// initialize variables for uspGetContact stored procedure
					LibID = 0;
					CntctID = 0;
					StatID = 0;
					DeptID = 0;
					SessID = 0;
					ActID = 0;
					MatID = 0;
					UID = UID;
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
					<cfset pageTitle = UnitSelected.UNit>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incLibrarians.cfm">
					<cfinclude template="incContacts.cfm">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">