<!---
// Required variables for uspGetSession
LibID = 0;
SessID = 0;
sDT = '';
eDT = '';
CntctID = 0;
DeptID = 0;
ActID = 0;
LrCatID = 0;
AffID = 0;
QuartID = 0;
Yr = 0;
Hr = 0;
UID = 0;
FiscalY = 0;
OutID = 0;
ClassID = 0;
--->
<cftry>
	<cfstoredproc procedure="uspGetSession" datasource="#APPLICATION.dsn#" cachedWithin="#CreateTimeSpan(0,0,2,0)#">
		<cfif LibID neq 0 >
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" value="#LibID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" null="yes">
		</cfif>
		<cfif SessID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@SessID" null="yes">
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
		<cfif ActID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" null="yes">
		</cfif>
		<cfif LrCatID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LrCatID" value="#LrCatID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LrCatID" null="yes">
		</cfif>
		<cfif AffID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffID" value="#AffID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffID" null="yes">
		</cfif>
		<cfif QuartID neq 0 and Yr neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuartID" value="#QuartID#" null="no">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Yr" value="#Yr#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuartID" null="yes">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Yr" null="yes">
		</cfif>
		<cfif Hr neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Hr" value="#Hr#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Hr" null="yes">
		</cfif>
		<cfif UID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UID" value="#UID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@UID" null="yes">
		</cfif>
		<cfif FiscalY neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#FiscalY#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" null="yes">
		</cfif>
		<cfif OutID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@OutID" value="#OutID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@OutID" null="yes">
		</cfif>
		<cfif CLassID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ClassID" value="#ClassID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ClassID" null="yes">
		</cfif>
		<cfif ShowAll neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@ShowAll" value="#ShowAll#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@ShowAll" null="yes">
		</cfif>
		<cfprocresult name="Sess">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
<cfif up2snuff and Sess.RecordCount neq 0>
	<cfscript>
		if (not isDefined("URL.fld")) {fld = "sd";}
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
				<cfcase value="st">Title #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="sc">ContactLastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="sq">Quarter #IIf(ord eq "a", DE("DESC"), DE("ASC"))#, SessionDateTime DESC</cfcase>
				<cfcase value="sd">SessionDateTime #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="sh">SessionHour #IIf(ord eq "a", DE("DESC"), DE("ASC"))#, SessionDateTime DESC</cfcase>
				<cfcase value="sl">FullName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="su">Unit #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="sp">SessionDepartment #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="scp">CoLibs #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="sa">Attendees #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="sv">ActivityType #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="fa">Faculty #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfdefaultcase>SessionDateTime DESC</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</cfquery>
	<cfscript>
		SessEditorID = ValueList(Sess.LibrarianID, ",");
		SessEditorID = ListAppend(SessEditorID, ValueList(Sess.DBRCreatorID, ","), ",");
	</cfscript>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
	<cfif Find("sessions.cfm", SCRIPT_NAME)>
<!--- lookup query for contacts --->
		<cfif CntctID neq 0>
			<cfscript>
// initialize variables for uspGetContact stored procedure
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
<!--- lookup query for quarters --->
		<cfif Yr neq "" and QuartID neq 0>
			<cfscript>
				Lookup = "Quarter";
				Header = "-select-";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
			<cfif up2snuff and Quarter.RecordCount neq 0>
				<cfquery name="Quarter" dbtype="query">
					SELECT * FROM Quarter WHERE Quarter.QuarterID = <cfoutput>#QuartID#</cfoutput>
				</cfquery>
			</cfif>
		</cfif>
<!--- lookup query for database record creator (librarian) --->
		<cfif LibID neq 0>
			<cfscript>
				LibID = LibID;
				UID = 0;
				ActID = 0;
				SessID = 0;
				MatID = 0;
				Set = '';
				DevPres = 0;
			</cfscript>
			<cfinclude template="uspGetLibrarian.cfm">
		</cfif>
<!--- lookup query for learner categories --->
		<cfif LrCatID neq 0>
			<cfscript>
				Lookup = "LearnerCategory";
				Header = "-select-";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
			<cfif up2snuff and LearnerCategory.RecordCount neq 0>
				<cfquery name="LearnerCategory" dbtype="query">
					SELECT * FROM LearnerCategory WHERE LearnerCategory.LearnerCategoryID = <cfoutput>#LrCatID#</cfoutput>
				</cfquery>
			</cfif>
		</cfif>
<!--- lookup query for affiliations --->
		<cfif AffID neq 0>
			<cfscript>
				Lookup = "Affiliation";
				Header = "-select-";
			</cfscript>
			<cfinclude template="uspGetLookup.cfm">
			<cfif up2snuff and Affiliation.RecordCount neq 0>
				<cfquery name="Affiliation" dbtype="query">
					SELECT * FROM Affiliation WHERE Affiliation.AffiliationID = <cfoutput>#AffID#</cfoutput>
				</cfquery>
			</cfif>
		</cfif>
	</cfif>
</cfif>
