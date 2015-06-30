<cfif not Find("getPassword.cfm", PATH_INFO)>
	<cflocation url="index.cfm" addtoken="no">
	<cfabort>
</cfif>
<cfquery name="checkAccount" datasource="#APPLICATION.dsn#">
	SELECT count(LibrarianID) AS account FROM dbo.Librarian WHERE UserName = '<cfoutput>#UserName#</cfoutput>'
</cfquery>
<cfscript>
	if ( checkAccount.account eq 0 )
	{
		up2snuff = 0;
		em = '#UserName# is not a valid SIA user name';
	}
	else
	{
		up2snuff = 1;
	}
</cfscript>
