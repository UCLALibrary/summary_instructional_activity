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
	<cfset pageTitle = "Update Instructional Session Information">
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			function Show(which)
			{
				if(document.getElementById)
				{
					document.getElementById(which).style.visibility='visible'
				}

				if(document.all)
				{ //ie
					document.all[which].style.visibility='visible'
				}
			}
			function Hide(which)
			{

				if(document.getElementById)
				{
					document.getElementById(which).style.visibility='hidden'
				}

				if(document.all)
				{ //ie
					document.all[which].style.visibility='hidden'
				}
			}
		//-->
	</script>
	<cfoutput>
		<form action="updateAssessment.cfm"
			  method="post"
			  name="Assessment"
			  id="Assessment">
			<span class="formSectionTitle">Update Instructional Assessment Information</span>
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				</cfif>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right" class="first">Session title:</td>
						<td class="first"><strong>#Sess.Title#</strong></td>
					</tr>
					<tr>
						<td align="right" class="rest">Date and time of session:</td>
						<td class="rest">
							<strong>#DateFormat(Sess.SessionDateTime, APPLICATION.dateFormat)# #TimeFormat(Sess.SessionDateTime, "h:m tt")#</strong>
						</td>
					</tr>
					<tr valign="top">
						<td align="right" class="rest">Evaluation/Feedback:</td>
						<td class="rest">
							<cfoutput>
								<textarea name="FeedbackText" cols="75" rows="5"><cfif isDefined("FORM.FeedbackText")>#FORM.FeedbackText#<cfelseif isDefined("Sess.FeedbackText")>#Sess.FeedbackText#<cfelse></cfif></textarea>
							</cfoutput>
						</td>
					</tr>
					<tr valign="top">
						<td align="right" class="rest">Pre-test used:</td>
						<td class="rest">
							<input
								name="PreTest"
								type="radio"
								value="1"
								<cfif isDefined("FORM.PreTest") and FORM.PreTest eq 1>
									checked
								<cfelseif isDefined("Sess.PreTest") and Sess.Pretest eq 1>
									checked
								<cfelse>
								</cfif>
							>Yes
							<input
								name="PreTest"
								type="radio"
								value="0"
								<cfif isDefined("FORM.PreTest") and FORM.PreTest eq 0>
									checked
								<cfelseif isDefined("Sess.PreTest") and Sess.PreTest eq 0>
									checked
								<cfelse>
								</cfif>
							>No
						</td>
					</tr>
					<tr valign="top">
						<td align="right" class="rest">Post-test used:</td>
						<td class="rest">
							<input
								name="PostTest"
								type="radio"
								value="1"
								<cfif isDefined("FORM.PostTest") and FORM.PostTest eq 1>
									checked
								<cfelseif isDefined("Sess.PostTest") and Sess.PostTest eq 1>
									checked
								<cfelse>
								</cfif>
							>Yes
							<input
								name="PostTest"
								type="radio"
								value="0"
								<cfif isDefined("FORM.PostTest") and FORM.PostTest eq 0>
									checked
								<cfelseif isDefined("Sess.PostTest") and Sess.PostTest eq 0>
									checked
								<cfelse>
								</cfif>
							>No
						</td>
					</tr>
					<tr valign="top">
						<td align="right" class="rest">Formal assessment used:</td>
						<td class="rest">
							<cfset Lookup = "FormalAssessment">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<cfloop query="FormalAssessment">
								<input
									type="checkbox"
									name="FormalAssessmentID"
									value="#FormalAssessment.FormalAssessmentID#"
									<cfif isDefined("FORM.FormalAssessmentID")>
										<cfloop index="faID" list="#FORM.FormalAssessmentID#" delimiters=",">
											<cfif faID eq FormalAssessment.FormalAssessmentID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelseif isDefined("Sess.FormalAssessmentID")>
										<cfloop index="faID" list="#Sess.FormalAssessmentID#" delimiters=",">
											<cfif faID eq FormalAssessment.FormalAssessmentID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelse>
									</cfif>
								>#FormalAssessment.FormalAssessment#<br>
							</cfloop>
						</td>
					</tr>
					<tr valign="top">
						<td align="right" class="rest">Feedback from faculty:</td>
						<td class="rest">
							<cfset Lookup = "FeedbackFaculty">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<cfloop query="FeedbackFaculty">
								<input
									type="checkbox"
									name="FeedbackFacultyID"
									value="#FeedbackFaculty.FeedbackFacultyID#"
									<cfif isDefined("FORM.FeedbackFacultyID")>
										<cfloop index="ffID" list="#FORM.FeedbackFacultyID#" delimiters=",">
											<cfif ffID eq FeedbackFaculty.FeedbackFacultyID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelseif isDefined("Sess.FeedbackFacultID")>
										<cfloop index="ffID" list="#Sess.FeedbackFacultID#" delimiters=",">
											<cfif ffID eq FormalAssessment.FeedbackFacultyID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelse>
									</cfif>
								>#FeedbackFaculty.FeedbackFaculty#<br>
							</cfloop>
							<!--/input-->
						</td>
					</tr>
					<tr valign="top">
						<td align="right" class="rest">Feedback from students:</td>
						<td class="rest">
							<cfset Lookup = "FeedbackStudent">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<cfloop query="FeedbackStudent">
								<input
									type="checkbox"
									name="FeedbackStudentID"
									value="#FeedbackStudent.FeedbackStudentID#"
									<cfif isDefined("FORM.FeedbackStudentID")>
										<cfloop index="fsID" list="#FORM.FeedbackStudentID#" delimiters=",">
											<cfif fsID eq FeedbackStudent.FeedbackStudentID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelseif isDefined("Sess.FeedbackStudentID")>
										<cfloop index="fsID" list="#Sess.FeedbackStudentID#" delimiters=",">
											<cfif fsID eq FeedbackStudent.FeedbackStudentID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelse>
									</cfif>
								>
								<cfif FeedbackStudent.FeedbackStudentID eq 6>
									<cfset elementName = "FeedbackStudentID">
									<cfset elementLabel = "Classroom assessment technique (requires sub-type(s) below):">
									<cfinclude template="incHiLiteMissingElement.cfm">
								<cfelse>
									#FeedbackStudent.FeedbackStudent#<br>
								</cfif>
							</cfloop>
							<!--/input-->
							<table border="0" cellpadding="0" cellspacing="0">
								<tr valign="top">
									<td width="18">&nbsp;</td>
									<td class="rest">
										<cfset Lookup = "ClassroomAssessment">
										<cfset Header = "">
										<cfinclude template="uspGetLookup.cfm">
										<cfset x = 1>
										<cfset y = ClassroomAssessment.RecordCount>
										<cfset split = Ceiling(Evaluate(y/2)+1)>
										<cfloop query="ClassroomAssessment">
											<input
												type="checkbox"
												name="ClassroomAssessmentID"
												value="#ClassroomAssessment.ClassroomAssessmentID#"
												<cfif isDefined("FORM.ClassroomAssessmentID")>
													<cfloop index="caID" list="#FORM.ClassroomAssessmentID#" delimiters=",">
														<cfif caID eq ClassroomAssessment.ClassroomAssessmentID>
															checked
															<cfbreak>
														</cfif>
													</cfloop>
												<cfelseif isDefined("Sess.ClassroomAssessmentID")>
													<cfloop index="caID" list="#Sess.ClassroomAssessmentID#" delimiters=",">
														<cfif caID eq ClassroomAssessment.ClassroomAssessmentID>
															checked
															<cfbreak>
														</cfif>
													</cfloop>
												<cfelse>
												</cfif>
											>#ClassroomAssessment.ClassroomAssessment#<br>
											<cfset x = x + 1>
											<cfif x eq split>
												</td>
												<td class="rest">
											</cfif>
										</cfloop>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<input name="SessID" type="hidden" value="#Sess.SessionID#">
							<input name="ActID" type="hidden" value="#Sess.ActivityID#">
							<input name="reqElements" type="hidden" value="none">
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
						</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel">
							<!---form action="session.cfm?SessID=#Sess.SessionID#" method="post">
								<input name="Submit" type="submit" class="mainControl" value="Cancel">
							</form--->
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>
</cfif>