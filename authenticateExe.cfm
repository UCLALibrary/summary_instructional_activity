<cfif not SESSION.isAuthentic or not Find(APPLICATION.HostServer, HTTP_REFERER)>
	<cflocation url="index.cfm" addtoken="no">
	<cfabort>
</cfif>
