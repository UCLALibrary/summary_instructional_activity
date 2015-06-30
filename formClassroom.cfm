<cfif (isDefined("Classroom.RecordCount") and Classroom.RecordCount eq 0) and not Find("addRemoveClassroom.cfm", SCRIPT_NAME)>
	<cfset pageTitle = "No Classroom Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No classroom found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfscript>
		if (Find("addNewClassroom", SCRIPT_NAME))
		{
			pageTitle = "Add a New Classroom";
		}
		else if (Find("updateClassroom.cfm", SCRIPT_NAME))
		{
			pageTitle = "Update Classroom Information";
		}
		else
		{
			pageTitle = "Classroom Information";
		}
	</cfscript>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incJSShowCalendar.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			var Name = new validation('a name for the classroom location', 'Name', 'text', 'isText(str)', null);
			var Building = new validation('a building', 'Building', 'text', 'isText(str)', null);
			var RoomNumber = new validation('a room number', 'RoomNumber', 'text', 'isText(str)', null);
			var elts = new Array( Name, Building, RoomNumber );
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
			if (ListContains("updateClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ","))
			{
				Action = "updateClassroom.cfm";
			}
			else if (ListContains("addRemoveClassroom.cfm,addNewClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ","))
			{
				Action = "addNewClassroom.cfm";
			}
		</cfscript>
		<form action="#Action#"
			  method="post"
			  name="Classroom"
			  id="Classroom"
			  onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<input type="hidden" name="version" value="">
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				</cfif>
				<cfif isDefined("Sess.RecordCount")>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<td colspan="2">
								Instructional session title<br>
								<input name="Title" type="text" disabled="true" value="#Sess.Title#" size="58" readonly="true">
							</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<td>
								Session date<br>
								<input name="SessionDateTime" type="text" disabled="true" value="#DateFormat(Sess.SessionDateTime, "mm/dd/yyyy")#" size="12" readonly="true">
							</td>
							<td colspan="2">
								Session time<br>
								<input name="SessionTime" type="text" disabled="true" value="#TimeFormat(Sess.SessionDateTime, "h:mm tt")#" size="8" readonly="true">
							</td>
						</tr>
					</table>
				</cfif>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td colspan="2">
							<em class="required">*</em>
							<cfset elementName = "Name">
							<cfset elementLabel = "Classroom name">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="Name"
								type="text"
								size="55"
								maxlength="255"
								<cfif isDefined("FORM.Name")>
									value="#FORM.Name#"
								<cfelseif isDefined("Classroom.Name")>
									value="#Classroom.Name#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							UCLA department<br>
							<cfset Lookup = "Department">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="DepartmentID">
								<cfloop query="Department">
									<option value="#Department.DepartmentID#"
										<cfif isDefined("FORM.DepartmentID") and FORM.DepartmentID eq Department.DepartmentID>
										selected
										<cfelseif isDefined("Classroom.DepartmentID") and Classroom.DepartmentID eq Department.DepartmentID>
										selected
										<cfelse>
										</cfif>
									>#Department.Department#</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr valign="top">
						<td>
							<em class="required">*</em>
							<cfset elementName = "Building">
							<cfset elementLabel = "Building">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="Building"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.Building")>
									value="#FORM.Building#"
								<cfelseif isDefined("Classroom.Building")>
									value="#Classroom.Building#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td>
							<em class="required">*</em>
							<cfset elementName = "RoomNumber">
							<cfset elementLabel = "Room number">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="RoomNumber"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.RoomNumber")>
									value="#FORM.RoomNumber#"
								<cfelseif isDefined("Classroom.RoomNumber")>
									value="#Classroom.RoomNumber#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							General room description<br>
							<textarea name="GeneralDescription" cols="48" rows="2"><cfif isDefined("FORM.GeneralDescription")>#FORM.GeneralDescription#<cfelseif isDefined("Classroom.GeneralDescription")>#Classroom.GeneralDescription#<cfelse></cfif></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="middle">
						<td align="right">
							Computer projector available:
						</td>
						<td>
							<input
								name="ComputerProjector"
								type="radio"
								value="1"
								<cfif isDefined("FORM.ComputerProjector") and FORM.ComputerProjector eq 1>
									checked
								<cfelseif isDefined("Classroom.ComputerProjector") and Classroom.ComputerProjector eq 1>
									checked
								<cfelse>
								</cfif>
							>Yes
							<input
								name="ComputerProjector"
								type="radio"
								value="0"
								<cfif isDefined("FORM.ComputerProjector") and FORM.ComputerProjector eq 0>
									checked
								<cfelseif isDefined("Classroom.ComputerProjector") and Classroom.ComputerProjector eq 0>
									checked
								<cfelse>
								</cfif>
							>No
						</td>
					</tr>
					<tr valign="top">
						<td align="right">
							Screen available:
						</td>
						<td>
							<input
								name="Screen"
								type="radio"
								value="1"
								<cfif isDefined("FORM.Screen") and FORM.Screen eq 1>
									checked
								<cfelseif isDefined("Classroom.Screen") and Classroom.Screen eq 1>
									checked
								<cfelse>
								</cfif>
							>Yes
							<input
								name="Screen"
								type="radio"
								value="0"
								<cfif isDefined("FORM.Screen") and FORM.Screen eq 0>
									checked
								<cfelseif isDefined("Classroom.Screen") and Classroom.Screen eq 0>
									checked
								<cfelse>
								</cfif>
							>No
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td colspan="3">
							Instructor workstation description<br>
							<textarea name="ComputerInstructorDesc" cols="48" rows="2"><cfif isDefined("FORM.ComputerInstructorDesc")>#FORM.ComputerInstructorDesc#<cfelseif isDefined("Classroom.ComputerInstructorDesc")>#Classroom.ComputerInstructorDesc#<cfelse></cfif></textarea>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							Student workstation description<br>
							<textarea name="ComputerStudentDesc" cols="48" rows="2"><cfif isDefined("FORM.ComputerStudentDesc")>#FORM.ComputerStudentDesc#<cfelseif isDefined("Classroom.ComputerStudentDesc")>#Classroom.ComputerStudentDesc#<cfelse></cfif></textarea>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							ADA accessibility description<br>
							<textarea name="ADAAccessibility" cols="48" rows="2"><cfif isDefined("FORM.ADAAccessibility")>#FORM.ADAAccessibility#<cfelseif isDefined("Classroom.ADAAccessibility")>#Classroom.ADAAccessibility#<cfelse></cfif></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="middle">
						<td>
							Room capacity
						</td>
						<td>
							<input
								name="RoomCapacity"
								type="text"
								size="10"
								maxlength="6"
								<cfif isDefined("FORM.RoomCapacity")>
									value="#FORM.RoomCapacity#"
								<cfelseif isDefined("Classroom.RoomCapacity")>
									value="#Classroom.RoomCapacity#"
								</cfif>
							>
						</td>
						<td>(number or brief description)</td>
					</tr>
				</table>
			</div>
			<span class="formSectionTitle">Contact Information</span>
			<div class="form">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							Contact last name<br>
							<input
								name="ContactLastName"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.ContactLastName")>
									value="#FORM.ContactLastName#"
								<cfelseif isDefined("Classroom.ContactLastName")>
									value="#Classroom.ContactLastName#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td colspan="2">
							Contact first name<br>
							<input
								name="ContactFirstName"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.ContactFirstName")>
									value="#FORM.ContactFirstName#"
								<cfelseif isDefined("Classroom.ContactFirstName")>
									value="#Classroom.ContactFirstName#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							<cfset elementName = "Email">
							<cfset elementLabel = "Email address">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="Email"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.Email")>
									value="#FORM.Email#"
								<cfelseif isDefined("Classroom.Email")>
									value="#Classroom.Email#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td>
							<cfset elementName = "Telephone">
							<cfset elementLabel = "Telephone">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="Telephone"
								type="text"
								size="25"
								maxlength="50"
								<cfif isDefined("FORM.Telephone")>
									value="#FORM.Telephone#"
								<cfelseif isDefined("Classroom.Telephone")>
									value="#Classroom.Telephone#"
								<cfelse>
									value=""
								</cfif>
							><br>
							######-######-########
						</td>
						<td>
							<cfset elementName = "TelephoneMobile">
							<cfset elementLabel = "Mobile">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="TelephoneMobile"
								type="text"
								size="25"
								maxlength="50"
								<cfif isDefined("FORM.TelephoneMobile")>
									value="#FORM.TelephoneMobile#"
								<cfelseif isDefined("Classroom.TelephoneMobile")>
									value="#Classroom.TelephoneMobile#"
								<cfelse>
									value=""
								</cfif>
							><br>
							######-######-########
						</td>
						<td>
							<cfset elementName = "Fax">
							<cfset elementLabel = "Fax">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="Fax"
								type="text"
								size="25"
								maxlength="50"
								<cfif isDefined("FORM.Fax")>
									value="#FORM.Fax#"
								<cfelseif isDefined("Classroom.Fax")>
									value="#Classroom.Fax#"
								<cfelse>
									value=""
								</cfif>
							><br>
							######-######-########
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfset elementName = "CalendarURL">
							<cfset elementLabel = 'URL for online calendar (including "http://")'>
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="CalendarURL"
								type="text"
								size="55"
								maxlength="500"
								<cfif isDefined("FORM.CalendarURL")>
									value="#FORM.CalendarURL#"
								<cfelseif isDefined("Classroom.CalendarURL")>
									value="#Classroom.CalendarURL#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfif Find("updateClassroom.cfm", SCRIPT_NAME)>
								<input name="ClassID" type="hidden" value="#Classroom.ClassroomID#">
							<cfelseif Find("addNewClassroom.cfm", SCRIPT_NAME)>
								<cfif SessID neq 0>
									<input name="SessID" type="hidden" value="#Sess.SessionID#">
								</cfif>
								<cfif IsDefined("ActID") and ActID neq 0>
									<input name="ActID" type="hidden" value="#ActID#">
								</cfif>
							</cfif>
							<input name="reqElements" type="hidden" value="Name,Classroom name;Building,Building;RoomNumber,Room number">
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Classroom, 'main');">
							<!--/form-->
						</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Classroom, 'alt');">
							<!---cfif ListContains("updateClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
								<form action="classroom.cfm?ClassID=#Classroom.ClassroomID#" method="post">
							<cfelseif ListContains("addNewClassroom.cfm,addNewClassroomExe.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
								<cfif SessID neq 0>
									<form action="session.cfm?SessID=#Sess.SessionID#" method="post">
								<cfelse>
									<form action="classrooms.cfm" method="post">
								</cfif>
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
