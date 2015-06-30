<!---
// Required variables for uspAddContact
LibID;
LastName;
FirstName;
Title;
ContactStatusID;
AffiliationID;
DepartmentID;
FacultyGroup;
Email;
Telephone;
TelephoneMobile;
Fax;
CampusAddress;
CampusMailCode;
SessID;
ActID;
MatID;
--->
<cfscript>
	if (isDefined("FORM.SessID"))
	{
		SessID = FORM.SessID;
	}
	else
	{
		SessID = 0;
	}
	if (isDefined("FORM.ActID"))
	{
		ActID = FORM.ActID;
	}
	else
	{
		ActID = 0;
	}
	if (isDefined("FORM.MatID"))
	{
		MatID = FORM.MatID;
	}
	else
	{
		MatID = 0;
	}
</cfscript>
<cfinclude template="incCleanForm.cfm">
<cfset newCntct="">
<cftry>
	<cfstoredproc procedure="uspCheckContactDupe" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@LastName" value="#FORM.LastName#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FirstName" value="#FORM.FirstName#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Email" value="#FORM.Email#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ContactID" null="yes">
		<cfprocresult name="CheckDupe">
	</cfstoredproc>
	<cfif CheckDupe.Reps neq 0>
		<cfscript>
			up2snuff = 0;
			em = "Sorry--that contact already exists in the SIA database.";
		</cfscript>
	<cfelse>
		<cfstoredproc procedure="uspAddContact" datasource="#APPLICATION.dsn#">
			<cfprocparam type="Out" cfsqltype="CF_SQL_INTEGER" dbvarname="@NewID" variable="newCntct"  null="yes">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@LastName" value="#FORM.LastName#">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FirstName" value="#FORM.FirstName#">
			<cfif FORM.Title neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" value="#FORM.Title#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" null="yes">
			</cfif>
			<cfif FORM.ContactStatusID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ContactStatusID" value="#FORM.ContactStatusID#" null="no">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ContactStatusID" null="yes">
			</cfif>
			<cfif FORM.AffiliationID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffiliationID" value="#FORM.AffiliationID#" null="no">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffiliationID" null="yes">
			</cfif>
			<cfif FORM.DepartmentID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" value="#FORM.DepartmentID#" null="no">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" null="yes">
			</cfif>
			<cfif FORM.FacultyGroup neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FacultyGroup" value="#FORM.FacultyGroup#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FacultyGroup" null="yes">
			</cfif>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Email" value="#FORM.Email#">
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
			<cfif FORM.CampusAddress neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusAddress" value="#FORM.CampusAddress#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusAddress" null="yes">
			</cfif>
			<cfif FORM.CampusMailCode neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusMailCode" value="#FORM.CampusMailCode#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CampusMailCode" null="yes">
			</cfif>
			<cfif FORM.Comments neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Comments" value="#FORM.Comments#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Comments" null="yes">
			</cfif>
			<cfif SessID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#" null="no">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" null="yes">
			</cfif>
			<cfif ActID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#ActID#" null="no">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" null="yes">
			</cfif>
			<cfif MatID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" value="#MatID#" null="no">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" null="yes">
			</cfif>
			<!---cfprocresult name="Cnct"--->
		</cfstoredproc>
		<!---cflock timeout="#CreateTimeSpan(0, 0, 120, 0)#" throwontimeout="no" type="exclusive" scope="session">
			<cfset SESSION.NewCnctID = Cnct.CntctID>
		</cflock--->
	</cfif>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database insert error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>