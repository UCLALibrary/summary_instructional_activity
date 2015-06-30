<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Outreach";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("OutID") and
		not isDefined("LibID") and
		not isDefined("CntctID") and
		not isDefined("DeptID") and
		not isDefined("StatID") and
		not isDefined("UID") and
		not isDefined("sDT") and
		not isDefined("eDT") and
		not isDefined("FiscalY")) {
		em = "Invalid or missing parameters";
	}
	else {
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif up2snuff>
<!--- initialize variables for uspGetOutreach stored procedure --->
	<cfparam name="OutID" default="0">
	<cfparam name="LibID" default="0">
	<cfparam name="CntctID" default="0">
	<cfparam name="DeptID" default="0">
	<cfparam name="StatID" default="0">
	<cfparam name="UID" default="0">
	<cfparam name="sDT" default="">
	<cfparam name="eDT" default="">
	<cfparam name="FiscalY" default="0">
	<cfinclude template="uspGetOutreach.cfm">
</cfif>
<cfinclude template="incBegin.cfm">
<cfif not up2snuff>
	<cfinclude template="incError.cfm">
<cfelse>
	<cfinclude template="incOutreach.cfm">
</cfif>
<cfinclude template="incEnd.cfm">