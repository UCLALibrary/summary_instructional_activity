<!---
// Required variables for uspGetOutreach
OutID = 0;
LibID = 0;
CntctID = 0;
DeptID = 0;
StatID = 0;
UID = 0;
sDT = '';
eDT = '';
FiscalY = 0;
--->
<cftry>
	<cfstoredproc procedure="uspGetOutreach" datasource="#APPLICATION.dsn#">
		<cfif OutID neq 0 >
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@OutID" value="#OutID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@OutID" null="yes">
		</cfif>
		<cfif LibID neq 0 >
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" value="#LibID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" null="yes">
		</cfif>
		<cfif CntctID neq 0 >
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#CntctID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" null="yes">
		</cfif>
		<cfif DeptID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DeptID" value="#DeptID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DeptID" null="yes">
		</cfif>
		<cfif StatID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@StatID" value="#StatID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@StatID" null="yes">
		</cfif>
		<cfif UID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UID" value="#UID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UID" null="yes">
		</cfif>
		<cfif sDT neq "" and eDT neq "">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@sDT" value = "#sDT#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@eDT" value = "#eDT#" null="no">
		<cfelseif sDT neq "" and eDT eq "">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@sDT" value = "#sDT#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@eDT" null="yes">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@sDT" null="yes">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@eDT" null="yes">
		</cfif>
		<cfif FiscalY neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#FiscalY#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" null="yes">
		</cfif>
		<cfprocresult name="Outreach">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
<cfif up2snuff and Outreach.RecordCount neq 0>
	<cfscript>
		if (not isDefined("URL.fld")) {fld = "d";}
		else {fld = URL.fld;}
		if (not isDefined("URL.ord")) {ord = "a";}
		else {ord = URL.ord;}
	</cfscript>
	<cfquery name="Outreach" dbtype="query">
	SELECT *
	FROM Outreach
	ORDER BY
		<cfoutput>
			<cfswitch expression="#fld#">
				<cfcase value="ot">OutreachDT #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="on">ContactLastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="od">ContactDepartment #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="os">ContactStatus #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="op">Purpose #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="ol">LibrarianLastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="ou">Unit #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfdefaultcase>OutreachDT DESC</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</cfquery>
	<cfset OutEditorID = ValueList(Outreach.LibrarianID, ",")>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
	<cfif ListContains("outreach.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
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
<!--- lookup query for contacts --->
		<cfif CntctID neq 0>
			<cfscript>
				LibID = 0;
				CntctID = CntctID;
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
	<cfif ListContains("outreachLog.cfm,deleteOutreach.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
<!--- lookup query for outreach method --->
		<cfif Outreach.Method neq "">
			<cfscript>
				Lookup = "OutreachMethod";
				Header = "-select-";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
		</cfif>
<!--- lookup query for outreach initiation --->
		<cfif Outreach.Initiate neq "">
			<cfscript>
				Lookup = "OutreachInitiate";
				Header = "-select-";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
		</cfif>
<!--- lookup query for outreach outcome --->
		<cfif Outreach.Outcome neq "">
			<cfscript>
				Lookup = "OutreachOutcome";
				Header = "-select-";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
		</cfif>
	</cfif>
</cfif>