<span class="formSectionTitle">Add an Activity/Session</span>
<div class="form">
	<script language="JavaScript">
		<!--
			// create a new object for each form element you need to validate
			var exe = new validation('one of the options', 'exe', 'radio', 'isRadio(formObj)', null);
			var elts = new Array( exe );
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
		//-->
	</script>
	<form action="addActivity.cfm"
		  method="post"
		  name="addActivity"
		  onSubmit="JavaScript:return validateForm(this);">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td align="right"><input name="exe" type="radio" value="addActSess"></td>
				<td>Add a new instructional activity</td>
			</tr>
			<tr valign="top">
				<td align="right"><input name="exe" type="radio" value="addSess"></td>
				<td>Add a new session to an existing instructional activity</td>
			</tr>
		</table>
	</div>
	<div class="controlArea">
		<table align="center">
			<tr valign="top">
				<td><input type="button" class="mainControl" onClick="JavaScript:history.back();"  value="&lt;&lt; Back"></td>
				<td><input type="submit" class="mainControl" value="Next &gt;&gt;"></td>
			</tr>
		</table>
	</form>
	</div>
</table>