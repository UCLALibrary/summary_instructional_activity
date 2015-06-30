<cfstoredproc procedure="uspAddFile" datasource="#APPLICATION.dsn#">
	<cfif ActID neq 0>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" null="yes">
	</cfif>
	<cfif LibID neq 0>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#LibID#" null="no">
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" null="yes">
	</cfif>
	<cfif FORM.Title neq "">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" value="#FORM.Title#" null="no">	
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" null="yes">
	</cfif>
	<cfif MaterialTypeID neq 0>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MaterialTypeID" value="#MaterialTypeID#" null="no">
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MaterialTypeID" null="yes">
	</cfif>
	<cfif FORM.Description neq "">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Description" value="#FORM.Description#" null="no">	
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Description" null="yes">	
	</cfif>
	<cfif FILE.ClientFileName neq "">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileName" value="#FILE.ClientFileName
#" null="no">
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileName" null="yes">
	</cfif>
	<cfif FILE.FileSize neq "">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FileSize" value="#FILE.FileSize#" null="no">
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@FileSize" null="yes">
	</cfif>
	<cfif FILE.ClientFileExt neq "">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileExtension" value="#FILE.ClientFileExt#" null="no">
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileExtension" null="yes">
	</cfif>
	<cfif FILE.contentType neq "">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentType" value="#FILE.contentType#">	
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentType" null="yes">
	</cfif>
	<cfif FILE.contentType neq "">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentSubType" value="#FILE.contentSubType#">
	<cfelse>
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FileContentSubType" null="yes">
	</cfif>
	<cfprocparam type="Out" cfsqltype="CF_SQL_INTEGER" variable="NewID" dbvarname="@NewID" null="yes">


CFFILE.TimeCreated
CFFILE.TimeLastModified




</cfstoredproc>
<cflock timeout="#CreateTimeSpan(0, 0, 60, 0)#" type="exclusive" scope="session">
	<cfset SESSION.MatID = NewID>
</cflock>
