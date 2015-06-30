<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("URL.MatID") or not isNumeric(URL.MatID)) {
		em = "Invalid or missing parameters";
	}
	else {
		MatID = URL.MatID;
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBeginInfo.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
// initialize variables for uspGetMaterial stored procedure
		MatID = URL.MatID;
		MatTypID = 0;
		LibID = 0;
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
		<cfinclude template="incBeginInfo.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="incMaterial.cfm">
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">
