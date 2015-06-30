<cfif isDefined("Outreach.RecordCount") and Outreach.RecordCount eq 0>
	<cfset pageTitle = "No Outreach Log Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">No outreach log found</td>
		</tr>
	</table>
	</div>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfoutput>	
<form action="deleteOutreach.cfm"
	method="post"
	name="deleteOutreach"
	id="deleteOutreach">
<span class="formSectionTitle">#pageTitle#</span>
<div class="form">
<table width="400" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
<p class="error">You are about to delete the record below. Are you sure you want to do this?</p>
		</td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<input name="OutID" type="hidden" value="#Outreach.OutreachID#">
		<input name="CntctID" type="hidden" value="#Outreach.ContactID#">
		<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
		</form>
		</td>
		<td>
		<form action="contact.cfm?CntctID=#Outreach.ContactID#" method="post">
		<input type="submit" class="mainControl" value="Cancel">				
		</form>
		</td>
	</tr>
</table>
	</cfoutput>
</div>
</cfif>