<!---
// Required variables for uspAddNewSession
@LibID INT,
@ActID INT,
@QuarterID INT = NULL,
@SessionDateTime SMALLDATETIME = NULL,
@Duration INT = NULL,
@NumAttendees INT = NULL,
@NumEnrolled INT = NULL,
@GroupName VARCHAR(255) = NULL,
@DepartmentID INT = NULL,
@AffiliationID INT = NULL,
@LearnerCategoryID INT = NULL,
PrepTime INT = NULL
PrepComment TEXT = NULL
--->
<cfinclude template="incCleanForm.cfm">
<cfscript>
	SessionDate = FORM.SessionDate;
	Hour = FORM.Hour;
	Minute = FORM.Minute;
	Marker = FORM.Marker;
	SessionDateTime = SessionDate & " " & Hour & ":" & Minute & " " & Marker;
</cfscript>
<cftry>
  <cfstoredproc procedure="uspAddSession" datasource="#APPLICATION.dsn#">
    <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
    <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
    <cfif FORM.QuarterID neq 0>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" value="#FORM.QuarterID#" null="no">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" null="yes">
    </cfif>
    <cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@SessionDateTime" value="#SessionDateTime#" null="no">
    <cfif FORM.Duration neq "">
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Duration" value="#FORM.Duration#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Duration" null="yes">
    </cfif>
    <cfif FORM.NumAttendees neq "">
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@NumAttendees" value="#FORM.NumAttendees#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@NumAttendees" null="yes">
    </cfif>
    <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@NumEnrolled" null="yes">
    <!---cfif FORM.NumEnrolled neq "">
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@NumEnrolled" value="#FORM.NumEnrolled#">
	  <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@NumEnrolled" null="yes">
    </cfif--->
    <cfif FORM.GroupName neq "">
      <cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@GroupName" value="#FORM.GroupName#" null="no">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@GroupName" null="yes">
    </cfif>
    <cfif FORM.DepartmentID neq 0>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" value="#FORM.DepartmentID#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" null="yes">
    </cfif>
    <cfif FORM.AffiliationID neq 0>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffiliationID" value="#FORM.AffiliationID#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffiliationID" null="yes">
    </cfif>
    <cfif FORM.LearnerCategoryID neq 0>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LearnerCategoryID" value="#FORM.LearnerCategoryID#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LearnerCategoryID" null="yes">
    </cfif>
    <cfif FORM.PrepTime neq "">
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@PrepTime" value="#FORM.PrepTime#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@PrepTime" null="yes">
    </cfif>
    <cfif FORM.PrepComment neq "">
      <cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@PrepComment" value="#FORM.PrepComment#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@PrepComment" null="yes">
    </cfif>
    <cfif FORM.Comments neq "">
      <cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Comments" value="#FORM.Comments#">
      <cfelse>
      <cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Comments" null="yes">
    </cfif>
    <cfprocresult name="Sess">
  </cfstoredproc>
  <cfcatch type="Database">
	<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
    <cfscript>
			up2snuff = 0;
			//em = "Database insert error. Please try again.";
		</cfscript>
  </cfcatch>
</cftry>
