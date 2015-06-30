<cfscript>
	sortURL = SCRIPT_NAME & "?SessID=" & SessID & "&Add=" & Add & "&";
	if ((isDefined("FORM.Add") and FORM.Add neq "0") or (isDefined("URL.Add") and URL.Add neq "0"))
	{
		pageTitle = "Assign a Classroom to this Instructional Session";
	}
	else
	{
		pageTitle = "Remove the Classroom Assigned to this Instructional Session";
	}
</cfscript>
<cfif Classroom.RecordCount eq 0>
	<cfset pageTitle = pageTitle>
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No classrooms existing in SIA database available to
				assign/remove to/from this instructional session</td>
			</tr>
		</table>
		<form action="addNewClassroom.cfm" method="post">
			<input name="SessID" type="hidden" value="#SessID#">
			<input name="ActID" type="hidden" value="#ActID#">
			<input type="submit" class="mainControl" value="Add New Classroom">
		</form>
	</div>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			<!---cfif UniqueRec gt 1>
				var ClassID = new validation('a classroom', 'ClassID', 'radio', 'isRadio(formObj)', null);
			<cfelse>
				var ClassID = new validation('a classroom', 'ClassID', 'checkbox', 'isCheck(formObj, form, 0, 1)', null);
			</cfif--->
			//var ClassID = new validation('a classroom', 'ClassID', 'checkbox', 'isCheck(formObj, form, 0, 1)', null);
			var ClassID = new validation('a classroom', 'ClassID', 'radio', 'isRadio(formObj)', null);
			var elts = new Array( ClassID );
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
					//  alert("I am valid!"); //remove this when you use the code
					return true; //change this to return true
				}
				else
					return true;
			}

			function selectRadio(elementID)
			{
				document.Classroom.ClassID[elementID].checked = true;
			}
		//-->
	</script>
	<cfinclude template="incJSInfoWindow.cfm">
	<form action="addRemoveClassroom.cfm"
		  method="post"
		  name="Classroom"
		  id="Classroom">
		  <!--onsubmit="JavaScript:return validateForm(this);"-->
		<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
		<div class="data">
			<cfif (isDefined("missingRequired") and missingRequired) or not up2snuff>
				<div class="formSectionTitleErr" style="width:50%;"><cfoutput>#em#</cfoutput></div>
			<cfelse>
				<cfif add neq 0>
					<p>
						The following
						<cfif UniqueRec gt 1>classrooms<cfelse>classroom</cfif>
						currently in the SIA Database
						<cfif UniqueRec gt 1>are<cfelse>is</cfif>
						available to assign to this instructional session.
					</p>
				<cfelse>
					<p>Remove the classroom currently assigned to this instructional session.</p>
				</cfif>
			</cfif>
			<input type="hidden" name="version" value="" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<cfif Add eq "1">
							<input name="Submit" type="submit" class="mainControl" value="Assign Selected" onclick="JavaScript:setVersion(Classroom, 'main');">
						<cfelseif Add eq "0">
							<input name="Submit" type="submit" class="mainControl" value="Remove Selected" onclick="JavaScript:setVersion(Classroom, 'main');">
						</cfif>
					</td>
					<cfif Add neq "0">
						<td width="12">&nbsp;</td>
						<td>
							<input name="Submit" type="submit" value="Add New Classroom" onclick="JavaScript:setVersion(Classroom, 'alt');">
						</td>
					</cfif>
					<td width="12">&nbsp;</td>
					<td>
						<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Classroom, 'alt');">
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<cfoutput>
						<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
						<th nowrap><a href="#sortURL#fld=na&ord=#ord#" class="columnHeading">Classroom name</a></th>
						<th nowrap><a href="#sortURL#fld=lo&ord=#ord#" class="columnHeading">Bldg./room num.</a></th>
						<th nowrap><a href="#sortURL#fld=dp&ord=#ord#" class="columnHeading">Department</a></th>
						<th nowrap><a href="#sortURL#fld=pr&ord=#ord#" class="columnHeading">Projector</a></th>
						<th nowrap><a href="#sortURL#fld=sc&ord=#ord#" class="columnHeading">Screen</a></th>
						<th nowrap><a href="#sortURL#fld=cn&ord=#ord#" class="columnHeading">Contact</a></th>
					</cfoutput>
				</tr>
				<cfset x = 0>
				<cfoutput query="Classroom" group="ClassroomID">
					<cfset class="#IIF(Classroom.CurrentRow eq 1, DE('first'), DE('rest'))#">
					<tr valign="top">
						<td class="#class#">
							<input name="ClassID" type="radio" value="#Classroom.ClassroomID#" checked>
							<!---cfif UniqueRec gt 1>
								<input name="ClassID" type="radio" value="#Classroom.ClassroomID#">
							<cfelse>
								<input name="ClassID" type="checkbox" value="#Classroom.ClassroomID#" checked>
							</cfif--->
						</td>
						<td class="#class#"><a href="JavaScript:newWindow('infoClassroom.cfm?ClassID=#Classroom.ClassroomID#','740','500','20','25','Classroom');" <cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>>#Classroom.Name#</a></td>
						<td class="#class#"><cfif Classroom.Building eq "" and Classroom.RoomNumber eq "">#APPLICATION.nullCaption#<cfelse><cfif Classroom.Building neq "">#Classroom.Building#</cfif><cfif Classroom.RoomNumber neq "">, #Classroom.RoomNUmber#</cfif></cfif></td>
						<td class="#class#"><cfif Classroom.Department neq "">#Classroom.Department#<cfelse>#APPLICATION.nullCaption#</cfif></td>
						<td class="#class#"><cfif Classroom.ComputerProjector neq ""><cfif Classroom.ComputerProjector>Yes<cfelse>No</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
						<td class="#class#"><cfif Classroom.Screen neq ""><cfif Classroom.Screen>Yes<cfelse>No</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
						<td class="#class#"><cfif Classroom.ContactLastName neq "" and Classroom.ContactFirstName neq "">#Classroom.ContactLastName#, #Classroom.ContactFirstName#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<cfset x = x + 1>
				</cfoutput>
			</table>
			<cfoutput>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<input name="SessID" type="hidden" value="#SessID#">
							<input name="ActID" type="hidden" value="#ActID#">
							<cfif Add eq "1">
								<input name="Submit" type="submit" class="mainControl" value="Assign Selected" onclick="JavaScript:setVersion(Classroom, 'main');">
							<cfelseif Add eq "0">
								<input name="Submit" type="submit" class="mainControl" value="Remove Selected" onclick="JavaScript:setVersion(Classroom, 'main');">
							</cfif>
							<!--/form-->
						</td>
						<cfif Add neq "0">
							<td width="12">&nbsp;</td>
							<td>
								<input name="Submit" type="submit" value="Add New Classroom" onclick="JavaScript:setVersion(Classroom, 'alt');">
								<!---form action="addNewClassroom.cfm" method="post">
									<input name="SessID" type="hidden" value="#SessID#">
									<input type="submit" value="Add New Classroom">
								</form--->
							</td>
						</cfif>
						<td width="12">&nbsp;</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Classroom, 'alt');">
							<!---form method="post" action="session.cfm?SessID=#SessID#" method="post">
								<input type="submit" class="mainControl" value="Cancel">
							</form--->
						</td>
					</tr>
				</table>
			</cfoutput>
		</div>
	</form>
</cfif>