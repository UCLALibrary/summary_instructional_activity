<script language="JavaScript" type="text/javascript">
	<!--
		// create a new object for each form element you need to validate
		var Password = new validation('enter your current password', 'Password', 'text', 'isText(str)', null);
		var newPassword = new validation('enter your new password', 'newPassword', 'text', 'isText(str)', null);
		var confirmPassword = new validation('confirm your new password by entering it again', 'confirmPassword', 'text', 'isText(str)', null);
		var elts = new Array( Password, newPassword, confirmPassword );
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
	//-->
</script>
<cfoutput>
	<form action="changePassword.cfm"
		  method="post"
		  name="changePWD"
		  id="changePWD"
		  onsubmit="JavaScript:return validateForm(this);">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<cfif not up2snuff>
							<div class="formSectionTitleErr" style="width:33%;">#em#<br></div>
						</cfif>
						Enter current password<br>
						<input
							name="Password"
							type="password"
							value=""
							size="15"
							maxlength="255">
					</td>
				</tr>
				<tr valign="top">
					<td>
						Enter new password<br>
						<input
							name="newPassword"
							type="password"
							size="15"
							maxlength="255">
					</td>
				</tr>
				<tr valign="top">
					<td>
						Re-enter new password<br>
						<input
							name="confirmPassword"
							type="password"
							size="15"
							maxlength="255">
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<input type="submit" class="mainControl" style="width:100px;" value="OK">
					</td>
					</form>
					<form action="updateLibrarian.cfm" method="post">
						<td>
							<input type="submit" class="mainControl" value="Cancel">
						</td>
					</form>
				</tr>
			</table>
		</div>
	</form>
</cfoutput>
<!--onClick="JavaScript:location.href='updateLibrarian.cfm';" -->