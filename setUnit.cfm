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
			<cfinclude template="formSetUnit.cfm">
		</cfif>
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if (SESSION.LibID eq 0 or not isDefined("FORM.setUID"))
		{
			em = "Session failed to initialize";
		}
		else
		{
			LibID = SESSION.LibID;
			setUID = FORM.setUID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="incCheckDataFormat.cfm">
		<cfif not up2snuff>
			<cfinclude template="formSetUnit.cfm">
		<cfelse>
			<cfinclude template="uspSetUnit.cfm">
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
					<cflock timeout="#CreateTimeSpan(0, 0, 120, 0)#" type="readonly" scope="session">
						<cfset SESSION.UID = Librarian.UnitID>
					</cflock>
					<cflocation url="mySIA.cfm" addtoken="yes">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">