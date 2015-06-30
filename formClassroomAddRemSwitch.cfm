<cfset pageTitle = "Add or Change a Location for this Instructional Session">
<cfinclude template="incBegin.cfm">
<cfoutput>
	<form action="addRemoveClassroom.cfm"
	      method="post"
	      name="Classroom"
	      id="Classroom">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<table width="350" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2">
					<p>What would you like to do?</p>
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
					<input name="Add" type="radio" value="1" checked>
					</td>
					<td width="90%" class="rest">
					Change the location for this instructional session
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
					<input name="Add" type="radio" value="0">
					</td>
					<td class="rest">
					Remove the location for this instructional session
					</td>
				</tr>
				<tr valign="top">
					<td class="rest">&nbsp;</td>
					<td class="rest">&nbsp;</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<input name="SessID" type="hidden" value="#SessID#">
						<input name="ActID" type="hidden" value="#ActID#">
						<input type="submit" class="mainControl" style="width:100px;" value="OK">
						</form>
					</td>
					<td>
						<form action="session.cfm?SessID=#SessID#&ActID=#ActID#" method="post">
							<input type="submit" class="mainControl" value="Cancel">
						</form>
					</td>
				</tr>
			</table>
		</div>
</cfoutput>