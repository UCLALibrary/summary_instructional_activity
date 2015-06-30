<!---
// Required variables for uspDeleteMaterial
MatID = 0
--->
<cftry>
	<cfstoredproc procedure="uspDeleteMaterial" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@MatID" value="#MatID#" null="no">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database deletion error";
		</cfscript>
	</cfcatch>
</cftry>