<!---
// Required variables for uspUpdateAssessment
SessID;
LibID;
PreTest;
PostTest;
FormalAssessmentID;
FeedBackFacultyID;
FeedBackStudentID;
ClassroomAssessmentID;
--->
<cfinclude template="incCleanForm.cfm">
<cfscript>
	if (StructKeyExists(FORM, "FeedbackStudentID") and StructKeyExists(FORM, "ClassroomAssessmentID")) {
		if (not FORM.FeedbackStudentID contains 6) {
			FeedbackStudentID = ListAppend(FORM.FeedbackStudentID, "6", ",");
			ClassroomAssessmentID = FORM.ClassroomAssessmentID;
		}
		else {
			FeedbackStudentID = FORM.FeedbackStudentID;
			ClassroomAssessmentID = FORM.ClassroomAssessmentID;
		}
	}
	else if (StructKeyExists(FORM, "FeedbackStudentID") and not StructKeyExists(FORM, "ClassroomAssessmentID")) {
		FeedbackStudentID = FORM.FeedbackStudentID;
		ClassroomAssessmentID = 0;
	}
	else if (not StructKeyExists(FORM, "FeedbackStudentID") and StructKeyExists(FORM, "ClassroomAssessmentID")) {
		FeedbackStudentID = 6;
		ClassroomAssessmentID = FORM.ClassroomAssessmentID;
	}
	else {
		ClassroomAssessmentID = 0;
		FeedbackStudentID = 0;
	}
</cfscript>
<cftry>
	<cfstoredproc procedure="uspUpdateAssessment" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#FORM.SessID#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#" null="no">
		<cfif isDefined("FORM.PreTest")>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@PreTest" value="#FORM.PreTest#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@PreTest" null="yes">
		</cfif>
		<cfif isDefined("FORM.PostTest")>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@PostTest" value="#FORM.PostTest#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@PostTest" null="yes">
		</cfif>
		<cfif isDefined("FORM.FormalAssessmentID")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FormalAssessmentID" value="#FORM.FormalAssessmentID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FormalAssessmentID" null="yes">
		</cfif>
		<cfif isDefined("FORM.FeedBackFacultyID")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FeedBackFacultyID" value="#FORM.FeedBackFacultyID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FeedBackFacultyID" null="yes">
		</cfif>
		<cfif FeedBackStudentID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FeedBackStudentID" value="#FeedBackStudentID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FeedBackStudentID" null="yes">
		</cfif>
		<cfif ClassroomAssessmentID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ClassroomAssessmentID" value="#ClassroomAssessmentID#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ClassroomAssessmentID" null="yes">
		</cfif>
		<cfif isDefined("FORM.FeedbackText")>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FeedbackText" value="#FORM.FeedbackText#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@FeedbackText" null="yes">
		</cfif>
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database update error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>