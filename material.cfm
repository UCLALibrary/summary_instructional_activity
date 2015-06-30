<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.MatID") or not isNumeric(URL.MatID))
	{
		em = "Invalid or missing parameters";
	}
	else
	{
		MatID = URL.MatID;
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variables for uspGetMaterial stored procedure
		MatID = MatID;
		MatTypID = 0;
		LibID = 0;
		ActID = 0;
		CntctID = 0;
		UID = 0;
		sDT = '';
		eDT = '';
		QuartID = 0;
		Yr = 0;
		FiscalY = 0;
		Set = "";
	</cfscript>
	<cfinclude template="uspGetMaterial.cfm">
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfif Material.RecordCount eq 0>
			<cfinclude template="incMaterial.cfm">
		<cfelse>
			<cfscript>
// initialize variables for uspGetContact stored procedure
				LibID = 0;
				CntctID = 0;
				StatID = 0;
				DeptID = 0;
				SessID = 0;
				ActID = 0;
				MatID = MatID;
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
				<cfscript>
// initialize variables for uspGetActivity stored procedure
					LibID = 0;
					ActID = 0;
					ActTypID = 0;
					DelModID = 0;
					MatID = URL.MatID;
					CntctID = 0;
					DBRCID = 0;
					UID = 0;
					sDT = '';
					eDT = '';
					QuartID = 0;
					Yr = 0;
					FiscalY = 0;
				</cfscript>
				<cfinclude template="uspGetActivity.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfscript>
	// initialize variables for uspGetMatSess stored procedure
						MatID = URL.MatID;
					</cfscript>
					<cfinclude template="uspGetMatSess.cfm">
					<cfif not up2snuff>
						<cfinclude template="incBegin.cfm">
						<cfinclude template="incError.cfm">
					<cfelse>
						<cfscript>
	// initialize variables for uspCheckRelationships stored procedure
							LibID = SESSION.LibID;
							CntctID = 0;
							ActID = 0;
							SessID = 0;
							MatID = MatID;
							ClassID = 0;
						</cfscript>
						<cfinclude template="uspCheckRelationships.cfm">
						<cfif not up2snuff>
							<cfinclude template="incBegin.cfm">
							<cfinclude template="incError.cfm">
						<cfelse>
							<cfinclude template="incMaterial.cfm">
							<cfinclude template="incMatSess.cfm">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">
<!---
--->
						<!---cfinclude template="incActivities.cfm"--->
