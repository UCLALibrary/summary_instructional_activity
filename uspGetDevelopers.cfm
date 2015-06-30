<!---
// Required variables for uspGetDevelopers
ActID;
--->
<cfscript>
	up2snuff = 1;
</cfscript>
<cftry>
	<cfstoredproc procedure="uspGetDevelopers" datasource="#APPLICATION.dsn#">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
		<cfprocresult name="Developers">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
