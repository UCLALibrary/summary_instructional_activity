<cfscript>
	pageTitle = "Error!";
	up2snuff = 1;
	em = "Error!";
	// initialize variables for uspGetAccount stored procedure
	LibID = SESSION.LibID;
	UserName = "";
	Password = "";
</cfscript>
<cfinclude template="uspGetAccount.cfm">
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
	<cfinclude template="incEnd.cfm">
<cfelse>
	<cfif not isDefined("FORM.Password") or
		  not isDefined("FORM.newPassword") or
			not isDefined("FORM.confirmPassword")>
		<cfset pageTitle = "Change Password">
		<cfinclude template="incBegin.cfm">
		<cfinclude template="formChangePassword.cfm">
		<cfinclude template="incEnd.cfm">
	<cfelseif Trim(FORM.Password) eq "" or
		      Trim(FORM.newPassword) eq "" or
		      Trim(FORM.confirmPassword) eq "">
		<cfset up2snuff = 0>
		<cfset pageTitle = "Change Password">
		<cfset em = "Please provide all of the following information">
		<cfinclude template="incBegin.cfm">
		<cfinclude template="formChangePassword.cfm">
		<cfinclude template="incEnd.cfm">
	<cfelse>
		<cfscript>
			if (FORM.Password neq Account.Password)
			{
				up2snuff = 0;
				em = "The value you entered for your current password is incorrect.";
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfset pageTitle = "Error!">
			<cfinclude template="formChangePassword.cfm">
			<cfinclude template="incEnd.cfm">
		<cfelse>
			<cfscript>
				newPassword = FORM.newPassword;
				confirmPassword = FORM.confirmPassword;
				if (not goodString(newPassword))
				{
					up2snuff = 0;
					em = "You new password must be at least 7 characters long and must not contain white spaces. Please select a different password.";
				}
				else
				{
					if (newPassword neq confirmPassword)
					{
						up2snuff = 0;
						em = "Your new passwords do not match. Please re-enter your passwords.";
					}
				}
				function goodString (string)
				{
					if (Find(" ", string) or Len(string) lt 7)
					{
						up2snuff = 0;
					}
					return up2snuff;
				}
			</cfscript>
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfset pageTitle = "Error!">
				<cfinclude template="formPassword.cfm">
				<cfinclude template="incEnd.cfm">
			<cfelse>
				<cftry>
					<cfstoredproc procedure="uspChangePassword" datasource="#APPLICATION.dsn#">
						<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" variable="@LibID" value="#SESSION.LibID#" null="no">
						<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" variable="@newPassword" value="#FORM.newPassword#" null="no">
					</cfstoredproc>
					<cfcatch type="Database">
						<cfset up2snuff = 0>
						<cfset em = "Error occurred while attempting to change your password. Please try again.">
					</cfcatch>
				</cftry>
				<cfif not up2snuff>
					<cfset pageTitle = "Error!">
					<cfset em = "An error occurred while attempting to change your password. Please try again.">
					<cfinclude template="incBegin.cfm">
					<cfinclude template="formChangePassword.cfm">
					<cfinclude template="incEnd.cfm">
				<cfelse>
					<cflocation url="changedPassword.cfm" addtoken="yes">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>