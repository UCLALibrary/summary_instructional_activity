<script language="JavaScript" type="text/javascript">
	<!--
		// create a new object for each form element you need to validate
		var UserName = new validation('enter your SIA user name', 'UserName', 'text', 'isText(str)', null);
		var elts = new Array( UserName );
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
	<form action="getPassword.cfm"
		  method="post"
		  name="Contact"
		  id="Contact"
		  onsubmit="JavaScript:return validateForm(this);">
		<span class="formSectionTitle">#pageTitle#</span>
		<input type="hidden" name="version" value="" />
		<div class="form">
			<div style="width:50%">
				<cfif isDefined("up2snuff") and not up2snuff>
					<div class="formSectionTitleErr">#em#<br></div>
				<cfelse>
					<p>To retrieve your password, enter your SIA user name
					and press enter.</p>
				</cfif>
			</div>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<em class="required">*</em>
						<cfset elementName = "UserName">
						<cfset elementLabel = "Your SIA user name">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="UserName"
							size="35"
							maxlength="50"
							<cfif isDefined("FORM.UserName")>
								value="#FORM.UserName#"
							</cfif>
						>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<input name="reqElements" type="hidden" value="UserName,Library network user name">
						<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK"><!-- onclick="JavaScript:setVersion(Contact, 'main');"-->
					<td>
						<input name="Submit" type="submit" class="mainControl" value="Cancel"><!-- onclick="JavaScript:setVersion(Contact, 'alt');"-->
					</td>
				</tr>
			</table>
		</div>
	</form>
</cfoutput>