<cfscript>
	/*if (ActID neq 0)
	{
		sortURL = SCRIPT_NAME & "?ActID=" & ActID & "&Add=" & Add & "&";
	}
	else */
	if (SessID neq 0)
	{
		sortURL = SCRIPT_NAME & "?SessID=" & SessID & "&ActID=" & ActID & "&Add=" & Add & "&";
	}
	else if (MatID neq 0)
	{
		sortURL = SCRIPT_NAME & "?MatID=" & MatID & "&Add=" & Add & "&";
	}
	else
	{
		sortURL = SCRIPT_NAME & "?LibID=" & SESSION.LibID & "&Add=" & Add & "&";
	}
	if ((isDefined("FORM.Add") and FORM.Add neq "0") or (isDefined("URL.Add") and URL.Add neq "0"))
	{
		/*if (ActID neq 0)
		{
			pageTitle = "Add a Contact to this Instructional Activity";
		}
		else */
		if (SessID neq 0)
		{
			pageTitle = "Add a Contact to this Instructional Session";
		}
		else if (MatID neq 0)
		{
			pageTitle = "Add a Contact to this Instructional Material";
		}
		else
		{
			pageTitle = "Add a Contact to Your mySIA Profile";
		}
	}
	else
	{
		/*if (ActID neq 0)
		{
			pageTitle = "Remove a Contact from this Instructional Activity";
		}
		else */
		if (SessID neq 0)
		{
			pageTitle = "Remove a Contact from this Instructional Session";
		}
		else if (MatID neq 0)
		{
			pageTitle = "Remove a Contact from this Instructional Material";
		}
		else
		{
			pageTitle = "Remove a Contact from Your mySIA Profile";
		}
	}
</cfscript>

<cfif Contact.RecordCount eq 0>
	<cfset pageTitle = pageTitle>
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No contacts existing in SIA database available to add</td>
			</tr>
		</table>
		<form action="addNewContact.cfm" method="post">
			<input type="submit" class="mainControl" value="Add New Contact">
		</form>
	</div>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			//var CntctID = new validation('a contact name', 'CntctID', 'checkbox', 'isCheck(formObj, form, 0, 1)', null);
			var CntctID = new validation('a contact name', 'CntctID', 'radio', 'isRadio(formObj)', null);
			var elts = new Array( CntctID );

			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please choose ";
			var endRequestAlert = ".";
			var beginInvalidAlert = " is an invalid ";
			var endInvalidAlert = "!";
			var beginFormatAlert = "  Use this format: ";

			function validateForm(form)
			{
				if ( form.version.value == 'main' )
				{
					if ( ( form.reccount.value * 1 ) == 1 )
					{
						if ( ! form.CntctID.checked )
						{
							alert( "Please choose a contact name" );
						}
						else
							return true;
					}
					else
					{
						for ( j = 0; j < form.CntctID.length; j++ )
						{
							if ( form.CntctID[j].checked )
							{
								return true;
							}
						}
						alert( "Please choose a contact name" );
					}
				}
				else
					return true;
			}

			function selectRadio(elementID)
			{
				document.Contact.CntctID[elementID].checked = true;
			}
		//-->
	</script>
	<cfinclude template="incJSInfoWindow.cfm">
	<form action="addRemoveContact.cfm"
	      method="post"
	      name="Contact"
	      id="Contact"
	      onsubmit="JavaScript:return validateForm(this);">
		<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
		<div class="data">
			<cfif (isDefined("missingRequired") and missingRequired) or not up2snuff>
				<div class="formSectionTitleErr" style="width:50%;"><cfoutput>#em#</cfoutput></div>
			<cfelse>
				<cfif add neq 0>
					<p>
						The following contact<cfif UniqueRec gt 1>s<cfelse></cfif>
						currently in the SIA Database
						<cfif UniqueRec gt 1>are<cfelse>is</cfif> available to add
						<!---cfif ActID neq 0>
							to this instructional activity.--->
						<cfif SessID neq 0>
							to this instructional session.
						<cfelseif MatID neq 0>
							to this instructional material.
						<cfelse>
							to your mySIA profile.
						</cfif>
					</p>
					<p>To prevent duplication, contacts you are already associated with do not appear on this list.</p>
				<cfelse>
					<p>
						<cfif UniqueRec gt 1>
							Remove one of the following contacts
						<cfelse>
							Remove the contact
						</cfif>
						<cfif ActID neq 0>
							currently assigned to this instructional activity.
						<cfelseif SessID neq 0>
							currently assigned to this instructional session.
						<cfelseif MatID neq 0>
							currently assigned to this instructional material.
						<cfelse>
							from your mySIA profile.
						</cfif>
					</p>
				</cfif>
			</cfif>

			<input type="hidden" name="version" value="" />
			<input type="hidden" name="reccount" value="<cfoutput>#UniqueRec#</cfoutput>" />

			<cfif IsDefined("URL.showButtons") or (Add eq "0")>
				<cfoutput>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<cfif Add eq "1">
									<input name="Submit" type="submit" class="mainControl" value="Add Selected" onclick="JavaScript:setVersion(Contact, 'main');" />
								<cfelseif Add eq "0">
									<input name="Submit" type="submit" class="mainControl" value="Remove Selected" onclick="JavaScript:setVersion(Contact, 'main');" />
								</cfif>
							</td>
							<cfif (isDefined("FORM.add") and FORM.add neq "0") or (isDefined("URL.add") and URL.add neq "0")>
								<td width="12">&nbsp;</td>
								<td>
									<input type="submit" name="Submit" class="mainControl" value="Add a New Contact" onclick="JavaScript:setVersion(Contact, 'alt');" />
								</td>
							</cfif>
							<td width="12">&nbsp;</td>
							<td>
								<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Contact, 'alt');" />
							</td>
						</tr>
					</table>
				</cfoutput>
			</cfif>

			<cfif add neq 0>
				<cfinclude template="formContactAlpha.cfm">
			<cfelse>
				<cfinclude template="formContactAll.cfm">
			</cfif>
			<!-- this is alpha query addin -->

			<cfif IsDefined("URL.showButtons") or (Add eq "0")>
				<cfoutput>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
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

								<cfif Add eq "1">
									<input name="Submit" type="submit" class="mainControl" value="Add Selected" onclick="JavaScript:setVersion(Contact, 'main');" />
								<cfelseif Add eq "0">
									<input name="Submit" type="submit" class="mainControl" value="Remove Selected" onclick="JavaScript:setVersion(Contact, 'main');" />
								</cfif>
								<!--/form-->
							</td>
							<cfif (isDefined("FORM.add") and FORM.add neq "0") or (isDefined("URL.add") and URL.add neq "0")>
								<td width="12">&nbsp;</td>
								<td>
									<input type="submit" name="Submit" class="mainControl" value="Add a New Contact" onclick="JavaScript:setVersion(Contact, 'alt');" />
								</td>
							</cfif>
							<td width="12">&nbsp;</td>
							<td>
								<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Contact, 'alt');" />
							</td>
						</tr>
					</table>
				</cfoutput>
			</cfif>
		</div>
	</form>
</cfif>
	<!--- cfoutput query="Contact" group="ContactID">
	<cfset class="#IIF(Contact.CurrentRow eq 1, DE('first'), DE('rest'))#">
	<tr valign="top">
	<td class="#class#">
	<cfif UniqueRec gt 1>
	<input name="CntctID" type="radio" value="#Contact.ContactID#">
	<cfelse>
	<input name="CntctID" type="checkbox" value="#Contact.ContactID#" checked>
	</cfif>
	</td>
	<td class="#class#"><a href="JavaScript:newWindow('infoContact.cfm?CntctID=#Contact.ContactID#','740','300','20','25','Contact');" <cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>>#Contact.LastName#, #Contact.FirstName#</a></td>
	<td class="#class#"><cfif Contact.Department neq "">#Contact.Department#<cfelse>#APPLICATION.nullCaption#</cfif></td>
	<td class="#class#"><cfif Contact.ContactStatus neq "">#Contact.ContactStatus#<cfelse>#APPLICATION.nullCaption#</cfif></td>
	<td class="#class#">#DateFormat(Contact.DBRCreatedDT, "yyyy-mm-dd")#</td>
	<td class="#class#"><cfif Contact.LibrarianLastName neq ""><cfoutput>#Contact.LibrarianLastName#<br></cfoutput><cfelse>--</cfif></td>
	<td class="#class#"><cfif Contact.Unit neq "">#Contact.Unit#<cfelse>--</cfif></td>
	</tr>
	<cfset x = x + 1>
	</cfoutput--->
								<!---cfif UniqueRec gt 1>
								<input name="CntctID" type="radio" value="#byletter.ContactID#">
								<cfelse>
								<input name="CntctID" type="checkbox" value="#byletter.ContactID#" checked>
								</cfif--->

								<!---form action="addNewContact.cfm" method="post">
									<cfif ActID neq 0>
										<input name="ActID" type="hidden" value="#ActID#">
									<cfelseif SessID neq 0>
										<input name="SessID" type="hidden" value="#SessID#">
									<cfelseif MatID neq 0>
										<input name="MatID" type="hidden" value="#MatID#">
									<cfelseif LibID neq 0>
										<input name="LibID" type="hidden" value="#LibID#">
									</cfif>
									<input type="submit" value="Add a New Contact">
								</form--->

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
			<!---cfif UniqueRec gt 1>
				var CntctID = new validation('a contact name', 'CntctID', 'radio', 'isRadio(formObj)', null);
			<cfelse>
				var CntctID = new validation('a contact name', 'CntctID', 'checkbox', 'isCheck(formObj, form, 0, 1)', null);
			</cfif--->
