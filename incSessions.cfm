<cfscript>
	sectionTitle = "";
	if (isDefined("Librarian.RecordCount"))
	{
		if (Find('mySIA', SCRIPT_NAME))
		{
			sectionTitle = "My Instructional Sessions";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?";
		}
		else if (Find('activity', SCRIPT_NAME))
		{
			sectionTitle = "Sessions";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?ActID=" & Activity.ActivityID & "&";
		}
		else
		{
			sectionTitle = "Instructional Sessions Provided by " & Librarian.Librarian;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?LibID=" & Librarian.LibrarianID & "&";
		}
	}
	else if (sDT neq "" and eDT eq "")
	{
		sectionTitle = "Instructional Sessions on " & DateFormat(sDT, "mmmm d, yyyy");
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?sDT=" & URLEncodedFormat(sDT) & "&";
	}
	else if (sDT neq "" and eDT neq "")
	{
		sectionTitle = "Instructional Sessions Provided Between " & DateFormat(sDT, "mmmm d, yyyy") & " and " & DateFormat(eDT, "mmmm d, yyyy");
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?sDT=" & URLEncodedFormat(sDT) & "eDT=" & URLEncodedFormat(eDT) & "&";
	}
	else if (isDefined("Contact.RecordCount") and Find('contact', SCRIPT_NAME))
	{
		sectionTitle = "Instructional Sessions Provided for " & Contact.Contact;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?CntctID=" & Contact.ContactID & "&";
	}
	else if (isDefined("DepartmentSelected.RecordCount"))
	{
		if (Find('department', SCRIPT_NAME))
		{
			sectionTitle = "Instructional Sessions Provided to " & DepartmentSelected.Department;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "DeptID=" & DepartmentSelected.DepartmentID & "&";
		}
		else
		{
			sectionTitle = "Instructional Sessions Provided to " & Department.Department;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "DeptID=" & Department.DepartmentID & "&";
		}
	}
	else if (isDefined("Unit.RecordCount"))
	{
		if (Find('unit', SCRIPT_NAME))
		{
			sectionTitle = "Instructional Sessions";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "&";
		}
		else
		{
			sectionTitle = "Instructional Sessions Provided by " & Unit.Unit;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?UID=" & Unit.UnitID & "&";
		}
	}
	else if (FiscalY neq 0)
	{
		sFiscal = FiscalY;
		eFiscal = FiscalY + 1;
		sectionTitle = "Instructional Sessions Provided Fiscal Year " & sFiscal & "/" & eFiscal;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?FiscalY=' & FiscalY & '&';
	}
	else if (Hr neq 0)
	{
		sectionTitle = "Instructional Sessions Provided During the " & TimeFormat(CreateTime(Hr, 00, 00), "h:mm tt") & " Hour";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?Hr=" & Hr & "&";
	}
	else if (ActID neq 0)
	{
		if (Find('unit', SCRIPT_NAME))
		{
			sectionTitle = "Instructional Sessions Provided by: " & Unit.Unit;
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "&";
		}
		else
		{
			sectionTitle = "Sessions";
			sortURL = APPLICATION.HostServer & SCRIPT_NAME & "?ActID=" & ActID & "&";
		}
	}
	else if (isDefined("LearnerCategory.RecordCount"))
	{
		sectionTitle = LearnerCategory.LearnerCategory & " Instructional Sessions";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?LrCatID=' & LearnerCategory.LearnerCategoryID & '&';
	}
	else if (isDefined("Affiliation.RecordCount"))
	{
		sectionTitle = Affiliation.Affiliation & " Instructional Sessions";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?AffID=' & Affiliation.AffiliationID & '&';
	}
	else if (Yr neq 0 and QuartID neq 0)
	{
		sectionTitle = "Instructional Sessions Provided " & Quarter.Quarter & " Quarter, " & Yr;
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?QuartID=' & QuartID & '&Yr=' & Yr & '&';
	}
	else if (OutID neq 0)
	{
		sectionTitle = "Instructional Sessions Resulting from Outreach Activity";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?OutID=' & Outreach.OutreachID & '&';
	}
	else if (isDefined("Classroom.RecordCount"))
	{
		sectionTitle = "Instructional Sessions Scheduled in this Classroom";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?ClassID=' & Classroom.ClassroomID & '&';
	}
	else
	{
		sectionTitle = "Instructional Sessions";
		sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
	}
</cfscript>
<cfif Sess.RecordCount eq 0>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<cfif SESSION.UserLevelID eq 2>
					<td class="first">Use the Sessions tab, rather than the My SIA tab in level 2 accounts, to view sessions for all people in the unit.</td>
				<cfelse>
					<td class="first">No sessions</td>
				</cfif>
			</tr>
		</table>
		<cfoutput>
			<cfif "1,5" contains SESSION.UserLevelID
			      and not ListContains("contact.cfm,department.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")> <!---mySIA.cfm,--->
				<form action="addSession.cfm" method="post">
					<input name="caller" type="hidden" value="start">
					<input name="Submit" type="submit" class="mainControl" value="Add Session">
					<!---cfif isDefined("ActID") and ActID neq 0>
						<input name="caller" type="hidden" value="incSessions1">
						<input name="ActID" type="hidden" value="#ActID#">
						<input name="Submit" type="submit" class="mainControl" value="Add Session">
					<cfelse>
						<input name="caller" type="hidden" value="incSessions2">
						<input name="Submit" type="submit" class="mainControl" value="Add Session">
					</cfif>
					<cfif isDefined("URL.sDT")>
						<input name="sDT" type="hidden" value="#URL.sDT#">
					</cfif--->
				</form>
			</cfif>
		</cfoutput>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<cfoutput>
			<cfif "1,5" contains SESSION.UserLevelID
			      and not ListContains("contact.cfm,department.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><!---mySIA.cfm,--->
				<form action="addSession.cfm" method="post">
					<input name="caller" type="hidden" value="start">
					<input name="Submit" type="submit" class="mainControl" value="Add Session">
					<!---cfif isDefined("ActID") and ActID neq 0>
						<input name="caller" type="hidden" value="incSessions1">
						<input name="ActID" type="hidden" value="#ActID#">
						<input name="Submit" type="submit" class="mainControl" value="Add Session">
					<cfelse>
						<input name="caller" type="hidden" value="incSessions2">
						<input name="Submit" type="submit" class="mainControl" value="Add Session">
					</cfif>
					<cfif isDefined("URL.sDT")>
						<input name="sDT" type="hidden" value="#URL.sDT#">
					</cfif--->
				</form>
			</cfif>
		</cfoutput>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<cfoutput>
					<cfif ActID eq 0>
						<th nowrap><a href="#sortURL#fld=st&ord=#ord#" class="columnHeading">Course Number & title (or Group)</a></th>
					<cfelse>
						<th nowrap><a href="#sortURL#fld=sd&ord=#ord#" class="columnHeading">Course Date/Time</a></th>
					</cfif>
					<cfif Find('mySIA', SCRIPT_NAME)>
						<th nowrap><a href="#sortURL#fld=fa&ord=#ord#" class="columnHeading">Contact</a></th>
						<!---th nowrap><a href="#sortURL#fld=sv&ord=#ord#" class="columnHeading">Type</a></th--->
						<th nowrap><a href="#sortURL#fld=sd&ord=#ord#" class="columnHeading">Date</a></th>
						<th nowrap><a href="#sortURL#fld=sq&ord=#ord#" class="columnHeading">Quarter</a></th>
						<th nowrap><a href="#sortURL#fld=scp&ord=#ord#" class="columnHeading">Co-Presenter</a></th>
						<th nowrap><a href="#sortURL#fld=sa&ord=#ord#" class="columnHeading">Number Of Students</a></th>
					<cfelse>
						<cfif QuartID eq 0>
							<th nowrap><a href="#sortURL#fld=sq&ord=#ord#" class="columnHeading">Quarter</a></th>
						</cfif>
						<cfif sDT eq "" and ActID eq 0>
							<th nowrap><a href="#sortURL#fld=sd&ord=#ord#" class="columnHeading">Date</a></th>
						</cfif>
						<cfif Hr eq 0 and ActID eq 0>
							<th nowrap><a href="#sortURL#fld=sh&ord=#ord#" class="columnHeading">Time</a></th>
						</cfif>
					</cfif>
					<cfif not Find("mySIA", SCRIPT_NAME)>
						<cfif not ListContains("contact.cfm,classroom.cfm,infoClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and DeptID eq 0>
							<th nowrap><a href="#sortURL#fld=sp&ord=#ord#" class="columnHeading">Department</a></th>
						</cfif>
						<cfif ListContains("activity.cfm,session.cfm,classroom.cfm,infoClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") or LibID eq 0>
							<th nowrap><a href="#sortURL#fld=sl&ord=#ord#" class="columnHeading">Librarian(s)</a></th>
							<th nowrap><a href="#sortURL#fld=su&ord=#ord#" class="columnHeading">Unit</a></th>
						</cfif>
					</cfif>
				</cfoutput>
			</tr>
			<cfoutput query="Sess" group="SessionID">
				<cfset class="#IIF(Sess.CurrentRow eq 1, DE('first'), DE('rest'))#">
				<cfscript>
					SessID = Sess.SessionID;
				</cfscript>
				<cfinclude template="uspGetEditors.cfm">
				<cfif not up2snuff>
					<cfinclude template="incError.cfm">
				</cfif>
				<tr valign="top">
					<cfif ActID eq 0>
						<td class="#class#"><!-- nowrap -->
							<!---cfif not Find("infoClassroom.cfm", SCRIPT_NAME) and
							     ( SESSION.UserLevelID lt 3 ) and
							     ( ListContains(EditorID, SESSION.LibID, ",") )--->
							<cfif not Find("infoClassroom.cfm", SCRIPT_NAME) and
								( ( ( SESSION.UserLevelID eq 1 ) and ( ListContains(EditorID, SESSION.LibID, ",") ) ) or
								  ( ( SESSION.UserLevelID eq 2 ) and ( Sess.UnitID eq SESSION.UID ) ) or
								  ( SESSION.UserLevelID gte 3 ) )>
								<a href="session.cfm?SessID=#Sess.SessionID#&ActID=#Sess.ActivityID#">#Sess.Title#</a>
							<cfelse>
								#Sess.Title#
							</cfif>
						</td>
					<cfelse>
						<td nowrap class="#class#">
							<!---cfif ( SESSION.UserLevelID lt 3 ) and ( ListContains(EditorID, SESSION.LibID, ",") )--->
							<cfif ( ( ( SESSION.UserLevelID eq 1 ) and ( ListContains(EditorID, SESSION.LibID, ",") ) ) or
								  ( ( SESSION.UserLevelID eq 2 ) and ( Sess.UnitID eq SESSION.UID ) ) or
								  ( SESSION.UserLevelID gte 3 ) )>
								<a href="session.cfm?SessID=#Sess.SessionID#&ActID=#Sess.ActivityID#">#DateFormat(Sess.SessionDateTime, APPLICATION.dateFormat)#</a>
								<a href="session.cfm?SessID=#Sess.SessionID#&ActID=#Sess.ActivityID#">#TimeFormat(Sess.SessionDateTime, "h:mm tt")#</a>
							<cfelse>
								#DateFormat(Sess.SessionDateTime, APPLICATION.dateFormat)#
								#TimeFormat(Sess.SessionDateTime, "h:mm tt")#
							</cfif>
						</td>
					</cfif>
					<cfif Find('mySIA', SCRIPT_NAME)>
						<td class="#class#">
							<!---cfif ( SESSION.UserLevelID lt 3 ) and ( ListContains(EditorID, SESSION.LibID, ",") )--->
							<cfif ( ( ( SESSION.UserLevelID eq 1 ) and ( ListContains(EditorID, SESSION.LibID, ",") ) ) or
								  ( ( SESSION.UserLevelID eq 2 ) and ( Sess.UnitID eq SESSION.UID ) ) or
								  ( SESSION.UserLevelID gte 3 ) )>
								<a href="session.cfm?SessID=#Sess.SessionID#&ActID=#Sess.ActivityID#">
									<cfif Len("#Sess.Faculty#") gt 1>#Sess.Faculty#<cfelse>#APPLICATION.nullCaption#</cfif>
								</a>
							<cfelse>
								<cfif Len("#Sess.Faculty#") gt 1>#Sess.Faculty#<cfelse>#APPLICATION.nullCaption#</cfif>
							</cfif>
							<!---cfif ( SESSION.UserLevelID lt 3 ) and ( ListContains(EditorID, SESSION.LibID, ",") )>
								<a href="session.cfm?SessID=#Sess.SessionID#">#Sess.ActivityType#</a>
							<cfelse>
								#Sess.ActivityType#
							</cfif--->
							<!---cfif not Find("infoClassroom.cfm", SCRIPT_NAME)>
							<cfelse>
							</cfif--->
						</td>
						<td nowrap class="#class#">
							<cfif not Find("infoClassroom.cfm", SCRIPT_NAME)><!--- and SESSION.UserLevelID gt 1--->
								<a href="sessions.cfm?sDT=#URLEncodedFormat(DateFormat(Sess.SessionDateTime, "mm/dd/yy"))#">#DateFormat(Sess.SessionDateTime, "mm/dd/yy")#</a>
							<cfelse>
								#DateFormat(Sess.SessionDateTime, "mm/dd/yy")#
							</cfif>
						</td>
						<td nowrap class="#class#">
							<cfif not Find("infoClassroom.cfm", SCRIPT_NAME)><!--- and SESSION.UserLevelID gt 1--->
								<a href="sessions.cfm?Yr=#DatePart("yyyy", Sess.SessionDateTime)#&QuartID=#Sess.QuarterID#">'#Right(DatePart("yyyy", Sess.SessionDateTime), 2)# #Sess.Quarter#</a>
							<cfelse>
								'#Right(DatePart("yyyy", Sess.SessionDateTime), 2)# #Sess.Quarter#
							</cfif>
						</td>
						<td nowrap class="#class#">
							<!---cfif ( SESSION.UserLevelID lt 3 ) and ( ListContains(EditorID, SESSION.LibID, ",") )--->
							<cfif ( ( ( SESSION.UserLevelID eq 1 ) and ( ListContains(EditorID, SESSION.LibID, ",") ) ) or
								  ( ( SESSION.UserLevelID eq 2 ) and ( Sess.UnitID eq SESSION.UID ) ) or
								  ( SESSION.UserLevelID gte 3 ) )>
								<a href="session.cfm?SessID=#Sess.SessionID#&ActID=#Sess.ActivityID#"><cfif Len("#Sess.CoLibs#") gt 1>#Sess.CoLibs#<cfelse>#APPLICATION.nullCaption#</cfif></a>
							<cfelse>
								<cfif Len("#Sess.CoLibs#") gt 1>#Sess.CoLibs#<cfelse>#APPLICATION.nullCaption#</cfif>
							</cfif>
							<!---cfif not Find("infoClassroom.cfm", SCRIPT_NAME)>
							<cfelse>
							</cfif--->
						</td>
						<td nowrap class="#class#">
							<!---cfif ( SESSION.UserLevelID lt 3 ) and ( ListContains(EditorID, SESSION.LibID, ",") )--->
							<cfif ( ( ( SESSION.UserLevelID eq 1 ) and ( ListContains(EditorID, SESSION.LibID, ",") ) ) or
								  ( ( SESSION.UserLevelID eq 2 ) and ( Sess.UnitID eq SESSION.UID ) ) or
								  ( SESSION.UserLevelID gte 3 ) )>
								<a href="session.cfm?SessID=#Sess.SessionID#&ActID=#Sess.ActivityID#">#Sess.Attendees#</a>
							<cfelse>
								#Sess.Attendees#
							</cfif>
							<!---cfif not Find("infoClassroom.cfm", SCRIPT_NAME)>
							<cfelse>
							</cfif--->
						</td>
					<cfelse>
						<cfif QuartID eq 0 and Yr eq 0>
							<td nowrap class="#class#">
								<cfif not Find("infoClassroom.cfm", SCRIPT_NAME)><!--- and SESSION.UserLevelID gt 1--->
									<a href="sessions.cfm?Yr=#DatePart("yyyy", Sess.SessionDateTime)#&QuartID=#Sess.QuarterID#">'#Right(DatePart("yyyy", Sess.SessionDateTime), 2)# #Sess.Quarter#</a>
								<cfelse>
									'#Right(DatePart("yyyy", Sess.SessionDateTime), 2)# #Sess.Quarter#
								</cfif>
							</td>
						</cfif>
						<cfif sDT eq "" and ActID eq 0>
							<td nowrap class="#class#">
								<cfif not Find("infoClassroom.cfm", SCRIPT_NAME)><!--- and SESSION.UserLevelID gt 1--->
									<a href="sessions.cfm?sDT=#URLEncodedFormat(DateFormat(Sess.SessionDateTime, "mm/dd/yy"))#">#DateFormat(Sess.SessionDateTime, "mm/dd/yy")#</a>
								<cfelse>
									#DateFormat(Sess.SessionDateTime, "mm/dd/yy")#
								</cfif>
							</td>
						</cfif>
						<cfif Hr eq 0 and ActID eq 0>
							<td nowrap class="#class#">
								<cfif not Find("infoClassroom.cfm", SCRIPT_NAME)><!--- and SESSION.UserLevelID gt 1--->
									<a href="sessions.cfm?Hr=#DatePart("h", Sess.SessionDateTime)#">#TimeFormat(Sess.SessionDateTime, "h:mm tt")#</a>
								<cfelse>
									#TimeFormat(Sess.SessionDateTime, "h:mm tt")#
								</cfif>
							</td>
						</cfif>
					</cfif>
					<cfif not Find("mySIA", SCRIPT_NAME)>
						<cfif not ListContains("contact.cfm,classroom.cfm,infoClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") and DeptID eq 0>
							<td class="#class#">
								<cfif Sess.SessionDepartment neq "">
									<a href="department.cfm?DeptID=#Sess.SessionDepartmentID#">#Sess.SessionDepartment#</a>
								<cfelse>
									#APPLICATION.nullCaption#
								</cfif>
							</td>
						</cfif>
						<cfif ListContains("activity.cfm,session.cfm,classroom.cfm,infoClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",") or LibID eq 0>
							<td class="#class#">
								<cfoutput>
									<cfif not Find("infoClassroom.cfm", SCRIPT_NAME)>
										<a href="librarian.cfm?LibID=#Sess.LibrarianID#">#Sess.LastName#</a>
									<cfelse>
										#Sess.LastName#
									</cfif>
									<br>
								</cfoutput>
							</td>
							<td nowrap class="#class#">
								<cfoutput>
									<cfif not Find("infoClassroom.cfm", SCRIPT_NAME)><!--- and SESSION.UserLevelID gt 1--->
										<a href="sessions.cfm?UID=#Sess.UnitID#">#Sess.Unit#</a>
									<cfelse>
										#Sess.Unit#
									</cfif>
									<br>
								</cfoutput>
							</td>
						</cfif>
					</cfif>
				</tr>
			</cfoutput>
		</table>
		<cfoutput>
			<cfif "1,5" contains SESSION.UserLevelID
			      and not ListContains("mySIA.cfm,contact.cfm,department.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
				<form action="addSession.cfm" method="post">
					<input name="caller" type="hidden" value="start">
					<input name="Submit" type="submit" class="mainControl" value="Add Session">
					<!---cfif isDefined("ActID") and ActID neq 0>
						<input name="caller" type="hidden" value="incSessions1">
						<input name="ActID" type="hidden" value="#ActID#">
						<input name="Submit" type="submit" class="mainControl" value="Add Session">
					<cfelse>
						<input name="caller" type="hidden" value="incSessions2">
						<input name="Submit" type="submit" class="mainControl" value="Add Session">
					</cfif>
					<cfif isDefined("URL.sDT")>
						<input name="sDT" type="hidden" value="#URL.sDT#">
					</cfif--->
				</form>
			</cfif>
		</cfoutput>
	</div>
</cfif>