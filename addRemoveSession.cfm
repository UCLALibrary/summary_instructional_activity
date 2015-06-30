<cfinclude template="authenticateExe.cfm">
<cfscript>
	pageTitle = "Error!";
	up2snuff = 0;
	em = 'Error!';
// check required variables
	if (not isDefined("FORM.SessID") and
	    not isDefined("URL.SessID")) {
		em = "Invalid or missing parameters";	
	}
	else if ((isDefined("FORM.SessID") and not isNumeric(FORM.SessID)) or
			 (isDefined("URL.SessID") and not isNumeric(URL.SessID))) {
		em = "Invalid or missing parameters";
	}
	else {
		up2snuff = 1;
	}
</cfscript>
<cfif not up2snuff>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
<cfelse>
	<cfscript>
		if (isDefined("FORM.SessID")) {
			SessID = FORM.SessID;
		}
		else if (isDefined("URL.SessID")) {
			SessID = URL.SessID;
		}
		else {
			SessID = 0;
		}
	</cfscript>			
	<cfif not isDefined("FORM.new") or (isDefined("FORM.new") and FORM.new neq "1")>
		<cfscript>
// initialize variables for uspGetContact stored procedure
			LibID = LibID;
			CntctID = 0;
			StatID = 0;
			DeptID = 0;
			SessID = SessID;
			ActID = ActID;
			MatID = MatID;
			UID = 0;
			sDT = '';
			eDT = '';
			FiscalY = 0;
			if ((isDefined("FORM.Add") and FORM.Add neq "0") or (isDefined("URL.Add") and URL.Add neq "0")){
				Set = "neg";
			}
			else {
				Set = "pos";
			}
		</cfscript>
		<cfinclude template="uspGetClassroom.cfm">
	</cfif>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfif (isDefined("FORM.Add") and FORM.Add neq "0") or
		      (isDefined("URL.Add") and URL.Add neq "0")>
			<cfif Contact.RecordCount eq 0>
				<cfinclude template="formContact.cfm">
			<cfelse>
				<cfinclude template="formContactList.cfm">
			</cfif>	
		</cfif>
		<cfif isDefined("FORM.AddRem")>
			<cfinclude template="formContactAddRemSwitch.cfm">
		</cfif>
		<cfif (isDefined("FORM.Add") and FORM.Add eq "0") or
		      (isDefined("URL.Add") and URL.Add eq "0")>
			<cfinclude template="formContactList.cfm">
		</cfif>				
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">