<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = "Error!";
	// check required variables
	if (not isDefined("SESSION.LibID") or SESSION.LibID eq 0)
	{
		em = "Session failed to initialize";
	}
	else
	{
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
		// initialize variables for uspGetLibrarian
		LibID = SESSION.LibID;
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
			<cfset em = "No librarian found">
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetSession stored procedure
				LibID = SESSION.LibID;
				SessID = 0;
				sDT = '';
				eDT = '';
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
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfscript>
					// initialize variables for uspGetMaterial stored procedure
					MatID = 0;
					MatTypID = 0;
					LibID = SESSION.LibID;
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
					<cfscript>
						// initialize variables for uspGetContact stored procedure
						LibID = SESSION.LibID;
						CntctID = 0;
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
						<cfset pageTitle = Librarian.FirstName & " " & Librarian.LastName & " (" & #Librarian.UserName# & ")">
						<cfinclude template="incBegin.cfm">
						<h1><cfoutput>#Librarian.FirstName# #Librarian.LastName# (#Librarian.UserName#)</cfoutput></h1>
						<table width="100%" border="0" cellpadding="0" cellspacing="5">
							<tr valign="top">
								<td width="80%">
									<cfinclude template="incSessions.cfm">
									<cfinclude template="incMaterials.cfm">
									<!---cfinclude template="incContacts.cfm"--->
									<cfinclude template="incLibrarian.cfm">
								</td>
								<td width="20%">
									<cfinclude template="incCalendar.cfm">
								</td>
							</tr>
						</table>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">