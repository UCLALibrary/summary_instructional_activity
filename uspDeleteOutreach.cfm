<!---
// Required variables for uspDeleteOutreach
@OutID INT
--->
<cftry>
	<cfstoredproc procedure="uspDeleteOutreach" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@OutID" value="#OutID#" null="no">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database deletion error";
		</cfscript>
	</cfcatch>
</cftry>