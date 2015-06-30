<!---
// Required variables for uspGetActivity
LibID = 0;
ActID = 0;
ActTypID = 0;
DelModID = 0;
MatID = 0;
CntctID = 0;
DBRCID = 0;
UID = 0;
sDT = '';
eDT = '';
QuartID = 0;
Yr = 0;
FiscalY = 0;
--->
<cfscript>
	up2snuff = 1;
</cfscript>
<cftry>
	<cfstoredproc procedure="uspGetActivity" datasource="#APPLICATION.dsn#">
		<cfif LibID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" value = "#LibID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@LibID" null="yes">
		</cfif>
		<cfif ActID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActID" value = "#ActID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActID" null="yes">
		</cfif>
		<cfif ActTypID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActTypID" value = "#ActTypID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@ActTypID" null="yes">
		</cfif>
		<cfif DelModID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@DelModID" value = "#DelModID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@DelModID" null="yes">
		</cfif>
		<cfif MatID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@MatID" value = "#MatID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@MatID" null="yes">
		</cfif>
		<cfif CntctID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@CntctID" value = "#CntctID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@CntctID" null="yes">
		</cfif>
		<cfif DBRCID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@DBRCID" value = "#DBRCID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@DBRCID" null="yes">
		</cfif>
		<cfif UID neq 0>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@UID" value = "#UID#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_INTEGER" dbvarname="@UID" null="yes">
		</cfif>
		<cfif sDT neq "" and eDT neq "">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@sDT" value = "#sDT#" null="no">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@eDT" value = "#eDT#" null="no">
		<cfelse>
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@sDT" null="yes">
			<cfprocparam type = "In" CFSQLType = "CF_SQL_DATE" dbvarname="@eDT" null="yes">
		</cfif>
		<cfif QuartID neq 0 and Yr neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuartID" value="#QuartID#" null="no">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Yr" value="#Yr#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuartID" null="yes">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Yr" null="yes">
		</cfif>
		<cfif FiscalY neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" value="#FiscalY#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FiscalY" null="yes">
		</cfif>
		<cfprocresult name="Activity">
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
	<cfquery name="Activity" dbtype="query">
	SELECT *
	FROM Activity
	ORDER BY
		<cfoutput>
			<cfswitch expression="#fld#">
				<cfcase value="at">Title #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="ay">ActivityType #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="am">DeliveryMode #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="ad">Duration #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="al">LibrarianLastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="au">Unit #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="aq">Quarter #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="ac">CompletionDT #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfdefaultcase>Title DESC</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</cfquery>
	<cfscript>
		ActEditorID = ValueList(Activity.LibrarianID, ",");
		ActEditorID = ListAppend(ActEditorID, ValueList(Activity.DBRCreatorID, ","), ",");
	</cfscript>
	<cfset UniqueRec = 0>
	<cfoutput query="Activity" group="ActivityID">
		<cfset UniqueRec = UniqueRec + 1>
	</cfoutput>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
	<cfif ListContains("activities.cfm,addSession.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
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
		<cfif Find("activities.cfm", SCRIPT_NAME)>
	<!--- lookup query for activity types --->
			<cfif ActTypID neq 0>
				<cfscript>
					Lookup = "ActivityType";
					Header = "-select-";
				</cfscript>
				<cfinclude template="uspGetLookup.cfm">
				<cfif up2snuff and ActivityType.RecordCount neq 0>
					<cfquery name="Unit" dbtype="query">
						SELECT * FROM ActivityType WHERE ActivityType.ActivityTypeID = <cfoutput>#ActTypID#</cfoutput>
					</cfquery>
				</cfif>
			</cfif>
	<!--- lookup query for delivery modes --->
			<cfif DelModID neq 0>
				<cfscript>
					Lookup = "DeliveryMode";
					Header = "-select-";
				</cfscript>
				<cfinclude template="uspGetLookup.cfm">
				<cfif up2snuff and DeliveryMode.RecordCount neq 0>
					<cfquery name="DeliveryMode" dbtype="query">
						SELECT * FROM DeliveryMode WHERE DeliveryMode.DeliveryModeID = <cfoutput>#DelModID#</cfoutput>
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
	<!--- lookup query for librarians --->
			<cfif LibID neq 0>
				<cfscript>
					LibID = LibID;
					UID = 0;
					DeptID = 0;
					CntctID = 0;
					ActID = 0;
					SessID = 0;
					MatID = 0;
					Set = '';
					DevPres = 0;
				</cfscript>
				<cfinclude template="uspGetLibrarian.cfm">
			</cfif>
		</cfif>
	</cfif>
</cfif>