<cfscript>
	sectionTitle = "";
	if (isDefined("Librarian.RecordCount") and not Find("material", SCRIPT_NAME))
	{
		if (Find('mySIA', SCRIPT_NAME))
		{
			sectionTitle = "My Instructional Sessions";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
		}
		else
		{
			sectionTitle = "Instructional Sessions Developed by " & Librarian.Librarian;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?LibID=' & Librarian.LibrarianID & '&';
		}
	}
	else if (isDefined("ActivityType.RecordCount"))
	{
		sectionTitle = Activity.ActivityType & " Instructional Sessions";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?ActTypID=' & ActivityType.ActivityTypeID & '&';
	}
	else if (isDefined("Material.RecordCount") and Material.RecordCount neq 0)
	{
		sectionTitle = "Used in Instructional Sessions";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?MatID=' & Material.MaterialID & '&';
	}
	else if (isDefined("Contact.RecordCount"))
	{
		sectionTitle = "Instructional Sessions Developed for " & Contact.Contact;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?CntctID=' & Contact.ContactID & '&';
	}
	else if (isDefined("DeliveryMode.RecordCount"))
	{
		sectionTitle = DeliveryMode.DeliveryMode & " Instructional Sessions";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?DelModID=' & DeliveryMode.DeliveryMode & '&';
	}
	else if (isDefined("Unit.RecordCount"))
	{
		if (Find('unit', SCRIPT_NAME))
		{
			sectionTitle = "Instructional Sessions";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?UID=' & UID & '&';
		}
		else
		{
			sectionTitle = "Instructional Sessions Developed by " & Unit.Unit;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?UID=' & UID & '&';
		}
	}
	else if (FiscalY neq 0)
	{
		sFiscal = FiscalY;
		eFiscal = FiscalY + 1;
		sectionTitle = "Instructional Sessions Developed Fiscal Year " & sFiscal & "/" & eFiscal;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?FiscalY=' & FiscalY & '&';
	}
	else if (sDT neq "" and eDT neq "")
	{
		sectionTitle = "Instructional Sessions Developed Between " & DateFormat(sDT, "mmmm d, yyyy") & " and " & DateFormat(eDT, "mmmm d, yyyy");
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?sDT=' & URLEncodedFormat(sDT) & 'eDT=' & URLEncodedFormat(eDT) & '&';
	}
	else if (Yr neq 0 and QuartID neq 0)
	{
		sectionTitle = "Instructional Sessions Developed " & Quarter.Quarter & " Quarter, " & Yr;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?QuartID=' & QuartID & '&Yr=' & Yr & '&';
	}
	else
	{
		sectionTitle = "Instructional Sessions";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
	}
</cfscript>
<cfif Activity.RecordCount eq 0>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional sessions</td>
			</tr>
		</table>
		<cfif ( "1,5" contains SESSION.UserLevelID ) and ListContains("activities.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
			<form action="addNewActivity.cfm" method="post">
				<input type="submit" class="mainControl" value="Add New Activity">
			</form>
		</cfif>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<cfoutput>
					<th nowrap><a href="#sortURL#fld=at&ord=#ord#" class="columnHeading">Session Title</a></th>
					<cfif ActTypID eq 0><th nowrap><a href="#sortURL#fld=ay&ord=#ord#" class="columnHeading">Type</a></th></cfif>
					<cfif not Find("contact.cfm", SCRIPT_NAME)>
						<cfif DelModID eq 0 and MatID eq 0><th nowrap><a href="#sortURL#fld=am&ord=#ord#" class="columnHeading">Dev. Mode</a></th></cfif>
						<!---cfif MatID eq 0><th><a href="#sortURL#fld=ad&ord=#ord#" class="columnHeading">Dur.</a></th></cfif--->
					</cfif>
					<cfif not Find("mySIA", SCRIPT_NAME) and LibID eq 0><th nowrap><a href="#sortURL#fld=al&ord=#ord#" class="columnHeading">Dev. by</a></th></cfif>
					<cfif not Find("unit", SCRIPT_NAME) and LibID eq 0 and UID eq 0><th nowrap><a href="#sortURL#fld=au&ord=#ord#" class="columnHeading">Unit</a></th></cfif>
					<!---cfif MatID eq 0><th nowrap><a href="#sortURL#fld=ac&ord=#ord#" class="columnHeading">Completed</a></th></cfif--->
				</cfoutput>
			</tr>
			<cfoutput query="Activity" group="ActivityID">
				<cfset class="#IIF(Activity.CurrentRow eq 1, DE('first'), DE('rest'))#">
				<cfscript>
					ActID = Activity.ActivityID;
				</cfscript>
				<cfinclude template="uspGetActivityEditors.cfm">
				<cfif not up2snuff>
					<cfinclude template="incError.cfm">
				</cfif>
				<tr valign="top">
					<td class="#class#">
						<cfif ( ( ( SESSION.UserLevelID eq 1 ) and ( ListContains(EditorID, SESSION.LibID, ",") ) ) or
								  ( ( SESSION.UserLevelID eq 2 ) and ( Activity.UnitID eq SESSION.UID ) ) or
								  ( SESSION.UserLevelID gte 3 ) )>
							<a href="activity.cfm?ActID=#Activity.ActivityID#">#Activity.Title#</a>
						<cfelse>
							#Activity.Title#
						</cfif>
					</td>
					<cfif ActTypID eq 0>
						<td class="#class#">
							<a href="activities.cfm?ActTypID=#Activity.ActivityTypeID#">#Activity.ActivityType#</a>
							<!---cfif SESSION.UserLevelID gt 1>
								<a href="activities.cfm?ActTypID=#Activity.ActivityTypeID#">#Activity.ActivityType#</a>
							<cfelse>
								#Activity.ActivityType#
							</cfif--->
						</td>
					</cfif>
					<cfif not Find("contact.cfm", SCRIPT_NAME)>
						<cfif DelModID eq 0 and MatID eq 0><!--- and SESSION.UserLevelID gt 1--->
							<td class="#class#">
								<a href="activities.cfm?DelModID=#Activity.DeliveryModeID#">#Activity.DeliveryMode#</a>
							</td>
						<cfelse>
							<td class="#class#">
								#Activity.DeliveryMode#
							</td>
						</cfif>
						<!---cfif MatID eq 0><td nowrap class="#class#"><cfif Activity.Duration neq "">#Activity.Duration# min.<cfelse>#APPLICATION.nullCaption#</cfif></td></cfif--->
					</cfif>
					<cfif not Find("mySIA", SCRIPT_NAME) and LibID eq 0>
						<td class="#class#">
							<cfoutput group="LibrarianID">
								<a href="librarian.cfm?LibID=#Activity.LibrarianID#">#Activity.LibrarianLastName#</a>
								<br>
							</cfoutput>
						</td>
					</cfif>
					<cfif not Find("unit", SCRIPT_NAME) and LibID eq 0 and UID eq 0>
						<td nowrap class="#class#">
							<cfoutput group="LibrarianID">
								<a href="activities.cfm?UID=#Activity.UnitID#">#Activity.Unit#</a>
								<br>
							</cfoutput>
						</td>
					</cfif>
					<!---cfif MatID eq 0><td nowrap class="#class#"><cfif Activity.CompletionDT neq "">#DateFormat(Activity.CompletionDT, "yyyy-mm-dd")#<cfelse>#APPLICATION.nullCaption#</cfif></td></cfif--->
				</tr>
			</cfoutput>
		</table>
		<!---cfif SESSION.UserLevelID lt 3 and ListContains("activities.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")--->
		<cfif ( "1,5" contains SESSION.UserLevelID ) and ListContains("activities.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
			<form action="addNewActivity.cfm" method="post">
				<input type="submit" class="mainControl" value="Add New Activity">
			</form>
		</cfif>
	</div>
</cfif>
