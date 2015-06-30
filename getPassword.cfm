<cfset pageTitle = "Retrieve Password">
<cfinclude template="incBegin.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfinclude template="formGetPassword.cfm">
<cfelseif isDefined("FORM.Submit")>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="index.cfm" addtoken="no">
	<cfelse>
		<cfscript>
			if ( not isDefined("FORM.UserName") )
			{
				up2snuff = 0;
				em = 'Missing required account information';
			}
			else
			{
				up2snuff = 1;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="formGetPassword.cfm">
		<cfelse>
			<cfinclude template="incCheckForm.cfm">
			<cfif missingRequired>
				<cfinclude template="formGetPassword.cfm">
			<cfelse>
				<cfscript>
					UserName = Trim(StripCR(FORM.UserName));
				</cfscript>
				<cfinclude template="verifyAccount.cfm">
				<cfif not up2snuff>
					<cfinclude template="formGetPassword.cfm">
				<cfelse>
					<cfinclude template="emailPassword.cfm">
					<cfif not up2snuff>
						<cfinclude template="incError.cfm">
					<cfelse>
						<cfinclude template="passwordMailed.cfm">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">