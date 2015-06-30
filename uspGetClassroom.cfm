<!---
// Required variables for uspGetClassroom
ClassID = 0;
SessID = 0;
Set = '';
--->
<cftry>
	<cfstoredproc procedure="uspGetClassroom" datasource="#APPLICATION.dsn#">
		<cfif ClassID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@ClassID" value="#ClassID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@ClassID" null="yes">
		</cfif>
		<cfif SessID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@SessID" value="#SessID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@SessID" null="yes">
		</cfif>
		<cfif Set neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" variable="@Set" value="#Set#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" variable="@Set" null="yes">
		</cfif>
		<cfprocresult name="Classroom">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database query error";
		</cfscript>
	</cfcatch>
</cftry>
<cfif up2snuff and Classroom.RecordCount neq 0>
	<cfscript>
		//if (not isDefined("URL.fld")) {fld = "d";}
		if (not isDefined("URL.fld")) {fld = "na";}
		else {fld = URL.fld;}
		//if (not isDefined("URL.ord")) {ord = "a";}
		if (not isDefined("URL.ord")) {ord = "d";}
		else {ord = URL.ord;}
	</cfscript>
	<cfquery name="Classroom" dbtype="query">
		SELECT *
		FROM Classroom
		ORDER BY
		<cfoutput>
			<cfswitch expression="#fld#">
				<cfcase value="na">Name #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="lo">Building #IIf(ord eq "a", DE("DESC"), DE("ASC"))#, RoomNumber #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="pr">ComputerProjector #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="sc">Screen #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="dp">DepartmentID #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="cn">ContactLastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#, ContactFirstName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfcase value="dc">DBRCreator #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
				<cfdefaultcase>Name DESC</cfdefaultcase>
			</cfswitch>
		</cfoutput>
	</cfquery>
	<cfset UniqueRec = 0>
	<cfoutput query="Classroom" group="ClassroomID">
		<cfset UniqueRec = UniqueRec + 1>
	</cfoutput>
	<cfscript>
		ClassEditorID = Classroom.DBRCreatorID;
	</cfscript>
	<cfset ClassEditorID = ValueList(Classroom.DBRCreatorID, ",")>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
</cfif>