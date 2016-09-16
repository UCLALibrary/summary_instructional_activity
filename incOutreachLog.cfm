<cfif Outreach.RecordCount eq 0>
	<cfset pageTitle = "No Outreach Log Found">
	<cfif Find("infoOutreach.cfm", SCRIPT_NAME)>
		<cfinclude template="incBeginInfo.cfm">
	<cfelse>
		<cfinclude template="incBegin.cfm">
	</cfif>
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No outreach log found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfset pageTitle = 'Log of Outreach Activity to ' & Outreach.Contact & ' on ' & DateFormat(Outreach.OutreachDT, APPLICATION.dateFormat)>
	<cfif not Find("deleteOutreach.cfm", SCRIPT_NAME)>
		<cfif Find("infoOutreach.cfm", SCRIPT_NAME)>
			<cfinclude template="incBeginInfo.cfm">
		<cfelse>
			<cfinclude template="incBegin.cfm">
		</cfif>
	</cfif>
	<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
	<div class="data">
		<cfoutput query="Outreach" group="OutreachID">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td nowrap class="fieldLabel">Name:</td>
								<td class="fieldValue">
									<strong>
										<cfif not ListContains("infoOutreach.cfm,deleteOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
											<a href="contact.cfm?CntctID=#Outreach.ContactID#">#Outreach.Contact#</a>
										<cfelse>
											#Outreach.Contact#
										</cfif>
									</strong>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Status:</td>
								<td class="fieldValue">
									<cfif not ListContains("infoOutreach.cfm,deleteOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<a href="outreach.cfm?StatID=#Outreach.ContactStatusID#">#Outreach.ContactStatus#</a>
									<cfelse>
										#Outreach.ContactStatus#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Department:</td>
								<td class="fieldValue">
									<cfif Outreach.ContactDepartmentID neq "">
										<cfif not ListContains("infoOutreach.cfm,deleteOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
											<a href="outreach.cfm?DeptID=#Outreach.ContactDepartmentID#">#Outreach.ContactDepartment#</a>
										<cfelse>
											#Outreach.ContactDepartment#
										</cfif>
									<cfelse>
										#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Other department/group:</td>
								<td class="fieldValue"><cfif Outreach.FacultyGroup neq "">#Outreach.FacultyGroup#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Purpose:</td>
								<td class="fieldValue" wrap>
									<cfif Outreach.Purpose neq "">#Outreach.Purpose#
									<cfelse>#APPLICATION.NullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Outcome:</td>
								<td class="fieldValue">
									<cfif Outreach.Outcome neq "">
										<ul>
											<cfloop index="oID" list="#Outreach.Outcome#" delimiters=",">
												<cfloop query="OutreachOutcome">
													<cfif oID eq OutreachOutcome.OutreachOutcomeID>
														<li>
															#OutreachOutcome.OutreachOutcome#
															<cfif oID eq 9>
																(#Outreach.OutcomeOther#)
															</cfif>
														</li>
													</cfif>
												</cfloop>
											</cfloop>
										</ul>
										<cfelse>
											#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
						</table>
					</td>
					<td width="2%">&nbsp;</td>
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td nowrap class="fieldLabel">Contacted by:</td>
								<td class="fieldValue">
									<cfif not ListContains("infoOutreach.cfm,deleteOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<a href="librarian.cfm?LibID=#Outreach.LibrarianID#">#Outreach.LibrarianLastName#</a>
									<cfelse>
										#Outreach.LibrarianLastName#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Contact method:</td>
								<td class="fieldValue">
									<cfif Outreach.Method neq "">
										<ul>
											<cfloop index="mID" list="#Outreach.Method#" delimiters=",">
												<cfloop query="OutreachMethod">
													<cfif mID eq OutreachMethod.OutreachMethodID>
														<li>
															#OutreachMethod.OutreachMethod#
															<cfif mID eq 5>
																(#Outreach.MethodOther#)
															</cfif>
														</li>
													</cfif>
												</cfloop>
											</cfloop>
										</ul>
									<cfelse>
										#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Initiated at/by:</td>
								<td class="fieldValue">
									<cfif Outreach.Initiate neq "">
										<ul>
											<cfloop index="iID" list="#Outreach.Initiate#" delimiters=",">
												<cfloop query="OutreachInitiate">
													<cfif iID eq OutreachInitiate.OutreachInitiateID>
														<li>
															#OutreachInitiate.OutreachInitiate#
															<cfif iID eq 6>
																(#Outreach.InitiateOther#)
															</cfif>
														</li>
													</cfif>
												</cfloop>
											</cfloop>
										</ul>
									<cfelse>
										#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Outreach date:</td>
								<td class="fieldValue">#DateFormat(Outreach.OutreachDT, APPLICATION.dateFormat)#</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Input on:</td>
								<td class="fieldValue">
									#DateFormat(Outreach.DBRCreatedDT, APPLICATION.dateFormat)# #TimeFormat(Outreach.DBRCreatedDT, APPLICATION.timeFormat)# by
									<cfif not ListContains("infoOutreach.cfm,deleteOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<a href="librarian.cfm?LibID=#Outreach.DBRCreatorID#">#Outreach.DBRCreator#</a>
									<cfelse>
										#Outreach.DBRCreator#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Last updated:</td>
								<td class="fieldValue">
									#DateFormat(Outreach.DBRUpdatedDT, APPLICATION.dateFormat)# #TimeFormat(Outreach.DBRUpdatedDT, APPLICATION.timeFormat)# by
									<cfif not ListContains("infoOutreach.cfm,deleteOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
										<a href="librarian.cfm?LibID=#Outreach.DBRUpdaterID#">#Outreach.DBRUpdater#</a>
									<cfelse>
										#Outreach.DBRUpdater#
									</cfif>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<cfif (SESSION.LibID eq Outreach.DBRCreatorID) and
			      (not ListContains("infoSession.cfm,deleteSession.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ","))>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<form action="updateOutreach.cfm" method="post">
								<input name="OutID" type="hidden" value="#OutID#">
								<input type="submit" class="mainControl" value="Update Outreach">
							</form>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<form action="deleteOutreach.cfm" method="post">
								<input name="OutID" type="hidden" value="#OutID#">
								<input type="submit" class="mainControl" value="Delete Outreach">
							</form>
						</td>
					</tr>
				</table>
			</cfif>
		</cfoutput>
	</div>
</cfif>