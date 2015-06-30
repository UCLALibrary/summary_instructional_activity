<cfset pageTitle = "Add/Remove an Instructional Material">
<cfinclude template="incBegin.cfm">
<cfoutput>
	<form action="addRemoveMaterial.cfm"
		  method="post"
		  name="Material"
		  id="Material">
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
						Add an instructional material to this session
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="Add" type="radio" value="0">
					</td>
					<td class="rest">
						Remove an instructional material from this session
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
						<input name="ActID" type="hidden" value="#ActID#">
						<input name="SessID" type="hidden" value="#SessID#">
						<input type="submit" class="mainControl" style="width:100px;" value="OK">
						</form>
					</td>
					<td>
						<form action="session.cfm?ActID=#ActID#&SessID=#SessID#" method="post">
							<input type="submit" class="mainControl" value="Cancel">
						</form>
					</td>
				</tr>
			</table>
		</div>
</cfoutput>