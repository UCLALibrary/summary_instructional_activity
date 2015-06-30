<!---
// Required variables for uspDeleteClassroom
ClassID = 0;
--->
<cftry>
	<cfstoredproc procedure="uspDeleteClassroom" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@ClassID" value="#ClassID#" null="no">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database deletion error";
		</cfscript>

	</cfcatch>
</cftry>