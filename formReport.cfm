	<script language="JavaScript" type="text/javascript">
		<!--
			function validateForm(form)
			{
				if (form.ReportID.options[ form.ReportID.selectedIndex ].value == 0)
				{
					alert("Please choose a report type");
					return false;
				}
				/*if ((form.QuarterID.options[ form.QuarterID.selectedIndex ].value != 0) &&
				    (form.Year.options[ form.Year.selectedIndex ].value == 0))
				{
					alert("If you select a quarter, you must also select a fiscal year");
					return false;
				}*/
				return true;
			}
			function switchTimes(formObj,yearType)
			{
				formObj.SessionDate.value = "";
				switch ( yearType )
				{
					case 1 :  formObj.CYear.selectedIndex = 0;
						break;
					case 2 :  formObj.FYear.selectedIndex = 0;
						break;
				}
			}

			function clearYears(formObj)
			{
				if ( formObj.SessionDate.value != "" )
				{
					formObj.QuarterID.selectedIndex = 0;
					formObj.CYear.selectedIndex = 0;
					formObj.FYear.selectedIndex = 0;
				}
			}
		//-->
	</script>
	<cfoutput>
		<form action="showReport.cfm" method="post" name="Reports" id="Reports" target="_blank" onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="left" style="font-size: small; color: red">
							The data you will see in any given report is determined by your user level.<br>
							Most librarians can see only their own data in the reports.<br>
							Instruction Coordinators and unit heads can see data for their whole unit.
							<br>The UL, AUL, and ILP director can view reports of the data for all the library units.
						</td>
					</tr>
					<tr><td><hr size="1"></td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
						<em class="required">*</em>Report type<br>
						<select name="ReportID">
							<option value="0">-select-</option>
							<cfloop query="Reports">
								<option value="#Reports.ReportID#">#Reports.Title#</option>
							</cfloop>
						</select>
						&nbsp;
						<a href="sessDefs.html" target="_blank"><img src="images/help_icon.gif" alt="View definitions" border="0"></a>
						</td>
					</tr>
					<tr><td><hr size="1"></td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<cfif SESSION.UserLevelID eq 1>
							<input type="hidden" name="OwnerID" value="#SESSION.LibID#">
						<cfelse>
							<td>
								<table>
								<tr valign="top">
								<cfoutput>
								<td>
								Library Staff Presenter(s):<br>
									<select name="Presenters" multiple="multiple" size="10">
										<cfloop query="Librarians">
											<option value="#Librarians.LibrarianID#">#Librarians.LastName#, #Librarians.FirstName#</option>
										</cfloop>
									</select>
								</td>
								<td>&nbsp;</td>
								<td>
								Library Staff Developer(s):<br>
									<select name="Developers" multiple="multiple" size="10">
										<cfloop query="Librarians">
											<option value="#Librarians.LibrarianID#">#Librarians.LastName#, #Librarians.FirstName#</option>
										</cfloop>
									</select>
								</td>
								<td>&nbsp;</td>
								</cfoutput>
								</tr>
								</table>

								<!---Library Staff Presenter<br>
								<select name="OwnerID">
									<option value="0">-select-</option>
									<cfloop query="Librarians">
										<option value="#Librarians.LibrarianID#">#Librarians.LastName#, #Librarians.FirstName#</option>
									</cfloop>
								</select--->
							</td>
						</cfif>
						<td>
							Contact<br>
							<select name="CntctID">
								<option value="0">-select-</option>
								<cfloop query="Contacts">
									<option value="#Contacts.ContactID#">#Contacts.LastName#, #Contacts.FirstName#</option>
								</cfloop>
							</select>
						</td>
						<!---td>
							Classroom<br>
							<select name="ClassID">
								<option value="0">-select-</option>
								<cfloop query="Classrooms">
									<option value="#Classrooms.ClassroomID#">#Classrooms.Name# (#Classrooms.Building# #Classrooms.RoomNumber#)</option>
								</cfloop>
							</select>
						</td--->
					</tr>
					<tr>
						<td colspan="3"><hr size="1"></td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td colspan="5">
							Select an optional date range: you can select: a full calendar year; a full fiscal year; a quarter
							within a calendar or fiscal year; or a specific date.  If you do not pick any of these, the report
							will use the current fiscal year.
						</td>
					</tr>
					<tr valign="top">
						<td>
							Quarter<br>
							<cfset Lookup = "Quarter">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="QuarterID">
								<cfloop query="Quarter">
									<option value="#Quarter.QuarterID#">#Quarter.Quarter#</option>
								</cfloop>
							</select>
						</td>
						<td>
							Fiscal Year<br>
							<select name="FYear" onchange="switchTimes(Reports,1)">
								<option value="0">-select-</option>
								<cfloop query="Years">
									<cfif DatePart("yyyy", Now()) gt Years.TheYear>
										<option value="#Years.TheYear#">#Years.TheYear#/#Years.TheYear + 1#</option>
									<cfelseif DatePart("yyyy", Now()) eq Years.TheYear and DatePart("m", Now()) ge 7>
										<option value="#Years.TheYear#">#Years.TheYear#/#Years.TheYear + 1#</option>
									<cfelse>
									</cfif>
								</cfloop>
							</select>
						</td>
						<!--td align="center">OR</td-->
						<td>
							Calendar Year<br>
							<select name="CYear" onchange="switchTimes(Reports,2)">
								<option value="0">-select-</option>
								<cfloop query="Years">
									<option value="#Years.TheYear#">#Years.TheYear#</option>
								</cfloop>
							</select>
						</td>
						<td>
							Session Date<br>
							<input type="text" name="SessionDate" size="12" maxlength="10" value="" onchange="clearYears(Reports)">
							&nbsp;
							<a href="javascript:ShowCalendar(Reports,'Reports','SessionDate')">Select Date</a>
						</td>
					</tr>
					<tr><td colspan="4"><hr size="1"></td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							Academic Departments and More<br>
							<cfset Lookup = "Department">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="DepartmentID">
								<cfloop query="Department">
									<option value="#Department.DepartmentID#">#Department.Department#</option>
								</cfloop>
							</select>
						</td>
						<td>
							Other department, college, etc.<br>
							<input
								name="FacultyGroup"
								type="text"
								size="25"
								maxlength="255"
								value=""
							>
						</td>
					</tr>
					<tr valign="top">
						<td>
							Learner category<br>
							<cfset Lookup = "LearnerCategory">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<select name="LearnerCategoryID" multiple size="10">
								<cfloop query="LearnerCategory">
									<option value="#LearnerCategory.LearnerCategoryID#">#LearnerCategory.LearnerCategory#</option>
								</cfloop>
							</select>
						</td>
						<td>&nbsp;</td>
						<!---td>
							Affiliation<br>
							<cfset Lookup = "Affiliation">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="AffiliationID">
								<cfloop query="Affiliation">
									<option value="#Affiliation.AffiliationID#">#Affiliation.Affiliation#</option>
								</cfloop>
							</select>
						</td--->
					</tr>
					<cfif SESSION.UserLevelID eq 1>
						<input type="hidden" name="UnitID" value="0">
					<cfelseif SESSION.UserLevelID eq 2>
						<input type="hidden" name="UnitID" value="#SESSION.UID#">
					<cfelse>
						<tr valign="top">
							<td colspan="3">
								Library unit<br>
								<cfset Lookup = "Unit">
								<cfset Header = "">
								<cfinclude template="uspGetLookup.cfm">
								<select name="UnitID">
									<option value="0">-select-</option>
									<cfloop query="Unit">
										<option value="#Unit.UnitID#">#Unit.Unit#</option>
									</cfloop>
								</select>
							</td>
						</tr>
					</cfif>
					<tr><td colspan="3"><hr size="1"></td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							Delivery mode<br>
							<cfset Lookup = "DeliveryMode">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<select name="DeliveryModes" multiple="multiple" size="#DeliveryMode.recordcount#">
								<cfloop query="DeliveryMode">
									<option value="#DeliveryMode.DeliveryModeID#">#DeliveryMode.DeliveryMode#</option>
								</cfloop>
							</select>
						</td>
						<td>
							Material type<br>
							<cfset Lookup = "MaterialType">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="MaterialTypeID">
								<cfloop query="MaterialType">
									<option value="#MaterialType.MaterialTypeID#">#MaterialType.MaterialType#</option>
								</cfloop>
							</select>
						</td>
					</tr>
					<tr><td colspan="2"><hr size="1"></td></tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							Display Class Duration?
						</td>
						<td>
							<input type="radio" name="Duration" value="0" checked>No<br>
							<input type="radio" name="Duration" value="1">Yes
						</td>
						<td>
							Display Development & Preparation time?
						</td>
						<td>
							<input type="radio" name="PrepTime" value="0" checked>No<br>
							<input type="radio" name="PrepTime" value="1">Yes
						</td>
						<td>
							Display Evaluation/Feedback?
						</td>
						<td>
							<input type="radio" name="Feedback" value="0" checked>No<br>
							<input type="radio" name="Feedback" value="1">Yes
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<input name="reqElements" type="hidden" value="ReportID,a report type">
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="VIEW REPORT">
						</td>
						<td>
							<input name="reset" type="reset" class="mainControl" style="width:100px;" value="Reset">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>
						<!--td>
							Activity/course type<br>
							<cfset Lookup = "ActivityType">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="ActivityTypeID">
								<cfloop query="ActivityType">
									<option value="#ActivityType.ActivityTypeID#">#ActivityType.ActivityType#</option>
								</cfloop>
							</select>
						</td>
							<select name="Duration">
								<option value="-1">-select-</option>
								<cfloop query="Durations">
									<option value="#Durations.Duration#">#Durations.Duration#</option>
								</cfloop>
							</select>
							&nbsp;mins
						</td>
							<select name="PrepTime">
								<option value="-1">-select-</option>
								<cfloop query="PrepTimes">
									<option value="#PrepTimes.PrepTime#">#PrepTimes.PrepTime#</option>
								</cfloop>
							</select>
							&nbsp;mins
						</td>
							<select name="DevTime">
								<option value="-1">-select-</option>
								<cfloop query="DevTimes">
									<option value="#DevTimes.DevTime#">#DevTimes.DevTime#</option>
								</cfloop>
							</select>
							&nbsp;mins
						</td--->
						<!---td>
							Display Preparation time?
						</td>
						<td>
							<input type="radio" name="PrepTime" value="0" checked>No<br>
							<input type="radio" name="PrepTime" value="1">Yes
						</td--->
