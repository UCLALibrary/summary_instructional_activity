<script language="JavaScript" type="text/javascript">
<!--
	function populateForm() {
	    opener.document.Contact.LastName.value = document.Loader.LastName.value;
	    opener.document.Contact.FirstName.value = document.Loader.FirstName.value;
	    opener.document.Contact.Title.value = document.Loader.Title.value;
	    opener.document.Contact.Email.value = document.Loader.Email.value;
	    opener.document.Contact.Telephone.value = document.Loader.Telephone.value;
	    opener.document.Contact.Fax.value = document.Loader.Fax.value;
	    opener.document.Contact.CampusAddress.value = document.Loader.CampusAddress.value;
	    opener.document.Contact.CampusMailcode.value = document.Loader.CampusMailcode.value;
		setTimeout('window.close()',500);
	    return false;
	}
//-->
</script>
<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
<div class="data">
<cfoutput query="Person">
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="fieldLabel">Name:</td>
		<td class="fieldValue">#Person.cn#</td>
	</tr>
	<tr>
		<td class="fieldLabel">Title:</td>
		<td class="fieldValue">#Person.title#</td>
	</tr>
	<tr>
		<td class="fieldLabel">Department:</td>
		<td class="fieldValue">#Person.department#</td>
	</tr>
	<tr>
		<td class="fieldLabel">Campus address:</td>
		<td class="fieldValue">#Person.uclaPostalAddress#</td>
	</tr>
	<tr>
		<td class="fieldLabel">Campus mailcode:</td>
		<td class="fieldValue">#Person.postalCode#</td>
	</tr>
	<tr>
		<td class="fieldLabel">Email:</td>
		<td class="fieldValue">#Person.mail#</td>
	</tr>
	<tr>
		<td class="fieldLabel">Telephone:</td>
		<td class="fieldValue">#Person.telephoneNumber#</td>
	</tr>
	<cfif Person.facsimileTelephoneNumber neq "">
	<tr>
		<td class="fieldLabel">Fax:</td>
		<td class="fieldValue">#Person.facsimileTelephoneNumber#</td>
	</tr>
	</cfif>
</table>
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
	<form name="Loader">
	<input name="LastName" type="hidden" value="#cnA[1]#">
	<input name="FirstName" type="hidden" value="#cnA[2]#">
	<input name="Title" type="hidden" value="#Person.title#">
	<input name="Email" type="hidden" value="#Person.mail#">
	<input name="Telephone" type="hidden" value="#Person.telephoneNumber#">
	<input name="CampusAddress" type="hidden" value="#Person.uclaPostalAddress#">
	<input name="CampusMailcode" type="hidden" value="#Person.postalCode#">
	<input name="Fax" type="hidden" value="#Person.facsimileTelephoneNumber#">
	<input type="button" class="mainControl" onClick="JavaScript:populateForm();" value="Copy Info">	
	</form>
		</td>
		<td width="12">&nbsp;</td>
		<td>
	<form action="directory.cfm" method="post">
	<cfif Person.RecordCount gt 1>
		<input name="qs" type="hidden" value="#FORM.qs#">	
	</cfif>	
	<input type="submit" class="mainControl" value="&lt;&lt; Back">
	</form>
		</td>
	</tr>
</table>
</cfoutput>
</div>
