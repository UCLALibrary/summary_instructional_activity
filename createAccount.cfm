<cfset pageTitle = "Create Your Account">
<cfinclude template="incBegin.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfinclude template="formCreateAccount.cfm">
<cfelseif isDefined("FORM.Submit")>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="index.cfm" addtoken="no">
	<cfelse>
		<cfscript>
			if ( not isDefined("FORM.Email") or
				 not isDefined("FORM.LastName") or
				 not isDefined("FORM.FirstName") or
				 not isDefined("FORM.netUserName") )
			{
				up2snuff = 0;
				goodCredential = 0;
				em = 'Missing required account information';
			}
			else
			{
				up2snuff = 1;
				goodCredential = 0;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="formCreateAccount.cfm">
		<cfelse>
			<cfinclude template="incCheckForm.cfm">
			<cfif missingRequired>
				<cfinclude template="formCreateAccount.cfm">
			<cfelse>
				<cfscript>
					LastName = Trim(StripCR(FORM.LastName));
					FirstName = Trim(StripCR(FORM.FirstName));
					Email = Trim(StripCR(FORM.Email));
					netUserName = Trim(StripCR(FORM.netUserName));
					UserName = Left(Email, Evaluate(Find("@", Email) - 1));
				</cfscript>
				<cfinclude template="createAccountVerify.cfm">
				<cfif not up2snuff and not goodCredential>
					<cfinclude template="formCreateAccount.cfm">
				<cfelse>
					<cfinclude template="createAccountLDAP.cfm">
					<cfif not up2snuff>
						<cfinclude template="incError.cfm">
					<cfelse>
						<cfif not goodCredential>
							<cfinclude template="formCreateAccount.cfm">
						<cfelse>
							<cfscript>
								cnA = ListToArray(#Trim(StripCR(Person.cn))#, ", ");
								UserName = Left(Person.mail, Evaluate(Find("@", Person.mail) - 1));
								Email = Trim(StripCR(Person.mail));
								LastName = cnA[1];
								FirstName = cnA[2];
								tempPassword = Left(Ucase(Hash(Person.mail)), 12) & RandRange(1000000, 9999999);
								Title = Trim(StripCR(Person.title));
								Telephone = Trim(StripCR(Person.telephoneNumber));
								CampusAddress = Trim(StripCR(Person.uclaPostalAddress));
								MailCode = Trim(StripCR(Person.postalCode));
								// initialize variables for uspGetAccount stored procedure
								LibID = 0;
								UserName = UserName;
								Password = "";
							</cfscript>
							<cfinclude template="uspGetAccount.cfm">
							<cfif not up2snuff>
								<cfinclude template="incError.cfm">
							<cfelse>
								<cfif Account.ExistingUsers gt 0>
									<cfscript>
										up2snuff = 0;
										em = "User name '" & UserName & "' already exists in the SIA Database.";
									</cfscript>
									<cfinclude template="formCreateAccount.cfm">
								<cfelse>
									<cfinclude template="createFileDirectory.cfm">
									<cfif not up2snuff>
										<cfinclude template="incError.cfm">
									<cfelse>
										<cfinclude template="uspCreateAccount.cfm">
										<cfif not up2snuff>
											<cfinclude template="incError.cfm">
										<cfelse>
											<cfinclude template="createAccountMail.cfm">
											<cfif not up2snuff>
												<cfinclude template="incError.cfm">
											<cfelse>
												<cfscript>
													StructClear(FORM);
												</cfscript>
												<cflocation url="createAccountConfirm.cfm" addtoken="yes">
											</cfif>
										</cfif>
									</cfif>
								</cfif>
							</cfif>
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">
