<cfscript>
	pageTitle = "Unable to Delete";
	if (Find("deleteActivity", SCRIPT_NAME)) {
		em = "Unable to delete this instructional activity because it is currently related to other records in the SIA Database.";
		action = "activity.cfm?ActID=" & FORM.ActID;
	}
	else if (Find("deleteSession", SCRIPT_NAME)) {
		em = "Unable to delete this instructional session because it is currently related to other records in the SIA Database.";
		action = "session.cfm?SessID=" & FORM.SessID;
	}
	else if (Find("deleteMaterial", SCRIPT_NAME)) {
		em = "Unable to delete this instructional material because it is currently related to other records in the SIA Database.";
		action = "material.cfm?MatID=" & FORM.MatID;
	}
	else if (Find("deleteContact", SCRIPT_NAME)) {
		em = "Unable to delete this contact because s/he is currently related to other records in the SIA Database.";
		action = "contact.cfm?CntctID=" & FORM.CntctID;
	}
	else {
		em = "Unable to delete this record.";
		action = "mySIA.cfm";
	}
</cfscript>
<cfinclude template="incBegin.cfm">
<cfoutput>
<span class="dataSectionTitle">#pageTitle#</span>
<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">#em#</td>
		</tr>
	</table>
	<form action="#action#" method="post">
	<input type="submit" class="mainControl" value="&lt;&lt; Back">
	</form>	
</div>
</cfoutput>