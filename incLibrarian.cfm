<cfif Librarian.RecordCount eq 0>
	<cfif not Find("mySIA", SCRIPT_NAME)>
		<cfset pageTitle = "No librarian found">
		<cfinclude template="incBegin.cfm">
	</cfif>
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No librarian found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfif not Find("mySIA", SCRIPT_NAME)>
		<cfset pageTitle = Librarian.Librarian>
		<cfif Find("infoLibrarian.cfm", SCRIPT_NAME)>
			<cfinclude template="incBeginInfo.cfm">
		<cfelse>
			<cfinclude template="incBegin.cfm">
		</cfif>
	</cfif>
	<cfoutput query="Librarian">
		<span class="dataSectionTitle"><cfif Find("mySIA", SCRIPT_NAME)>My Profile<cfelse>#Librarian.Librarian#</cfif></span>
		<div class="data">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td class="fieldLabel">Name:</td>
								<td class="fieldValue">#Librarian.Librarian#</td>
							</tr>
							<tr valign="top">
								<td class="fieldLabel">Title:</td>
								<td class="fieldValue"><cfif Librarian.Title neq "">#Librarian.Title#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td class="fieldLabel">Unit:</td>
								<td class="fieldValue"><cfif Librarian.Unit neq ""><cfif not ListContains("infoLibrarian.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="unit.cfm?UID=#Librarian.UnitID#">#Librarian.Unit#</a><cfelse>#Librarian.Unit#</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td class="fieldLabel">Address:</td>
								<td class="fieldValue"><cfif Librarian.CampusMailcode neq "" and Librarian.CampusAddress neq "">Mail Code #Librarian.CampusMailcode#, #Librarian.CampusAddress#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
						</table>
					</td>
					<td width="2%">&nbsp;</td>
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td class="fieldLabel">Email:</td>
								<td class="fieldValue"><cfif Librarian.Email neq ""><cfif not ListContains("infoLibrarian.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="mailto:#Librarian.Email#">#Librarian.Email#</a><cfelse>#Librarian.Email#</cfif></cfif></td>
							</tr>
							<tr valign="top">
								<td class="fieldLabel">Telephone:</td>
								<td class="fieldValue"><cfif Librarian.Telephone neq "">#Librarian.Telephone#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td class="fieldLabel">Mobile:</td>
								<td class="fieldValue"><cfif Librarian.TelephoneMobile neq "">#Librarian.TelephoneMobile#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td class="fieldLabel">Fax:</td>
								<td class="fieldValue"><cfif Librarian.Fax neq "">#Librarian.Fax#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="bottom">
								<td class="fieldLabel">Member since:</td>
								<td class="fieldValue">#DateFormat(Librarian.UserSince, "#APPLICATION.dateFormat#")#</td>
							</tr>
							<tr valign="bottom">
								<td class="fieldLabel">Profile updated:</td>
								<td class="fieldValue">#DateFormat(Librarian.UpdatedDT, "#APPLICATION.dateFormat#")# #TimeFormat(Librarian.UpdatedDT, "#APPLICATION.timeFormat#")#</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<cfif "1,5" contains SESSION.UserLevelID and SESSION.LibID eq Librarian.LibrarianID>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<form action="updateLibrarian.cfm" method="post">
								<input type="submit" class="mainControl" value="Update Profile">
								<input name="LibID" type="hidden" value="#Librarian.LibrarianID#">
							</form>
						</td>
						<cfif ListContains("updatedLibrarian.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
							<td width="12">&nbsp;</td>
							<td>
								<form action="mySIA.cfm" method="post">
									<input type="submit" class="mainControl" value="Back to mySIA">
								</form>
							</td>
						</cfif>
					</tr>
				</table>
			</cfif>
		</div>
	</cfoutput>
</cfif>
