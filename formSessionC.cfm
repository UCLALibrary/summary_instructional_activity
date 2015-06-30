<cfoutput>
	<cfset pageTitle = "Add an Instructional Session: Optional Data for #Activity.Title#">
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incJSShowCalendar.cfm">
	<span class="formSectionTitle">#pageTitle#</span>
	<div class="form">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td>
					<a href="addRemoveContact.cfm?SessID=#SESSION.SessID#">Add Faculty</a>
				</td>
			</tr>
			<tr valign="top">
				<td>
					<a href="addRemoveLibrarian.cfm?SessID=#SESSION.SessID#">Add Co_Presenter(s)</a>
				</td>
			</tr>
			<tr valign="top">
				<td>
					<a href="addRemoveLibrarian.cfm?SessID=#SESSION.SessID#">Add Developer(s)</a>
				</td>
			</tr>
			<tr valign="top">
				<td>
					<a href="addRemoveMaterial.cfm?ActID=#SESSION.ActID#">Add Material(s)</a>
				</td>
			</tr>
			<tr valign="top">
				<td>
					<a href="addRemoveClassroom.cfm?SessID=#SESSION.SessID#">Add Classroom</a>
				</td>
			</tr>
			<tr valign="top">
				<td>
					<a href="updateAssessment.cfm?SessID=#SESSION.SessID#">Add Assessment</a>
				</td>
			</tr>
		</table>
	</div>
</cfoutput>