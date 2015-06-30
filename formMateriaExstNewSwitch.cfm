<cfset pageTitle = "Add an Instructional Material">
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
						<p>I would like to add...</p>
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="newMat" type="radio" value="0" checked>
					</td>
					<td width="90%" class="rest">
						an instructional material existing in the SIA Database
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="newMat" type="radio" value="1">
					</td>
					<td class="rest">
						a new instructional material
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
						<cfif isDefined("ActID")>
							<input name="ActID" type="hidden" value="#ActID#">
						</cfif>
						<cfif isDefined("SessID")>
							<input name="SessID" type="hidden" value="#SessID#">
						</cfif>
						<input type="submit" class="mainControl" style="width:100px;" value="OK">
						</form>
					</td>
					<td>
						<cfif isDefined("ActID")>
							<form action="session.cfm?ActID=#ActID#&SessID=#SessID#" method="post">
						<cfelse>
							<form action="materials.cfm?LibID=#SESSION.LibID#" method="post">
						</cfif>
						<input type="submit" class="mainControl" value="Cancel">
						</form>
					</td>
				</tr>
			</table>
		</div>
</cfoutput>