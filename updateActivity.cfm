<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if (not isDefined("FORM.ActID") or not isNumeric(FORM.ActID))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
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
			<cfinclude template="formActivity.cfm">
		</cfif>
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="activity.cfm?ActID=#FORM.ActID#" addtoken="no">
	<cfelse>
		<cfscript>
			pageTitle = "Error!";
			up2snuff = 0;
			em = 'Error!';
			// check required variables
			if (not isDefined("FORM.ActID") or not isNumeric(FORM.ActID))
			{
				em = "Invalid or missing parameters";
			}
			else
			{
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
				<cfinclude template="incCheckForm.cfm">
				<cfif missingRequired>
					<cfinclude template="formActivity.cfm">
				<cfelse>
					<cfinclude template="incCheckDataFormat.cfm">
					<cfif not up2snuff>
						<cfinclude template="formActivity.cfm">
					<cfelse>
						<cfinclude template="uspUpdateActivity.cfm">
						<cfif not up2snuff>
							<cfinclude template="formActivity.cfm">
						<cfelse>
							<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
</cfif>
<cfinclude template="incEnd.cfm">