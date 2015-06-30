<!---
// Required variables for uspAsscMaterial
@ActID INT,
@MatID INT
--->
<cftry>
	<cfstoredproc procedure="uspRemoveMaterialActivity" datasource="#APPLICATION.dsn#">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActID" value = "#ActID#" null="no">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@MatID" value = "#MatID#" null="no">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database deletion error. Please try again.";
		</cfscript>
	</cfcatch>	
</cftry>
