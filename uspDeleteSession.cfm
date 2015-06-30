<!---
// Required variables for uspDeleteSession
SessID = 0;
--->
<cftry>
	<cfstoredproc procedure="uspDeleteSession" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@SessID" value="#SessID#" null="no">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset em = "Error is delete session: #cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database deletion error";
		</cfscript>
	</cfcatch>
</cftry>