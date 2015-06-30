<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Sessions";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("LibID") and
		not isDefined("SessID") and
		not isDefined("sDT") and
		not isDefined("eDT") and
		not isDefined("CntctID") and
		not isDefined("DeptID") and
		not isDefined("ActID") and
		not isDefined("LrCatID") and
		not isDefined("AffID") and
		not isDefined("QuartID") and
		not isDefined("Yr") and
		not isDefined("Hr") and
		not isDefined("UID") and
		not isDefined("FiscalY") and
		not isDefined("OutID"))
	{
		em = "Invalid or missing parameters";
	}
	else
	{
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif up2snuff>
<!--- initialize variables for uspGetSession stored procedure --->
	<cfparam name="LibID" default="0">
	<cfparam name="SessID" default="0">
	<cfparam name="CntctID" default="0">
	<cfparam name="DeptID" default="0">
	<cfparam name="ActID" default="0">
	<cfparam name="LrCatID" default="0">
	<cfparam name="AffID" default="0">
	<cfparam name="QuartID" default="0">
	<cfparam name="Yr" default="0">
	<cfparam name="Hr" default="0">
	<cfparam name="sDT" default="">
	<cfparam name="eDT" default="">
	<cfparam name="UID" default="0">
	<cfparam name="FiscalY" default="0">
	<cfparam name="OutID" default="0">
	<cfparam name="ClassID" default="0">
	<cfparam name="ShowAll" default="0">
	<cfinclude template="uspGetSession.cfm">
</cfif>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfset pageTitle = "Sessions">
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incSessions.cfm">
</cfif>
<cfinclude template="incEnd.cfm">