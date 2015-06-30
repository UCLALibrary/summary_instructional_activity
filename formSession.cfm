<cfif isDefined("Sess.RecordCount") and Sess.RecordCount eq 0>
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
	<cfscript>
		if (Find("addSession.cfm", SCRIPT_NAME))
		{
			pageTitle = "Add an Instructional Session";
		}
		else if (Find("updateSession.cfm", SCRIPT_NAME))
		{
			pageTitle = "Update Instructional Session";
		}
		else
		{
			pageTitle = "Instructional Session";
		}
	</cfscript>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incJSShowCalendar.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			var QuarterID = new validation('a quarter', 'QuarterID', 'select', 'isSelect(formObj)', null);
			var SessionDate = new validation('a sesssion date', 'SessionDate', 'text', 'isDate(str)', 'mm/dd/yyyy');
			var Hour = new validation('a session time', 'Hour', 'select', 'isSelect(formObj)', null);
			var Marker = new validation('AM or PM for the session time', 'Marker', 'select', 'isSelect(formObj)', null);
			//var GroupName = new validation('a group name', 'GroupName', 'text', 'isText(formObj)', null);
			var elts = new Array( QuarterID, SessionDate, Hour, Marker ); //, GroupName );
			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please choose ";
			var endRequestAlert = ".";
			var beginInvalidAlert = " is an invalid ";
			var endInvalidAlert = "!";
			var beginFormatAlert = "Use the format: ";

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
					//  alert("I am valid!"); //remove this when you use the code
					return true; //change this to return true
				}
				else
					return true;
			}
		//-->
	</script>
	<cfoutput>
		<cfscript>
			if (Find("updateSession", SCRIPT_NAME))
			{
				Action = "updateSession.cfm";
			}
			else if (Find("addSession", SCRIPT_NAME))
			{
				Action = "addSession.cfm";
			}
		</cfscript>
		<form action="#Action#"
	          method="post"
	          name="Session"
	          id="Session"
	          onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				</cfif>
				<input type="hidden" name="version" value="" />
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td colspan="4">
							Instructional activity title<br>
							<cfif Find("updateSession.cfm", SCRIPT_NAME)>
								<input name="Title" type="text" disabled="true" value="#Sess.Title#" size="65" readonly="true">
							<cfelseif  Find("addSession.cfm", SCRIPT_NAME)>
								<input name="Title" type="text" disabled="true" value="#Activity.Title#" size="65" readonly="true">
							<cfelse>
							</cfif>
						</td>
					</tr>
					<tr valign="top">
						<td>
							<em class="required">*</em>Quarter<br>
							<cfset Lookup = "Quarter">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="QuarterID">
								<cfloop query="Quarter">
									<option value="#Quarter.QuarterID#"
											<cfif isDefined("FORM.QuarterID") and FORM.QuarterID eq Quarter.QuarterID>
												selected
											<cfelseif isDefined("Sess.QuarterID") and Sess.QuarterID eq Quarter.QuarterID>
												selected
											<cfelse>
											</cfif>
									>#Quarter.Quarter#</option>
								</cfloop>
							</select>
						</td>
						<td>
							<em class="required">*</em>
							<cfset elementName = "SessionDate">
							<cfset elementLabel = "Session date">
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
							<a href="javascript:ShowCalendar('Session','SessionDate')">Select Date</a><!--EZ-D8 Select</a><sup>&reg;</sup-->
						</td>
						<td nowrap>
							<em class="required">*</em>Session time<br>
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
							>  min.
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							<cfset elementName = "NumAttendees">
							<cfset elementLabel = "Number of students">
							<cfinclude template="incHiLiteMissingElement.cfm">
						</td>
						<td>
							<input
								name="NumAttendees"
								type="text"
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
						<td>&nbsp;</td>
					</tr>
					<!---tr valign="top">
						<td>
							<cfset elementName = "NumEnrolled">
							<cfset elementLabel = "Number of students enrolled">
							<cfinclude template="incHiLiteMissingElement.cfm">
						</td>
						<td>
							<input
								name="NumEnrolled"
								type="text"
								size="5"
								maxlength="6"
								<cfif isDefined("FORM.NumEnrolled")>
									value="#FORM.NumEnrolled#"
								<cfelseif isDefined("Sess.NumEnrolled")>
									value="#Sess.NumEnrolled#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td>&nbsp;</td>
					</tr--->
					<tr valign="top">
						<td colspan="2">
							<!--em class="required">*</em-->Group name<br>
							<input
								name="GroupName"
								type="text"
								size="50"
								maxlength="255"
								<cfif isDefined("FORM.GroupName")>
									value="#FORM.GroupName#"
								<cfelseif isDefined("Sess.GroupName")>
									value="#Sess.GroupName#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td>
							Affiliation<br>
							<cfset Lookup = "Affiliation">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="AffiliationID">
								<cfloop query="Affiliation">
									<option value="#Affiliation.AffiliationID#"
										<cfif isDefined("FORM.AffiliationID") and FORM.AffiliationID eq Affiliation.AffiliationID>
											selected
										<cfelseif isDefined("Sess.AffiliationID") and Sess.AffiliationID eq Affiliation.AffiliationID>
											selected
										<cfelse>
										</cfif>
									>#Affiliation.Affiliation#</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="2">
							UCLA department<br>
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
						<td>
							Learner category<br>
							<cfset Lookup = "LearnerCategory">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="LearnerCategoryID">
								<cfloop query="LearnerCategory">
								<option value="#LearnerCategory.LearnerCategoryID#"
									<cfif isDefined("FORM.LearnerCategoryID") and FORM.LearnerCategoryID eq LearnerCategory.LearnerCategoryID>
										selected
									<cfelseif isDefined("Sess.LearnerCategoryID") and Sess.LearnerCategoryID eq LearnerCategory.LearnerCategoryID>
										selected
									</cfif>
								>#LearnerCategory.LearnerCategory#</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							Session Comments<br>
							<textarea name="Comments" cols="48" rows="4"><cfif isDefined("FORM.Comments")>#FORM.Comments#<cfelseif isDefined("Sess.Comments")>#Sess.Comments#<cfelse></cfif></textarea>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							<cfset elementName = "PrepTime">
							<cfset elementLabel = "Preparation time">
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
					</tr>
					<tr valign="top">
						<td colspan="3">
							Preparation time comments<br>
							<textarea name="PrepComment" cols="48" rows="4"><cfif isDefined("FORM.PrepComment")>#FORM.PrepComment#<cfelseif isDefined("Sess.PrepComment")>#Sess.PrepComment#<cfelse></cfif></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<input name="caller" type="hidden" value="formSession">
							<cfif Find("updateSession", SCRIPT_NAME)>
								<input name="SessID" type="hidden" value="#Sess.SessionID#">
							<cfelseif Find("addSession", SCRIPT_NAME)>
								<input name="ActID" type="hidden" value="#ActID#">
							<cfelse>
							</cfif>
							<input name="reqElements" type="hidden" value="QuarterID,a quarter;SessionDate,a sesssion date;Hour,a session time;Marker,AM or PM for the session time"> <!--;GroupName, a group name"-->
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Session, 'main');">
						</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Session, 'alt');">
							<!---cfif Find("addSession", SCRIPT_NAME)>
								<form action="activity.cfm?ActID=#ActID#" method="post">
							<cfelseif Find("updateSession", SCRIPT_NAME)>
								<form action="session.cfm?SessID=#Sess.SessionID#" method="post">
							<cfelse>
								<form action="sessions.cfm?LibID=#SESSION.LibID#" method="post">
							</cfif>
							<input type="submit" class="mainControl" value="Cancel">
							</form--->
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>
</cfif>
