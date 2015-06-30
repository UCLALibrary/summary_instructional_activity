<!---
// Required variables for uspGetLibrarian
@LibID INT = NULL,
@UID INT = NULL,
@DeptID INT = NULL,
@CntctID INT = NULL,
@ActID INT = NULL,
@SessID INT = NULL,
@MatID INT = NULL,
@Set VARCHAR(3) = NULL
--->
<cftry>
	<cfstoredproc procedure="uspGetLibrarian" datasource="#APPLICATION.dsn#">
		<cfif LibID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" value="#LibID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" null="yes">
		</cfif>
		<cfif UID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@UID" value="#UID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@UID" null="yes">
		</cfif>
		<cfif DeptID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@DeptID" value="#DeptID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@DeptID" null="yes">
		</cfif>
		<cfif CntctID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@CntctID" value="#CntctID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@CntctID" null="yes">
		</cfif>
		<cfif ActID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" variable="@ActID" value="#ActID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" variable="@ActID" null="yes">
		</cfif>
		<cfif SessID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" variable="@SessID" value="#SessID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" variable="@SessID" null="yes">
		</cfif>
		<cfif MatID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" variable="@MatID" value="#MatID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" variable="@MatID" null="yes">
		</cfif>
		<cfif Set neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Set" value="#Set#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Set" null="yes">
		</cfif>
		<cfif DevPres neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevPres" value="#DevPres#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevPres" null="yes">
		</cfif>
		<cfprocresult name="Librarian">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset up2snuff = 0>
		<cfset em = "Database query error">
	</cfcatch>
</cftry>
<cfif up2snuff and Librarian.RecordCount neq 0>
	<cfscript>
		if (not isDefined("URL.fld")) {fld = "d";}
		else {fld = URL.fld;}
		if (not isDefined("URL.ord")) {ord = "a";}
		else {ord = URL.ord;}
	</cfscript>
	<cfquery name="Librarian" dbtype="query">
	SELECT *
	FROM Librarian
	ORDER BY
		<cfoutput>
			<cfswitch expression="#fld#">
				<cfcase value="ln">LastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="lt">Title #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="lu">Unit #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="ls">UserSince #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfdefaultcase>LastName ASC</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</cfquery>
	<cfset UniqueRec = 0>
	<cfoutput query="Librarian" group="LibrarianID">
		<cfset UniqueRec = UniqueRec + 1>
	</cfoutput>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
<!--- lookup query for units --->
	<cfif UID neq 0>
		<cfscript>
			Lookup = "Unit";
			Header = "-select-";
		</cfscript>
		<cfinclude template="uspGetLookup.cfm">
		<cfif up2snuff and Unit.RecordCount neq 0>
			<cfquery name="Unit" dbtype="query">
				SELECT * FROM Unit WHERE Unit.UnitID = <cfoutput>#UID#</cfoutput>
			</cfquery>
		</cfif>
	</cfif>
<!--- lookup query for departments --->
	<cfif DeptID neq 0>
		<cfscript>
			Lookup = "Department";
			Header = "-select-";
		</cfscript>
		<cfinclude template="uspGetLookup.cfm">
		<cfif up2snuff and Department.RecordCount neq 0>
			<cfquery name="Department" dbtype="query">
				SELECT * FROM Unit WHERE Department.DepartmentID = <cfoutput>#DeptID#</cfoutput>
			</cfquery>
		</cfif>
	</cfif>
	<cfif CntctID neq 0>
		<cfscript>
// initialize variables for uspGetContact stored procedure
			LibID = 0;
			CntctID = URL.CntctID;
			StatID = 0;
			DeptID = 0;
			SessID = 0;
			ActID = 0;
			MatID = 0;
			UID = 0;
			sDT = '';
			eDT = '';
			FiscalY = 0;
			Set = '';
		</cfscript>
		<cfinclude template="uspGetContact.cfm">
	</cfif>
</cfif>