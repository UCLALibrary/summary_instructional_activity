<!---
// Required variables for uspGetPresenters
SessID;
--->
<cfscript>
	up2snuff = 1;
</cfscript>
<cftry>
	<cfstoredproc procedure="uspGetPresenters" datasource="#APPLICATION.dsn#">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#" null="no">
		<cfprocresult name="Presenters">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
