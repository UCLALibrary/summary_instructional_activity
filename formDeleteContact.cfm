<cfif isDefined("Contact.RecordCount") and Contact.RecordCount eq 0>
	<cfset pageTitle = "No Contact Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">No contact found</td>
		</tr>
	</table>
	</div>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfoutput>	
<form action="deleteContact.cfm"
	method="post"
	name="deleteContact"
	id="deleteContact">
<span class="formSectionTitle">#pageTitle#</span>
<div class="form">
<table width="400" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
<p class="error">You are about to delete the record below including all files and other records associated with it. Are you sure you want to do this?</p>
		</td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<input name="CntctID" type="hidden" value="#Contact.ContactID#">
		<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
		</form>
		</td>
		<td>
		<form action="contact.cfm?CntctID=#Contact.ContactID#" method="post">
		<input type="submit" class="mainControl" value="Cancel">				
		</form>
		</td>
	</tr>
</table>
	</cfoutput>
</div>
</cfif>