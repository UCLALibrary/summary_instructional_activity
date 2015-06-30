<cfset authRefer = APPLICATION.HostServer>
<cfif not Find(authRefer, HTTP_REFERER)>
	<cflocation url="index.cfm?action=deny" addtoken="no">
	<cfabort>
</cfif>