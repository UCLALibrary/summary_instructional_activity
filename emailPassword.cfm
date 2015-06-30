<cfquery name="getPassword" datasource="#APPLICATION.dsn#">
	SELECT
		l.FirstName,
		l.LastName,
		l.Email,
		a.Password
	FROM
		dbo.Librarian l
		JOIN dbo.Accounts a ON l.LibrarianID = a.LibrarianID
	where
		l.UserName = '<cfoutput>#UserName#</cfoutput>'
</cfquery>

<cftry>
	<cfmail to="#getPassword.Email#"
			from="do-not-reply@library.ucla.edu"
			subject="SIA Password Retrieval">
		Dear #getPassword.FirstName# #getPassword.LastName#:

		Your SIA password is: #getPassword.Password#

		Go to the UCLA Library SIA Database now: http://sia.library.ucla.edu/

		Sent: #DateFormat(Now(), "mm/dd/yyyy")#
	</cfmail>
	<cfcatch type="Any">
		<cfscript>
			up2snuff = 0;
			em = "Account information email send failure.";
		</cfscript>
	</cfcatch>
</cftry>