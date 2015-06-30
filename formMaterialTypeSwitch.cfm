<cfset pageTitle = "Add an Instructional Material">
<cfinclude template="incBegin.cfm">
<cfoutput>
	<form action="addNewMaterial.cfm"
		  method="post"
		  name="SelectMaterial"
		  id="SelectMaterial">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<table width="350" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="2">
						<p>Please select the type of instructional material your would like to add:</p>
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="IsFile" type="radio" value="1" checked>
					</td>
					<td width="90%" class="rest">
						A local file on my computer such as a print handout in Word<sup>&reg;</sup> or Adobe
						PDF<sup>&reg;</sup>, a PowerPoint<sup>&reg;</sup> presentation, spreadsheet, etc.
					</td>
				</tr>
				<tr valign="middle">
					<td class="rest">
						<input name="IsFile" type="radio" value="0">
					</td>
					<td class="rest">
						An online resource such as a Web site, database, digital learning object, course Web site, etc.
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
						<input name="newMat" type="hidden" value="1">
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
							<form action="materials.cfm?UID=#SESSION.UID#" method="post">
						</cfif>
						<input type="submit" class="mainControl" value="Cancel">
						</form>
					</td>
				</tr>
			</table>
		</div>
</cfoutput>