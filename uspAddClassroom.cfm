<!---
// Required variables for uspAddSessionClassroom
@SessID INT,
@ClassID INT,
@LibID INT
--->
<cftry>
	<cfstoredproc procedure="uspAddSessionClassroom" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ClassID" value="#ClassID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database insert error. Please try again.";
		</cfscript>
	</cfcatch>	
</cftry>