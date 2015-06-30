<cfif isDefined("Activity.RecordCount") and Activity.RecordCount eq 0>
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
	<cfscript>
		if (Find("addNewActivity.cfm", SCRIPT_NAME))
		{
			pageTitle = "Add a New Instructional Activity";
		}
		else
		{
			pageTitle = "Update Instructional Activity";
		}
	</cfscript>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incJSShowCalendar.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			var Title = new validation('an activity/course title', 'Title', 'text', 'isText(str)', null);
			var ActivityTypeID = new validation('an activity type', 'ActivityTypeID', 'select', 'isSelect(formObj)', null);
			var DeliveryModeID = new validation('a delivery mode', 'DeliveryModeID', 'select', 'isSelect(formObj)', null);
			var elts = new Array( Title, ActivityTypeID, DeliveryModeID );

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
	<cfscript>
		if (Find("updateActivity", SCRIPT_NAME))
		{
			Action = "updateActivity.cfm";
		}
		else if (Find("addNewActivity", SCRIPT_NAME))
		{
			Action = "addNewActivity.cfm";
		}
	</cfscript>
	<cfoutput>
		<form action="#Action#"
		      method="post"
		      name="Activity"
		      id="Activity"
		      onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				</cfif>
				<input type="hidden" name="version" value="" />
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td colspan="3">
							<em class="required">*</em>
							<cfset elementName = "Title">
							<cfset elementLabel = "Activity/course title">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="Title"
								type="text"
								size="55"
								maxlength="255"
								<cfif isDefined("FORM.Title")>
									value="#FORM.Title#"
								<cfelse>
									value=""
								</cfif>
							>
							&nbsp;
							<a href="http://www.registrar.ucla.edu/schedule/" target="_blank" class="navLink0">Schedule of Classes</a>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							Activity/course description<br>
							<textarea name="Description" cols="48" rows="4"><cfif isDefined("FORM.Description")>#FORM.Description#<cfelse></cfif></textarea>
						</td>
					</tr>
					<tr valign="top">
						<td>
							<em class="required">*</em>
							Activity/course type<br>
							<cfset Lookup = "ActivityType">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="ActivityTypeID">
								<cfloop query="ActivityType">
									<option
										value="#ActivityType.ActivityTypeID#"
										<cfif isDefined("FORM.ActivityTypeID") and FORM.ActivityTypeID eq ActivityType.ActivityTypeID>selected</cfif>
									>#ActivityType.ActivityType#</option>
								</cfloop>
							</select>
						</td>
						<td>
							<em class="required">*</em>
							Delivery mode<br>
							<cfset Lookup = "DeliveryMode">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="DeliveryModeID">
								<cfloop query="DeliveryMode">
									<option
										value="#DeliveryMode.DeliveryModeID#"
										<cfif isDefined("FORM.DeliveryModeID") and FORM.DeliveryModeID eq DeliveryMode.DeliveryModeID>selected</cfif>
									>#DeliveryMode.DeliveryMode#</option>
								</cfloop>
							</select>
						</td>
						<td>
							&nbsp;
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td nowrap colspan="3">
							<cfset elementName = "DevTime">
							<cfset elementLabel = "Development time">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="DevTime"
								type="text"
								style="text-align:right;"
								size="5"
								maxlength="6"
								<cfif isDefined("FORM.DevTime")>
									value="#FORM.DevTime#"
								<cfelse>
									value=""
								</cfif>
							> min.
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							Development time comments<br>
							<textarea name="DevComment" cols="48" rows="4" ><cfif isDefined("FORM.DevComment")>#FORM.DevComment#<cfelse></cfif></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfif Find("updateActivity", SCRIPT_NAME)>
								<input name="ActID" type="hidden" value="#Activity.ActivityID#">
							</cfif>
							<input name="reqElements" type="hidden" value="Title,Activity/course title;ActivityTypeID,Activity/course type;DeliveryModeID,Delivery mode">
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Activity, 'main');" >
						</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Activity, 'alt');" >
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>
</cfif>