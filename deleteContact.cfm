<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.CntctID") or not isNumeric(FORM.CntctID)) {
			em = "Invalid or missing parameters";
		}
		else {
			CntctID = FORM.CntctID;
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
			CntctID = CntctID;
			ActID = 0;
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
					<cfinclude template="formDeleteContact.cfm">
					<cfinclude template="incContact.cfm">
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
		if (not isDefined("FORM.CntctID") or not isNumeric(FORM.CntctID)) {
			em = "Invalid or missing parameters";
		}
		else {
			CntctID = FORM.CntctID;
			up2snuff = 1;
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="uspDeleteContact.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cflocation url="contacts.cfm?LibID=#SESSION.LibID#" addtoken="no">
		</cfif>
	</cfif>	
</cfif>
<cfinclude template="incEnd.cfm">