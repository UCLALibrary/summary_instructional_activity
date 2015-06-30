<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		if (not isDefined("FORM.CntctID")or not isNumeric(FORM.CntctID))
		{
			up2snuff = 0;
		}
		else
		{
			CntctID = FORM.CntctID;
			up2snuff = 1;
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
			<cfinclude template="formOutreach.cfm">
		</cfif>
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		if (not isDefined("FORM.CntctID")or not isNumeric(FORM.CntctID))
		{
			up2snuff = 0;
		}
		else
		{
			CntctID = FORM.CntctID;
			up2snuff = 1;
		}
	</cfscript>
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
				<cfinclude template="uspAddNewOutreach.cfm">
				<cfif not up2snuff>
					<cfinclude template="formOutreach.cfm">
				<cfelse>
					<cflocation url="contact.cfm?CntctID=#CntctID#" addtoken="no">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
</cfif>
<cfinclude template="incEnd.cfm">