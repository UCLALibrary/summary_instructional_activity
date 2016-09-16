<!---cfif not Find("createAccount.cfm", PATH_INFO)>
	<cflocation url="index.cfm" addtoken="no">
	<cfabort>
</cfif--->
<cfscript>
	Domain = Right(Email, Len(Email) - Find("@", Email));
	if (ListValueCount(APPLICATION.legalDomains, Domain, ",") lt 1)
	{
		up2snuff = 0;
		goodCredential = 0;
		em = 'Illegal domain for email address.';
	}
	else if (netUserName neq UserName)
	{
		up2snuff = 0;
		goodCredential = 0;
		em = 'You must be an employee of the UCLA Library and possess a valid Library network user name to qualify for an account.';
	}
	else
	{
		up2snuff = 1;
		goodCredential = 1;
	}
</cfscript>
