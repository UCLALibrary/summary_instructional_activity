<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Materials";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("MatID") and
		not isDefined("MatTypID") and
		not isDefined("LibID") and
		not isDefined("ActID") and
		not isDefined("UID") and
		not isDefined("sDT") and
		not isDefined("eDT") and
		not isDefined("QuartID") and
		not isDefined("Yr") and
		not isDefined("FiscalY") and
		not isDefined("Set")) {
		em = "Invalid or missing parameters";
	}
	else {
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfparam name="MatID" default="0">
	<cfparam name="MatTypID" default="0">
	<cfparam name="LibID" default="0">
	<cfparam name="ActID" default="0">
	<cfparam name="CntctID" default="0">
	<cfparam name="UID" default="0">
	<cfparam name="sDT" default="">
	<cfparam name="eDT" default="">
	<cfparam name="QuartID" default="0">
	<cfparam name="Yr" default="0">
	<cfparam name="FiscalY" default="0">
	<cfparam name="Set" default="">
	<cfinclude template="uspGetMaterial.cfm">
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incMaterials.cfm">	
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">