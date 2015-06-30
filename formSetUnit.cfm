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
	<cfset pageTitle = "Set Unit for " & Librarian.Librarian>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			var setUID = new validation('a library unit', 'setUID', 'select', 'isSelect(formObj)', null);
			var elts = new Array( setUID );
			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please select ";
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
		<form action="setUnit.cfm"
			  method="post"
			  name="SetUnit"
			  id="SetUnit"
			  onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				<cfelse>
					<p style="width:50%">
						Welcome to the SIA Database!<br><br>
						Before you can begin using the SIA Database,
						you must select your library unit.
						<strong>Please select carefully!</strong>
						If you select incorrectly or if you move to a
						different unit within the library, only an
						SIA Database administrator can reset your unit for you.
					</p>
				</cfif>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							Last name<br>
							<input
								name="LastName"
								type="text" disabled="true"
								value="#Librarian.LastName#"
								size="25"
								maxlength="255" readonly="true">
						</td>
						<td colspan="2">
							First name<br>
							<input
								name="FirstName"
								type="text" disabled="true"
								value="#Librarian.FirstName#"
								size="25"
								maxlength="255" readonly="true">
						</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							<strong>Select your library unit</strong><br>
							<cfset Lookup = "Unit">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<select name="setUID">
								<option value="0">-select-</option>
								<cfloop query="Unit">
									<option value="#Unit.UnitID#">#Unit.Unit#</option>
								</cfloop>
							</select>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
							<input name="reqElements" type="hidden" value="none">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>
</cfif>