<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.ClassID") or not isNumeric(FORM.ClassID)) {
			em = "Invalid or missing parameters";
		}
		else {
			ClassID = FORM.ClassID;
			up2snuff = 1;
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
// initialize variables for uspCheckRelationships stored procedure
			LibID = 0;
			CntctID = 0;
			ActID = 0;
			SessID = 0;
			MatID = 0;
			ClassID = ClassID;
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
// initialize variables for uspGetClassroom
					ClassID = ClassID;
					SessID = 0;
					Set = 'One';
				</cfscript>
				<cfinclude template="uspGetClassroom.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfinclude template="formDeleteClassroom.cfm">
					<cfinclude template="incClassroom.cfm">
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
		if (not isDefined("FORM.ClassID") or not isNumeric(FORM.ClassID)) {
			em = "Invalid or missing parameters";
		}
		else {
			ClassID = FORM.ClassID;
			up2snuff = 1;
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfinclude template="uspDeleteClassroom.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cflocation url="classrooms.cfm" addtoken="no">
		</cfif>
	</cfif>	
</cfif>
<cfinclude template="incEnd.cfm">