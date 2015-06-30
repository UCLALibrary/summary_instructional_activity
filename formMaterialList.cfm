<cfscript>
	if (ActID neq 0)
	{
		sortURL = SCRIPT_NAME & "?ActID=" & ActID & "&SessID=" & SessID & "&add=" & add & "&";
	}
	else
	{
		sortURL = SCRIPT_NAME & "?add=" & add & "&";
	}
</cfscript>
<cfif Material.RecordCount eq 0>
	<cfset pageTitle = "Add an Instructional Material">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional materials available to add/remove</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfscript>
		if (Add neq "0")
		{
			pageTitle = "Add an Instructional Material";
		}
		else
		{
			pageTitle = "Remove an Instructional Material";
		}
	</cfscript>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
		// create a new object for each form element you need to validate
		<cfif UniqueRec gt 1>
		var MatID = new validation('an instructional material', 'MatID', 'radio', 'isRadio(formObj)', null);
		<cfelse>
		var MatID = new validation('an instructional material', 'MatID', 'checkbox', 'isCheck(formObj, form, 0, 1)', null);
		</cfif>
		var elts = new Array(
		MatID
		);
		var allAtOnce = false;
		var beginRequestAlertForText = "Please include ";
		var beginRequestAlertGeneric = "Please choose ";
		var endRequestAlert = ".";
		var beginInvalidAlert = " is an invalid ";
		var endInvalidAlert = "!";
		var beginFormatAlert = "  Use this format: ";

		function validateForm(form) {
		var formEltName = "";
		var formObj = "";
		var str = "";
		var realName = "";
		var alertText = "";
		var firstMissingElt = null;
		var hardReturn = "\r\n";

		for (i=0; i<elts.length; i++) {
		formEltName = elts[i].formEltName;
		formObj = eval("form." + formEltName);
		realName = elts[i].realName;

		if (elts[i].eltType == "text") {
		str = formObj.value;

		if (eval(elts[i].upToSnuff)) continue;

		if (str == "") {
		if (allAtOnce) {
		alertText += beginRequestAlertForText + realName + endRequestAlert + hardReturn;
		if (firstMissingElt == null) {firstMissingElt = formObj};
		} else {
		alertText = beginRequestAlertForText + realName + endRequestAlert + hardReturn;
		alert(alertText);
		}
		} else {
		if (allAtOnce) {
		alertText += str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
		} else {
		alertText = str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
		}
		if (elts[i].format != null) {
		alertText += beginFormatAlert + elts[i].format + hardReturn;
		}
		if (allAtOnce) {
		if (firstMissingElt == null) {firstMissingElt = formObj};
		} else {
		alert(alertText);
		}
		}
		} else {
		if (eval(elts[i].upToSnuff)) continue;
		if (allAtOnce) {
		alertText += beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
		if (firstMissingElt == null) {firstMissingElt = formObj};
		} else {
		alertText = beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
		alert(alertText);
		}
		}
		if (!isIE3) {
		var goToObj = (allAtOnce) ? firstMissingElt : formObj;
		if (goToObj.select) goToObj.select();
		if (goToObj.focus) goToObj.focus();
		}
		if (!allAtOnce) {return false};
		}
		if (allAtOnce) {
		if (alertText != "") {
		alert(alertText);
		return false;
		}
		}
		//  alert("I am valid!"); //remove this when you use the code
		return true; //change this to return true
		}
		function selectRadio(elementID) {
		document.Material.MatID[elementID].checked = true;
		}
		//-->
	</script>
	<cfinclude template="incJSInfoWindow.cfm">
	<form action="addRemoveMaterial.cfm"
		  method="post"
		  name="Material"
		  id="Material"
		  onsubmit="JavaScript:return validateForm(this);">
		<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
		<div class="data">
			<cfif isDefined("missingRequired") and missingRequired>
				<div class="formSectionTitleErr" style="width:50%;"><cfoutput>#em#</cfoutput></div>
			</cfif>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<cfoutput>
						<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
						<th nowrap><a href="#sortURL#fld=mt&ord=#ord#" class="columnHeading">Title</a></th>
						<th nowrap><a href="#sortURL#fld=my&ord=#ord#" class="columnHeading">Type</th>
						<th nowrap><a href="#sortURL#fld=ml&ord=#ord#" class="columnHeading">Developed by</th>
						<th nowrap><a href="#sortURL#fld=mu&ord=#ord#" class="columnHeading">Unit</th>
						<th nowrap><a href="#sortURL#fld=mq&ord=#ord#" class="columnHeading">Quarter</th>
						<th nowrap><a href="#sortURL#fld=mc&ord=#ord#" class="columnHeading">Completed</th>
					</cfoutput>
				</tr>
				<cfset x = 0>
				<cfoutput query="Material" group="MaterialID">
					<cfset class="#IIF(Material.CurrentRow eq 1, DE('first'), DE('rest'))#">
					<tr valign="top">
						<td class="#class#">
							<!---cfif UniqueRec gt 1>
								<input name="MatID" type="radio" value="#Material.MaterialID#">
							<cfelse>
							</cfif--->
							<input name="MatID" type="checkbox" value="#Material.MaterialID#">
						</td>
						<td class="#class#"><a href="JavaScript:newWindow('infoMaterial.cfm?MatID=#Material.MaterialID#','740','300','20','25','Material');" <cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>>#Material.MaterialTitle#</a></td>
						<td class="#class#">#Material.MaterialType#</td>
						<td class="#class#"><cfoutput group="LibrarianID">#Material.LibrarianLastName#<br></cfoutput></td>
						<td class="#class#">#Material.Unit#</td>
						<td nowrap class="#class#"><cfif Material.CompletionDT neq "">'#Right(DatePart("yyyy", Material.CompletionDT), 2)# #Material.Quarter#<cfelse>#APPLICATION.nullCaption#</cfif></td>
						<td nowrap class="#class#"><cfif Material.CompletionDT neq "">#DateFormat(Material.CompletionDT, "mm/dd/yy")#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<cfset x = x + 1>
				</cfoutput>
			</table>
			<cfoutput>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfif Add neq "0">
								<input name="Submit" type="submit" class="mainControl" value="Add Selected">
							<cfelse>
								<input name="Submit" type="submit" class="mainControl" value="Remove Selected">
							</cfif>
							<cfif isDefined("FORM.ActID")>
								<input name="ActID" type="hidden" value="#FORM.ActID#">
							<cfelseif isDefined("URL.ActID")>
								<input name="ActID" type="hidden" value="#URL.ActID#">
							</cfif>
							<cfif isDefined("FORM.SessID")>
								<input name="SessID" type="hidden" value="#FORM.SessID#">
							<cfelseif isDefined("URL.SessID")>
								<input name="SessID" type="hidden" value="#URL.SessID#">
							</cfif>
							</form>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<cfif isDefined("FORM.ActID")>
								<form action="session.cfm?ActID=#FORM.ActID#&SessID=#FORM.SessID#" method="post">
							<cfelseif isDefined("URL.ActID")>
								<form action="session.cfm?ActID=#URL.ActID#&SessID=#URL.SessID#" method="post">
							<cfelseif isDefined("FORM.refURL")>
								<form action="#refURL#" method="post">
							<cfelse>
								<form action="mySIA.cfm" method="post">
							</cfif>
							<input type="submit" class="mainControl" value="Cancel">
							</form>
						</td>
					</tr>
				</table>
			</cfoutput>
	</div>
</cfif>