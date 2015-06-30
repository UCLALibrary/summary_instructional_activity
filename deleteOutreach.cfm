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
			<cfif SESSION.LibID neq Outreach.DBRCreatorID>
				<cfinclude template="incDenyDelete.cfm">
			<cfelse>
				<cfinclude template="formDeleteOutreach.cfm">
				<cfinclude template="incOutreachLog.cfm">
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if (not isDefined("FORM.OutID") or not isDefined("FORM.CntctID"))
		{
			em = "Invalid or missing contact ID value";
		}
		else
		{
			OutID = FORM.OutID;
			CntctID = FORM.CntctID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="uspDeleteOutreach.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cflocation url="contact.cfm?CntctID=#CntctID#" addtoken="no">
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">