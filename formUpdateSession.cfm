<cfscript>
	//initialize vars for uspGetPresenters proc
	SessID = SessID;
</cfscript>
<cfinclude template="uspGetPresenters.cfm">
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
		//initialize vars for uspGetDevelopers proc
		ActID = ActID;
	</cfscript>
	<cfinclude template="uspGetDevelopers.cfm">
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfset pageTitle = "Update Instructional Session">
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incJSShowContacts.cfm">
		<cfinclude template="incJSShowPresenters.cfm">
		<cfinclude template="incJSShowDepartments.cfm">
		<cfinclude template="incJSShowCalendar.cfm">
			<script language="JavaScript" type="text/javascript">
				<!--
					// create a new object for each form element you need to validate
					//var Title = new validation('an session title', 'Title', 'text', 'isText(str)', null);
					var ActivityTypeID = new validation('an activity type', 'ActivityTypeID', 'select', 'isSelect(formObj)', null);
					var DeliveryModeID = new validation('a delivery mode', 'DeliveryModeID', 'select', 'isSelect(formObj)', null);
					var QuarterID = new validation('a quarter', 'QuarterID', 'select', 'isSelect(formObj)', null);
					var SessionDate = new validation('a sesssion date', 'SessionDate', 'text', 'isDate(str)', 'mm/dd/yyyy');
					var Hour = new validation('a session time', 'Hour', 'select', 'isSelect(formObj)', null);
					var Marker = new validation('AM or PM for the session time', 'Marker', 'select', 'isSelect(formObj)', null);
					var elts = new Array( Title, ActivityTypeID, DeliveryModeID, QuarterID, SessionDate, Hour, Marker  );

					var allAtOnce = false;
					var beginRequestAlertForText = "Please include ";
					var beginRequestAlertGeneric = "Please choose ";
					var endRequestAlert = ".";
					var beginInvalidAlert = " is an invalid ";
					var endInvalidAlert = "!";
					var beginFormatAlert = "  Use this format: ";

					function validateForm(form)
					{
						var formEltName = "";
						var formObj = "";
						var str = "";
						var realName = "";
						var alertText = "";
						var firstMissingElt = null;
						var hardReturn = "\r\n";

						if ( form.version.value == 'main' )
						{
							for (i=0; i<elts.length; i++)
							{
								formEltName = elts[i].formEltName;
								formObj = eval("form." + formEltName);
								realName = elts[i].realName;

								if (elts[i].eltType == "text")
								{
									str = formObj.value;
									if (eval(elts[i].upToSnuff))
										continue;
									if (str == "")
									{
										if (allAtOnce)
										{
											alertText += beginRequestAlertForText + realName + endRequestAlert + hardReturn;
											if (firstMissingElt == null)
											{
												firstMissingElt = formObj;
											}
										}
										else
										{
											alertText = beginRequestAlertForText + realName + endRequestAlert + hardReturn;
											alert(alertText);
										}
									}
									else
									{
										if (allAtOnce)
										{
											alertText += str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
										}
										else
										{
											alertText = str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
										}
										if (elts[i].format != null)
										{
											alertText += beginFormatAlert + elts[i].format + hardReturn;
										}
										if (allAtOnce)
										{
											if (firstMissingElt == null)
											{
												firstMissingElt = formObj;
											}
										}
										else
										{
											alert(alertText);
										}
									}
								}
								else
								{
									if (eval(elts[i].upToSnuff))
										continue;
									if (allAtOnce)
									{
										alertText += beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
										if (firstMissingElt == null)
										{
											firstMissingElt = formObj;
										}
									}
									else
									{
										alertText = beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
										alert(alertText);
									}
								}
								if (!isIE3)
								{
									var goToObj = (allAtOnce) ? firstMissingElt : formObj;
									if (goToObj.select)
										goToObj.select();
									if (goToObj.focus)
										goToObj.focus();
								}
								if (!allAtOnce)
								{
									return false;
								}
							}
							if (allAtOnce)
							{
								if (alertText != "")
								{
									alert(alertText);
									return false;
								}

							}
							return true; //change this to return true
						}
						else
							return true;
					}
				//-->
			</script>
			<cfoutput>
				<form action="updateSession.cfm"
					  method="post"
					  name="Session"
					  id="Session"
					  onsubmit="JavaScript:return validateForm(this);">
					<span class="formSectionTitle">#pageTitle#</span>
					<div class="form">
						<cfif isDefined("up2snuff") and not up2snuff>
							<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
						</cfif>
						<input type="hidden" name="version" value="" />

						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td><!-- colspan="3"-->
									<em class="required">*</em>
									Department | Campus Unit | Group<br/>
									<input name="SessionDepartment" type="text" size="55"
										<cfif isDefined("FORM.SessionDepartment")>
											value="#FORM.SessionDepartment#"
										<cfelseif IsDefined("Sess.SessDeptTitle")>
											value="#Sess.SessDeptTitle#"
										<cfelse>
											value=""
										</cfif>
										disabled="true" readonly="true">
									<input type="hidden" name="SessionDepartmentID" value="#Sess.SessDeptIDs#">
									<a href="javascript:ShowDepartments('Session','SessionDepartment','SessionDepartmentID',[#ValueList(Sess.SessDeptIDs,",")#])">Select Department|Unit|Group</a>
									<br/><em>Select the department, campus unit, or group.</em>
								</td>
								<td colspan="2">&nbsp;</td>
							</tr>

							<tr valign="top">
								<td>
									Course Number<br/>
									<input name="CourseNumber" type="text" size="55" value="#Sess.CourseNumber#">
								</td>
								<td>
									Course Section<br/>
									<input name="CourseSection" type="text" size="25" value="#Sess.CourseSection#">
								</td>
							</tr>
							<tr>
								<td colspan="2">
								<em>If a course, add the course number and section as they appear in the <a href='http://www.registrar.ucla.edu/schedule/' target='_blank' class='navLink0'>Schedule of Classes</a></em>
								</td>
							</tr>

							<tr valign="top">
								<td>
									Session Title<br/>
									<input
										name="Title"
										type="text"
										size="55"
										maxlength="255"
										<cfif isDefined("FORM.Title")>
											value="#FORM.Title#"
										<cfelseif isDefined("Activity.Title")>
											value="#Activity.Title#"
										<cfelse>
											value=""
										</cfif>
									><br/>
									<em>Include a title for sessions not related to departments/courses</em>
								</td>
								<!---td>
									Instructional Contact(s) (e.g., course instructor):<br>
									<textarea name="ContactName" disabled="true" readonly="true">#ValueList(Contact.Contact,";")#</textarea>
									<input type="hidden" name="ContactID" value="#ValueList(Contact.ContactID,",")#">
									<a href="javascript:ShowContacts('Session','ContactName','ContactID', [#ValueList(Contact.ContactID,",")#])">Select Contact</a>
								</td--->
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr valign="top">
								<td>
									Description of session/consultation/topic<br>
									<textarea name="Description" cols="48" rows="4"><cfif isDefined("FORM.Description")>#FORM.Description#<cfelseif isDefined("Activity.Description")>#Activity.Description#<cfelse></cfif></textarea>
								</td>
								<td>
									<table>
										<cfoutput>
											<tr valign="top">
												<td>
													Library Staff Presenter(s):<br>
													<textarea name="PresenterNames" disabled="true" readonly="true">#ValueList(Presenters.FullName,";")#</textarea>
													<input type="hidden" name="PresenterIDs" value="#ValueList(Presenters.LibrarianID, ",")#">
													<a href="javascript:ShowLibs('Session','PresenterNames','PresenterIDs', 'pres', [#ValueList(Presenters.LibrarianID, ",")#])">Select Presenter(s)</a>
												</td>
											</tr>
											<tr><td>&nbsp;</td></tr>
											<tr>
												<td>
													Library Staff Developer(s):<br>
													<textarea name="DeveloperNames" disabled="true" readonly="true">#ValueList(Developers.FullName,";")#</textarea>
													<input type="hidden" name="DeveloperIDs" value="#ValueList(Developers.LibrarianID,",")#">
													<a href="javascript:ShowLibs('Session','DeveloperNames','DeveloperIDs', 'dev', [#ValueList(Developers.LibrarianID, ",")#])">Select Developer(s)</a>
													</td>
												<td>&nbsp;</td>
											</tr>
										</cfoutput>
									</table>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr valign="top">
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr valign="top">
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr><td colspan="3"><hr size="1"></td></tr>
						</table>


						<h3>Date and Time</h3>

						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td>
									<em class="required">*</em>Quarter<br>
									<cfset Lookup = "Quarter">
									<cfset Header = "">
									<cfinclude template="uspGetLookup.cfm">
									<cfloop query="Quarter">
										<input type="radio" name="QuarterID" value="#Quarter.QuarterID#"
											<cfif isDefined("FORM.QuarterID") and FORM.QuarterID eq Quarter.QuarterID>
												checked
											<cfelseif isDefined("Sess.QuarterID") and Sess.QuarterID eq Quarter.QuarterID>
												checked
											<cfelse>
											</cfif>
										>#Quarter.Quarter#<br/>
									</cfloop>
								</td>
								<td>
									<em class="required">*</em>
									<cfset elementName = "SessionDate">
									<cfset elementLabel = "Session date<br>(mm/dd/yyyy)">
									<cfinclude template="incHiLiteMissingElement.cfm"><br>
									<input
										type="text"
										name="SessionDate"
										size="12"
										maxlength="10"
										<cfif isDefined("FORM.SessionDate")>
											value="#FORM.SessionDate#"
										<cfelseif isDefined("FORM.sDT")>
											value="#FORM.sDT#"
										<cfelseif isDefined("Sess.SessionDateTime")>
											value="#DateFormat(Sess.SessionDateTime, "mm/dd/yyyy")#"
										<cfelse>
											value=""
										</cfif>
									><br>
									<a href="javascript:ShowCalendar('Session','SessionDate')">Select Date</a>
								</td>
								<td nowrap>
									<em class="required">*</em>Session start time<br>
									<select name="Hour">
										<option value="">--</option>
										<cfloop index="Hr" from="1" to="12" step="1">
											<option value="#Hr#"
												<cfif isDefined("FORM.Hour") and FORM.Hour eq Hr>
													selected
												<cfelseif isDefined("Sess.SessionDateTime") and TimeFormat(Sess.SessionDateTime, "h") eq Hr>
													selected
												</cfif>
											>#Hr#</option>
										</cfloop>
									</select>
									<span style="font-size:150%;">:</span>
									<select name="Minute">
										<cfloop index="Minute" from="0" to="55" step="5">
											<option value="#TimeFormat(CreateTime(00, Minute, 00), "mm")#"
												<cfif isDefined("FORM.Minute") and TimeFormat(CreateTime(00, Minute, 00), "mm") eq FORM.Minute>
													selected
												<cfelseif isDefined("Sess.SessionDateTime") and TimeFormat(CreateTime(00, Minute, 00), "mm") eq Minute(Sess.SessionDateTime)>
													selected
												<cfelse>
												</cfif>
											>#TimeFormat(CreateTime(00, Minute, 00), "mm")#</option>
										</cfloop>
									</select>
									<select name="Marker">
										<option value="">--</option>
										<cfif isDefined("FORM.Marker")>
											<option value="AM" <cfif FORM.Marker eq "AM">selected</cfif>>A.M.</option>
											<option value="PM" <cfif FORM.Marker eq "PM">selected</cfif>>P.M.</option>
										<cfelseif isDefined("Sess.SessionDateTime")>
											<option value="AM" <cfif Hour(Sess.SessionDateTime) lt 12>selected</cfif>>A.M.</option>
											<option value="PM" <cfif Hour(Sess.SessionDateTime) gt 11>selected</cfif>>P.M.</option>
										<cfelse>
											<option value="AM">A.M.</option>
											<option value="PM">P.M.</option>
										</cfif>
									</select>
								</td>
								<td>
									<em class="required">*</em>
									<cfset elementName = "Duration">
									<cfset elementLabel = "Duration">
									<cfinclude template="incHiLiteMissingElement.cfm"><br>
									<input
										name="Duration"
										type="text"
										style="text-align:right;" size="5" maxlength="6"
										<cfif isDefined("FORM.Duration")>
											value="#FORM.Duration#"
										<cfelseif isDefined("Sess.Duration")>
											value="#Sess.Duration#"
										<cfelse>
											value=""
										</cfif>
									>  min.<br>
									<p style="font-size: small;">
										For whole courses taught, enter duration of one session
										<b>and</b><br>enter the number of sessions in the whole course:
										<input
											name="SessionCount"
											type="text"
											style="text-align:right;" size="5" maxlength="6"
											<cfif isDefined("FORM.SessionCount")>
												value="#FORM.SessionCount#"
											<cfelseif isDefined("Activity.SessionCount")>
												value="#Activity.SessionCount#"
											<cfelse>
											value=""
											</cfif>
										>
									</p>
								</td>
							</tr>
							<tr><td colspan="4" style="font-size: small;">For whole courses taught, enter date of first session.</td></tr>
							<tr>
								<td colspan="2">
									<!--em class="required">*</em-->
									<cfset elementName = "PrepTime">
									<cfset elementLabel = "Approx. Development & Preparation time for all librarians">
									<cfinclude template="incHiLiteMissingElement.cfm"><br>
									<input
										name="PrepTime"
										type="text"
										style="text-align:right;"
										size="5"
										maxlength="6"
										<cfif isDefined("FORM.PrepTime")>
											value="#FORM.PrepTime#"
										<cfelseif isDefined("Sess.PrepTime")>
											value="#Sess.PrepTime#"
										<cfelse>
											value=""
										</cfif>
									> min.
								</td>
								<td>&nbsp;</td>
								<td>
									Development & Preparation time comments<br>
									<textarea name="PrepComment" cols="48" rows="4"><cfif isDefined("FORM.PrepComment")>#FORM.PrepComment#<cfelseif isDefined("Sess.PrepComment")>#Sess.PrepComment#<cfelse></cfif></textarea>
								</td>
							</tr>
							<tr><td colspan="4"><hr size="1"></td></tr>
						</table>

						<h3>Session Details</h3>

						<table border="0" cellpadding="0" cellspacing="0">
							<!---tr valign="top">
								<td colspan="3">
									Session type is required.<br/>
									If you select Yes for Scholarly Communication, then select fron the Scholarly Communication<br/>
									topic(s).  To unselect a Scholarly Communication topic, ctrl-click the topic to unselect it.<br/>
									<a href="sessDefs.html" target="_blank">Definitions</a> of session types.
								</td>
							</tr--->
							<tr valign="top">
								<td width="45%">
									<em class="required">*</em>
									Session type<br>
									<cfset Lookup = "ActivityType">
									<cfset Header = "">
									<cfinclude template="uspGetLookup.cfm">
									<cfloop query="ActivityType">
										<input type="radio" name="ActivityTypeID" value="#ActivityType.ActivityTypeID#"
											<cfif isDefined("FORM.ActivityTypeID") and FORM.ActivityTypeID eq ActivityType.ActivityTypeID>
												checked
											<cfelseif isDefined("Activity.ActivityTypeID") and Activity.ActivityTypeID eq ActivityType.ActivityTypeID>
												checked
											</cfif>
										><b>#ActivityType.ActivityType#</b><br/>
										<div class="help">#ActivityType.HelpText#</div><br/>
									</cfloop>
								</td>
								<td width="55%">
									Strategic Priorities & Initiatives<br/>
									<cfset Lookup = "Initiative">
									<cfset Header = "">
									<cfinclude template="uspGetLookup.cfm">
									<cfloop query="Initiative">
										<input type="checkbox" name="InitiativeTypes" value="#Initiative.InitiativeID#"
											<cfif isDefined("FORM.InitiativeTypes")>
												<cfloop index="typeID" list="#FORM.InitiativeTypes#" delimiters=",">
													<cfif typeID eq Initiative.InitiativeID>checked
														<cfbreak>
													</cfif>
												</cfloop>
											<cfelseif isDefined("Sess.InitiativeIDs")>
												<cfloop index="typeID" list="#Sess.InitiativeIDs#" delimiters=",">
													<cfif typeID eq Initiative.InitiativeID>checked
														<cfbreak>
													</cfif>
												</cfloop>
											</cfif>
										>#Initiative.Initiative#<br/>
									</cfloop>
								</td>
								<!---td>
									<em class="required">*</em>
									Scholarly Communication<br>
									<cfif (isDefined("FORM.ScholarlyCommunication") and FORM.ScholarlyCommunication neq "") or (isDefined("Sess.ScholarlyCommunication") and Sess.ScholarlyCommunication neq "")>
										<input type="radio" name="ScholarlyCommunication" value="1" <cfif isDefined("FORM.ScholarlyCommunication") and FORM.ScholarlyCommunication eq "1">checked<cfelseif isDefined("Sess.ScholarlyCommunication") and Sess.ScholarlyCommunication eq "1">checked</cfif>>Yes
										<input type="radio" name="ScholarlyCommunication" value="0" <cfif isDefined("FORM.ScholarlyCommunication") and FORM.ScholarlyCommunication eq "0">checked<cfelseif isDefined("Sess.ScholarlyCommunication") and Sess.ScholarlyCommunication eq "0">checked</cfif>>No
									<cfelse>
										<input type="radio" name="ScholarlyCommunication" value="1">Yes
										<input type="radio" name="ScholarlyCommunication" value="0" checked>No
									</cfif>
								</td--->
								<td>&nbsp;</td>
							</tr>
							<tr valign="top">
								<td>
									<em class="required">*</em>
									Delivery mode<br>
									<cfset Lookup = "DeliveryMode">
									<cfset Header = "">
									<cfinclude template="uspGetLookup.cfm">
									<cfloop query="DeliveryMode">
										<input type="checkbox" name="DeliveryModes" value="#DeliveryMode.DeliveryModeID#"
											<cfif isDefined("FORM.DeliveryModes")>
												<cfloop index="delivID" list="#FORM.DeliveryModes#" delimiters=",">
													<cfif delivID eq DeliveryMode.DeliveryModeID>checked
														<cfbreak>
													</cfif>
												</cfloop>
											<cfelseif isDefined("Activity.DeliveryModes")>
												<cfloop index="delivID" list="#Activity.DeliveryModes#" delimiters=",">
													<cfif delivID eq DeliveryMode.DeliveryModeID>checked
														<cfbreak>
													</cfif>
												</cfloop>
											</cfif>>#DeliveryMode.DeliveryMode#<br/>
									</cfloop>
								</td>
								<td>
									Scholarly Communication topic(s)<br>
									<cfset Lookup = "ScholComm">
									<cfset Header = "">
									<cfinclude template="uspGetLookup.cfm">
									<cfloop query="ScholComm">
										<input type="checkbox" name="ScholCommTypes" value="#ScholComm.ScholCommID#"
											<cfif isDefined("FORM.ScholCommTypes")>
												<cfloop index="typeID" list="#FORM.ScholCommTypes#" delimiters=",">
													<cfif typeID eq ScholComm.ScholCommID>checked
														<cfbreak>
													</cfif>
												</cfloop>
												<cfelseif isDefined("Activity.ScholCommTypes")>
													<cfloop index="typeID" list="#Activity.ScholCommTypes#" delimiters=",">
														<cfif typeID eq ScholComm.ScholCommID>checked
														<cfbreak>
														</cfif>
													</cfloop>
												<cfelse>
											</cfif>
										>#ScholComm.ScholComm#<br/>
									</cfloop>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr><td colspan="3"><hr size="1"></td></tr>
						</table>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td align="left" colspan="2">
									<em class="required">*</em>
									<cfset elementName = "NumAttendees">
									<cfset elementLabel = "Number of learners">
									<cfinclude template="incHiLiteMissingElement.cfm">
									&nbsp;
									<input
										name="NumAttendees"
										type="text"
										style="text-align:right;"
										size="5"
										maxlength="6"
										<cfif isDefined("FORM.NumAttendees")>
											value="#FORM.NumAttendees#"
										<cfelseif isDefined("Sess.NumAttendees")>
											value="#Sess.NumAttendees#"
										<cfelse>
											value=""
										</cfif>
									>
								</td>
							</tr>
							<tr valign="top">
								<td>
									<em class="required">*</em>
									Learner category<br>
									<cfset Lookup = "LearnerCategory">
									<cfset Header = "">
									<cfinclude template="uspGetLookup.cfm">
									<cfloop query="LearnerCategory">
										<input type="checkbox" name="LearnerCategoryID" value="#LearnerCategory.LearnerCategoryID#"
											<cfif isDefined("FORM.LearnerCategoryID")>
												<cfloop index="learnID" list="#FORM.LearnerCategoryID#" delimiters=",">
													<cfif learnID eq LearnerCategory.LearnerCategoryID>checked
													<cfbreak>
													</cfif>
												</cfloop>
											<cfelseif isDefined("Sess.LearnerCatIDs")>
												<cfloop index="learnID" list="#Sess.LearnerCatIDs#" delimiters=",">
													<cfif learnID eq LearnerCategory.LearnerCategoryID>checked
													<cfbreak>
													</cfif>
												</cfloop>
											</cfif>
										>#LearnerCategory.LearnerCategory#<br/>
									</cfloop>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td colspan="2">
									What did *you* learn as a result of this session that might be helpful to others?<br/>
									<textarea name="Learned" cols="50" rows="5">#Sess.Learned#</textarea>
								</td>
							</tr>
							<tr valign="top">
								<td colspan="2">
									Learner Academic Departments and More<br>
									<cfset Lookup = "Department">
									<cfset Header = "-select-">
									<cfinclude template="uspGetLookup.cfm">
									<select name="DepartmentID">
										<cfloop query="Department">
										<option value="#Department.DepartmentID#"
											<cfif isDefined("FORM.DepartmentID") and FORM.DepartmentID eq Department.DepartmentID>
												selected
											<cfelseif isDefined("Sess.DepartmentID") and Sess.DepartmentID eq Department.DepartmentID>
												selected
											<cfelse>
											</cfif>
										>#Department.Department#</option>
										</cfloop>
									</select>
								</td>
							</tr>
							<tr valign="top">
								<td colspan="2">
									If you select "Other" or "Multiple" for Academic Departments, please enter the department name(s) here:<br>
									<textarea name="other_multi_dept" cols="50" rows="5">#Sess.other_multi_dept#</textarea>
								</td>
							</tr>
							<tr><td colspan="2"><hr size="1"></td></tr>
						</table>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<input name="ActID" type="hidden" value="#ActID#">
									<input name="SessID" type="hidden" value="#SessID#">
									<input name="reqElements" type="hidden" value="ActivityTypeID,Activity/course type;DeliveryModeID,Delivery mode;QuarterID,a quarter;SessionDate,a sesssion date;Hour,a session time;Marker,AM or PM for the session time">
									<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Session, 'main');">
								</td>
								<td>
									<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Session, 'alt');">
								</td>
							</tr>
						</table>
					</div>
				</form>
			</cfoutput>
	</cfif>
</cfif>
