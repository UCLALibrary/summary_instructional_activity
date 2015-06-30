<cfset pageTitle = "Add an Instructional Session">
<cfinclude template="incBegin.cfm">
<cfoutput>
	<form action="addSession.cfm"
	      method="post"
	      name="AddSession"
	      id="AddSession">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<table width="350" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2">
						<p>Would you like to add a session to this instructional activity?</p>
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="addActSess" type="radio" value="1" checked>
					</td>
					<td width="90%" class="rest">Yes</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="addActSess" type="radio" value="0">
					</td>
					<td class="rest">No, not right now</td>
				</tr>
				<tr valign="top">
					<td class="rest">&nbsp;</td>
					<td class="rest">&nbsp;</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
						<input name="ActID" type="hidden" value="#SESSION.ActID#">
						<input name="caller" type="hidden" value="formAddSessionSwitch">
						<!--/form-->
					</td>
					<td>
						<input name="Submit" type="submit" class="mainControl" value="Cancel">
						<!---form action="activity.cfm?ActID=#SESSION.ActID#" method="post">
							<input type="submit" class="mainControl" value="Cancel">
						</form--->
					</td>
				</tr>
			</table>
		</div>
	</form>
</cfoutput>