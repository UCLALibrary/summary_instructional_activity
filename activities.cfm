<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if ( SESSION.LibID eq 0 or
	     ( not isDefined("LibID") and
	       not isDefined("ActID") and
	       not isDefined("MatID") and
	       not isDefined("ActTypID") and
	       not isDefined("DelModID") and
	       not isDefined("DBRCID") and
	       not isDefined("UID") and
	       not isDefined("sDT") and
	       not isDefined("eDT") and
	       not isDefined("QuartID") and
	       not isDefined("Yr") and
	       not isDefined("FiscalY") ) ) 
	{
		em = "Invalid or missing parameters";
	}
	else 
	{
		up2snuff = 1;
		em = 'None';
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
<!--- initialize variables for uspGetActivity stored procedure --->
	<cfparam name="LibID" default="0">
	<cfparam name="ActID" default="0">
	<cfparam name="ActTypID" default="0">
	<cfparam name="DelModID" default="0">
	<cfparam name="MatID" default="0">
	<cfparam name="CntctID" default="0">
	<cfparam name="DBRCID" default="0">
	<cfparam name="UID" default="0">
	<cfparam name="sDT" default="">
	<cfparam name="eDT" default="">
	<cfparam name="QuartID" default="0">
	<cfparam name="Yr" default="0">
	<cfparam name="FiscalY" default="0">
	<cfinclude template="uspGetActivity.cfm">
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfset pageTitle = "Activities">
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incActivities.cfm">
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">