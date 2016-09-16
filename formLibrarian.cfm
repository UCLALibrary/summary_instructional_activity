<cfif Librarian.RecordCount eq 0>
	<cfset pageTitle = "No Librarian Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No librarian found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfset pageTitle = "Update Information about " & Librarian.Librarian>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			var LastName = new validation('your last name', 'LastName', 'text', 'isText(str)', null);
			var FirstName = new validation('your first name', 'FirstName', 'text', 'isText(str)', null);
			var Email = new validation('your email address', 'Email', 'text', 'isEmail(str)', null);
			var elts = new Array( LastName, FirstName, Email );
			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please choose ";
			var endRequestAlert = ".";
			var beginInvalidAlert = " is an invalid ";
			var endInvalidAlert = "!";
			var beginFormatAlert = "Use this format: ";

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
		<form action="updateLibrarian.cfm"
			  method="post"
			  name="UpdateLibrarian"
			  id="UpdateLibrarian"
			  onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				</cfif>
				<input type="hidden" name="version" value="" />
				<table border="0" cellpadding="0" cellspacing="0">
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
								<cfelseif isDefined("Librarian.LastName")>
									value="#Librarian.LastName#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
						<td colspan="2">
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
								<cfelseif isDefined("Librarian.FirstName")>
									value="#Librarian.FirstName#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							Unit: &nbsp;#Librarian.Unit#
							<!---br>
							<cfset Lookup = "Unit">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<select name="UnitID" disabled="disabled">
								<option value="0">-select-</option>
								<cfloop query="Unit">
									<option
										value="#Unit.UnitID#"
										<cfif isDefined("Unit.UnitID") and Librarian.UnitID eq Unit.UnitID>
											selected
										</cfif>
									>#Unit.Unit#</option>
								</cfloop>
							</select--->
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							Title<br>
							<textarea name="Title" cols="48" rows="4"><cfif isDefined("Librarian.Title")>#Librarian.Title#</cfif></textarea>
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							<em class="required">*</em>
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
								<cfelseif isDefined("Librarian.Email")>
									value="#Librarian.Email#"
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
								maxlength="12"
								<cfif isDefined("FORM.Telephone")>
									value="#FORM.Telephone#"
								<cfelseif isDefined("Librarian.Telephone")>
									value="#Librarian.Telephone#"
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
								<cfelseif isDefined("Librarian.TelephoneMobile")>
									value="#Librarian.TelephoneMobile#"
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
								<cfelseif isDefined("Librarian.Fax")>
									value="#Librarian.Fax#"
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
								<cfif isDefined("Librarian.CampusAddress")>
									value="#Librarian.CampusAddress#"
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
								<cfif isDefined("Librarian.CampusMailCode")>
									value="#Librarian.CampusMailcode#"
								</cfif>
							>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Save Changes" onclick="JavaScript:setVersion(UpdateLibrarian, 'main');" >
							<input name="reqElements" type="hidden" value="LastName,Your last name;FirstName,Your first name;Email,Your email address">
							<!--/form-->
						</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(UpdateLibrarian, 'alt');" >
							<!---form action="mySIA.cfm" method="post">
								<input type="submit" class="mainControl" value="Cancel">
							</form--->
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>
	<cfif ListContains("updateLibrarian.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
		<cfscript>
			// initialize variables for uspGetAccount stored procedure
			LibID = LibID;
			UserName = "";
			Password = "";
		</cfscript>
		<cfinclude template="uspGetAccount.cfm">
		<cfif not up2snuff>
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfoutput>
				<form action="changePassword.cfm"
					  method="post"
					  name="changePassword"
					  id="chagePassword">
					<span class="formSectionTitle">User Name and Password</span>
					<div class="form">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="bottom">
								<td>
									SIA user name<br>
									<input
										name="UserName"
										type="text"
										disabled="true"
										value="#Account.UserName#"
										size="15"
										maxlength="255" readonly="true">
								</td>
								<td>
									Password<br>
									<input
										name="Password"
										type="password"
										disabled="true"
										value="#Account.Password#"
										size="15"
										maxlength="255" readonly="true">
								</td>
							</tr>
						</table>
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td>
									<input type="submit" class="mainControl" value="Change Password">
									</form>
								</td>
								<td>
									<form action="mySIA.cfm" method="post">
										<input type="submit" class="mainControl" value="Cancel">
									</form>
								</td>
							</tr>
						</table>
					</div>
			</cfoutput>
		</cfif>
	</cfif>
</cfif>