<!---
// Required variables for uspRemoveLibrarianContact
LibID;
CntctID;
// Required variables for uspRemoveActivityContact
LibID;
ActID;
CntctID;
// Required variables for uspRemoveSessionContact
LibID;
SessID;
CntctID;
// Required variables for uspRemoveMaterialContact
LibID;
MatID;
CntctID;
--->
<cftry>
	<!---cfif ActID neq 0>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspRemoveActivityContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop--->
	<cfif SessID neq 0>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspRemoveActivityContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>

		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspRemoveSessionContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#FORM.SessID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>
	<cfelseif MatID neq 0>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspRemoveMaterialContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" value="#FORM.MatID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>
	<cfelse>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspRemoveLibrarianContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#FORM.LibID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>
	</cfif>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database delete error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>