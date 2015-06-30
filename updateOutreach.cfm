<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.OutID") or not isNumeric(FORM.OutID))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
			OutID = FORM.OutID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
// initialize variables for uspGetOutreach stored procedure
			OutID = OutID;
			LibID = 0;
			CntctID = 0;
			DeptID = 0;
			StatID = 0;
			UID = 0;
			sDT = '';
			eDT = '';
			FiscalY = 0;
		</cfscript>
		<cfinclude template="uspGetOutreach.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
		// initialize variables for uspGetContact stored procedure
				LibID = 0;
				CntctID = Outreach.ContactID;
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
				<cfinclude template="formOutreach.cfm">
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfscript>
		pageTitle = "Error";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.OutID") or not isNumeric(FORM.OutID))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
			OutID = FORM.OutID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
			up2snuff = 1;
// initialize variables for uspGetOutreach stored procedure
			OutID = OutID;
			LibID = 0;
			CntctID = 0;
			DeptID = 0;
			StatID = 0;
			UID = 0;
			sDT = '';
			eDT = '';
			FiscalY = 0;
		</cfscript>
		<cfinclude template="uspGetOutreach.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="incCheckForm.cfm">
			<cfif missingRequired>
				<cfinclude template="formOutreach.cfm">
			<cfelse>
				<cfinclude template="incCheckDataFormat.cfm">
				<cfif not up2snuff>
					<cfinclude template="formOutreach.cfm">
				<cfelse>
					<cfinclude template="uspUpdateOutreach.cfm">
					<cfif not up2snuff>
						<cfinclude template="formOutreach.cfm">
					<cfelse>
						<cflocation url="outreachLog.cfm?OutID=#OutID#" addtoken="no">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">