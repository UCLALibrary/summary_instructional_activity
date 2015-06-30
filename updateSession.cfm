<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if ((not isDefined("FORM.SessID") or not isNumeric(FORM.SessID)) or (not isDefined("FORM.ActID") or not isNumeric(FORM.ActID)))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
			SessID = FORM.SessID;
			ActID = FORM.ActID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
			// initialize variables for uspGetActivity stored procedure
			if (SESSION.UserLevelID lt 2)
			{
				LibID = SESSION.LibID;
			}
			else
			{
				LibID = 0;
			}
			ActID = ActID;
			ActTypID = 0;
			DelModID = 0;
			MatID = 0;
			CntctID = 0;
			DBRCID = 0;
			UID = 0;
			sDT = '';
			eDT = '';
			QuartID = 0;
			Yr = 0;
			FiscalY = 0;
		</cfscript>
		<cfinclude template="uspGetActivity.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetSession stored procedure
				LibID = SESSION.LibID;
				SessID = SessID;
				sDT = '';
				eDT = '';
				CntctID = 0;
				DeptID = 0;
				ActID = ActID;
				LrCatID = 0;
				AffID = 0;
				QuartID = 0;
				Yr = 0;
				Hr = 0;
				UID = 0;
				FiscalY = 0;
				OutID = 0;
				ClassID = 0;
				ShowAll = 0;
			</cfscript>
			<cfinclude template="uspGetSession.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="formUpdateSession.cfm"><!---formSession.cfm"--->
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if ((not isDefined("FORM.SessID") or not isNumeric(FORM.SessID)) or (not isDefined("FORM.ActID") or not isNumeric(FORM.ActID)))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
			SessID = FORM.SessID;
			ActID = FORM.ActID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
	<cfelse>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetActivity stored procedure
				if (SESSION.UserLevelID lt 2)
				{
					LibID = SESSION.LibID;
				}
				else
				{
					LibID = 0;
				}
				ActID = ActID;
				ActTypID = 0;
				DelModID = 0;
				MatID = 0;
				CntctID = 0;
				DBRCID = 0;
				UID = 0;
				sDT = '';
				eDT = '';
				QuartID = 0;
				Yr = 0;
				FiscalY = 0;
			</cfscript>
			<cfinclude template="uspGetActivity.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfscript>
					// initialize variables for uspGetSession stored procedure
					LibID = 0;
					SessID = SessID;
					sDT = '';
					eDT = '';
					CntctID = 0;
					DeptID = 0;
					ActID = ActID;
					LrCatID = 0;
					AffID = 0;
					QuartID = 0;
					Yr = 0;
					Hr = 0;
					UID = 0;
					FiscalY = 0;
					OutID = 0;
					ClassID = 0;
					ShowAll = 0;
				</cfscript>
				<cfinclude template="uspGetSession.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfinclude template="incCheckForm.cfm">
					<cfif missingRequired>
						<cfinclude template="formUpdateSession.cfm"><!---formSession.cfm"--->
					<cfelse>
						<cfinclude template="incCheckDataFormat.cfm">
						<cfif not up2snuff>
							<cfinclude template="formUpdateSession.cfm"><!---formSession.cfm"--->
						<cfelse>
							<cfinclude template="uspUpdateSession.cfm">
							<cfif not up2snuff>
								<cfinclude template="formUpdateSession.cfm"><!---formSession.cfm"--->
							<cfelse>
								<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
							</cfif>
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">