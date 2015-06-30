<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.MatID") or not isNumeric(FORM.MatID)) {
			em = "Invalid or missing parameters";
		}
		else {
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
// initialize variables for uspGetMaterial stored procedure
			MatID = FORM.MatID;
			MatTypID = 0;
			LibID = 0;
			ActID = 0;
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
			<cfinclude template="formMaterial.cfm">
		</cfif>
	</cfif>
<cfelse>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.MatID") or not isNumeric(FORM.MatID)) {
			em = "Invalid or missing parameters";
		}
		else {
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
// initialize variables for uspGetMaterial stored procedure
			MatID = FORM.MatID;
			MatTypID = 0;
			LibID = 0;
			ActID = 0;
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
			<cfinclude template="incCheckForm.cfm">
			<cfif missingRequired>
				<cfinclude template="formMaterial.cfm">
			<cfelse>
				<cfinclude template="incCheckDataFormat.cfm">
				<cfif not up2snuff>
					<cfinclude template="formMaterial.cfm">
				<cfelse>
					<cfif isDefined("FORM.FileLocation") and FORM.FileLocation neq "">
						<cfinclude template="incUploadFile.cfm">				
						<cfif not up2snuff>
							<cfinclude template="formMaterial.cfm">
						<cfelse>
							<cfinclude template="uspUpdateMaterial.cfm">				
							<cfif not up2snuff>
								<cfinclude template="formMaterial.cfm">
							<cfelse>
								<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
							</cfif>
						</cfif>
					<cfelse>
						<cfinclude template="uspUpdateMaterial.cfm">				
						<cfif not up2snuff>
							<cfinclude template="formMaterial.cfm">
						<cfelse>
							<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">