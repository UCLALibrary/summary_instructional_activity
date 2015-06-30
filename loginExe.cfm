<!---cfscript>
	up2snuff = 1;
	if (IsDefined("COOKIE.cookieOn"))
	{
		if (COOKIE.cookieOn eq "1")
		{
			goodCookie = 1;
		}
		else
		{
			goodCookie = 0;
		}
	}
	else
	{
		goodCookie = 0;
	}
</cfscript>
<cfif not goodCookie>
	<cflocation url="index.cfm?action=nc" addtoken="yes">
	<cfabort>
</cfif--->
<cfscript>
	up2snuff = 1;
</cfscript>
<cfif not IsDefined("FORM.UserName") or
      not IsDefined("FORM.Password") or
      Trim(StripCR(FORM.UserName)) eq "" or
      Trim(StripCR(FORM.Password)) eq "">
	<cflocation url="login.cfm?action=deny" addtoken="no">
	<cfabort>
</cfif>
<cfscript>
	// initialize variables for uspGetAccount stored procedure
	LibID = 0;
	UserName = Trim(StripCR(FORM.UserName));
	Password = Trim(StripCR(FORM.Password));
</cfscript>
<cfinclude template="uspGetAccount.cfm">
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfif Account.RecordCount gt 0>
		<cfset fiscalYear="">
		<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>
		<cflock timeout="#CreateTimeSpan(0, 0, 120, 0)#" type="readonly" scope="session">
			<cfset SESSION.isAuthentic = 1>
			<cfset SESSION.LibID = Account.LibrarianID>
			<cfset SESSION.UserName = Account.UserName>
			<cfset SESSION.UserLevelID = Account.UserLevelID>
			<cfset SESSION.Administrator = Account.Administrator>
			<cfset SESSION.UID = Account.UnitID>
			<cfset SESSION.fiscalYear = fiscalYear>
		</cflock>
		<cfscript>
			//ActURL = "";
			SessURL = "";
			CntctURL = "";
			ClassURL = "";
			ReportURL = "selReport.cfm"; //"reports.cfm";
			if (SESSION.UserLevelID eq 1)
			{
				SessURL = "sessions.cfm?LibID=" & SESSION.LibID & "&ShowAll=1";
				//ActURL = "activities.cfm?LibID=" & SESSION.LibID;
				MatURL = "materials.cfm?LibID=" & SESSION.LibID;
				CntctURL = "contacts.cfm?LibID=" & SESSION.LibID;
				ClassURL = "classrooms.cfm";
			}
			else if (SESSION.UserLevelID eq 2)
			{
				SessURL = "sessions.cfm?UID=" & SESSION.UID;
				//ActURL = "activities.cfm?UID=" & SESSION.UID;
				MatURL = "materials.cfm?UID=" & SESSION.UID;
				CntctURL = "contacts.cfm?UID=" & SESSION.UID;
				ClassURL = "classrooms.cfm";
			}
			else if (SESSION.UserLevelID eq 3)
			{
				SessURL = "sessions.cfm?FiscalY=" & fiscalYear;
				//ActURL = "activities.cfm?FiscalY=" & fiscalYear;
				MatURL = "materials.cfm?FiscalY=" & fiscalYear;
				CntctURL = "contacts.cfm?FiscalY=" & fiscalYear;
				ClassURL = "classrooms.cfm";
			}
			else
			{
				SessURL = "sessionsSupe.cfm?FiscalY=" & fiscalYear;
				//ActURL = "activities.cfm?FiscalY=" & fiscalYear;
				MatURL = "materials.cfm?FiscalY=" & fiscalYear;
				CntctURL = "contacts.cfm?FiscalY=" & fiscalYear;
				ClassURL = "classrooms.cfm";
			}

			navArray = ArrayNew(2);
			navArray[1][1] = "mySIA.cfm";
			navArray[1][2] = "mySIA";
			//navArray[2][1] = ActURL;
			//navArray[2][2] = "Activities";
			navArray[2][1] = SessURL;
			navArray[2][2] = "Sessions";
			navArray[3][1] = MatURL;
			navArray[3][2] = "Materials";
			navArray[4][1] = CntctURL;
			navArray[4][2] = "Contacts/Outreach";
			navArray[5][1] = ClassURL;
			navArray[5][2] = "Classrooms";
			navArray[6][1] = ReportURL;
			navArray[6][2] = "Reports";
		</cfscript>
		<cfif Account.NewUser>
			<cflocation url="setUnit.cfm" addtoken="no">
		<cfelse>
			<cfif SESSION.UserLevelID eq 3>
				<cflocation url="selReport.cfm" addtoken="no"><!---reports.cfm--->
			<cfelse>
				<cflocation url="mySIA.cfm" addtoken="no">
			</cfif>
		</cfif>
	<cfelse>
		<cflocation url="index.cfm?action=deny" addtoken="no">
	</cfif>
</cfif>