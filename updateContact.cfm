<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if (not isDefined("FORM.CntctID") or not isNumeric(FORM.CntctID))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
			CntctID = FORM.CntctID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
			// initialize variables for uspGetContact stored procedure
			LibID = 0;
			CntctID = CntctID;
			StatID = 0;
			DeptID = 0;
			SessID = 0;
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
			<cfinclude template="formContact.cfm">
		</cfif>
	</cfif>
<cfelse>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="contact.cfm?CntctID=#CntctID#" addtoken="no">
	<cfelse>
		<cfscript>
			pageTitle = "Error!";
			up2snuff = 0;
			em = 'Error!';
			// check required variables
			if (not isDefined("FORM.CntctID") or not isNumeric(FORM.CntctID))
			{
				em = "Invalid or missing parameters";
			}
			else
			{
				CntctID = FORM.CntctID;
				up2snuff = 1;
				em = 'None';
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetContact stored procedure
				LibID = 0;
				CntctID = CntctID;
				StatID = 0;
				DeptID = 0;
				SessID = 0;
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
				<cfinclude template="incCheckForm.cfm">
				<cfif missingRequired>
					<cfinclude template="formContact.cfm">
				<cfelse>
					<cfinclude template="incCheckDataFormat.cfm">
					<cfif not up2snuff>
						<cfinclude template="formContact.cfm">
					<cfelse>
						<cfinclude template="uspUpdateContact.cfm">
						<cfif not up2snuff>
							<cfinclude template="formContact.cfm">
						<cfelse>
							<cflocation url="contact.cfm?CntctID=#CntctID#" addtoken="no">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">