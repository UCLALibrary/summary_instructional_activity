<cfset pageTitle = "Add an Instructional Material">
<cfinclude template="incBegin.cfm">
<script language="JavaScript" type="text/javascript">
	<!--
		// onSubmit="JavaScript:return validateForm(this);"
		// check for IE3
		var isIE3 = (navigator.appVersion.indexOf('MSIE 3') != -1);

		// object definition
		function validation(realName, formEltName, eltType, upToSnuff, format)
		{
			this.realName = realName;
			this.formEltName = formEltName;
			this.eltType = eltType;
			this.upToSnuff = upToSnuff;
			this.format = format;
		}

		// create a new object for each form element you need to validate
		var newAct = new validation('the type of instructional activity your would like to add', 'newAct', 'radio', 'isRadio(formObj)', null);
		var elts = new Array( newAct );
		var allAtOnce = false;
		var beginRequestAlertForText = "Please include ";
		var beginRequestAlertGeneric = "Please choose ";
		var endRequestAlert = ".";
		var beginInvalidAlert = " is an invalid ";
		var endInvalidAlert = "!";
		var beginFormatAlert = "  Use this format: ";

		function isRadio(formObj)
		{
			for (j=0; j<formObj.length; j++)
			{
				if (formObj[j].checked)
				{
					return true;
				}
			}
			return false;
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
<cfoutput>
	<form action="addActivity.cfm"
		  method="post"
		  name="Activity"
		  id="Activity"
		  onSubmit="JavaScript:return validateForm(this);">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<table width="350" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2"><p>I would like to add...</p></td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="newMat" type="radio" value="0">
					</td>
					<td class="rest">an instructional activity existing in the SIA Database</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="newMat" type="radio" value="1">
					</td>
					<td class="rest">a new instructional activity</td>
				</tr>
				<tr valign="top">
					<td class="rest">&nbsp;</td>
					<td class="rest">&nbsp;</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
						<cfif isDefined("FORM.ActID")>
							<input name="ActID" type="hidden" value="#FORM.ActID#">
						<cfelseif isDefined("SESSION.ActID") and SESSION.ActID neq 0>
							<input name="ActID" type="hidden" value="#SESSION.ActID#">
						</cfif>
						<cfif isDefined("FORM.refURL")>
							<input name="refURL" type="hidden" value="#FORM.refURL#">
						</cfif>
						<!--/form-->
					</td>
					<td>
						<input name="Submit" type="submit" class="mainControl" value="Cancel">
						<!---cfif isDefined("FORM.ActID")>
						<form action="activity.cfm?ActID=#FORM.ActID#" method="post">
						<cfelseif isDefined("SESSION.ActID") and SESSION.ActID neq 0>
						<form action="activity.cfm?ActID=#SESSION.ActID#" method="post">
						<cfelseif isDefined("FORM.refURL")>
						<form action="#refURL#" method="post">
						<cfelse>
						<form action="mySIA.cfm" method="post">
						</cfif>
						<input type="submit" class="mainControl" value="Cancel">
						</form--->
					</td>
				</tr>
			</table>
		</div>
	</form>
</cfoutput>