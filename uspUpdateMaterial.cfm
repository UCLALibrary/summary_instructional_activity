<!---
// Required variables for uspUpdateMaterial
MatID;
LibID;
IsFile;
MaterialTitle;
MaterialTypeID;
Description;
CompletionDT;
QuarterID;
DevTime;
DevComment;
URL;
FileName;
FileSize;
FileExtension;
FileContentType;
FileContentSubtype;
FileCreatedDT;
FileUpdatedDT;
--->
<cfscript>
// IsFile
	if (FORM.IsFile) {
		IsFile = 1;
	}
	else {
		IsFile = 0;
	}
// FileName
	if (isDefined("FILE.ClientFile")) {FileName = FILE.ClientFile;}
	else {FileName = "";}
// FileSize
	if (isDefined("FILE.FileSize")) {FileSize = FILE.FileSize;}
	else {FileSize = "";}
// FileExtension
	if (isDefined("FILE.ClientFileExt")) {FileExtension = FILE.ClientFileExt;}
	else {FileExtension = "";}
// FileContentType
	if (isDefined("FILE.ContentType")) {FileContentType  = FILE.ContentType;}
	else {FileContentType = "";}
// FileContentSubtype
	if (isDefined("FILE.ContentSubType")) {FileContentSubtype = ContentSubType;}
	else {FileContentSubtype = "";}
// FileCreatedDT
	if (isDefined("FILE.TimeCreated")) {
		FileCreatedDT = DateFormat(FILE.TimeCreated, "mm/dd/yyy") & " " & TimeFormat(FILE.TimeCreated);
	}
	else {
		FileCreatedDT = "";
	}
// FileUpdatedDT
	if (isDefined("FILE.TimeLastModified")) {
		FileUpdatedDT = DateFormat(FILE.timeLastModified, "mm/dd/yyy") & " " & TimeFormat(FILE.timeLastModified);
	}
	else {
		FileUpdatedDT = "";
	}
</cfscript>
<cfinclude template="incCleanForm.cfm">
<cftry>
	<cfstoredproc procedure="uspUpdateMaterial" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" value="#FORM.MatID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
		<cfif FORM.MaterialTitle neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" value="#FORM.MaterialTitle#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" null="yes">
		</cfif>
		<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@IsFile" value="#IsFile#">
		<cfif isDefined("FORM.URL") and FORM.URL neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@URL" value="#FORM.URL#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@URL" null="yes">
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MaterialTypeID" value="#FORM.MaterialTypeID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MaterialTypeID" null="yes">
		</cfif>
		<cfif FORM.Description neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Description" value="#FORM.Description#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Description" null="yes">
		</cfif>
		<cfif FileName neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileName" value="#FileName#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileName" null="yes">
		</cfif>
		<cfif FileSize neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FileSize" value="#FileSize#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FileSize" null="yes">
		</cfif>
		<cfif FileExtension neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileExtension" value="#FileExtension#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileExtension" null="yes">
		</cfif>
		<cfif FileContentType neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentType" value="#FileContentType#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentType" null="yes">
		</cfif>
		<cfif FileContentSubtype neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentSubtype" value="#FileContentSubtype#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentSubtype" null="yes">
		</cfif>
		<cfif FORM.QuarterID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" value="#FORM.QuarterID#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" null="yes">
		</cfif>
		<cfif FORM.CompletionDT neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@CompletionDT" value="#FORM.CompletionDT#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@CompletionDT" null="yes">
		</cfif>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevTime" null="yes">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@DevComment" null="yes">
		<cfif FileCreatedDT neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@FileCreatedDT" value="#FileCreatedDT#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@FileCreatedDT" null="yes">
		</cfif>
		<cfif FileUpdatedDT neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@FileUpdatedDT" value="#FileUpdatedDT#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@FileUpdatedDT" null="yes">
		</cfif>
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database update error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>

<!---cfif FORM.DevTime neq "">
<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevTime" value="#FORM.DevTime#">
<cfelse>
</cfif>
<cfif FORM.DevComment neq "">
<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@DevComment" value="#FORM.DevComment#">
<cfelse>
</cfif--->
