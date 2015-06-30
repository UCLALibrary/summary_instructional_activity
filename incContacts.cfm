<cfscript>
	sectionTitle = "";
	if (isDefined("Librarian.RecordCount") and not Find('unit', SCRIPT_NAME))
	{
		if (Find('mySIA', SCRIPT_NAME))
		{
			sectionTitle = "My Contacts";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
		}
		else
		{
			sectionTitle = "Contacts Associated with " & Librarian.Librarian;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?LibID=' & Librarian.LibrarianID & '&';
		}
	}
	else if (isDefined("Unit.RecordCount"))
	{
		if (Find('unit', SCRIPT_NAME))
		{
			sectionTitle = "Contacts Associated with " & Unit.Unit;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?UID=' & Unit.UnitID & '&';
		}
		else
		{
			sectionTitle = "Contacts Associated with " & Unit.Unit;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?UID=' & Unit.UnitID & '&';
		}
	}
	else if (isDefined("DepartmentSelected.RecordCount"))
	{
		sectionTitle = "Contacts Associated with " & DepartmentSelected.Department;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?DeptID=' & DepartmentSelected.DepartmentID & '&';
	}
	else if (isDefined("ContactStatus.RecordCount"))
	{
		sectionTitle = ContactStatus.ContactStatus & " Contacts";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?StatID=' & ContactStatus.ContactStatusID & '&';
	}
	else if (FiscalY neq 0)
	{
		sFiscal = FiscalY;
		eFiscal = FiscalY + 1;
		sectionTitle = "Contacts Establised Fiscal Year " & sFiscal & "/" & eFiscal;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?FiscalY=' & FiscalY & '&';
	}
	else if (sDT neq "" and eDT neq "")
	{
		sectionTitle = "Contacts Established Between " & DateFormat(sDT, "mmmm d, yyyy") & " and " & DateFormat(eDT, "mmmm d, yyyy");
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?sDT=' & URLEncodedFormat(sDT) & 'eDT=' & URLEncodedFormat(eDT) & '&';
	}
	else
	{
		sectionTitle = "Contacts";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
	}
</cfscript>
<cfif Contact.RecordCount eq 0>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top"><td class="first">No contacts</td></tr>
		</table>
		<cfif ( "1,5" contains SESSION.UserLevelID ) and ListContains("contacts.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
			<form action="addRemoveContact.cfm" method="post">
				<input name="LibID" type="hidden" value="<cfoutput>#SESSION.LibID#</cfoutput>">
				<input name="Add" type="submit" class="mainControl" value="Add Contact">
			</form>
		</cfif>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<cfoutput>
			<p style="font-size: small;">
				To enter an Outreach, select a Contact and hit the Add Outreach button.
			</p>
			<cfif ( "1,5" contains SESSION.UserLevelID ) and ListContains("contacts.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
				<form action="addRemoveContact.cfm" method="post">
					<input name="LibID" type="hidden" value="#SESSION.LibID#">
					<cfif Contact.RecordCount gt 0>
						<input name="addRem" type="submit" class="mainControl" value="Add/Remove">
					<cfelse>
						<input name="Add" type="submit" class="mainControl" value="Add Contact">
					</cfif>
				</form>
			</cfif>
		</cfoutput>
		<!---Contact list = <cfif IsDefined("cntctList")><cfoutput>#cntctList#</cfoutput></cfif--->
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<cfoutput>
					<th nowrap>
						<a href="#sortURL#fld=cn&ord=#ord#" class="columnHeading">Name</a>
					</th>
					<cfif DeptID eq 0>
						<th nowrap>
							<a href="#sortURL#fld=cd&ord=#ord#" class="columnHeading">Academic department</a>
						</th>
					</cfif>
					<th nowrap>
						<a href="#sortURL#fld=cd&ord=#ord#" class="columnHeading">Other department/group</a>
					</th>
					<cfif StatID eq 0>
						<th nowrap>
							<a href="#sortURL#fld=cs&ord=#ord#" class="columnHeading">Status</a>
						</th>
					</cfif>
					<th nowrap>
						<a href="#sortURL#fld=cc&ord=#ord#" class="columnHeading">Member since</a>
					</th>
					<cfif not Find("mySIA", SCRIPT_NAME)>
						<cfif LibID eq 0 and UID eq 0>
							<th nowrap>
								<a href="#sortURL#fld=cl&ord=#ord#" class="columnHeading">Associated with</a>
							</th>
							<th nowrap>
								<a href="#sortURL#fld=cu&ord=#ord#" class="columnHeading">Unit</a>
							</th>
						<cfelseif LibID neq 0>
								<th nowrap>
									<a href="#sortURL#fld=da&ord=#ord#" class="columnHeading">Added to mySIA</a>
								</th>
						</cfif>
					</cfif>
				</cfoutput>
			</tr>
			<cfoutput query="Contact" group="ContactID">
				<cfset class="#IIF(Contact.CurrentRow eq 1, DE('first'), DE('rest'))#">
				<tr valign="top">
					<td class="#class#">
						<cfif IsDefined("URL.cntctList") and ( ListFind(URL.cntctList, Contact.ContactID, ",") )>
							<em class="required">*</em>
						</cfif>
						<cfif IsDefined("URL.newCntct") and ( URL.newCntct eq Contact.ContactID )>
							<em class="required">*</em>
						</cfif>
						<a href="contact.cfm?CntctID=#Contact.ContactID#">#Contact.LastName#, #Contact.FirstName#</a>
					</td>
					<cfif DeptID eq 0>
						<td class="#class#">
							<cfif Contact.Department neq "">
								<a href="contacts.cfm?DeptID=#Contact.DepartmentID#">#Contact.Department#</a>
							<cfelse>
								#APPLICATION.nullCaption#
							</cfif>
						</td>
					</cfif>
					<td class="#class#">
						<cfif Contact.FacultyGroup neq "">
							#Contact.FacultyGroup#
						<cfelse>
							#APPLICATION.nullCaption#
						</cfif>
					</td>
					<cfif StatID eq 0>
						<td class="#class#">
							<cfif Contact.ContactStatus neq "">
								<a href="contacts.cfm?StatID=#Contact.ContactStatusID#">#Contact.ContactStatus#</a>
							<cfelse>
								#APPLICATION.nullCaption#
							</cfif>
						</td>
					</cfif>
					<td class="#class#">#DateFormat(Contact.DBRCreatedDT, "mm/dd/yy")#</td>
					<cfif not Find("mySIA", SCRIPT_NAME)>
						<cfif LibID eq 0 and UID eq 0>
							<td class="#class#">
								<cfoutput>
									<a href="librarian.cfm?LibID=#Contact.LibrarianID#">#Contact.LibrarianLastName#</a>
									<br>
								</cfoutput>
							</td>
							<td class="#class#">
								<cfif Contact.UnitID neq "">
									<a href="contacts.cfm?UID=#Contact.UnitID#">#Contact.Unit#</a>
								<cfelse>
									Nobody
								</cfif>
							</td>
						<cfelseif LibID neq 0>
							<td class="#class#">
								#DateFormat(Contact.AssociatedDT, APPLICATION.dateFormat)# #TimeFormat(Contact.AssociatedDT, APPLICATION.timeFormat)#
							</td>
						</cfif>
					</cfif>
				</tr>
			</cfoutput>
		</table>
		<cfoutput>
			<cfif ( "1,5" contains SESSION.UserLevelID ) and ListContains("contacts.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
				<form action="addRemoveContact.cfm" method="post">
					<input name="LibID" type="hidden" value="#SESSION.LibID#">
					<cfif Contact.RecordCount gt 0>
						<input name="addRem" type="submit" class="mainControl" value="Add/Remove">
					<cfelse>
						<input name="Add" type="submit" class="mainControl" value="Add Contact">
					</cfif>
				</form>
			</cfif>
			<!---p style="font-size: small;">
				To enter an Outreach, select a Contact and hit the Add Outreach button.
			</p--->
		</cfoutput>
	</div>
</cfif>