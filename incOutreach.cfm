<cfscript>
	sectionTitle = "";
	if (isDefined("Librarian.RecordCount")) {
		if (Find('mySIA', SCRIPT_NAME)) {
		sectionTitle = "My Outreach Activities";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
		}
		else {
		sectionTitle = Librarian.Librarian & "'s Outreach Activities";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?LibID=' & Librarian.LibrarianID & '&';
		}
	}
	else if (isDefined("Contact.RecordCount")) {
		sectionTitle = "Outreach Activities to " & Contact.Contact;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?CntctID=' & Contact.ContactID & '&';
	}
	else if (isDefined("Department.RecordCount")) {
		if (Find('department', SCRIPT_NAME)) {
		sectionTitle = "Outreach Activities";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?DeptID=' & Department.DeptID & '&';
		}
		else {
		sectionTitle = "Outreach Activities to " & Department.Department;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?DeptID=' & Department.DepartmentID & '&';
		}
	}
	else if (isDefined("ContactStatus.RecordCount")) {
		sectionTitle = ContactStatus.ContactStatus & " Outreach Activities";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?StatID=' & ContactStatus.ContactStatusID & '&';
	}
	else if (isDefined("Unit.RecordCount")) {
		if (Find('unit', SCRIPT_NAME)) {
		sectionTitle = "Outreach Activities";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?UID=' & Unit.UnitID & '&';
		}
		else {
		sectionTitle = Unit.Unit & "'s Outreach Activities";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?UID=' & Unit.UnitID & '&';
		}
	}
	else if (FiscalY neq 0) {
		sFiscal = FiscalY;
		eFiscal = FiscalY + 1;
		sectionTitle = "Outreach Activities Fiscal Year " & sFiscal & "/" & eFiscal;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?FiscalY=' & FiscalY & '&';
	}
	else if (sDT neq "" and eDT neq "") {
		sectionTitle = "Outreach Activities Between " & DateFormat(sDT, "mmmm d, yyyy") & " and " & DateFormat(eDT, "mmmm d, yyyy");
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?sDT=' & URLEncodedFormat(sDT) & 'eDT=' & URLEncodedFormat(eDT) & '&';
	}
	else {
		sectionTitle = "Outreach Activities";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
	}
</cfscript>
<cfif Outreach.RecordCount eq 0>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
		<td class="first">No outreach activities</td>
		</tr>
	</table>
	<cfif ( "1,5" contains SESSION.UserLevelID )>
		<cfoutput>
			<form action="addNewOutreach.cfm" method="post">
				<input name="CntctID" type="hidden" value="#Contact.ContactID#">
				<input type="submit" class="mainControl" value="Add Outreach">
			</form>
		</cfoutput>
	</cfif>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
	<cfoutput>
		<th nowrap><a href="#sortURL#fld=ot&ord=#ord#" class="columnHeading">Date</a></th>
		<cfif CntctID eq 0 and DeptID eq 0 and StatID eq 0>
			<th nowrap><a href="#sortURL#fld=on&ord=#ord#" class="columnHeading">Name</a></th>
			<th nowrap><a href="#sortURL#fld=od&ord=#ord#" class="columnHeading">Department</a></th>
			<th nowrap><a href="#sortURL#fld=os&ord=#ord#" class="columnHeading">Status</a></th>
		</cfif>
		<th nowrap><a href="#sortURL#fld=op&ord=#ord#" class="columnHeading">Purpose</a></th>
		<th nowrap><a href="#sortURL#fld=op&ord=#ord#" class="columnHeading">Outcome</a></th>
		<cfif not Find("mySIA", SCRIPT_NAME)>
			<cfif LibID eq 0><th nowrap><a href="#sortURL#fld=ol&ord=#ord#" class="columnHeading">Librarian</a></th></cfif>
			<cfif UID eq 0><th nowrap><a href="#sortURL#fld=ou&ord=#ord#" class="columnHeading">Unit</a></th></cfif>
		</cfif>
	</cfoutput>
		</tr>
	<cfoutput query="Outreach" group="OutreachID">
		<cfset class="#IIF(Outreach.CurrentRow eq 1, DE('first'), DE('rest'))#">
		<tr valign="top">
			<td nowrap class="#class#"><a href="outreachLog.cfm?OutID=#Outreach.OutreachID#">#DateFormat(Outreach.OutreachDT, "mm/dd/yy")#</a></td>
			<cfif CntctID eq 0 and DeptID eq 0 and StatID eq 0>
				<td class="#class#"><a href="outreach.cfm?CntctID=#Outreach.ContactID#">#Outreach.ContactLastName#, #Outreach.ContactFirstName#</a></td>
				<td class="#class#"><a href="outreach.cfm?DeptID=#Outreach.ContactDepartmentID#">#Outreach.ContactDepartment#</a></td>
				<td class="#class#"><a href="outreach.cfm?StatID=#Outreach.ContactStatusID#">#Outreach.ContactStatus#</a></td>
			</cfif>
			<td class="#class#" wrap>
				<cfif Find(" ", Outreach.Purpose) gt 4>
					<cfset x = 1>
					<cfloop index="Word" list="#Outreach.Purpose#" delimiters=" ">
						<cfif x lte 4>
							<cfif x gt 1>
							</cfif>
							#Word#
						<cfelse>
							...
							<a href="outreachLog.cfm?OutID=#Outreach.OutreachID#">more</a>
							<cfbreak>
						</cfif>
						<cfset x = x + 1>
					</cfloop>
				<cfelse>
					#Outreach.Purpose#
				</cfif>
			</td>
			<td class="#class#">#Outreach.DisplayOutcome#</td>
			<cfif not Find("mySIA", SCRIPT_NAME)>
				<cfif LibID eq 0><td class="#class#"><a href="outreach.cfm?LibID=#Outreach.LibrarianID#">#Outreach.LibrarianLastName#</a></td></cfif>
				<cfif UID eq 0><td nowrap class="#class#"><a href="outreach.cfm?UID=#Outreach.UnitID#">#Outreach.Unit#</a></td></cfif>
			</cfif>
		</tr>
	</cfoutput>
	</table>
	<cfif ( "1,5" contains SESSION.UserLevelID ) and ListContains("contact.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
		<cfoutput>
		<form action="addNewOutreach.cfm" method="post">
		<input name="CntctID" type="hidden" value="#Contact.ContactID#">
		<input type="submit" class="mainControl" value="Add Outreach">
		</form>
		</cfoutput>
	</cfif>
</div>
</cfif>

