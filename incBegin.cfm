<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>SIA Database 2.0:
			<cfif IsDefined("pageTitle")>
				<cfoutput>#pageTitle#</cfoutput>
			</cfif>
		</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="css/global.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" type="text/javascript" src="js/incFunctions.js"></script>
	</head>
	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="middle">
				<td height="35" colspan="6" class="banner">
					<img src="images/SIA_S.gif" alt="UCLA Library SIA Database" width="235" height="30" hspace="15" border="0">
				</td>
			</tr>
		</table>
		<cfif not ListContains("createAccount.cfm,confirmAccount.cfm,setUnit.cfm,getPassword.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="middle">
					<cfif SESSION.UserLevelID neq 3>
						<cfloop index="x" from="1" to="#ArrayLen(navArray)#" step="1">
							<cfoutput>
								<td width="12%"
									<cfswitch expression="#x#">
										<cfcase value="1">
											<cfif ListContains("mySIA.cfm,changePassword.cfm,changedPassword.cfm,updateLibrarian.cfm,updateLibrarianExe.cfm,updatedLibrarian.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
												class="navLink1"
											<cfelse>
												class="navLink0"
											</cfif>
										</cfcase>
										<!---cfcase value="2">
											<cfif ListContains("activity.cfm,activities.cfm,updateActivity.cfm,updateActivityExe.cfm,addNewActivity.cfm,deleteActivity.cfm,deleteActivityExe.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")
												or
												  (ListContains("addRemoveLibrarian.cfm,addRemoveLibrarianExe.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and (isDefined("ActID") and ActID neq 0))>
												class="navLink1"
											<cfelse>
												class="navLink0"
											</cfif>
										</cfcase--->
										<cfcase value="2">
											<cfif ListContains("session.cfm,sessions.cfm,sessionsSupe.cfm,addNewSession.cfm,addNewSessionExe.cfm,updateSession.cfm,updateSessionExe.cfm,addSession.cfm,updateAssessment.cfm,updateAssessmentExe.cfm,deleteSession.cfm,deleteSessionExe.cfm,copySession.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")
												or
												  (ListContains("addRemoveLibrarian.cfm,addRemoveLibrarianExe.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and (isDefined("SessID") and SessID neq 0))>
												class="navLink1"
											<cfelse>
												class="navLink0"
											</cfif>
										</cfcase>
										<cfcase value="3">
											<cfif ListContains("material.cfm,materials.cfm,addMaterial.cfm,addRemoveMaterial.cfm,addNewMaterial.cfm,addRemoveMaterialExe.cfm,materialAddList.cfm,updateMaterial.cfm,updatedMaterial.cfm,deleteMaterial.cfm,deleteMaterialExe.cfm,materialRemoveList.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")
												or
												  (ListContains("addRemoveLibrarian.cfm,addRemoveLibrarianExe.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and (isDefined("MatID") and MatID neq 0))>
												class="navLink1"
											<cfelse>
												class="navLink0"
											</cfif>
										</cfcase>
										<cfcase value="4">
											<cfif ListContains("contact.cfm,contacts.cfm,addRemoveContact.cfm,addRemoveContactExe.cfm,addNewContact.cfm,addNewContactExe.cfm,updateContact.cfm,updateContactExe.cfm,outreach.cfm,outreachLog.cfm,addContact.cfm,addSessionContact.cfm,department.cfm,addNewOutreach.cfm,deleteOutreach.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
												class="navLink1"
											<cfelse>
												class="navLink0"
											</cfif>
										</cfcase>
										<cfcase value="5">
											<cfif ListContains("classrooms.cfm,classroom.cfm,addNewClassroom.cfm,addNewClassroomExe.cfm,addRemoveClassroom.cfm,updateClassroom.cfm,updateClassroomExe.cfm,deleteClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
												class="navLink1"
											<cfelse>
												class="navLink0"
											</cfif>
										</cfcase>
										<cfcase value="6">
											<cfif ListContains("reports.cfm,selReport.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
												class="navLink1"
											<cfelse>
												class="navLink0"
											</cfif>
										</cfcase>
										<cfdefaultcase>
											class="navLink0"
										</cfdefaultcase>
									</cfswitch>
								>
									<a href="#navArray[x][1]#">#navArray[x][2]#</a>
								</td>
							</cfoutput>
						</cfloop>
					<cfelse>
						<cfoutput>
							<td width="50%"
								<cfif ListContains("reports.cfm,selReport.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
									class="navLink1"
								<cfelse>
									class="navLink0"
								</cfif>
							>
								<a href="#navArray[6][1]#">#navArray[6][2]#</a>
							</td>
						</cfoutput>
					</cfif>
					<td width="15%" class="navLinkLog"><a href="logoutExe.cfm">Log Out</a></td>
					<td width="10%" class="navSpace">&nbsp;</td>
				</tr>
			</table>
		</cfif>
		<div id="liveArea">