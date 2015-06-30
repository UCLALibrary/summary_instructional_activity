<cfscript>
	/*if (ActID neq 0)
	{
		sortURL = SCRIPT_NAME & "?ActID=" & ActID & "&Add=" & Add & "&";
	}
	else */
	if (SessID neq 0)
	{
		sortURL = SCRIPT_NAME & "?SessID=" & "&ActID=" & ActID & "&Add=" & Add & "&";
	}
	else if (MatID neq 0)
	{
		sortURL = SCRIPT_NAME & "?MatID=" & MatID & "&Add=" & Add & "&";
	}
	if ( ( isDefined("FORM.Add") and FORM.Add neq "0" ) or
	     ( isDefined("URL.Add") and URL.Add neq "0" ) )
	{
		/*if (ActID neq 0)
		{
			pageTitle = "Add a Developer to this Instructional Activity";
		}
		else */
		if (SessID neq 0)
		{
			pageTitle = "Add a Presenter to this Instructional Session";
		}
		else if (MatID neq 0)
		{
			pageTitle = "Add a Developer to this Instructional Material";
		}
	}
	else
	{
		/*if (ActID neq 0)
		{
			pageTitle = "Remove a Developer from this Instructional Activity";
		}
		else */
		if (SessID neq 0)
		{
			pageTitle = "Remove a Presenter from this Instructional Session";
		}
		else if (MatID neq 0)
		{
			pageTitle = "Remove a Developer from this Instructional Material";
		}
	}
</cfscript>
<cfif Librarian.RecordCount eq 0>
	<cfset pageTitle = pageTitle>
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No other available librarians existing in SIA database.</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			<cfif UniqueRec gt 1>
				var LibID = new validation('a librarian from the list', 'LibID', 'radio', 'isRadio(formObj)', null);
			<cfelse>
				var LibID = new validation('a librarian from the list', 'LibID', 'checkbox', 'isCheck(formObj, form, 0, 1)', null);
			</cfif>
			var elts = new Array( LibID );
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
					//  alert("I am valid!"); //remove this when you use the code
					return true; //change this to return true
				}
				else
					return true;
			}

			function selectRadio(elementID)
			{
				document.Librarian.LibID[elementID].checked = true;
			}
		//-->
	</script>
	<cfinclude template="incJSInfoWindow.cfm">
	<form action="addRemoveLibrarian.cfm"
		  method="post"
		  name="Librarian"
		  id="Librarian"
		  onsubmit="JavaScript:return validateForm(this);">
		<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
		<div class="data">
			<cfif (isDefined("missingRequired") and missingRequired) or not up2snuff>
				<div class="formSectionTitleErr" style="width:50%;"><cfoutput>#em#</cfoutput></div>
			<cfelse>
				<cfif add neq 0>
					<p>
						The following
						<cfif UniqueRec gt 1> librarians<cfelse> librarian</cfif>
						currently in the SIA Database
						<cfif UniqueRec gt 1> are<cfelse> is</cfif>
						available to add
						<!---cfif ActID neq 0>
							as developers of this instructional activity.--->
						<cfif SessID neq 0>
							as presenters of this instructional session.
						<cfelseif MatID neq 0>
							as developers of this instructional material.
						</cfif>
					</p>
				<cfelse>
					<p>
						<!---cfif ActID neq 0>
							<cfif UniqueRec gt 1>
								Remove one of the following developers
							<cfelse>
								Remove the developer
							</cfif>
							currently assigned to this instructional activity.--->
						<cfif SessID neq 0>
							<cfif UniqueRec gt 1>
								Remove one of the following presenters
							<cfelse>
								Remove the presenter
							</cfif>
							currently assigned to this instructional session.
						<cfelseif MatID neq 0>
							<cfif UniqueRec gt 1>
								Remove one of the following developers
							<cfelse>
								Remove the developer
							</cfif>
							currently assigned to this instructional material.
						</cfif>
					</p>
				</cfif>
			</cfif>
			<input type="hidden" name="version" value="" />
			<cfoutput>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfif Add eq "1">
								<input name="Submit" type="submit" class="mainControl" value="Add Selected" onclick="JavaScript:setVersion(Librarian, 'main');">
							<cfelseif Add eq "0">
								<input name="Submit" type="submit" class="mainControl" value="Remove Selected" onclick="JavaScript:setVersion(Librarian, 'main');">
							</cfif>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Librarian, 'alt');">
						</td>
					</tr>
				</table>
			</cfoutput>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<cfoutput>
						<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
						<th nowrap><a href="#sortURL#fld=ln&ord=#ord#" class="columnHeading">Name</a></th>
						<th nowrap><a href="#sortURL#fld=lt&ord=#ord#" class="columnHeading">Title</a></th>
						<th nowrap><a href="#sortURL#fld=lu&ord=#ord#" class="columnHeading">Unit</a></th>
					</cfoutput>
				</tr>
				<cfset x = 0>
				<cfoutput query="Librarian" group="LibrarianID">
					<cfset class="#IIF(Librarian.CurrentRow eq 1, DE('first'), DE('rest'))#">
					<tr valign="top">
						<td class="#class#">
							<input name="LibID" type="checkbox" value="#Librarian.LibrarianID#">
							<!---cfif UniqueRec gt 1>
								<input name="LibID" type="radio" value="#Librarian.LibrarianID#">
							<cfelse>
								<input name="LibID" type="checkbox" value="#Librarian.LibrarianID#" checked>
							</cfif--->
						</td>
						<td class="#class#"><a href="JavaScript:newWindow('infoLibrarian.cfm?LibID=#Librarian.LIbrarianID#','740','300','20','25','Librarian');" <cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>>#Librarian.LastName#, #Librarian.FirstName#</a></td>
						<td class="#class#"><cfif Librarian.Title neq "">#Librarian.Title#<cfelse>#APPLICATION.nullCaption#</cfif></td>
						<td class="#class#">#Librarian.Unit#</td>
					</tr>
					<cfset x = x + 1>
				</cfoutput>
			</table>
			<cfoutput>
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
			</cfoutput>
			<cfoutput>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfif Add eq "1">
								<input name="Submit" type="submit" class="mainControl" value="Add Selected" onclick="JavaScript:setVersion(Librarian, 'main');">
							<cfelseif Add eq "0">
								<input name="Submit" type="submit" class="mainControl" value="Remove Selected" onclick="JavaScript:setVersion(Librarian, 'main');">
							</cfif>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Librarian, 'alt');">
						</td>
					</tr>
				</table>
			</cfoutput>
		</div>
	</form>
</cfif>

<!---cfif ActID neq 0>
	<input name="ActID" type="hidden" value="#ActID#"--->
<!---cfif ActID neq 0>
	<form action="activity.cfm?ActID=#ActID#" method="post">
<cfelseif SessID neq 0>
	<form method="post" action="session.cfm?SessID=#SessID#" method="post">
<cfelseif MatID neq 0>
	<form action="material.cfm?MatID=#MatID#" method="post">
<cfelseif LibID neq 0>
	<form action="contacts.cfm?LibID=#LibID#" method="post">
</cfif>
	<input type="submit" class="mainControl" value="Cancel">
</form--->
