<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.LibID") or not isNumeric(URL.LibID)) {
		em = "Invalid or missing parameters";
	}
	else {
		LibID = URL.LibID;
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variables for uspGetLibrarian stored procedure
		LibID = LibID;
		UID = 0;
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
		<cfif Librarian.RecordCount eq 0>
			<cfinclude template="incLibrarian.cfm">
		<cfelse>
			<cfif (SESSION.LibID eq URL.LibID) or (SESSION.UserLevelID gt 1)>
				<cfscript>
// initialize variables for uspGetSession stored procedure
					if (SESSION.LibID eq URL.LibID) {
						LibID = SESSION.LibID;
					}
					else if (SESSION.UserLevelID eq 2 and Librarian.UnitID eq SESSION.UID) {
						LibID = URL.LibID;
					}
					else if (SESSION.UserLevelID eq 3) {
						LibID = URL.LibID;
					}
					SessID = 0;
					sDT = "";
					eDT = "";
					CntctID = 0;
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
			</cfif>
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="incLibrarian.cfm">
				<cfif (SESSION.LibID eq URL.LibID) or (SESSION.UserLevelID gt 1)>
					<cfinclude template="incSessions.cfm">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">