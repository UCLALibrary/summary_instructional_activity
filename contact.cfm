<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.CntctID") or not isNumeric(URL.CntctID)) {
		em = "Invalid or missing contact ID value";
	}
	else {
		CntctID = URL.CntctID;
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variables for uspGetContact stored procedure
		LibID = 0;
		CntctID = CntctID;
		StatID = 0;
		DeptID = 0;
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
		<cfif Contact.RecordCount eq 0>
			<cfinclude template="incContact.cfm">
		<cfelse>
			<cfscript>
// initialize variables for uspGetOutreach stored procedure
				OutID = 0;
				LibID = 0;
				CntctID = CntctID;
				DeptID = 0;
				StatID = 0;
				UID = 0;
				sDT = '';
				eDT = '';
				FiscalY = 0;
			</cfscript>
			<cfinclude template="uspGetOutreach.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfscript>
// initialize variables for uspGetSession stored procedure
					LibID = 0;
					SessID = 0;
					sDT = "";
					eDT = "";
					CntctID = Contact.ContactID;
					DeptID = 0;
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
// initialize variables for uspGetActivity stored procedure
						LibID = 0;
						ActID = 0;
						ActTypID = 0;
						DelModID = 0;
						MatID = 0;
						CntctID = Contact.ContactID;
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
// initialize variables for uspGetMaterial stored procedure
							MatID = 0;
							MatTypID = 0;
							LibID = 0;
							ActID = 0;
							CntctID = CntctID;
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
							<cfscript>
// initialize variables for uspCheckRelationships stored procedure
								LibID = SESSION.LibID;
								CntctID = CntctID;
								ActID = 0;
								SessID = 0;
								MatID = 0;
								ClassID = 0;
							</cfscript>
							<cfinclude template="uspCheckRelationships.cfm">
							<cfif not up2snuff>
								<cfinclude template="incBegin.cfm">
								<cfinclude template="incError.cfm">
							<cfelse>
								<cfinclude template="incContact.cfm">
								<cfinclude template="incOutreach.cfm">
								<cfif Sess.RecordCount neq 0>
									<cfinclude template="incSessions.cfm">
								</cfif>
								<!---cfif Activity.RecordCount neq 0>
									<cfinclude template="incActivities.cfm">
								</cfif--->
								<cfif Material.RecordCount neq 0>
									<cfinclude template="incMaterials.cfm">
								</cfif>
							</cfif>
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">
