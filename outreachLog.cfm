<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error";
	up2snuff = 0;
	em = 'Error!';
	// check required variables
	if (not isDefined("URL.OutID") or not isNumeric(URL.OutID))
	{
		em = "Invalid or missing contact ID value";
	}
	else
	{
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif up2snuff>
	<cfscript>
		// initialize variables for uspGetOutreach stored procedure
		OutID = URL.OutID;
		LibID = 0;
		CntctID = 0;
		DeptID = 0;
		StatID = 0;
		UID = 0;
		sDT = '';
		eDT = '';
		FiscalY = 0;
	</cfscript>
	<cfinclude template="uspGetOutreach.cfm">
</cfif>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfinclude template="incOutreachLog.cfm">
</cfif>
<cfinclude template="incEnd.cfm">