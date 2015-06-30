<cfif not Find("createAccount.cfm", PATH_INFO)>
	<cflocation url="index.cfm" addtoken="no">
	<cfabort>
</cfif>
<cftry>
	<cfdirectory directory="#APPLICATION.FileDirectory##UserName#" action="create">
	<cfcatch type="Any">
		<cfset up2snuff = 0>
		<cfset em = "Unable to create a file directory on the server.">
	</cfcatch>
</cftry>