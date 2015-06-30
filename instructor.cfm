<cfset authRefer = APPLICATION.HostServer>
<cfif not Find(authRefer, HTTP_REFERER)>
	<cflocation url="index.cfm" addtoken="no">
	<cfabort>
</cfif>

<cfinclude template="uspGetInstructor.cfm">
<cfif Instructor.RecordCount eq 0>
	<cfset pageTitle = "<cfoutput>#Instructor.Instructor#</cfoutput>">
<cfelse>
	<cfset pageTitle = "Error!">
</cfif>
<cfinclude template="incBegin.cfm">
<cfoutput query="Instructor" group="InstructorID">
<span class="dataSectionTitle">Instructor Information</span>
<div class="data">
	<cfif Instructor.RecordCount eq 0>
		<p class="error">Error!</p>
	<cfelse>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td width="49%">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<td nowrap class="fieldLabel">Name:</td>
							<td class="fieldValue"><strong>#Instructor.Instructor#</strong></td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Status:</td>
							<td class="fieldValue">#Instructor.InstructorStatus#</td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Department:</td>
							<td class="fieldValue"><a href="department.cfm?DeptID=#Instructor.DepartmentID#">#Instructor.Department#</a></td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Campus address:</td>
							<td class="fieldValue">Box #Instructor.CampusMailcode#, #Instructor.CampusAddress#</td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Email:</td>
							<td class="fieldValue">#Instructor.Email# <img src="images/iconMail.gif" alt="Email #Instructor.FirstName# #Instructor.LastName#" width="31" height="23" hspace="2" align="absmiddle"></td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Telephone:</td>
							<td class="fieldValue">#Instructor.Telephone#</td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Fax:</td>
							<td class="fieldValue">
		<cfif Instructor.Fax neq "">
			#Instructor.Fax#
		<cfelse>
			#APPLICATION.nullCaption#
		</cfif>
							</td>
						</tr>
				</table>
			<td width="2%">&nbsp;</td>
			<td width="49%">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<td nowrap class="fieldLabel">Contacted by:</td>
							<td class="fieldValue"><a href="librarian.cfm?LibID=#Instructor.LibrarianID#">#Instructor.DBRCreator#</a></td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Input on:</td>
							<td class="fieldValue">#DateFormat(Instructor.DBRCreatedDT, APPLICATION.dateFormat)#, #TimeFormat(Instructor.DBRCreatedDT, APPLICATION.timeFormat)#</td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Last updated on:</td>
							<td class="fieldValue">#DateFormat(Instructor.DBRUpdatedDT, APPLICATION.dateFormat)#, #TimeFormat(Instructor.DBRUpdatedDT, APPLICATION.timeFormat)#</td>
						</tr>
						<tr valign="top">
							<td nowrap class="fieldLabel">Associated with:</td>
							<td class="fieldValue">
		<cfoutput>
			<a href="librarian.cfm?LibID=#Instructor.LibrarianID#">#Instructor.Librarian#</a> (#Instructor.Unit#)<br>
		</cfoutput>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>			
	<form action="updateInstructor.cfm" method="post">
	<input type="submit" class="subControl" value="Update Instructor Info">
	<input name="InstrID" type="hidden" value="#InstrID#">
	</form>
	</cfif>
</div>
</cfoutput>
<cfset LibID = 0>
<cfinclude template="uspGetSession.cfm">
<span class="dataSectionTitle">Instructional Activities/Sessions for <cfoutput>#Sess.Instructor#</cfoutput></span>
<div class="data">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<th><a href="mySIA.cfm?fld=at" class="columnHeading">Activity/Session Title</a></th>
		<th><a href="mySIA.cfm?fld=dt" class="columnHeading">Date</a></th>
		<th><a href="mySIA.cfm?fld=qu" class="columnHeading">Quarter</a></th>
		<th><a href="mySIA.cfm?fld=ti" class="columnHeading">Time</a></th>
		<th><a href="mySIA.cfm?fld=ti" class="columnHeading">Librarian(s)</a></th>
	</tr>
<cfif Sess.RecordCount neq 0>
	<cfoutput query="Sess" group="SessionID">
	<cfset class="#IIF(Sess.CurrentRow eq 1, DE('first'), DE('rest'))#">
		<tr valign="top">
			<td class="#class#"><a href="sessionLibrarian.cfm?SessID=#Sess.SessionID#">#Sess.Title#</a></td>
			<td align="center" class="#class#">#DateFormat(Sess.SessionDateTime, "mm/dd/yyyy")#</td>
			<td align="center" class="#class#">#Sess.Quarter#</td>
			<td align="center" class="#class#">#TimeFormat(Sess.SessionDateTime, "h:mmtt")#</td>
			<td align="left" class="#class#">
		<cfoutput>
			<a href="librarian.cfm?LibID=#Sess.LibrarianID#">#Librarian#</a><br>
		</cfoutput>			
			</td>
			
		</tr>
	</cfoutput>
<cfelse>
		<tr>
			<td colspan="4" class="first">No instructional sessions for this instructor</td>
		</tr>
</cfif>
</table>
<cfoutput>
	<form action="addContact.cfm" method="post">
	<input type="submit" class="subControl" value="Add Session">
	<input name="InstrID" type="hidden" value="#InstrID#">
	</form>
</cfoutput>
</div>
<cfinclude template="incEnd.cfm">