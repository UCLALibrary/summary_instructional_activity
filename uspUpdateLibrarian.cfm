<!--
// Required variables for uspUpdateLibrarian
LibID;
LastName;
FirstName;
Title;
CampusAddress;
CampusMailcode;
Telephone;
TelephoneMobile;
Fax;
Email;
--->
<cfinclude template="incCleanForm.cfm">
<cftry>
	<cfstoredproc procedure="uspUpdateLibrarian" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@LastName" value="#FORM.LastName#">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FirstName" value="#FORM.FirstName#">
		<cfif FORM.Title neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" value="#FORM.Title#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" null="yes">
		</cfif>
		<cfif FORM.CampusAddress neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusAddress" value="#FORM.CampusAddress#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusAddress" null="yes">
		</cfif>
		<cfif FORM.CampusMailcode neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusMailcode" value="#FORM.CampusMailcode#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusMailcode" null="yes">
		</cfif>
		<cfif FORM.Telephone neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Telephone" value="#FORM.Telephone#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Telephone" null="yes">
		</cfif>
		<cfif FORM.TelephoneMobile neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@TelephoneMobile" value="#FORM.TelephoneMobile#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@TelephoneMobile" null="yes">
		</cfif>
		<cfif FORM.Fax neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Fax" value="#FORM.Fax#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Fax" null="yes">
		</cfif>
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Email" value="#FORM.Email#">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database update error. Please try again.";
		</cfscript>
	</cfcatch>	
</cftry>
