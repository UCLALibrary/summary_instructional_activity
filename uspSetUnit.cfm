<!---
// Required variables for uspUpdateLibrarian
    @LibID INT,
    @UID INT
--->
<cftry>
	<cfstoredproc procedure="uspSetUnit" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UID" value="#FORM.setUID#">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database update error. Please try again.";
		</cfscript>
	</cfcatch>	
</cftry>
