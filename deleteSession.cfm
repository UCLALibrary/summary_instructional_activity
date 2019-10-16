<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if (not isDefined("FORM.SessID") or not isNumeric(FORM.SessID))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
			SessID = FORM.SessID;
			up2snuff = 1;
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
			// initialize variables for uspCheckRelationships stored procedure
			LibID = SESSION.LibID;
			CntctID = 0;
			ActID = 0;
			SessID = SessID;
			MatID = 0;
			ClassID = 0;
		</cfscript>
		<cfinclude template="uspCheckRelationships.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfif Relationships.Total gt 0>
				<cfinclude template="incDenyDelete.cfm">
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
					ActID = FORM.ActID;
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
						SessID = FORM.SessID;
						sDT = '';
						eDT = '';
						CntctID = 0;
						DeptID = 0;
						ActID = 0;
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
						<cfscript>
							// initialize variables for uspGetContact stored procedure
							LibID = 0;
							CntctID = 0;
							StatID = 0;
							DeptID = 0;
							SessID = SessID;
							ActID = 0;
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
									ActID = FORM.ActID;
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
											<cfinclude template="formDeleteSession.cfm">
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
<cfelse>
	<cfif Form.Submit eq "Cancel">
		<cflocation url="session.cfm?SessID=#FORM.SessID#&ActID=#FORM.ActID#" addtoken="no">
	<cfelse>
		<cfscript>
			pageTitle = "Error!";
			up2snuff = 0;
			em = 'Error!';
			// check required variables
			if ( ( not isDefined("FORM.SessID") or not isNumeric(FORM.SessID) ) or
			     ( not isDefined("FORM.ActID") or not isNumeric(FORM.ActID) ) )
			{
				em = "Invalid or missing parameters";
			}
			else
			{
				ActID = FORM.ActID;
				SessID = FORM.SessID;
				up2snuff = 1;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="uspDeleteSession.cfm">
			<cfinclude template="uspDeleteActivity.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cflocation url="sessions.cfm?LibID=#SESSION.LibID#&ShowAll=1" addtoken="no">
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">