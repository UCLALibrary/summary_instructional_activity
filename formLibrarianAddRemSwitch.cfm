<cfscript>
	/*if (ActID neq 0)
	{
		pageTitle = "Add or Remove a Developer to/from this Instructional Activity";
	}
	else */
	if (SessID neq 0)
	{
		if ( IsDefined("LibType") and LibType eq "develop" )
			pageTitle = "Add or Remove a Developer to/from this Instructional Session";
		else
			pageTitle = "Add or Remove a Presenter to/from this Instructional Session";
	}
	else if (MatID neq 0)
	{
		pageTitle = "Add or Remove a Developer to/from this Instructional Material";
	}
	else
	{
		pageTitle = "Add or Remove a Librarian";
	}
</cfscript>
<cfinclude template="incBegin.cfm">
<script language="JavaScript" type="text/javascript">
	<!--
		// create a new object for each form element you need to validate
		<cfif ActID neq 0>
			var Add = new validation('whether you would like to add or remove a developer', 'Add', 'radio', 'isRadio(formObj)', null);
		</cfif>
		<cfif SessID neq 0>
			var Add = new validation('whether you would like to add or remove a presenter', 'Add', 'radio', 'isRadio(formObj)', null);
		</cfif>
		<cfif MatID neq 0>
			var Add = new validation('whether you would like to add or remove a developer', 'Add', 'radio', 'isRadio(formObj)', null);
		</cfif>
		var elts = new Array( Add );
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
<cfoutput>
	<form action="addRemoveLibrarian.cfm"
	      method="post"
	      name="Librarian"
	      id="Librarian"
	      onSubmit="JavaScript:return validateForm(this);">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<table width="350" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2"><p>What would you like to do?</p></td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="Add" type="radio" value="1" checked>
					</td>
					<td width="90%" class="rest">
						<!---cfif ActID neq 0>Add a developer to this instructional activity--->
						<cfif SessID neq 0>Add a <cfif IsDefined("LibType") and LibType eq "develop">developer<cfelse>presenter</cfif> to this instructional session
						<cfelseif MatID neq 0>Add a developer to this instructional material</cfif>
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="Add" type="radio" value="0">
					</td>
					<td class="rest">
						<!---cfif ActID neq 0>Remove a developer currently assigned to this instructional activity--->
						<cfif SessID neq 0>Remove a <cfif IsDefined("LibType") and LibType eq "develop">developer<cfelse>presenter</cfif> currently assigned to this instructional session
						<cfelseif MatID neq 0>Remove a developer currently assigned to this instructional material</cfif>
					</td>
				</tr>
				<tr valign="top">
					<td class="rest">&nbsp;</td>
					<td class="rest">&nbsp;</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<!---cfif ActID neq 0>
							<input name="ActID" type="hidden" value="#ActID#"--->
						<cfif SessID neq 0>
							<input name="ActID" type="hidden" value="#ActID#">
							<input name="SessID" type="hidden" value="#SessID#">
						<cfelseif MatID neq 0>
							<input name="MatID" type="hidden" value="#MatID#">
						<cfelseif LibID neq 0>
							<input name="LibID" type="hidden" value="#LibID#">
						</cfif>
						<cfif LibType neq 0>
							<input name="LibType" type="hidden" value="#LibType#">
						</cfif>
						<input name="Switch" type="submit" class="mainControl" style="width:100px;" value="OK">
						</form>
					</td>
					<td>
						<!---input name="Switch" type="submit" class="mainControl" value="Cancel"--->
						<!---cfif ActID neq 0>
							<form action="activity.cfm?ActID=#ActID#" method="post"--->
						<cfif SessID neq 0>
							<form action="session.cfm?SessID=#SessID#&ActID=#ActID#" method="post">
						<cfelseif MatID neq 0>
							<form action="material.cfm?MatID=#MatID#" method="post">
						<cfelseif LibID neq 0>
							<form action="contacts.cfm?LibID=#LibID#" method="post">
						</cfif>
						<input type="submit" class="mainControl" value="Cancel">
						</form>
					</td>
				</tr>
			</table>
		</div>
	</form>
</cfoutput>