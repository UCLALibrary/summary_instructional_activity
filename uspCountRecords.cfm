<!---
// Required variables for uspCountRecords
Object = '';
--->
<cftry>
	<cfstoredproc procedure="uspCountRecords" datasource="#APPLICATION.dsn#">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@Object" value="#Object#" null="no">
		<cfprocresult name="#Object#">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset up2snuff = 0>
		<cfset em = "Database error">
	</cfcatch>
</cftry>
