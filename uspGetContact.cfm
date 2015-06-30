<!---
// Required variables for uspGetContact
LibID = 0;
CntctID = 0;
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
--->
<cftry>
	<cfstoredproc procedure="uspGetContact" datasource="#APPLICATION.dsn#">
		<cfif LibID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@LibID" value="#LibID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@LibID" null="yes">
		</cfif>
		<cfif CntctID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@CntctID" value="#CntctID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@CntctID" null="yes">
		</cfif>
		<cfif StatID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@StatID" value="#StatID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@StatID" null="yes">
		</cfif>
		<cfif DeptID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@DeptID" value="#DeptID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@DeptID" null="yes">
		</cfif>
		<cfif SessID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@SessID" value="#SessID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@SessID" null="yes">
		</cfif>
		<cfif ActID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@ActID" value="#ActID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@ActID" null="yes">
		</cfif>
		<cfif MatID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@MatID" value="#MatID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@MatID" null="yes">
		</cfif>
		<cfif UID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@UID" value="#UID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@UID" null="yes">
		</cfif>
		<cfif sDT neq "" and eDT neq "">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" variable="@sDT" value = "#sDT#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" variable="@eDT" value = "#eDT#" null="no">
		<cfelseif sDT neq "" and eDT eq "">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" variable="@sDT" value = "#sDT#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" variable="@eDT" null="yes">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" variable="@sDT" null="yes">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" variable="@eDT" null="yes">
		</cfif>
		<cfif FiscalY neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@FiscalY" value="#FiscalY#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@FiscalY" null="yes">
		</cfif>
		<cfif Set neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" variable="@Set" value="#Set#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" variable="@Set" null="yes">
		</cfif>
		<cfprocresult name="Contact">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
<cfif up2snuff and Contact.RecordCount neq 0>
	<cfscript>
		if (not isDefined("URL.fld"))
		{
			fld = "d";
		}
		else
		{
			fld = URL.fld;
		}
		if (not isDefined("URL.ord"))
		{
			ord = "a";
		}
		else
		{
			ord = URL.ord;
		}
	</cfscript>
	<cfquery name="Contact" dbtype="query">
		SELECT *
		FROM Contact
		ORDER BY
		<cfoutput>
			<cfswitch expression="#fld#">
				<cfcase value="cn">LastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="cs">ContactStatus #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="cd">Department #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="cl">LibrarianLastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="cu">Unit #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="cc">DBRCreatedDT #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="da">AssociatedDT #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfdefaultcase>LastName ASC</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</cfquery>
	<cfset UniqueRec = 0>
	<cfoutput query="Contact" group="ContactID">
		<cfset UniqueRec = UniqueRec + 1>
	</cfoutput>
	<cfset CntctEditorID = ValueList(Contact.DBRCreatorID, ",")>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
	<cfif Find("contacts.cfm", SCRIPT_NAME)>
<!--- lookup query for departments --->
		<cfif DeptID neq 0>
			<cfscript>
				Lookup = "Department";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
			<cfif up2snuff and Department.RecordCount neq 0>
				<cfquery name="Department" dbtype="query">
				SELECT * FROM Department WHERE DepartmentID = <cfoutput>#DeptID#</cfoutput>
				</cfquery>
			</cfif>
		</cfif>
<!--- lookup query for status --->
		<cfif StatID neq 0>
			<cfscript>
				Lookup = "ContactStatus";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
			<cfif up2snuff and ContactStatus.RecordCount neq 0>
				<cfquery name="ContactStatus" dbtype="query">
				SELECT * FROM ContactStatus WHERE ContactStatusID = <cfoutput>#StatID#</cfoutput>
				</cfquery>
			</cfif>
		</cfif>
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
<!--- lookup query for librarians --->
		<cfif LibID neq 0>
			<cfscript>
				LibID = LibID;
				UID = 0;
				DevPres = 0;
			</cfscript>
			<cfinclude template="uspGetLibrarian.cfm">
		</cfif>
	</cfif>
</cfif>