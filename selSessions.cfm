	<cfoutput>
		<form action="sessionsSupe.cfm" method="post" name="Sessions" id="Sessions" onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<table border="0" cellpadding="0" cellspacing="0">
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
							<select name="Year">
								<option value="0">-select-</option>
								<cfloop query="Years">
									<option value="#Years.TheYear#">#Years.TheYear#/#Years.TheYear + 1#</option>
								</cfloop>
							</select>
						</td>
						<td align="center">OR</td>
						<td>
							Session Date<br>(mm/dd/yyyy)<br>
							<input type="text" name="SessionDate" size="12" maxlength="10" value="">
							&nbsp;
							<a href="javascript:ShowCalendar('Sessions','SessionDate')">Select Date</a>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td>
							UCLA department<br>
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
					<tr valign="top">
						<td>
							Session type<br>
							<cfset Lookup = "ActivityType">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="ActivityTypeID">
								<cfloop query="ActivityType">
									<option value="#ActivityType.ActivityTypeID#">#ActivityType.ActivityType#</option>
								</cfloop>
							</select>
						</td>
						<td>
							Delivery mode<br>
							<cfset Lookup = "DeliveryMode">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="DeliveryModeID">
								<cfloop query="DeliveryMode">
									<option value="#DeliveryMode.DeliveryModeID#">#DeliveryMode.DeliveryMode#</option>
								</cfloop>
							</select>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<!--input name="reqElements" type="hidden" value="ReportID,a report type"-->
							<input name="Submit" type="submit" class="mainControl" style="width:120px;" value="View Sessions">
						</td>
						<td>
							<input name="reset" type="reset" class="mainControl" style="width:100px;" value="Reset">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>