<cfset sortURL = SCRIPT_NAME & "?addSess=1&">
<cfif Activity.RecordCount eq 0>
	<cfset pageTitle = "No Instructional Activities">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Select an Instructional Activity</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional activities</td>
			</tr>
		</table>
		<cfif SESSION.UserLevelID lt 3 and ListContains("addSession.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
			<form action="addNewActivity.cfm" method="post">
				<input type="submit" class="mainControl" value="Add New Activity">
			</form>
		</cfif>
	</div>
<cfelse>
	<cfset pageTitle = "Instructional Activities Developed by " & Unit.Unit>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			<cfif UniqueRec gt 1>
				var ActID = new validation('an instructional activity', 'ActID', 'radio', 'isRadio(formObj)', null);
			<cfelse>
				var ActID = new validation('an instructional activity', 'ActID', 'checkbox', 'isCheck(formObj, form, 0, 1)', null);
			</cfif>
			var elts = new Array( ActID );
			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please select ";
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
					//  alert("I am valid!"); //remove this when you use the code
					return true; //change this to return true
				}
				else
					return true;
			}

			function selectRadio(elementID)
			{
				document.Activity.ActID[elementID].checked = true;
			}
		//-->
	</script>
	<cfinclude template="incJSInfoWindow.cfm">
	<form action="addSession.cfm"
		  method="post"
		  name="Activity"
		  id="Activity"
		  onSubmit="JavaScript:return validateForm(this);">
		<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
		<div class="data">
			<cfif (isDefined("missingRequired") and missingRequired) or not up2snuff>
				<div class="formSectionTitleErr" style="width:50%;"><cfoutput>#em#</cfoutput></div>
			<cfelse>
				<p>Select an instructional activity for the session.</p>
			</cfif>
			<input type="hidden" name="version" value="" />
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<cfoutput>
						<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
						<th nowrap><a href="#sortURL#fld=at&ord=#ord#" class="columnHeading">Activity Title</a></th>
						<th nowrap><a href="#sortURL#fld=ay&ord=#ord#" class="columnHeading">Type</a></th>
						<th nowrap><a href="#sortURL#fld=am&ord=#ord#" class="columnHeading">Dev. Mode</a></th>
						<th><a href="#sortURL#fld=ad&ord=#ord#" class="columnHeading">Dur.</a></th>
						<th nowrap><a href="#sortURL#fld=al&ord=#ord#" class="columnHeading">Dev. by</a></th>
						<!---th nowrap><a href="#sortURL#fld=ac&ord=#ord#" class="columnHeading">Completed</a></th--->
					</cfoutput>
				</tr>
				<cfset x = 0>
				<cfoutput query="Activity" group="ActivityID">
					<cfset class="#IIF(Activity.CurrentRow eq 1, DE('first'), DE('rest'))#">
					<tr valign="top">
						<td class="#class#">
							<cfif UniqueRec gt 1>
								<input name="ActID" type="radio" value="#Activity.ActivityID#">
							<cfelse>
								<input name="ActID" type="checkbox" value="#Activity.ActivityID#" checked>
							</cfif>
						</td>
						<td class="#class#"><a href="JavaScript:newWindow('infoActivity.cfm?ActID=#Activity.ActivityID#','740','350','20','25','Activity');" <cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>>#Activity.Title#</a></td>
						<td class="#class#">#Activity.ActivityType#</td>
						<td class="#class#">#Activity.DeliveryMode#</td>
						<td nowrap class="#class#"><cfif Activity.Duration neq "">#Activity.Duration# min.<cfelse>#APPLICATION.nullCaption#</cfif></td>
						<td class="#class#"><cfoutput group="LibrarianID">#Activity.LibrarianLastName#<br></cfoutput></td>
						<!---td nowrap class="#class#"><cfif Activity.CompletionDT neq "">#DateFormat(Activity.CompletionDT, "yyyy-mm-dd")#<cfelse>#APPLICATION.nullCaption#</cfif></td--->
					</tr>
					<cfset x = x + 1>
				</cfoutput>
			</table>
			<cfoutput>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<input name="caller" type="hidden" value="formActivityList">
							<!---input name="LibID" type="hidden" value="<cfoutput>#SESSION.LibID#</cfoutput>"--->
							<cfif isDefined("FORM.sDT")>
								<input name="sDT" type="hidden" value="#FORM.sDT#">
							</cfif>
							<input name="Submit" type="submit" class="mainControl" value="Add Session" onclick="JavaScript:setVersion(Activity, 'main');">
							<!--input name="addActSess" type="submit" class="mainControl" value="Add Session"-->
							<!--/form-->
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Activity, 'alt');" >
							<!---cfif isDefined("FORM.sDT")>
								<form action="sessions.cfm?sDT=#FORM.sDT#" method="post">
							<cfelse>
								<form action="sessions.cfm?LibID=#SESSION.LibID#" method="post">
							</cfif>
							<input type="submit" class="mainControl" value="Cancel">
							</form--->
						</td>
					</tr>
				</table>
			</cfoutput>
		</div>
	</form>
</cfif>