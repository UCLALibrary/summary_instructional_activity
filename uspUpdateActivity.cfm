<!---
// Required variables for uspUpdateActivity
@ActID INT,
@LibID INT,
@Title VARCHAR(255),
@ActivityTypeID INT = NULL,
@DeliveryModeID INT = NULL,
@Description TEXT = NULL,
@Duration INT = NULL,
@QuarterID INT = NULL,
@CompletionDT SMALLDATETIME = NULL,
@DevTime INT = NULL,
@DevComment TEXT = NULL
--->
<cfinclude template="incCleanForm.cfm">
<cftry>
	<cfstoredproc procedure="uspCheckActivityDupe" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" value="#FORM.Title#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActivityTypeID" value="#FORM.ActivityTypeID#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DeliveryModeID" value="#FORM.DeliveryModeID#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID"  value="#FORM.ActID#" null="no">
		<cfprocresult name="CheckDupe">
	</cfstoredproc>
	<cfif CheckDupe.Reps neq 0>
		<cfscript>
			up2snuff = 0;
			em = "Attempted update of activity would have caused duplication.";
		</cfscript>
	<cfelse>
		<cfstoredproc procedure="uspUpdateActivity" datasource="#APPLICATION.dsn#">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
			<cfif FORM.Title neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" value="#FORM.Title#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Title" null="yes">
			</cfif>
			<cfif FORM.ActivityTypeID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActivityTypeID" value="#FORM.ActivityTypeID#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActivityTypeID" null="yes">
			</cfif>
			<cfif FORM.DeliveryModeID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DeliveryModeID" value="#FORM.DeliveryModeID#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DeliveryModeID" null="yes">
			</cfif>
			<cfif FORM.Description neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Description" value="#FORM.Description#" null="no">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Description" null="yes">
			</cfif>
			<!---cfif FORM.Duration neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Duration" value="#FORM.Duration#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Duration" null="yes">
			</cfif>
			<cfif FORM.QuarterID neq 0>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" value="#FORM.QuarterID#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" null="yes">
			</cfif--->
			<!---cfif FORM.CompletionDT neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@CompletionDT" value="#FORM.CompletionDT#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@CompletionDT" null="yes">
			</cfif--->
			<cfif FORM.DevTime neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevTime" value="#FORM.DevTime#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevTime" null="yes">
			</cfif>
			<cfif FORM.DevComment neq "">
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@DevComment" value="#FORM.DevComment#">
			<cfelse>
				<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@DevComment" null="yes">
			</cfif>
		</cfstoredproc>
	</cfif>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database update error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>