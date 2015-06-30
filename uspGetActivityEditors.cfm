<!---
// Required variables for get_editors_by_session
SessID;
--->
<cfscript>
	up2snuff = 1;
</cfscript>
<cftry>
	<cfstoredproc procedure="uspGetActivityEditors" datasource="#APPLICATION.dsn#">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
		<cfprocresult name="Editors">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
<cfif up2snuff and Editors.RecordCount neq 0>
	<cfscript>
		EditorID = ValueList(Editors.LibrarianID, ",");
		EditorID = ListAppend(EditorID, ValueList(Editors.DBRCreatorID, ","), ",");
	</cfscript>
</cfif>