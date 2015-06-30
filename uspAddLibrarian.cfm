<!---
// Required variables for uspAddActivityLibrarian
ActID;
LibID;
// Required variables for uspAddSessionLibrarian
SessID;
LibID;
// Required variables for uspAddMaterialLibrarian
MatID;
LibID;
--->
<cftry>
	<!---cfif ActID neq 0>
		<cfloop index="theLibrarian" list="#FORM.LibID#">
			<cfstoredproc procedure="uspGetLibrarianUnit" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
				<cfprocresult name="GetUnit">
			</cfstoredproc>
			<cfset UnitID="#GetUnit.UnitID#">
			<cfstoredproc procedure="uspAddActivityLibrarian" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UnitID" value="#UnitID#" null="no">
			</cfstoredproc>
		</cfloop--->
	<cfif SessID neq 0>
		<cfif IsDefined("FORM.LibType") and FORM.LibType eq "develop">
			<cfloop index="theLibrarian" list="#FORM.LibID#">
				<cfstoredproc procedure="uspGetLibrarianUnit" datasource="#APPLICATION.dsn#">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
					<cfprocresult name="GetUnit">
				</cfstoredproc>
				<cfset UnitID="#GetUnit.UnitID#">
				<cfstoredproc procedure="uspAddActivityLibrarian" datasource="#APPLICATION.dsn#">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UnitID" value="#UnitID#" null="no">
				</cfstoredproc>
			</cfloop>
		<cfelse>
			<cfloop index="theLibrarian" list="#FORM.LibID#">
				<cfstoredproc procedure="uspGetLibrarianUnit" datasource="#APPLICATION.dsn#">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
					<cfprocresult name="GetUnit">
				</cfstoredproc>
				<cfset UnitID="#GetUnit.UnitID#">
				<cfstoredproc procedure="uspAddSessionLibrarian" datasource="#APPLICATION.dsn#">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#" null="no">
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no" >
					<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UnitID" value="#UnitID#" null="no">
				</cfstoredproc>
			</cfloop>
		</cfif>
	<cfelseif MatID neq 0>
		<cfloop index="theLibrarian" list="#FORM.LibID#">
			<cfstoredproc procedure="uspAddMaterialLibrarian" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" value="#MatID#" null="no">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#theLibrarian#" null="no">
			</cfstoredproc>
		</cfloop>
	</cfif>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database insert error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>