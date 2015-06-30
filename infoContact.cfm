<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.CntctID") or not isNumeric(URL.CntctID)) {
		em = "Invalid or missing parameters";
	}
	else {
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBeginInfo.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variables for uspGetContact stored procedure
		LibID = 0;
		CntctID = URL.CntctID;
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
		<cfinclude template="incBeginInfo.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="incContact.cfm">
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">
