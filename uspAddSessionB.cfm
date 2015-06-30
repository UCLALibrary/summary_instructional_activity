<cfinclude template="incCleanForm.cfm">
<cfscript>
	SessionDate = FORM.SessionDate;
	Hour = FORM.Hour;
	Minute = FORM.Minute;
	Marker = FORM.Marker;
	SessionDateTime = SessionDate & " " & Hour & ":" & Minute & " " & Marker;
</cfscript>
<cftry>
	<cfstoredproc procedure="uspSetDevTime" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevTime" null="yes">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@DevComment" null="yes">
	</cfstoredproc>

	<cfstoredproc procedure="uspSetSessionDetails" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#FORM.SessID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
		<cfif FORM.QuarterID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" value="#FORM.QuarterID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@QuarterID" null="yes">
		</cfif>
		<cfprocparam type="In" cfsqltype="CF_SQL_TIMESTAMP" dbvarname="@SessionDateTime" value="#SessionDateTime#" null="no">
		<cfif FORM.Duration neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Duration" value="#FORM.Duration#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@Duration" null="yes">
		</cfif>
		<cfif FORM.SessionCount neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessionCount" value="#FORM.SessionCount#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessionCount" null="yes">
		</cfif>
		<cfif FORM.PrepTime neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@PrepTime" value="#FORM.PrepTime#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@PrepTime" null="yes">
		</cfif>
		<cfif FORM.PrepComment neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@PrepComment" value="#FORM.PrepComment#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@PrepComment" null="yes">
		</cfif>
	</cfstoredproc>

	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database update error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>
		<!---cfif FORM.NumAttendees neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@NumAttendees" value="#FORM.NumAttendees#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@NumAttendees" null="yes">
		</cfif>
		<cfif FORM.GroupName neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@GroupName" value="#FORM.GroupName#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@GroupName" null="yes">
		</cfif>
		<cfif FORM.AffiliationID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffiliationID" value="#FORM.AffiliationID#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@AffiliationID" null="yes">
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" value="#FORM.DepartmentID#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" null="yes">
		</cfif>
		<cfif FORM.LearnerCategoryID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LearnerCategoryID" value="#FORM.LearnerCategoryID#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LearnerCategoryID" null="yes">
		</cfif>
		<cfif FORM.Comments neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Comments" value="#FORM.Comments#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Comments" null="yes">
		</cfif--->
		<!---cfif FORM.DevTime neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DevTime" value="#FORM.DevTime#">
		<cfelse>
		</cfif>
		<cfif FORM.DevComment neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@DevComment" value="#FORM.DevComment#">
		<cfelse>
		</cfif--->
