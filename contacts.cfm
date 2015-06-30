<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Contacts";
	up2snuff = 0;
	em = 'Error!';
	// check required variables
	if ( not isDefined("LibID") and
	     not isDefined("CntctID") and
	     not isDefined("StatID") and
	     not isDefined("DeptID") and
	     not isDefined("SessID") and
	     not isDefined("UID") and
	     not isDefined("sDT") and
	     not isDefined("eDT") and
	     not isDefined("FiscalY") )
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
	<!--- initialize variables for uspGetContact stored procedure --->
	<cfparam name="LibID" default="0">
	<cfparam name="CntctID" default="0">
	<cfparam name="StatID" default="0">
	<cfparam name="DeptID" default="0">
	<cfparam name="SessID" default="0">
	<cfparam name="ActID" default="0">
	<cfparam name="MatID" default="0">
	<cfparam name="UID" default="0">
	<cfparam name="sDT" default="">
	<cfparam name="eDT" default="">
	<cfparam name="FiscalY" default="0">
	<cfparam name="Set" default="">
	<cfinclude template="uspGetContact.cfm">
</cfif>
<cfif not up2snuff>
	<cfset pageTitle = "Error!">
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incContacts.cfm">
</cfif>
<cfinclude template="incEnd.cfm">