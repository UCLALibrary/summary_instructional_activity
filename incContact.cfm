<cfif Contact.RecordCount eq 0>
	<cfset pageTitle = "No Contact Found">
	<cfif Find("infoContact.cfm", SCRIPT_NAME)>
		<cfinclude template="incBeginInfo.cfm">
	<cfelse>
		<cfinclude template="incBegin.cfm">
	</cfif>
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">No contact found</td>
		</tr>
	</table>
	</div>
<cfelse>
	<cfif not Find("deleteContact.cfm", SCRIPT_NAME)>
		<cfset pageTitle = Contact.Contact>
		<cfif Find("infoContact.cfm", SCRIPT_NAME)>
			<cfinclude template="incBeginInfo.cfm">
		<cfelse>
			<cfinclude template="incBegin.cfm">
		</cfif>
	</cfif>
	<span class="dataSectionTitle">Contact Information</span>
	<div class="data">
	<cfoutput query="Contact" group="ContactID">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td width="49%">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td nowrap class="fieldLabel">Name:</td>
						<td class="fieldValue"><strong>#Contact.Contact#</strong></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Affiliation:</td>
						<td class="fieldValue">#Contact.Affiliation#</td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Status:</td>
						<td class="fieldValue"><cfif Contact.ContactStatus neq ""><cfif not ListContains("infoContact.cfm,deleteContact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="contacts.cfm?StatID=#Contact.ContactStatusID#">#Contact.ContactStatus#</a><cfelse>#Contact.ContactStatus#</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Academic department:</td>
						<td class="fieldValue"><cfif Contact.Department neq ""><cfif not ListContains("infoContact.cfm,deleteContact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="department.cfm?DeptID=#Contact.DepartmentID#">#Contact.Department#</a><cfelse>#Contact.Department#</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Other department/group:</td>
						<td class="fieldValue"><cfif Contact.FacultyGroup neq "">#Contact.FacultyGroup#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Campus address:</td>
						<td class="fieldValue"><cfif Contact.CampusMailCode neq "">Box #Contact.CampusMailcode#,</cfif> <cfif Contact.CampusAddress neq "">#Contact.CampusAddress#</cfif><cfif Contact.CampusMailCode eq "" and Contact.CampusAddress eq "">#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Email:</td>
						<td class="fieldValue"><cfif not ListContains("infoContact.cfm,deleteContact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="mailto:#Contact.Email#">#Contact.Email#</a><cfelse>#Contact.Email#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Telephone:</td>
						<td class="fieldValue"><cfif Contact.Telephone neq "">#Contact.Telephone#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Mobile:</td>
						<td class="fieldValue"><cfif Contact.TelephoneMobile neq "">#Contact.TelephoneMobile#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Fax:</td>
						<td class="fieldValue"><cfif Contact.Fax neq "">#Contact.Fax#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
				</table>
			<td width="2%">&nbsp;</td>
			<td width="49%">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td nowrap class="fieldLabel">Member since:</td>
						<td class="fieldValue">#DateFormat(Contact.DBRCreatedDT, APPLICATION.dateFormat)#</td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Input on:</td>
						<td class="fieldValue">#DateFormat(Contact.DBRCreatedDT, APPLICATION.dateFormat)# #TimeFormat(Contact.DBRCreatedDT, APPLICATION.timeFormat)# by <cfif not ListContains("infoContact.cfm,deleteContact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="librarian.cfm?LibID=#Contact.DBRCreatorID#">#Contact.DBRCreator#</a><cfelse>#Contact.DBRCreator#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Last updated:</td>
						<td class="fieldValue">#DateFormat(Contact.DBRUpdatedDT, APPLICATION.dateFormat)# #TimeFormat(Contact.DBRUpdatedDT, APPLICATION.timeFormat)# by <cfif not ListContains("infoContact.cfm,deleteContact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="librarian.cfm?LibID=#Contact.DBRUpdaterID#">#Contact.DBRUpdater#</a><cfelse>#Contact.DBRUpdater#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Associated with:</td>
						<td class="fieldValue"><cfoutput><cfif Contact.LibrarianLastName neq ""><cfif not ListContains("infoContact.cfm,deleteContact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="librarian.cfm?libid=#Contact.LibrarianID#">#Contact.LibrarianLastName#</a> (<a href="contacts.cfm?UID=#Contact.UnitID#">#Contact.Unit#</a>)<cfelse>#Contact.LibrarianLastName# (#Contact.Unit#)</cfif><br><cfelse>Unassociated</cfif></cfoutput></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<cfif ( "1,5" contains SESSION.UserLevelID ) and not ListContains("infoContact.cfm,deleteContact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<form action="updateContact.cfm" method="post">
					<input type="submit" class="mainControl" value="Update Contact">
					<input name="cntctID" type="hidden" value="#Contact.ContactID#">
					</form>
				</td>
				<td width="12">&nbsp;</td>
				<td>
					<form action="deleteContact.cfm" method="post">
					<input name="CntctID" type="hidden" value="#Contact.ContactID#">
					<input type="submit" class="mainControl" value="Delete Contact"
						<cfif (SESSION.LibID neq Contact.DBRCreatorID) or (Relationships.Total gt 0)>
							disabled="true"
						</cfif>
					>
					</form>
				</td>
			</tr>
		</table>
	</cfif>
	</cfoutput>
</cfif>
</div>