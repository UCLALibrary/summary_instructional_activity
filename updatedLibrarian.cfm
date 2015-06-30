<cfinclude template="authenticateExe.cfm">
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
		<cfinclude template="incLibrarian.cfm">
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">