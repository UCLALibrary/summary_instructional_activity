<cfif isDefined("Session.RecordCount") and Session.RecordCount eq 0>
	<cfset pageTitle = "No Instructional Session Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional session found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfset pageTitle = "Deleting Instructional Session">
	<cfinclude template="incBegin.cfm">
	<cfoutput>
		<form action="deleteSession.cfm" method="post" name="deleteSession" id="deleteSession">
			<input name="SessID" type="hidden" value="#Sess.SessionID#">
			<input name="ActID" type="hidden" value="#Activity.ActivityID#">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<table width="400" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<p class="error">You are about to delete the record below including all records associated with it. Are you sure you want to do this?</p>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
						</td>
						<td>
							<input name="Submit" type="submit" class="mainControl" value="Cancel">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</cfoutput>
</cfif>