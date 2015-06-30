<cfif isDefined("Material.RecordCount") and Material.RecordCount eq 0>
	<cfset pageTitle = "No Instructional Material Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">No instructional material found</td>
		</tr>
	</table>
	</div>
<cfelse>
	<cfset pageTitle = "Deleting Instructional Material">
	<cfinclude template="incBegin.cfm">
	<cfoutput>	
<form action="deleteMaterial.cfm"
	method="post"
	name="deleteMaterial"
	id="deleteMaterial">
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
		<input name="MatID" type="hidden" value="#Material.MaterialID#">
		<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
		</form>
		</td>
		<td>
		<form action="materials.cfm?LibID=#SESSION.LibID#" method="post">
		<input type="submit" class="mainControl" value="Cancel">				
		</form>
		</td>
	</tr>
</table>
	</cfoutput>
</div>
</cfif>