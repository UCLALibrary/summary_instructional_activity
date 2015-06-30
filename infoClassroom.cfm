<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.ClassID") or not isNumeric(URL.ClassID)) {
		em = "Invalid or missing parameters";
	}
	else {
		ClassID = URL.ClassID;
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBeginInfo.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variables for uspGetClassroom
		ClassID = ClassID;
		SessID = 0;
		Set = 'One';
	</cfscript>
	<cfinclude template="uspGetClassroom.cfm">
	<cfif not up2snuff>
		<cfinclude template="incBeginInfo.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
// initialize variables for uspGetSession stored procedure
			LibID = 0;
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
			ClassID = ClassID;
			ShowAll = 0;
		</cfscript>
		<cfinclude template="uspGetSession.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="incClassroom.cfm">
			<cfinclude template="incSessions.cfm">
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">
