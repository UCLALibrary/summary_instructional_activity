<cfscript>
	up2snuff = 1;
</cfscript>
<cftry>
	<cfstoredproc procedure="uspGetMatSess" datasource="#APPLICATION.dsn#">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@MatID" value = "#MatID#" null="no">
		<cfprocresult name="Sess">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
<cfif up2snuff and Activity.RecordCount neq 0>
	<cfscript>
		if (not isDefined("URL.fld")) {fld = "a";}
		else {fld = URL.fld;}
		if (not isDefined("URL.ord")) {ord = "a";}
		else {ord = URL.ord;}
	</cfscript>
	<cfquery name="Sess" dbtype="query">
	SELECT *
	FROM Sess
	ORDER BY
		<cfoutput>
			<cfswitch expression="#fld#">
				<cfcase value="at">Title #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="ay">ActivityType #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfdefaultcase>Title DESC</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</cfquery>
	<cfscript>
		ActEditorID = ValueList(Sess.LibrarianID, ",");
		ActEditorID = ListAppend(ActEditorID, ValueList(Sess.DBRCreatorID, ","), ",");
	</cfscript>
	<cfset UniqueRec = 0>
	<cfoutput query="Sess" group="ActivityID">
		<cfset UniqueRec = UniqueRec + 1>
	</cfoutput>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
</cfif>