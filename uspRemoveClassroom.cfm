<!---
// Required variables for uspRemoveSessionClassroom
@SessID INT,
@ClassID INT
--->
<cftry>
	<cfstoredproc procedure="uspRemoveSessionClassroom" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ClassID" value="#ClassID#">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database deletion error. Please try again.";
		</cfscript>
	</cfcatch>	
</cftry>