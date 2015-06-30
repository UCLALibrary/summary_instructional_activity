<!--
first call: display input form;
on submit, execute uspAddNewContact & execute JS to populate session form
-->
<cfinclude template="authenticateExe.cfm">
<cfscript>
	formName = FORM.formName;
	displayName = FORM.displayName;
	valueName = FORM.valueName;
	up2snuff = 1;
</cfscript>
<cfif isDefined("FORM.adding")>
	<cfif not FORM.adding>
		<cfinclude template="formContactPopup.cfm">
	<cfelse>
		<cfscript>
			up2snuff = 1;
		</cfscript>
		<cfinclude template="incCheckForm.cfm">
		<cfif missingRequired>
			<cfinclude template="formContactPopup.cfm">
		<cfelse>
			<cfinclude template="incCheckDataFormat.cfm">
			<cfif not up2snuff>
				<cfinclude template="formContactPopup.cfm">
			<cfelse>
				<cfinclude template="uspAddNewContact.cfm">
				<cfif not up2snuff>
					<cfinclude template="formContactPopup.cfm">
				<cfelse>
					<cfscript>
						cnctName = FORM.LastName & ', ' & FORM.FirstName;
						cnctID = newCntct;
					</cfscript>
					<cfinclude template="contactSubmit.cfm">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfinclude template="incBeginInfo.cfm">
	<cfinclude template="incError.cfm">
	<cfinclude template="incEnd.cfm">
</cfif>
