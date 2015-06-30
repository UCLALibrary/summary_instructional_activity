<cfscript>
	dataSectionTitle = ATTRIBUTES.dataSectionTitle;
	message = ATTRIBUTES.message;
	submitCaption = ATTRIBUTES.submitCaption;
	redirectURL = ATTRIBUTES.redirectURL;
</cfscript>
<cfoutput>
<span class="dataSectionTitle">#dataSectionTitle#</span>
<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">#message#</td>
		</tr>
	</table>
	<cfif submitCaption neq "" and redirectURL neq "">
		<form action="#redirectURL#" method="post">
			<input type="submit" class="mainControl" value="#submitCaption#"> 
		</form>
	</cfif>	
</div>
</cfoutput>