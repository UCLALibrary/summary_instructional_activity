<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.ActID") or not isNumeric(FORM.ActID)) {
			em = "Invalid or missing parameters";
		}
		else {
			ActID = FORM.ActID;
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
			ActID = ActID;
			SessID = 0;
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
					LibID = 0;
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
// initialize variables for uspGetContact stored procedure
						LibID = 0;
						CntctID = 0;
						StatID = 0;
						DeptID = 0;
						SessID = 0;
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
							<cfinclude template="formDeleteActivity.cfm">
							<cfinclude template="incActivity.cfm">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>	
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.ActID") or not isNumeric(FORM.ActID)) {
			em = "Invalid or missing parameters";
		}
		else {
			ActID = FORM.ActID;
			up2snuff = 1;
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="uspDeleteActivity.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cflocation url="activities.cfm?LibID=#SESSION.LibID#" addtoken="no">
		</cfif>
	</cfif>	
</cfif>
<cfinclude template="incEnd.cfm">