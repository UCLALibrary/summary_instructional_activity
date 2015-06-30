<!---
// Required variables for uspAsscMaterial
@ActID INT,
@MatID INT
--->
<cftry>
	<cfloop index="theMaterial" list="#FORM.MatID#">
		<cfstoredproc procedure="uspAddMaterialActivity" datasource="#APPLICATION.dsn#">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActID" value = "#ActID#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@MatID" value = "#theMaterial#" null="no">
		</cfstoredproc>
	</cfloop>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
			em = "Database insert error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>
