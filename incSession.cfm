<cfif Sess.RecordCount eq 0>
	<cfset pageTitle = "No Instructional Session Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional session found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfif not Find("deleteSession.cfm", SCRIPT_NAME)>
		<cfset pageTitle = Sess.Title>
		<cfif Find("infoSess.cfm", SCRIPT_NAME)>
			<cfinclude template="incBeginInfo.cfm">
		<cfelse>
			<cfinclude template="incBegin.cfm">
		</cfif>
	</cfif>
	<span class="dataSectionTitle">Instructional Session Information</span>
	<div class="data">
		<cfoutput query="Sess" group="SessionID">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td nowrap class="fieldLabel">Department | Campus Unit | Group:</td>
								<td class="fieldValue">
									<cfif Sess.SessDeptTitle neq "">
									<strong>
											#Sess.SessDeptTitle#
									</strong>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Course Number:</td>
								<td class="fieldValue">
									<cfif Sess.CourseNumber neq "">
										#Sess.CourseNumber#
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Course Section:</td>
								<td class="fieldValue">
									<cfif Sess.CourseSection neq "">
										#Sess.CourseSection#
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Session Title:</td>
								<td class="fieldValue">
									<cfif Sess.Title neq "">
										<cfif Sess.SessDeptTitle eq "">
											<strong>#Sess.Title#</strong>
										<cfelse>#Sess.Title#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Primary Session type:</td>
								<td class="fieldValue">
									<cfif Activity.ActivityType neq "">
										<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") and (SESSION.UserLevelID gt 1)>
											<a href="activities.cfm?ActTypID=#Activity.ActivityTypeID#">#Activity.ActivityType#</a>
										<cfelse>#Activity.ActivityType#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Scholarly Communication:</td>
								<td class="fieldValue">
									<cfif Sess.ScholarlyCommunication neq "">
										<!---cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") and (SESSION.UserLevelID gt 1)>
											<a href="activities.cfm?DelModID=#Activity.DeliveryModeID#">#Activity.DeliveryMode#</a>
										<cfelse>#Activity.DeliveryMode#
										</cfif--->
										<cfif Sess.ScholarlyCommunication eq "1">Yes
										<cfelse>No
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Scholarly Communication type(s):</td>
								<td class="fieldValue">
									<cfif Activity.ScholCommTypes neq "">
										#Activity.DisplaySecondary#
										<!---cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") and (SESSION.UserLevelID gt 1)>
											<a href="activities.cfm?ActTypID=#Activity.ActivityTypeID#">#Activity.ActivityType#</a>
										<cfelse>#Activity.ActivityType#
										</cfif--->
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Delivery mode(s):</td>
								<td class="fieldValue">
									<cfif Activity.DeliveryModes neq "">
										#Activity.DisplayDelivery#
										<!---cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") and (SESSION.UserLevelID gt 1)>
											<a href="activities.cfm?DelModID=#Activity.DeliveryModeID#">#Activity.DeliveryMode#</a>
										<cfelse>#Activity.DeliveryMode#
										</cfif--->
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Description:</td>
								<td class="fieldValue"><cfif Activity.Description neq "">#Activity.Description#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Instructor Learned:</td>
								<td class="fieldValue"><cfif Sess.Learned neq "">#Sess.Learned#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Presenter(s):</td>
								<td class="fieldValue">
									<cfif Presenters.RecordCount neq 0>
										<cfloop query="Presenters">
											<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
												<a href="librarian.cfm?LibID=#Presenters.LibrarianID#">#Presenters.Lastname#</a>
												<cfif SESSION.UserLevelID gt 1>
													(<a href="sessions.cfm?UID=#Presenters.UnitID#">#Presenters.Unit#</a>)
												<cfelse>
													(#Presenters.Unit#)
												</cfif>
											<cfelse>#Presenters.Lastname# (#Presenters.Unit#)
											</cfif>
											<br>
										</cfloop>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
									<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(SessEditorID, SESSION.LibID, ",") ) or
									        ( SESSION.UserLevelID eq 5 ) ) and
									        not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<form action="addRemoveLibrarian.cfm" method="post">
											<input name="SessID" type="hidden" value="#SessID#">
											<input name="ActID" type="hidden" value="#ActID#">
											<input name="LibType" type="hidden" value="present">
											<cfif Presenters.RecordCount gt 0>
												<input name="addRem" type="submit" class="subControl" value="Add/Remove Presenter">
											<cfelse>
												<input name="add" type="submit" class="subControl" value="Add Presenter">
											</cfif>
										</form>
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Quarter:</td>
								<td class="fieldValue">
									<cfif Sess.Quarter neq "">
										<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
											<cfif SESSION.UserLevelID gt 1>
												<a href="sessions.cfm?Yr=#DatePart("yyyy", Sess.SessionDateTime)#&QuartID=#Sess.QuarterID#">'#Right(DatePart("yyyy", Sess.SessionDateTime), 2)# #Sess.Quarter#</a>
											<cfelse>
												'#Right(DatePart("yyyy", Sess.SessionDateTime), 2)# #Sess.Quarter#
											</cfif>
										<cfelse>'#Right(DatePart("yyyy", Sess.SessionDateTime), 2)# #Sess.Quarter#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Date:</td>
								<td class="fieldValue">
									<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<cfif SESSION.UserLevelID gt 1>
											<a href="sessions.cfm?sDT=#URLEncodedFormat(DateFormat(Sess.SessionDateTime, "mm/dd/yy"))#">#DateFormat(Sess.SessionDateTime, "mm/dd/yy")#</a>
										<cfelse>
											#DateFormat(Sess.SessionDateTime, "mm/dd/yy")#
										</cfif>
									<cfelse>#DateFormat(Sess.SessionDateTime, "mm/dd/yy")#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Time:</td>
								<td class="fieldValue">
									<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<cfif SESSION.UserLevelID gt 1>
											<a href="sessions.cfm?Hr=#DatePart("h", Sess.SessionDateTime)#">	#TimeFormat(Sess.SessionDateTime, "h:mm tt")#</a>
										<cfelse>
											#TimeFormat(Sess.SessionDateTime, "h:mm tt")#
										</cfif>
									<cfelse>#TimeFormat(Sess.SessionDateTime, "h:mm tt")#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Duration:</td>
								<td class="fieldValue">
									<cfif Sess.duration neq "">#Sess.Duration# min.
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Session count:</td>
								<td class="fieldValue">
									<cfif Activity.SessionCount neq "">#Activity.SessionCount#
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Affiliation:</td>
								<td class="fieldValue">
									<cfif Sess.SessionAffiliation neq "">
										<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
											<cfif SESSION.UserLevelID gt 1>
												<a href="sessions.cfm?AffID=#Sess.AffiliationID#">#Sess.SessionAffiliation#</a>
											<cfelse>
												#Sess.SessionAffiliation#
											</cfif>
										<cfelse>#Sess.SessionAffiliation#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Learner cat.:</td>
								<td class="fieldValue">
									<cfif Sess.LearnerCategorys neq "">
										<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
											<cfif SESSION.UserLevelID gt 1>
												<a href="sessions.cfm?LrCatID=#Sess.LearnerCategoryID#">#Sess.LearnerCategorys#</a>
											<cfelse>
												#Sess.LearnerCategorys#
											</cfif>
										<cfelse>#Sess.LearnerCategorys#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Num. students:</td>
								<td class="fieldValue">
									<cfif Sess.NumAttendees neq "">#Sess.NumAttendees#
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>

							<tr valign="top">
								<td nowrap class="fieldLabel">Strategic Initiatives:</td>
								<td class="fieldValue">
									<cfif Sess.Initiatives neq "">#Sess.Initiatives#
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Suppl. materials:</td>
								<td class="fieldValue">
									<cfif Material.RecordCount neq 0>
										<ul>
											<cfloop query="Material">
												<li>
													<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
														<a href="material.cfm?MatID=#Material.MaterialID#">#Material.MaterialTitle#</a>
													<cfelse>#Material.MaterialTitle#
													</cfif>
												</li>
											</cfloop>
										</ul>
									<cfelse>
										None<br>
									</cfif>
									<cfif
										( ( SESSION.UserLevelID eq 1 and (IsDefined("ActEditorID") and ListContains(ActEditorID, SESSION.LibID, ",") ) ) or
											( SESSION.UserLevelID eq 5 ) ) and
										( not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") )>
										<form action="addRemoveMaterial.cfm" method="post">
											<input name="SessID" type="hidden" value="#SessID#">
											<input name="ActID" type="hidden" value="#ActID#">
											<input type="hidden" name="caller" value="incSession">
											<input type="hidden" name="matCount" value="#Material.RecordCount#">
											<cfif Material.RecordCount gt 0>
												<input name="addRem" type="submit" class="subControl" value="Add/Remove Material">
											<cfelse>
												<input name="add" type="submit" class="subControl" value="Add Material">
											</cfif>
										</form>
									</cfif>
								</td>
							</tr>
						</table>
					</td>
					<td width="2%">&nbsp;</td>
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td nowrap class="fieldLabel">Session location:</td>
								<td class="fieldValue">
									<cfif Classroom.RecordCount neq 0>
										<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
											<a href="classroom.cfm?ClassID=#Classroom.ClassroomID#">#Classroom.Name#</a>
										<cfelse>#Classroom.Name#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
									<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(SessEditorID, SESSION.LibID, ",") ) or
									        ( SESSION.UserLevelID eq 5 ) ) and
									      not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<form action="addRemoveClassroom.cfm" method="post">
											<input name="SessID" type="hidden" value="#SessID#">
											<input name="ActID" type="hidden" value="#ActID#">
											<cfif Classroom.RecordCount gt 0>
												<input name="addRemClass" type="submit" class="subControl" value="Change/Remove">
											<cfelse>
												<input name="Add" type="submit" class="subControl" value="Assign Classroom">
											</cfif>
										</form>
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Fac./TA contact(s):</td>
								<td class="fieldValue">
									<cfif Contact.RecordCount neq 0>
										<cfloop query="Contact">
											<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
												<a href="contact.cfm?CntctID=#Contact.ContactID#">#Contact.Contact#</a>
											<cfelse>#Contact.Contact#
											</cfif>
											<br>
										</cfloop>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
									<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(SessEditorID, SESSION.LibID, ",") ) or
									        ( SESSION.UserLevelID eq 5 ) ) and
									      ( not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") )>
										<form action="addRemoveContact.cfm" method="post">
											<input name="SessID" type="hidden" value="#SessID#">
											<input name="ActID" type="hidden" value="#ActID#">
											<cfif Contact.RecordCount gt 0>
												<input name="addRem" type="submit" class="subControl" value="Add/Remove Contact">
											<cfelse>
												<input name="add" type="submit" class="subControl" value="Add Contact">
											</cfif>
										</form>
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Learner Academic Departments:</td>
								<td class="fieldValue">
									<cfif Sess.SessionDepartment neq "">
										<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
											<a href="department.cfm?DeptID=#Sess.SessionDepartmentID#">#Sess.SessionDepartment#</a>
											<cfif Sess.SessionDepartmentID eq 196 OR Sess.SessionDepartmentID eq 197>
												<br/>(#Sess.other_multi_dept#)
											</cfif>
										<cfelse>#Sess.SessionDepartment#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Developed by:</td>
								<td class="fieldValue">
									<cfif Developers.RecordCount neq 0>
										<cfloop query="Developers">
											<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
												<a href="librarian.cfm?LibID=#Developers.LibrarianID#">#Developers.Lastname#</a>
												<cfif SESSION.UserLevelID gt 1>
													(<a href="activities.cfm?UID=#Developers.UnitID#">#Developers.Unit#</a>)
												<cfelse>
													(#Developers.Unit#)
												</cfif>
											<cfelse>#Developers.Lastname# (#Developers.Unit#)
											</cfif>
											<br>
										</cfloop>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
									<cfif ( ( SESSION.UserLevelID eq 1 and (IsDefined("ActEditorID") and ListContains(ActEditorID, SESSION.LibID, ",") ) ) or
									        ( SESSION.UserLevelID eq 5 ) ) and
										    ( not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") )>
										<form action="addRemoveLibrarian.cfm" method="post">
											<input name="SessID" type="hidden" value="#SessID#">
											<input name="ActID" type="hidden" value="#ActID#">
											<input name="LibType" type="hidden" value="develop">
											<cfif Developers.RecordCount gt 0>
												<input name="addRem" type="submit" class="subControl" value="Add/Remove Developer">
											<cfelse>
												<input name="add" type="submit" class="subControl" value="Add Developer">
											</cfif>
										</form>
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Total prep. time:</td>
								<td class="fieldValue">
									<cfif SESSION.UserLevelID lt 2>
										<cfif Sess.PrepTime neq "">#Sess.PrepTime# min.
										<cfelse>#APPLICATION.nullCaption#
										</cfif>
									<cfelse>
										<cfif Sess.TotalPrepTime neq "">#Sess.TotalPrepTime# min.
										<cfelse>#APPLICATION.nullCaption#
										</cfif>
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Prep. comment:</td>
								<td class="fieldValue">
									<cfif Sess.PrepComment neq "">
										<cfset x = 0>
										<cfoutput>
											<cfif x gt 1>;</cfif>
											#Sess.PrepComment#
											<cfset x = x + 1>
										</cfoutput>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Input on:</td>
								<td class="fieldValue">
									#DateFormat(Sess.DBRCreatedDT, APPLICATION.dateFormat)# #TimeFormat(Sess.DBRCreatedDT, APPLICATION.timeFormat)# by
									<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<a href="librarian.cfm?LibID=#Sess.DBRCreatorID#">#Sess.DBRCreator#</a>
									<cfelse>#Sess.DBRCreator#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Last updated:</td>
								<td class="fieldValue">
									#DateFormat(Sess.DBRUpdatedDT, APPLICATION.dateFormat)# #TimeFormat(Sess.DBRUpdatedDT, APPLICATION.timeFormat)# by
									<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<a href="librarian.cfm?LibID=#Sess.DBRUpdaterID#">#Sess.DBRUpdater#</a>
									<cfelse>#Sess.DBRUpdater#
									</cfif>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(SessEditorID, SESSION.LibID, ",") ) or
					( SESSION.UserLevelID eq 5 ) ) and
			      ( not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") )>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<form action="updateSession.cfm" method="post">
								<input type="submit" class="mainControl" value="Update Session">
								<input name="ActID" type="hidden" value="#ActID#">
								<input name="SessID" type="hidden" value="#Sess.SessionID#">
							</form>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<form action="deleteSession.cfm" method="post">
								<input name="SessID" type="hidden" value="#Sess.SessionID#">
								<input name="ActID" type="hidden" value="#ActID#">
								<input
									type="submit"
									class="mainControl"
									value="Delete Session"
									<cfif (SESSION.LibID neq Sess.DBRCreatorID) or (Relationships.Total gt 0)>
										disabled="true"
									</cfif>
								>
							</form>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<form action="copySession.cfm" method="post">
								<input type="submit" class="mainControl" value="Copy Session">
								<input name="ActID" type="hidden" value="#ActID#">
								<input name="SessID" type="hidden" value="#Sess.SessionID#">
							</form>
						</td>
					</tr>
				</table>
			</cfif>
		</cfoutput>
	</div>
	<cfif not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
		<span class="formSectionTitle">Instructional Assessment Information</span>
		<div class="data">
			<cfoutput>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td width="49%">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr valign="top">
									<td nowrap class="fieldLabel">Pre-test:</td>
									<td class="fieldValue">
										<cfif Sess.PreTest neq "">#Sess.PreTest#
										<cfelse>#APPLICATION.nullCaption#
										</cfif>
									</td>
								</tr>
								<tr valign="top">
									<td nowrap class="fieldLabel">Post-test:</td>
									<td class="fieldValue">
										<cfif Sess.PostTest neq "">#Sess.PostTest#
										<cfelse>#APPLICATION.nullCaption#
										</cfif>
									</td>
								</tr>
								<tr valign="top">
									<td nowrap class="fieldLabel">Formal assessment:</td>
									<td class="fieldValue">
										<cfif Sess.FormalAssessmentID neq "">
											<cfset Lookup = "FormalAssessment">
											<cfset Header = "">
											<cfinclude template="uspGetLookup.cfm">
											<ul>
												<cfloop index="faID" list="#Sess.FormalAssessmentID#" delimiters=",">
													<cfloop query="FormalAssessment">
														<cfif faID eq FormalAssessment.FormalAssessmentID>
															<li>#FormalAssessment.FormalAssessment#</li>
														</cfif>
													</cfloop>
												</cfloop>
											</ul>
										<cfelse>#APPLICATION.nullCaption#
										</cfif>
									</td>
								</tr>
								<tr valign="top">
									<td nowrap class="fieldLabel">Faculty feedback:</td>
									<td class="fieldValue">
										<cfif Sess.FeedbackFacultyID neq "">
											<cfset Lookup = "FeedbackFaculty">
											<cfset Header = "">
											<cfinclude template="uspGetLookup.cfm">
											<ul>
												<cfloop index="ffID" list="#Sess.FeedbackFacultyID#" delimiters=",">
													<cfloop query="FeedbackFaculty">
														<cfif ffID eq FeedbackFaculty.FeedbackFacultyID>
															<li>#FeedbackFaculty.FeedbackFaculty#</li>
														</cfif>
													</cfloop>
												</cfloop>
											</ul>
										<cfelse>#APPLICATION.nullCaption#
										</cfif>
									</td>
								</tr>
							</table>
						</td>
						<td width="2%">&nbsp;</td>
						<td width="49%">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr valign="top">
									<td nowrap class="fieldLabel">Student feedback:</td>
									<td class="fieldValue">
										<cfif Sess.FeedbackStudentID neq "">
											<cfset Lookup = "FeedbackStudent">
											<cfset Header = "">
											<cfinclude template="uspGetLookup.cfm">
											<ul>
												<cfloop index="fsID" list="#Sess.FeedbackStudentID#" delimiters=",">
													<cfloop query="FeedbackStudent">
														<cfif fsID eq FeedbackStudent.FeedbackStudentID>
															<cfif fsID eq 6>
																<li>#FeedbackStudent.FeedbackStudent#<br>(types listed below)
																	<cfset Lookup = "ClassroomAssessment">
																	<cfset Header = "">
																	<cfinclude template="uspGetLookup.cfm">
																	<ul>
																		<cfloop index="caID" list="#Sess.ClassroomAssessmentID#" delimiters=",">
																			<cfloop query="ClassroomAssessment">
																				<cfif caID eq ClassroomAssessment.ClassroomAssessmentID>
																					<li style="list-style-type:circle;">#ClassroomAssessment.ClassroomAssessment#</li>
																				</cfif>
																			</cfloop>
																		</cfloop>
																	</ul>
																</li>
															<cfelse>
																<li>#FeedbackStudent.FeedbackStudent#</li>
															</cfif>
														</cfif>
													</cfloop>
												</cfloop>
											</ul>
										<cfelse>#APPLICATION.nullCaption#
										</cfif>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr valign="top">
						<td width="49%">
							Feedback story:
						</td>
						<td width="2%">&nbsp;</td>
						<td width="49%">
							#Sess.FeedbackText#
						</td>
					</tr>
				</table>
				<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(SessEditorID, SESSION.LibID, ",") ) or
						( SESSION.UserLevelID eq 5 ) ) and
				      ( not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",") )>
					<form action="updateAssessment.cfm" method="post">
						<input type="submit" class="mainControl" value="Add Assessment">
						<input name="SessID" type="hidden" value="#Sess.SessionID#">
						<input name="ActID" type="hidden" value="#Sess.ActivityID#">
					</form>
				</cfif>
			</cfoutput>
		</div>
	</cfif>
</cfif>
