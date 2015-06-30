<cfset pageTitle = "Add a New Contact to this Instructional Activity">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>SIA Database</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="css/global.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" type="text/javascript" src="js/incFunctions.js"></script>
	</head>
	<body style="margin:0;background-color:#FFFFFF;">
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
			<form action="addContact.cfm" method="post" name="Contact" id="Contact" onsubmit="JavaScript:return validateForm(this);">
				<span class="formSectionTitle">#pageTitle#</span>
				<div class="form">
					<cfif IsDefined("up2snuff") and not up2snuff>
						<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
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
									<cfelse>
										value=""
									</cfif>
								>
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
											<cfif isDefined("FORM.ContactStatusID") and FORM.ContactStatusID eq ContactStatus.ContactStatusID>selected</cfif>
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
											<cfif isDefined("FORM.AffiliationID") and FORM.AffiliationID eq Affiliation.AffiliationID>selected\</cfif>
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
											<cfif isDefined("FORM.DepartmentID") and FORM.DepartmentID eq Department.DepartmentID>selected</cfif>
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
									<cfelse>
										value=""
									</cfif>
								>
							</td>
						</tr>
						<tr valign="top">
							<td colspan="2" rowspan="2">
								Comments<br>
								<textarea name="Comments" cols="48" rows="4"><cfif isDefined("FORM.Comments")>#FORM.Comments#<cfelse></cfif></textarea>
							</td>
							<td>&nbsp;</td>
						</tr>
					</table>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<input name="reqElements" type="hidden" value="LastName,Last name;FirstName,First name;Email,Email address">
								<input type="hidden" name="adding" value="1">
								<input type="hidden" name="formName" value="#formName#">
								<input type="hidden" name="displayName" value="#displayName#">
								<input type="hidden" name="valueName" value="#valueName#">
								<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Contact, 'main');" >
							</td>
						</tr>
					</table>
				</div>
			</form>
		</cfoutput>
	</body>
</html>