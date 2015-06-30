<cfinclude template="authenticateExe.cfm">
<cfif isDefined("FORM.caller")>
	<cfif FORM.caller eq "start">
		<cfinclude template="formSessionA.cfm">
	</cfif>
	<cfif FORM.caller eq "formA">
		<cfif Form.Submit eq "Cancel">
			<cflocation url="sessions.cfm?LibID=#SESSION.LibID#&ShowAll=1" addtoken="no">
		<cfelse>
			<cfinclude template="incCheckForm.cfm">
			<cfif missingRequired>
				<cfinclude template="formSessionA.cfm">
			<cfelse>
				<cfinclude template="incCheckDataFormat.cfm">
				<cfif not up2snuff>
					<cfinclude template="formSessionA.cfm">
				<cfelse>
					<cfinclude template="uspAddSessionA.cfm">
					<cfif not up2snuff>
						<cfinclude template="formSessionA.cfm">
					<cfelse>
						<cflocation url="session.cfm?SessID=#SESSION.SessID#&ActID=#SESSION.ActID#">
						<!---cfscript>
							// initialize variables for uspGetActivity stored procedure
							LibID = 0;
							ActID = SESSION.ActID;
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
								LibID = SESSION.LibID;
								SessID = SESSION.SessID;
								sDT = '';
								eDT = '';
								CntctID = 0;
								DeptID = 0;
								ActID = SESSION.ActID;
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
								<cfinclude template="formSessionB.cfm">
							</cfif>
						</cfif--->
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
	<!---cfif FORM.caller eq "formB">
		<cfif Form.Submit eq "Cancel">
			<cflocation url="sessions.cfm?LibID=#SESSION.LibID#&ShowAll=1" addtoken="no">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetActivity stored procedure
				LibID = 0;
				ActID = SESSION.ActID;
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
					LibID = SESSION.LibID;
					SessID = SESSION.SessID;
					sDT = '';
					eDT = '';
					CntctID = 0;
					DeptID = 0;
					ActID = SESSION.ActID;
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
					<cfinclude template="uspAddSessionB.cfm">
					<cfif not up2snuff>
						<cfinclude template="formSessionB.cfm">
					<cfelse>
						<cflocation url="session.cfm?SessID=#SESSION.SessID#&ActID=#SESSION.ActID#">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif--->
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
</cfif>
<cfinclude template="incEnd.cfm">