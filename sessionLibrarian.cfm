<cfset LibID = SESSION.LibID>
<cfinclude template="uspGetSession.cfm">
<cfset pageTitle = "My SIA">
<cfinclude template="incBegin.cfm">
<cfinclude template="incSession.cfm">
<div class="controlArea">
<cfoutput>
	<form action="updateSession.cfm" method="post">
	<table border="0" align="center" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td><input type="button" class="mainControl" onClick="JavaScript:history.back();"  value="&lt;&lt; Back"></td>
			<td><input type="submit" class="mainControl" value="#updateCaption#"></td>
		</tr>
	</table>
	<input name="sid" type="hidden" value="#Sess.SessionID#">
	</form>
</cfoutput>
</div>
<cfinclude template="incEnd.cfm">





