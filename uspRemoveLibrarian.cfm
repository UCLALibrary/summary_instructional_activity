<!---
// Required variables for uspRemoveActivityLibrarian
ActID;
LibID;
// Required variables for uspRemoveSessionLibrarian
SessID;
LibID;
// Required variables for uspRemoveMaterialLibrarian
MatID;
LibID;
--->
<cftry>
	<!---cfif ActID neq 0>
		<cfloop index="theLibrarian" list="#FORM.LibID#">
			<cfstoredproc procedure="uspRemoveActivityLibrarian" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
			</cfstoredproc>
		</cfloop--->
	<cfif SessID neq 0>
		<cfif IsDefined("FORM.LibType") and FORM.LibType eq "develop">
			<cfloop index="theLibrarian" list="#FORM.LibID#">
				<cfstoredproc procedure="uspRemoveActivityLibrarian" datasource="#APPLICATION.dsn#">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
				</cfstoredproc>
			</cfloop>
		<cfelse>
			<cfloop index="theLibrarian" list="#FORM.LibID#">
				<cfstoredproc procedure="uspRemoveSessionLibrarian" datasource="#APPLICATION.dsn#">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#" null="no">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
				</cfstoredproc>
			</cfloop>
		</cfif>
	<cfelseif MatID neq 0>
		<cfloop index="theLibrarian" list="#FORM.LibID#">
			<cfstoredproc procedure="uspRemoveMaterialLibrarian" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" value="#MatID#" null="no">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
			</cfstoredproc>
		</cfloop>
	</cfif>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database delete error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>