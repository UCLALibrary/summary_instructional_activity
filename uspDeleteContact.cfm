<!---
// Required variables for uspDeleteOutreach
CntctID = 0;
--->
<cftry>
	<cfstoredproc procedure="uspDeleteContact" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@CntctID" value="#CntctID#" null="no">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database deletion error";
		</cfscript>

	</cfcatch>
</cftry>