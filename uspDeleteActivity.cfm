<!---
// Required variables for uspDeleteActivity
ActID = 0;
--->
<cftry>
	<cfstoredproc procedure="uspDeleteActivity" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@ActID" value="#ActID#" null="no">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset em = "Error is delete activity: #cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database deletion error";
		</cfscript>

	</cfcatch>
</cftry>