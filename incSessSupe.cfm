<cfscript>
	sFiscal = FiscalY;
	eFiscal = FiscalY + 1;
	sectionTitle = "Instructional Sessions Provided Fiscal Year " & sFiscal & "/" & eFiscal;

	if ( SessionDate neq "" )
	{
		sectionTitle = sectionTitle & "; Sessions on " & DateFormat(SessionDate, "mmmm d, yyyy");
	}
	if (isDefined("Department.RecordCount"))
	{
		sectionTitle = sectionTitle & "; Sessions Provided to " & Department.Department;
	}
	if (isDefined("Unit.RecordCount"))
	{
		sectionTitle = sectionTitle & "; Sessions Provided by " & Unit.Unit;
	}
	if (Year neq 0 and QuartID neq 0)
	{
		sectionTitle = sectionTitle & "; During " & Quarter.Quarter & " Quarter, " & Year;
	}
	if (isDefined("DeliveryMode.RecordCount"))
	{
		sectionTitle = sectionTitle & "; Provided in/by " & DeliveryMode.DeliveryMode;
	}
	if (isDefined("ActivityType.RecordCount"))
	{
		sectionTitle = sectionTitle & "; " & ActivityType.ActivityType;
	}
</cfscript>
<cfif Sessions.RecordCount eq 0>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No sessions</td>
			</tr>
		</table>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<th nowrap>Session Title</th>
				<cfif ActTypeID eq 0>
					<th nowrap>Type</th>
				</cfif>
				<cfif QuartID eq 0>
					<th nowrap>Quarter</th>
				</cfif>
				<cfif SessionDate eq "">
					<th nowrap>Date</th>
				</cfif>
				<th nowrap>Time</th>
				<cfif UID eq 0>
					<th nowrap>Unit</th>
				</cfif>
				<th nowrap>Librarian(s)</th>
				<th nowrap>Co-Presenter(s)</th>
				<cfif DepID eq 0>
					<th nowrap>Department</th>
				</cfif>
				<th nowrap>Faculty</th>
				<th nowrap>Number Of Students</th>
			</tr>
			<cfoutput query="Sessions" group="SessionID">
				<cfset class="#IIF(Sessions.CurrentRow eq 1, DE('first'), DE('rest'))#">
				<tr valign="top">
					<td class="#class#">
						<a href="session.cfm?SessID=#Sessions.SessionID#&ActID=#Sessions.ActivityID#">#Sessions.Title#</a>
					</td>
					<cfif ActTypeID eq 0>
						<td class="#class#">
							<a href="session.cfm?SessID=#Sessions.SessionID#">#Sessions.ActivityType#</a>
						</td>
					</cfif>
					<cfif QuartID eq 0>
						<td nowrap class="#class#">
							<a href="sessions.cfm?Yr=#DatePart("yyyy", Sessions.SessionDateTime)#&QuartID=#Sessions.QuarterID#">'#Right(DatePart("yyyy", Sessions.SessionDateTime), 2)# #Sessions.Quarter#</a>
						</td>
					</cfif>
					<cfif SessionDate eq "">
						<td nowrap class="#class#">
							<a href="sessions.cfm?sDT=#URLEncodedFormat(DateFormat(Sessions.SessionDateTime, "mm/dd/yy"))#">#DateFormat(Sessions.SessionDateTime, "mm/dd/yy")#</a>
						</td>
					</cfif>
					<td nowrap class="#class#">
						<a href="sessions.cfm?Hr=#DatePart("h", Sessions.SessionDateTime)#">#TimeFormat(Sessions.SessionDateTime, "h:mm tt")#</a>
					</td>
					<cfif UID eq 0>
						<td nowrap class="#class#">
							<cfoutput>
								<a href="sessions.cfm?UID=#Sessions.UnitID#">#Sessions.Unit#</a>
								<br>
							</cfoutput>
						</td>
					</cfif>
					<td class="#class#">
						<cfoutput>
							<a href="librarian.cfm?LibID=#Sessions.LibrarianID#">#Sessions.LastName#</a>
							<br>
						</cfoutput>
					</td>
					<td nowrap class="#class#">
						<a href="session.cfm?SessID=#Sessions.SessionID#"><cfif Len("#Sessions.CoLibs#") gt 1>#Sessions.CoLibs#<cfelse>#APPLICATION.nullCaption#</cfif></a>
					</td>
					<cfif DepID eq 0>
						<td class="#class#">
							<cfif Sessions.SessionDepartment neq "">
								<a href="department.cfm?DeptID=#Sessions.SessionDepartmentID#">#Sessions.SessionDepartment#</a>
							<cfelse>
								#APPLICATION.nullCaption#
							</cfif>
						</td>
					</cfif>
					<td class="#class#">
						<a href="session.cfm?SessID=#Sessions.SessionID#">
							<cfif Len("#Sessions.Faculty#") gt 1>#Sessions.Faculty#<cfelse>#APPLICATION.nullCaption#</cfif>
						</a>
					</td>
					<td nowrap class="#class#" align="right">
						<a href="session.cfm?SessID=#Sessions.SessionID#">#Sessions.Attendees#</a>
					</td>
				</tr>
			</cfoutput>
		</table>
	</div>
</cfif>