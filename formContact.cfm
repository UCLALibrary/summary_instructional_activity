<cfif (isDefined("Contact.RecordCount") and Contact.RecordCount eq 0) and not ListContains("addRemoveContact.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
	<cfset pageTitle = "No Contact Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No contact found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfscript>
		if (ListContains("addRemoveContact.cfm,addNewContact.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ","))
		{
			if (ActID neq 0)
			{
				pageTitle = "Add a New Contact to this Instructional Activity";
			}
			else if (SessID neq 0)
			{
				pageTitle = "Add a New Contact to this Instructional Session";
			}
			else if (MatID neq 0)
			{
				pageTitle = "Add a New Contact to this Instructional Material";
			}
			else
			{
				pageTitle = "Add a New Contact to Your mySIA Profile";
			}
		}
		else
		{
			pageTitle = "Update Contact";
		}
	</cfscript>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--

			// create a new object for each form element you need to validate
			var LastName = new validation('a last name', 'LastName', 'text', 'isText(str)', null);
			var FirstName = new validation('a first name', 'FirstName', 'text', 'isText(str)', null);
			var Email = new validation('an email address', 'Email', 'text', 'isEmail(str)', null);
			var elts = new Array( LastName, FirstName, Email );
			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please choose ";
			var endRequestAlert = ".";
			var beginInvalidAlert = " is an invalid ";
			var endInvalidAlert = "!";
			var beginFormatAlert = "  Use this format: ";

			function isPhoneNum(str)
			{
				if (str.length != 12)
				{
					return false
				}
				for (j=0; j<str.length; j++)
				{
					if ((j == 3) || (j == 7))
					{
						if (str.charAt(j) != "-")
						{
							return false
						}
					}
					else
					{
						if ((str.charAt(j) < "0") || (str.charAt(j) > "9"))
						{
							return false
						}
					}
				}
				return true;
			}

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
		<cfscript>
			if (ListContains("updateContact.cfm,updateContactExe.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ","))
			{
				Action = "updateContact.cfm";
			}
			else if (ListContains("addRemoveContact.cfm,addNewContact.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ","))
			{
				Action = "addNewContact.cfm";
			}
		</cfscript>
		<form action="#Action#" method="post" name="Contact" id="Contact" onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				</cfif>
				<cfif isDefined("Activity.RecordCount") or
				      isDefined("Sess.RecordCount") or
				      isDefined("Material.RecordCount")>
					<cfif isDefined("Activity.RecordCount") or
					      isDefined("Material.RecordCount")>
					      	<table border="0" cellpadding="0" cellspacing="0">
					      		<tr valign="top">
								<td>
									Contact to be added to:<br>
									<input name="Title" type="text" disabled="true"
									<cfif isDefined("Activity.RecordCount")>
										value="#Activity.Title#"
									<cfelseif isDefined("Material.RecordCount")>
										value="#Material.MaterialTitle#"
									</cfif>
									size="65" readonly="true">
								</td>
							</tr>
						</table>
					<cfelse>
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
				</cfif>
				<input type="hidden" name="version" value="" />
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td valign="bottom" colspan="3">
							<a href="javascript:ShowDirectory('Contact')">
								Search and copy from UCLA directory
							</a>
						</td>
					</tr>
					<tr valign="top">
						<td>
							<em class="required">*</em>
							<cfset elementName = "LastName">
							<cfset elementLabel = "Last name">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="LastName"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.LastName")>
									value="#FORM.LastName#"
								<cfelseif isDefined("Contact.LastName")>
									value="#Contact.LastName#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td>
							<em class="required">*</em>
							<cfset elementName = "FirstName">
							<cfset elementLabel = "First name">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="FirstName"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.FirstName")>
									value="#FORM.FirstName#"
								<cfelseif isDefined("Contact.FirstName")>
									value="#Contact.FirstName#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td valign="bottom">&nbsp;</td>
					</tr>
					<tr valign="top">
						<td colspan="3"><!-- rowspan="2" -->
							Title<br>
							<input
								type="text"
								name="Title"
								size="50"
								maxlength="255"
								<cfif isDefined("FORM.Title")>
									value="#FORM.Title#"
								<cfelseif isDefined("Contact.Title")>
									value="#Contact.Title#"
								<cfelse>
									value=""
								</cfif>
							>
							<!---textarea
								name="Title"
								cols="48"
								rows="4">
								<cfif isDefined("FORM.Title")>
									#FORM.Title#
								<cfelseif isDefined("Contact.Title")>
									#Contact.Title#
								<cfelse>
								</cfif>
							</textarea--->
						</td>
					</tr>
					<tr valign="top">
						<td>
							Status<br>
							<cfset Lookup = "ContactStatus">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="ContactStatusID">
								<cfloop query="ContactStatus">
									<option
										value="#ContactStatus.ContactStatusID#"
										<cfif isDefined("FORM.ContactStatusID") and FORM.ContactStatusID eq ContactStatus.ContactStatusID>selected<cfelseif isDefined("Contact.ContactStatusID") and Contact.ContactStatusID eq ContactStatus.ContactStatusID>selected</cfif>
									>
										#ContactStatus.ContactStatus#
									</option>
								</cfloop>
							</select>
						</td>
						<td>
							Affiliation<br>
							<cfset Lookup = "Affiliation">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="AffiliationID">
								<cfloop query="Affiliation">
									<option
										value="#Affiliation.AffiliationID#"
										<cfif isDefined("FORM.AffiliationID") and FORM.AffiliationID eq Affiliation.AffiliationID>selected<cfelseif isDefined("Contact.AffiliationID") and Contact.AffiliationID eq Affiliation.AffiliationID>selected</cfif>
										>
										#Affiliation.Affiliation#
									</option>
								</cfloop>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<table border="0" cellpadding="1" cellspacing="1">
					<tr valign="top">
						<td>
							Academic Departments and More<br>
							<cfset Lookup = "Department">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="DepartmentID">
								<cfloop query="Department">
									<option
										value="#Department.DepartmentID#"
										<cfif isDefined("FORM.DepartmentID") and FORM.DepartmentID eq Department.DepartmentID>selected<cfelseif isDefined("Contact.DepartmentID") and Contact.DepartmentID eq Department.DepartmentID>selected</cfif>
										>
										#Department.Department#
									</option>
								</cfloop>
							</select>
						</td>
						<td align="center" valign="top"><b>OR</b></td>
						<td>
							Other department, college, etc.<br>
							<input
								name="FacultyGroup"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.FacultyGroup")>
									value="#FORM.FacultyGroup#"
								<cfelseif isDefined("Contact.FacultyGroup")>
									value="#Contact.FacultyGroup#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td colspan="3"><em class="required">*</em>
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
								<cfelseif isDefined("Contact.Email")>
									value="#Contact.Email#"
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
								<cfelseif isDefined("Contact.Telephone")>
									value="#Contact.Telephone#"
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
								maxlength="12"
								<cfif isDefined("FORM.TelephoneMobile")>
									value="#FORM.TelephoneMobile#"
								<cfelseif isDefined("Contact.TelephoneMobile")>
									value="#Contact.TelephoneMobile#"
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
								maxlength="12"
								<cfif isDefined("FORM.Fax")>
									value="#FORM.Fax#"
								<cfelseif isDefined("Contact.Fax")>
									value="#Contact.Fax#"
								<cfelse>
									value=""
								</cfif>
							><br>
							######-######-########
						</td>
					</tr>
					<tr valign="top">
						<td>
							Campus address<br>
							<input
								name="CampusAddress"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.CampusAddress")>
									value="#FORM.CampusAddress#"
								<cfelseif isDefined("Contact.CampusAddress")>
									value="#Contact.CampusAddress#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td colspan="2">
							Campus mailcode<br>
							<input
								name="CampusMailcode"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.CampusMailCode")>
									value="#FORM.CampusMailCode#"
								<cfelseif isDefined("Contact.CampusMailCode")>
									value="#Contact.CampusMailCode#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="2" rowspan="2">
							Comments<br>
							<textarea name="Comments" cols="48" rows="4"><cfif isDefined("FORM.Comments")>#FORM.Comments#<cfelseif isDefined("Contact.Comments")>#Contact.Comments#<cfelse></cfif></textarea>
						</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfif Find("updateContact.cfm", SCRIPT_NAME)>
								<input name="CntctID" type="hidden" value="#Contact.ContactID#">
							<cfelseif Find("addNewContact.cfm", SCRIPT_NAME)>
								<!---cfif ActID neq 0>
									<input name="ActID" type="hidden" value="#ActID#"--->
								<cfif SessID neq 0>
									<input name="SessID" type="hidden" value="#SessID#">
									<input name="ActID" type="hidden" value="#ActID#">
								<cfelseif MatID neq 0>
									<input name="MatID" type="hidden" value="#MatID#">
								</cfif>
							</cfif>
							<cfif isDefined("FORM.refURL")>
								<input name="refURL" type="hidden" value="#FORM.refURL#">
							</cfif>
							<input name="reqElements" type="hidden" value="LastName,Last name;FirstName,First name;Email,Email address">
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Contact, 'main');" >
						</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Contact, 'alt');" >
							<!---cfif Find("updateContact.cfm", SCRIPT_NAME)>
								<form action="contact.cfm?CntctID=#CntctID#" method="post">
							<cfelseif Find("addNewContact.cfm", SCRIPT_NAME)>
								<cfif ActID neq 0>
									<form action="activity.cfm?ActID=#ActID#" method="post">
								<cfelseif SessID neq 0>
									<form action="session.cfm?SessID=#SessID#" method="post">
								<cfelseif MatID neq 0>
									<form action="material.cfm?MatID=#MatID#" method="post">
								<cfelseif isDefined("FORM.refURL")>
									<form action="#FORM.refURL#" method="post">
								<cfelse>
									<form action="mySIA.cfm" method="post">
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