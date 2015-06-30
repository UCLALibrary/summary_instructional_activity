<!---
// Required variables for uspCheckRelationships
@LibID INT = NULL,
@CntctID INT = NULL,
@ActID INT = NULL,
@SessID INT = NULL,
@MatID INT = NULL,
@ClassID INT = NULL
--->
<cftry>
	<cfstoredproc procedure="uspCheckRelationships" datasource="#APPLICATION.dsn#">
		<cfif LibID neq 0 >
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" value="#LibID#" null="no">	
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" null="yes">	
		</cfif>
		<cfif CntctID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#CntctID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" null="yes">
		</cfif>
		<cfif ActID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" null="yes">
		</cfif>
		<cfif SessID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" null="yes">
		</cfif>
		<cfif MatID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" value="#MatID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" null="yes">
		</cfif>
		<cfif ClassID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ClassID" value="#ClassID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ClassID" null="yes">
		</cfif>
		<cfprocresult name="Relationships">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>	
</cftry>