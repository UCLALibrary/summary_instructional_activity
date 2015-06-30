<!---
// Required variables for uspGetAccount
    @LibID INT = NULL,
    @UserName VARCHAR(50) = NULL,
    @Password VARCHAR(50) = NULL
--->
<cftry>
	<cfstoredproc procedure="uspGetAccount" datasource="#APPLICATION.dsn#">
		<cfif LibID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" value = "#LibID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" null="yes">
		</cfif>
		<cfif UserName neq "" and Password neq "">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@UserName" value = "#UserName#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@Password" value = "#Password#" null="no">
		<cfelseif UserName neq "" and Password eq "">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@UserName" value = "#UserName#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@Password" null="yes">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@UserName" null="yes">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@Password" null="yes">
		</cfif>
		<cfprocresult name="Account">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset up2snuff = 0>
		<!---cfset em = "Account access error"--->
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
	</cfcatch>
</cftry>
