<script language="JavaScript" type="text/javascript">
	<!--
		// create a new object for each form element you need to validate
		var qs = new validation('a name to search', 'qs', 'text', 'isText(str)', null);
		var elts = new Array( qs );
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
			return true; //change this to return true
		}
	//-->
</script>
<form action="directory.cfm"
	  method="post"
	  name="Directory"
	  id="Directory"
	  onsubmit="JavaScript:return validateForm(this);">
	<span class="formSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
	<div class="form">
		<cfif not up2snuff>
			<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
		</cfif>
		<cfif isDefined("Person.RecordCount") and Person.RecordCount eq 0>
			<p class="error">No directory entries found</p>
		</cfif>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td>
					<em class="required">*</em>
					<cfset elementName = "qs">
					<cfset elementLabel = "Enter name">
					<cfinclude template="incHiLiteMissingElement.cfm"><br>
					<input
						name="qs"
						type="text"
						size="50"
						maxlength="255"
						<cfif isDefined("qs")>
							value="<cfoutput>#qs#</cfoutput>"
						</cfif>
					>
				</td>
			</tr>
		</table>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td>
					<!--input name="reqFields" type="hidden" value="qs,A name to search"-->
					<input name="reqElements" type="hidden" value="qs,A name to search">
					<input type="submit" class="mainControl" value="Search">
				</td>
				<td>
					<input type="button" class="mainControl" onclick="window.close()" value="Cancel">
					<!--form>
					<input type="button" class="mainControl" onclick="window.close()" value="Cancel">
					</form-->
				</td>
			</tr>
		</table>
	</div>
</form>