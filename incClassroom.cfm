<cfif Classroom.RecordCount eq 0>
	<cfset pageTitle = "No Classroom Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No classroom found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfif not Find("deleteClassroom.cfm", SCRIPT_NAME)>
		<cfset pageTitle = Classroom.Name>
		<cfif Find("infoClassroom.cfm", SCRIPT_NAME)>
			<cfinclude template="incBeginInfo.cfm">
		<cfelse>
			<cfinclude template="incBegin.cfm">
		</cfif>
	</cfif>
	<span class="dataSectionTitle">Classroom Information</span>
	<div class="data">
		<cfoutput query="Classroom" group="ClassroomID">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td nowrap class="fieldLabel">Classroom name:</td>
								<td class="fieldValue"><strong>#Classroom.Name#</a></strong></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Building<cfif Classroom.RoomNumber neq "">/room number</cfif>:</td>
								<td class="fieldValue"><cfif Classroom.Building eq "" and Classroom.RoomNumber eq "">#APPLICATION.nullCaption#<cfelse><cfif Classroom.Building neq "">#Classroom.Building#</cfif><cfif Classroom.RoomNumber neq "">, #Classroom.RoomNUmber#</cfif></cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Department:</td>
								<td class="fieldValue"><cfif Classroom.Department neq "">#Classroom.Department#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">General room descript.:</td>
								<td class="fieldValue"><cfif Classroom.GeneralDescription neq "">#Classroom.GeneralDescription#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Projector:</td>
								<td class="fieldValue"><cfif Classroom.ComputerProjector neq ""><cfif Classroom.ComputerProjector>Yes<cfelse>No</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Screen:</td>
								<td class="fieldValue"><cfif Classroom.Screen neq ""><cfif Classroom.Screen>Yes<cfelse>No</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Instr. wrkst. descript.:</td>
								<td class="fieldValue"><cfif Classroom.ComputerInstructorDesc neq "">#Classroom.ComputerInstructorDesc#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Student wrkst. descript.:</td>
								<td class="fieldValue"><cfif Classroom.ComputerStudentDesc neq "">#Classroom.ComputerStudentDesc#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">ADA access descript.:</td>
								<td class="fieldValue"><cfif Classroom.ADAAccessibility neq "">#Classroom.ADAAccessibility#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Room capacity:</td>
								<td class="fieldValue"><cfif Classroom.RoomCapacity neq "">#Classroom.RoomCapacity#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
						</table>
					</td>
					<td width="2%">&nbsp;</td>
					<td width="49%">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr valign="top">
								<td nowrap class="fieldLabel">Online calendar:</td>
								<td class="fieldValue"><cfif Classroom.CalendarURL neq ""><cfif not ListContains("infoClassroom.cfm,deleteClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="#Classroom.CalendarURL#" target="_blank">Available</a><cfelse>Available</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Contact:</td>
								<td class="fieldValue"><cfif Classroom.ContactLastName neq "" and Classroom.ContactFirstName neq "">#Classroom.ContactFirstName# #Classroom.ContactLastName#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Contact email:</td>
								<td class="fieldValue"><cfif Classroom.Email neq ""><cfif not ListContains("infoClassroom.cfm,deleteClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="mailto:#Classroom.Email#">#Classroom.Email#</a><cfelse>#Classroom.Email#</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Contact telephone:</td>
								<td class="fieldValue"><cfif Classroom.Telephone neq "">#Classroom.Telephone#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Contact mobile:</td>
								<td class="fieldValue"><cfif Classroom.TelephoneMobile neq "">#Classroom.TelephoneMobile#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Contact fax:</td>
								<td class="fieldValue"><cfif Classroom.Fax neq "">#Classroom.Fax#<cfelse>#APPLICATION.nullCaption#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Input on:</td>
								<td class="fieldValue">#DateFormat(Classroom.CreatedDT, APPLICATION.dateFormat)# #TimeFormat(Classroom.CreatedDT, APPLICATION.timeFormat)# by <cfif not ListContains("infoClassroom.cfm,deleteClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="librarian.cfm?LibID=#Classroom.DBRCreatorID#">#Classroom.DBRCreator#</a><cfelse>#Classroom.DBRCreator#</cfif></td>
							</tr>
							<tr valign="top">
								<td nowrap class="fieldLabel">Last updated:</td>
								<td class="fieldValue">#DateFormat(Classroom.UpdatedDT, APPLICATION.dateFormat)# #TimeFormat(Classroom.UpdatedDT, APPLICATION.timeFormat)# by <cfif not ListContains("infoClassroom.cfm,deleteClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")><a href="librarian.cfm?LibID=#Classroom.DBRUpdaterID#">#Classroom.DBRUpdater#</a><cfelse>#Classroom.DBRUpdater#</cfif></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<cfif ( "1,5" contains SESSION.UserLevelID ) and not ListContains("infoClassroom.cfm,deleteClassroom.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<form action="updateClassroom.cfm" method="post">
								<input type="submit" class="mainControl" value="Update Classroom">
								<input name="ClassID" type="hidden" value="#Classroom.ClassroomID#">
							</form>
						</td>
						<td width="12">&nbsp;</td>
						<td>
							<form action="deleteClassroom.cfm" method="post">
								<input name="ClassID" type="hidden" value="#Classroom.ClassroomID#">
								<input type="submit" class="mainControl" value="Delete Classroom"
									<cfif (SESSION.LibID neq Classroom.DBRCreatorID) or (Relationships.Total gt 0)>
									disabled="true"
								</cfif>
								>
							</form>
						</td>
					</tr>
				</table>
			</cfif>
		</cfoutput>
	</div>
</cfif>