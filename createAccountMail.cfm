<cfif not Find("createAccount.cfm", PATH_INFO)>
	<cflocation url="index.cfm" addtoken="no">
	<cfabort>
</cfif>
<cftry>
	<cfmail to="#Email#"
			from="Diane Mizrachi <mizrachi@library.ucla.edu>"
			subject="SIA Database Account Created">Dear #FirstName# #LastName#:

Congratulations! Your UCLA Library SIA Database account has been created. You can begin using the SIA database by logging in using the following information:

UserID: #UserName#
Temporary password (case sensitive): #tempPassword#

After logging into your account for the first time, you will be asked to select a library unit. You will not be able to change your library unit once you have selected it, so please choose carefully. You will be able to change any other information in your mySIA profile.

Go to the UCLA Library SIA Database now: http://sia.library.ucla.edu/

Sent: #Now()#
</cfmail>
	<cfcatch type="Any">
		<cfscript>
			up2snuff = 0;
			em = "Account information email send failure.";
		</cfscript>
	</cfcatch>
</cftry>
