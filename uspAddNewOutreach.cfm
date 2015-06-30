<!---
// Required variables for uspAddOutreach
@LibID INT,
@CntctID INT,
@Purpose VARCHAR(500) = NULL,
@OutreachDT SMALLDATETIME,
@Method VARCHAR(50) = NULL,
@Initiate VARCHAR(50) = NULL,
@Outcome VARCHAR(50) = NULL,
@OutcomeOther VARCHAR(255) = NULL,
@InitiateOther VARCHAR(255) = NULL,
@MethodOther VARCHAR(255) = NULL
--->
<cfinclude template="incCleanForm.cfm">
<cftry>
	<cfstoredproc procedure="uspAddOutreach" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#FORM.CntctID#">
		<cfif isDefined("FORM.Purpose")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Purpose" value="#FORM.Purpose#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Purpose" null="yes">
		</cfif>
		<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@OutreachDT" value="#FORM.OutreachDT#">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" null="yes">
		<cfif isDefined("FORM.QuarterID")>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" value="#FORM.QuarterID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" null="yes">
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" value="#FORM.DepartmentID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" null="yes">
		</cfif>
		<cfif isDefined("FORM.FacultyGroup")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FacultyGroup" value="#FORM.FacultyGroup#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FacultyGroup" null="yes">
		</cfif>
		<cfif isDefined("FORM.Method")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Method" value="#FORM.Method#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Method" null="yes">
		</cfif>
		<cfif isDefined("FORM.Initiate")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Initiate" value="#FORM.Initiate#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Initiate" null="yes">
		</cfif>
		<cfif isDefined("FORM.Outcome")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Outcome" value="#FORM.Outcome#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Outcome" null="yes">
		</cfif>
		<cfif isDefined("FORM.OutcomeOther")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@OutcomeOther" value="#FORM.OutcomeOther#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@OutcomeOther" null="yes">
		</cfif>
		<cfif isDefined("FORM.InitiateOther")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@InitiateOther" value="#FORM.InitiateOther#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@InitiateOther" null="yes">
		</cfif>
		<cfif isDefined("FORM.MethodOther")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@MethodOther" value="#FORM.MethodOther#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@MethodOther" null="yes">
		</cfif>
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database insert error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>