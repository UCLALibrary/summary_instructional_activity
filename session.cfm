<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
	// check required variables
	if ((not isDefined("URL.SessID") or not isNumeric(URL.SessID)) or (not isDefined("URL.ActID") or not isNumeric(URL.ActID)))
	{
		em = "Invalid or missing parameters";
	}
	else
	{
		SessID = URL.SessID;
		ActID = URL.ActID;
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
			<cfif Sess.RecordCount eq 0>
				<cfinclude template="incSession.cfm">
			<cfelse>
				<cfscript>
					// initialize variables for uspGetContact stored procedure
					LibID = 0;
					CntctID = 0;
					StatID = 0;
					DeptID = 0;
					SessID = SessID;
					ActID = ActID;
					MatID = 0;
					UID = 0;
					sDT = '';
					eDT = '';
					FiscalY = 0;
					Set = '';
				</cfscript>
				<cfinclude template="uspGetContact.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfscript>
						// initialize variables for uspGetClassroom
						ClassID = 0;
						SessID = SessID;
						Set = 'Pos';
					</cfscript>
					<cfinclude template="uspGetClassroom.cfm">
					<cfif not up2snuff>
						<cfinclude template="incBegin.cfm">
						<cfinclude template="incError.cfm">
					<cfelse>
						<cfscript>
							// initialize variables for uspGetMaterial stored procedure
							MatID = 0;
							MatTypID = 0;
							LibID = 0;
							ActID = ActID;
							CntctID = 0;
							UID = 0;
							sDT = '';
							eDT = '';
							QuartID = 0;
							Yr = 0;
							FiscalY = 0;
							Set = "";
						</cfscript>
						<cfinclude template="uspGetMaterial.cfm">
						<cfif not up2snuff>
							<cfinclude template="incBegin.cfm">
							<cfinclude template="incError.cfm">
						<cfelse>
							<cfscript>
								// initialize variables for uspCheckRelationships stored procedure
								LibID = SESSION.LibID;
								CntctID = 0;
								ActID = ActID;
								SessID = SessID;
								MatID = 0;
								ClassID = 0;
							</cfscript>
							<cfinclude template="uspCheckRelationships.cfm">
							<cfif not up2snuff>
								<cfinclude template="incBegin.cfm">
								<cfinclude template="incError.cfm">
							<cfelse>
								<cfscript>
									//initialize vars for uspGetPresenters proc
									SessID = SessID;
								</cfscript>
								<cfinclude template="uspGetPresenters.cfm">
								<cfif not up2snuff>
									<cfinclude template="incBegin.cfm">
									<cfinclude template="incError.cfm">
								<cfelse>
									<cfscript>
										//initialize vars for uspGetDevelopers proc
										ActID = ActID;
									</cfscript>
									<cfinclude template="uspGetDevelopers.cfm">
									<cfif not up2snuff>
										<cfinclude template="incBegin.cfm">
										<cfinclude template="incError.cfm">
									<cfelse>
										<cfinclude template="incSession.cfm">
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
