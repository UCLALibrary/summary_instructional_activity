<cfinclude template="authenticateExe.cfm">
<cfscript>
	up2snuff = 1;
// initialize variables for uspGetClassroom
	ClassID = 0;
	SessID = 0;
	Set = '';
</cfscript>
<cfinclude template="uspGetClassroom.cfm">
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfset pageTitle = "Classrooms">
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incClassrooms.cfm">
</cfif>
<cfinclude template="incEnd.cfm">