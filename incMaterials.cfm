<cfscript>
	sectionTitle = "";
	if (isDefined("Librarian.RecordCount")) {
		if (Find('mySIA', SCRIPT_NAME)) {
			sectionTitle = "My Instructional Materials";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
		}
		else {
			sectionTitle = "Instructional Materials Developed by " & Librarian.Librarian;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?LibID=' & Librarian.LibrarianID & '&';
		}
	}
	else if (isDefined("Unit.RecordCount")) {
		if (Find('unit', SCRIPT_NAME)) {
			sectionTitle = "Instructional Materials";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & 'UnitID=' & Unit.UnitID & '&';
		}
		else {
			sectionTitle = "Instructional Materials Developed by " & Unit.Unit;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & 'UnitID=' & Unit.UnitID & '&';
		}
	}
	else if (isDefined("MaterialType.RecordCount")) {
		sectionTitle = MaterialType.MaterialType & " Instructional Materials";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & 'MatTypID=' & MaterialType.MaterialTypeID & '&';
	}
	else if (isDefined("Activity.RecordCount") and not Find('contact', SCRIPT_NAME)) {
		if (Find('activity', SCRIPT_NAME)) {
			sectionTitle = "Instructional Materials";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
		}
		else {
			sectionTitle = "Instructional Materials" & ' Used for ' & Activity.Title;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?ActID=' & Activity.ActivityID & '&';
		}
	}
	else if (isDefined("Contact.RecordCount")) {
		sectionTitle = "Instructional Materials Developed for " & Contact.Contact;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?CntctID=' & Contact.ContactID & '&';
	}
	else if (FiscalY neq 0) {
		sFiscal = FiscalY;
		eFiscal = FiscalY + 1;
		sectionTitle = "Instructional Materials Developed Fiscal Year " & sFiscal & "/" & eFiscal;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?FiscalY=' & FiscalY & '&';
	}
	else if (sDT neq "" and eDT neq "") {
		sectionTitle = "Instructional Materials Developed Between " & DateFormat(sDT, "mmmm d, yyyy") & " and " & DateFormat(eDT, "mmmm d, yyyy");
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?sDT=' & URLEncodedFormat(sDT) & 'eDT=' & URLEncodedFormat(eDT) & '&';
	}
	else if (Yr neq 0 and QuartID neq 0) {
		sectionTitle = "Instructional Materials Developed " & Quarter.Quarter & " Quarter, " & Yr;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?QuartID=' & QuartID & '&Yr=' & Yr & '&';
	}
	else {
		sectionTitle = "Instructional Materials";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
	}
</cfscript>
<cfif Material.RecordCount eq 0>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<cfif SESSION.UserLevelID eq 2>
				<td class="first">Use the Materials tab, rather than the My SIA tab in level 2 accounts, to view materials for all people in the unit.</td>
			<cfelse>
				<td class="first">No materials</td>
			</cfif>
		</tr>
	</table>
	<cfif ( "1,5" contains SESSION.UserLevelID )><!-- and ListContains("materials.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")-->
		<form action="addNewMaterial.cfm" method="post">
		<input type="submit" class="mainControl" value="Add New Material">
		</form>
	</cfif>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
	<cfoutput>
		<th nowrap><a href="#sortURL#fld=mt&ord=#ord#" class="columnHeading">Title</a></th>
		<cfif MatTypID eq 0><th nowrap><a href="#sortURL#fld=my&ord=#ord#" class="columnHeading">Type</a></th></cfif>
		<cfif not Find("mySIA", SCRIPT_NAME)>
			<th nowrap><a href="#sortURL#fld=ml&ord=#ord#" class="columnHeading">Developed by</a></th>
			<cfif UID eq 0 and LibID eq 0><th nowrap><a href="#sortURL#fld=mu&ord=#ord#" class="columnHeading">Unit</a></th></cfif>
		</cfif>
		<cfif Yr eq 0 and QuartID eq 0><th nowrap><a href="#sortURL#fld=mq&ord=#ord#" class="columnHeading">Quarter</a></th></cfif>
		<th nowrap><a href="#sortURL#fld=mc&ord=#ord#" class="columnHeading">Completed</a></th>
	</cfoutput>
		</tr>
	<cfoutput query="Material" group="MaterialID">
		<cfset class="#IIF(Material.CurrentRow eq 1, DE('first'), DE('rest'))#">
		<tr valign="top">
		<td class="#class#"><a href="material.cfm?MatID=#Material.MaterialID#">#Material.MaterialTitle#</a></td>
		<cfif MatTypID eq 0><td class="#class#"><a href="materials.cfm?MatTypID=#Material.MaterialTypeID#">#Material.MaterialType#</a></td></cfif>
		<cfif not Find("mySIA", SCRIPT_NAME)>
			<td class="#class#"><cfoutput group="LibrarianID"><a href="librarian.cfm?LibID=#Material.LibrarianID#">#Material.LibrarianLastName#</a><br></cfoutput></td>
			<cfif UID eq 0 and LibID eq 0><td class="#class#"><a href="materials.cfm?UID=#Material.UnitID#">#Material.Unit#</a></td></cfif>
		</cfif>
		<cfif Yr eq 0 and QuartID eq 0><td nowrap class="#class#"><cfif Material.CompletionDT neq "" and Material.Quarter neq ""><a href="materials.cfm?Yr=#DatePart("yyyy", Material.CompletionDT)#&QuartID=#Material.QuarterID#">'#Right(DatePart("yyyy", Material.CompletionDT), 2)# #Material.Quarter#</a><cfelse>#APPLICATION.nullCaption#</cfif></td></cfif>
		<td nowrap class="#class#"><cfif Material.CompletionDT neq "" and Material.Quarter neq "">#DateFormat(Material.CompletionDT, "mm/dd/yy")#<cfelse>#APPLICATION.nullCaption#</cfif></td>
		</tr>
	</cfoutput>
	</table>
	<cfif ( "1,5" contains SESSION.UserLevelID )><!-- and ListContains("materials.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")-->
		<form action="addRemoveMaterial.cfm" method="post">
		<input type="submit" class="mainControl" value="Add New Material">
		</form>
	</cfif>
	</div>
</cfif>
