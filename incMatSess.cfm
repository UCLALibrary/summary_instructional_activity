<cfscript>
	sectionTitle = "Used in Instructional Sessions";
	sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?MatID=' & Material.MaterialID & '&';
</cfscript>
<cfif Sess.RecordCount eq 0>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional sessions</td>
			</tr>
		</table>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<cfoutput>
					<th nowrap>
						<a href="#sortURL#fld=at&ord=#ord#" class="columnHeading">Session Title</a>
					</th>
					<th nowrap>
						<a href="#sortURL#fld=ay&ord=#ord#" class="columnHeading">Type</a>
					</th>
				</cfoutput>
			</tr>
			<cfoutput query="Sess" group="ActivityID">
				<cfset class="#IIF(Activity.CurrentRow eq 1, DE('first'), DE('rest'))#">
				<cfscript>
					ActID = Sess.ActivityID;
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
							<a href="session.cfm?SessID=#Sess.SessionID#&ActID=#Sess.ActivityID#">#Sess.Title#</a>
						<cfelse>
							#Sess.Title#
						</cfif>
					</td>
					<td class="#class#">
						#Sess.ActivityType#
					</td>
				</tr>
			</cfoutput>
		</table>
	</div>
</cfif>