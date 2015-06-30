<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if (SESSION.LibID eq 0)
		{
			em = "Session failed to initialize";
		}
		else
		{
			LibID = SESSION.LibID;
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
			<cfinclude template="formLibrarian.cfm">
		</cfif>
	</cfif>
<cfelse>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="mySIA.cfm" addtoken="no">
	<cfelse>
		<cfscript>
			pageTitle = "Error!";
			up2snuff = 0;
			em = 'Error!';
			// check required variables
			// check required variables
			if (SESSION.LibID eq 0)
			{
				em = "Session failed to initialize";
			}
			else
			{
				LibID = SESSION.LibID;
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
				<cfinclude template="incCheckForm.cfm">
				<cfif missingRequired>
					<cfinclude template="formLibrarian.cfm">
				<cfelse>
					<cfinclude template="incCheckDataFormat.cfm">
					<cfif not up2snuff>
						<cfinclude template="formLibrarian.cfm">
					<cfelse>
						<cfinclude template="uspUpdateLibrarian.cfm">
						<cfif not up2snuff>
							<cfinclude template="formLibrarian.cfm">
						<cfelse>
							<cflocation url="updatedLibrarian.cfm" addtoken="no">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">