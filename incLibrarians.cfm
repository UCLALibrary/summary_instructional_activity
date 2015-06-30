<cfif not up2snuff>
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
		sectionTitle = "";
		if (isDefined("Unit.RecordCount")) {
			sectionTitle = "Librarians in " & Unit.Unit;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?UID=' & Unit.UnitID;
		}
		else if (isDefined("Department.RecordCount")) {
			sectionTitle = "Librarians Associated with " & Department.Department;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?DeptID=' & Department.DepartmentID & '&';
		}
		else if (isDefined("Contact.RecordCount")) {
			sectionTitle = "Librarians Associated with " & Contact.Contact;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?CntctID=' & Contact.ContactID & '&';
		}
		else if (isDefined("ContactStatus.RecordCount")) {
			sectionTitle = ContactStatus.ContactStatus & " Contacts";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?StatID=' & ContactStatus.ContactStatusID & '&';
		}
		else {
			sectionTitle = "Librarians";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
		}
	</cfscript>
	<cfif Librarian.RecordCount eq 0>
		<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
		<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No librarians</td>
			</tr>
		</table>
		</div>
	<cfelse>
		<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
		<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
		<cfoutput>
				<th nowrap><a href="#sortURL#fld=ln&ord=#ord#" class="columnHeading">Name</a></th>
				<th nowrap><a href="#sortURL#fld=lt&ord=#ord#" class="columnHeading">Title</a></th>
				<cfif UID eq 0><th nowrap><a href="#sortURL#fld=lu&ord=#ord#" class="columnHeading">Unit</a></th></cfif>
				<th nowrap><a href="#sortURL#fld=ls&ord=#ord#" class="columnHeading">Member since</a></th>
		</cfoutput>
			</tr>
		<cfoutput query="Librarian">
			<cfset class="#IIF(Librarian.CurrentRow eq 1, DE('first'), DE('rest'))#">
			<tr valign="top">
				<td nowrap class="#class#"><a href="librarian.cfm?LibID=#Librarian.LibrarianID#">#Librarian.LastName#, #Librarian.FirstName#</a></td>
				<td class="#class#">#Librarian.Title#</td>
				<cfif UID eq 0><td nowrap class="#class#"><a href="unit.cfm?UID=#Librarian.UnitID#">#Librarian.Unit#</a></td></cfif>
				<td class="#class#">#DateFormat(Librarian.UserSince, APPLICATION.dateFormat)#</td>
			</tr>
		</cfoutput>
		</table>
		</div>
	</cfif>	
</cfif>