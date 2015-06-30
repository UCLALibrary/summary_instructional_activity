<script language="JavaScript" type="text/javascript">
	<!--
		// create a new object for each form element you need to validate
		var LastName = new validation('enter your last name', 'LastName', 'text', 'isText(str)', null);
		var FirstName = new validation('enter your first name', 'FirstName', 'text', 'isText(str)', null);
		var Email = new validation('enter your email address', 'Email', 'text', 'isEmail(str)', null);
		var netUserName = new validation('enter your library network user name', 'netUserName', 'text', 'isText(str)', null);
		var elts = new Array( LastName, FirstName, Email, netUserName );
		var allAtOnce = false;
		var beginRequestAlertForText = "Please ";
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
	<form action="createAccount.cfm"
		  method="post"
		  name="Contact"
		  id="Contact"
		  onsubmit="JavaScript:return validateForm(this);">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<div style="width:50%">
				<cfif isDefined("up2snuff") and not up2snuff>
					<div class="formSectionTitleErr">#em#<br></div>
				<cfelse>
					<p>Welcome to the UCLA Library SIA Database.
					It will take only a few minutes to create your
					account. Please complete the form below. Once
					you have received your email confirmation message,
					you can begin exploring all of the  excitement the
					SIA Database has to offer. Make sure you:</p>
					<ul>
						<li>Enter your first and last names
						<em>exactly as they appear in the UCLA Campus Directory</em>
						(you can change these later)</li>
						<li>Enter your <em>UCLA Library</em> email address</li>
						<li>Enter your Library network user name (i.e.,
						the one you used to log on to your workstation)</li>
					</ul>
				</cfif>
			</div>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<em class="required">*</em>
						<cfset elementName = "LastName">
						<cfset elementLabel = "Your last name">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="LastName"
							size="35"
							maxlength="255"
							<cfif isDefined("FORM.LastName")>
								value="#FORM.LastName#"
							</cfif>
						>
					</td>
					<td valign="bottom">
						<a href="javascript:ShowDirectory('Contact')">Search and copy from<br>UCLA directory</a>
					</td>
				</tr>
				<tr valign="top">
					<td colspan="2">
						<em class="required">*</em>
						<cfset elementName = "FirstName">
						<cfset elementLabel = "Your first name">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="FirstName"
							size="35"
							maxlength="255"
							<cfif isDefined("FORM.FirstName")>
								value="#FORM.FirstName#"
							</cfif>
						>
					</td>
				</tr>
				<tr valign="top">
					<td colspan="2">
						<em class="required">*</em>
						<cfset elementName = "Email">
						<cfset elementLabel = "Your email address">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="Email"
							size="35"
							maxlength="255"
							<cfif isDefined("FORM.Email")>
								value="#FORM.Email#"
							</cfif>
						>
					</td>
				</tr>
				<tr valign="top">
					<td colspan="2">
						<em class="required">*</em>
						<cfset elementName = "netUserName">
						<cfset elementLabel = "Library network user name">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="netUserName"
							size="35"
							maxlength="255"
							<cfif isDefined("FORM.netUserName")>
							value="#FORM.netUserName#"
							</cfif>
						>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<input type="hidden" name="Title">
						<input type="hidden" name="Telephone">
						<input type="hidden" name="Fax">
						<input type="hidden" name="CampusAddress">
						<input type="hidden" name="CampusMailcode">
						<input name="reqElements" type="hidden" value="LastName,Last name;FirstName,First name;Email,Email address;netUserName,Library network user name">
						<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Contact, 'main');">
					<!--/td>
					</form-->
					</td>
					<!--td-->
					<td>
						<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Contact, 'alt');">
						<!--form action="index.cfm" method="post">
						<input type="submit" class="mainControl" value="Cancel">
						</form-->
					</td>
				</tr>
			</table>
		</div>
	</form>
</cfoutput>