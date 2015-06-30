<cfif Activity.RecordCount eq 0>
	<cfset pageTitle = "No Instructional Activity Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional activity found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfif not Find("deleteActivity.cfm", SCRIPT_NAME)>
		<cfset pageTitle = Activity.Title>
		<cfif Find("infoActivity.cfm", SCRIPT_NAME)>
			<cfinclude template="incBeginInfo.cfm">
		<cfelse>
			<cfinclude template="incBegin.cfm">
		</cfif>
	</cfif>
	<span class="dataSectionTitle">Instructional Activity Information</span>
	<div class="data">
		<cfoutput query="Activity" group="ActivityID">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="49%">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td width="20%" nowrap class="fieldLabel">Activity/course title:</td>
								<td width="80%" class="fieldValue"><strong>#Activity.Title#</strong></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Activity/course type:</td>
								<td class="fieldValue">
									<cfif Activity.ActivityType neq "">
										<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and (SESSION.UserLevelID gt 1)>
											<a href="activities.cfm?ActTypID=#Activity.ActivityTypeID#">#Activity.ActivityType#</a>
										<cfelse>#Activity.ActivityType#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Delivery mode:</td>
								<td class="fieldValue">
									<cfif Activity.DeliveryMode neq "">
										<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and (SESSION.UserLevelID gt 1)>
											<a href="activities.cfm?DelModID=#Activity.DeliveryModeID#">#Activity.DeliveryMode#</a>
										<cfelse>#Activity.DeliveryMode#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Description:</td>
								<td class="fieldValue"><cfif Activity.Description neq "">#Activity.Description#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<!---tr valign="top">
								<td nowrap class="fieldLabel">Duration:</td>
								<td class="fieldValue"><cfif Activity.Duration neq "">#Activity.Duration# min.<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr--->
							<tr valign="top">
								<td nowrap class="fieldLabel">Suppl. materials:</td>
								<td class="fieldValue">
									<cfif Material.RecordCount neq 0>
										<ul>
											<cfloop query="Material">
												<li>
													<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
														<a href="material.cfm?MatID=#Material.MaterialID#">#Material.MaterialTitle#</a>
													<cfelse>#Material.MaterialTitle#
													</cfif>
												</li>
											</cfloop>
										</ul>
									<cfelse>
										None<br>
									</cfif>
									<!---cfif ( SESSION.UserLevelID lt 3 ) and
										  ( ListContains(ActEditorID, SESSION.LibID, ",") ) and--->
									<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(ActEditorID, SESSION.LibID, ",") ) or
									        ( SESSION.UserLevelID eq 5 ) ) and
										  ( not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") )>
										<form action="addRemoveMaterial.cfm" method="post">
											<input name="ActID" type="hidden" value="#ActID#">
											<cfif Material.RecordCount gt 0>
												<input name="addRem" type="submit" class="subControl" value="Add/Remove Material">
											<cfelse>
												<input name="add" type="submit" class="subControl" value="Add Material">
											</cfif>
										</form>
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Developed for:</td>
								<td class="fieldValue">
									<cfif Contact.RecordCount neq 0>
										<cfloop query="Contact">
											<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
												<a href="contact.cfm?CntctID=#Contact.ContactID#">#Contact.Contact#</a>
											<cfelse>#Contact.Contact#
											</cfif><br>
										</cfloop>
									<cfelse>
										#APPLICATION.nullCaption#<br>
									</cfif>
									<!---cfif ( SESSION.UserLevelID lt 3 ) and
										  ( ListContains(ActEditorID, SESSION.LibID, ",") ) and--->
									<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(ActEditorID, SESSION.LibID, ",") ) or
									        ( SESSION.UserLevelID eq 5 ) ) and
										  ( not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") )>
										<form action="addRemoveContact.cfm" method="post">
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
						</table>
					</td>
					<td width="2%">&nbsp;</td>
					<td width="49%">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td nowrap class="fieldLabel">Developed by:</td>
								<td class="fieldValue">
									<cfset x = 0>
									<cfoutput>
										<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and (SESSION.UserLevelID gt 1)>
											<a href="librarian.cfm?LibID=#Activity.LibrarianID#">#Activity.LibrarianLastName#</a>
											(<a href="activities.cfm?UID=#Activity.UnitID#">#Activity.Unit#</a>)
										<cfelse>
											#Activity.LibrarianLastName# (#Activity.Unit#)
										</cfif>
										<br>
										<cfset x = x + 1>
									</cfoutput>
									<!---cfif ( SESSION.UserLevelID lt 3 ) and
										  ( SESSION.LibID eq DBRCreatorID ) and--->
									<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(ActEditorID, SESSION.LibID, ",") ) or
									        ( SESSION.UserLevelID eq 5 ) ) and
										  ( not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") )>
										<form action="addRemoveLibrarian.cfm" method="post">
											<input name="ActID" type="hidden" value="#ActID#">
											<cfif x gte 2>
												<input name="addRem" type="submit" class="subControl" value="Add/Remove Developer">
											<cfelse>
												<input name="add" type="submit" class="subControl" value="Add Developer">
											</cfif>
										</form>
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Dev. time:</td>
								<td class="fieldValue">
									<cfif Activity.DevTime neq "">
										<cfif SESSION.UserLevelID lt 2>#Activity.DevTime#
										<cfelse>#Activity.TotalDevTime#
										</cfif>
										min.
									<cfelse>
										#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Dev. comment:</td>
								<td class="fieldValue">
									<cfif Activity.DevComment neq "">#Activity.DevComment#
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr>
							<!---tr valign="top">
								<td nowrap class="fieldLabel">Completed on:</td>
								<td class="fieldValue"><cfif Activity.CompletionDT neq "">#DateFormat(Activity.CompletionDT, APPLICATION.dateFormat)#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr--->
							<!---tr valign="top">
								<td nowrap class="fieldLabel">Quarter:</td>
								<td class="fieldValue">
									<cfif Activity.Quarter neq "" and Activity.CompletionDT neq "">
										<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
											<a href="activities.cfm?Yr=#DatePart("yyyy", Activity.CompletionDT)#&QuartID=#Activity.QuarterID#">'#Right(DatePart("yyyy", Activity.CompletionDT), 2)# #Activity.Quarter#</a>
										<cfelse>
											'#Right(DatePart("yyyy", Activity.CompletionDT), 2)# #Activity.Quarter#
										</cfif>
									<cfelse>#APPLICATION.nullCaption#
									</cfif>
								</td>
							</tr--->
							<tr valign="top">
								<td nowrap class="fieldLabel">Input on:</td>
								<td class="fieldValue">
									#DateFormat(Activity.DBRCreatedDT, APPLICATION.dateFormat)# #TimeFormat(Activity.DBRCreatedDT, APPLICATION.timeFormat)#
									by
									<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
										<a href="librarian.cfm?LibID=#Activity.DBRCreatorID#">#Activity.DBRCreator#</a>
									<cfelse>#Activity.DBRCreator#
									</cfif>
								</td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Last updated:</td>
								<td class="fieldValue">
									#DateFormat(Activity.DBRUpdatedDT, APPLICATION.dateFormat)# #TimeFormat(Activity.DBRUpdatedDT, APPLICATION.timeFormat)#
									by
									<cfif not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
										<a href="librarian.cfm?LibID=#Activity.DBRUpdaterID#">#Activity.DBRUpdater#</a>
									<cfelse>#Activity.DBRUpdater#
									</cfif>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!---cfif ( SESSION.UserLevelID lt 3 ) and
				  ( ListContains(ActEditorID, SESSION.LibID, ",") ) and--->
			<cfif ( ( SESSION.UserLevelID eq 1 and ListContains(ActEditorID, SESSION.LibID, ",") ) or
					( SESSION.UserLevelID eq 5 ) ) and
				  ( not ListContains("infoActivity.cfm,deleteActivity.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") )>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<form action="updateActivity.cfm" method="post">
								<input name="ActID" type="hidden" value="#ActID#">
								<input type="submit" class="mainControl" value="Update Activity">
							</form>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<form action="deleteActivity.cfm" method="post">
								<input name="ActID" type="hidden" value="#ActID#">
								<input type="submit" class="mainControl" value="Delete Activity"
									<cfif (SESSION.LibID neq Activity.DBRCreatorID) or (Relationships.Total gt 0)>
										disabled="true"
									</cfif>
								>
							</form>
						</td>
					</tr>
				</table>
			</cfif>
		</cfoutput>
	</div>
</cfif>
