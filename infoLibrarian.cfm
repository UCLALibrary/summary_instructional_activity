<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.LibID")or not isNumeric(URL.LibID))
	{
		em = "Invalid or missing parameters";
	}
	else
	{
		LibID = URL.LibID;
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBeginInfo.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variables for uspGetLibrarian stored procedure
		LibID = URL.LibID;
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
		<cfinclude template="incBeginInfo.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="incLibrarian.cfm">
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">
