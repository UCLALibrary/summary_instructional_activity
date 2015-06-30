<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		up2snuff = 1;
	</cfscript>
	<cfif not isDefined("FORM.IsFile") or FORM.IsFile eq "">
		<cfinclude template="formMaterialTypeSwitch.cfm">
	<cfelse>
		<cfinclude template="formMaterial.cfm">
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		if (isDefined("FORM.ActID"))
		{
			ActID = FORM.ActID;
		}
		else
		{
			ActID = 0;
		}
		if (isDefined("FORM.SessID"))
		{
			SessID = FORM.SessID;
		}
		else
		{
			SessID = 0;
		}
	</cfscript>
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
					<cfinclude template="uspAddNewMaterial.cfm">
					<cfif not up2snuff>
						<cfinclude template="formMaterial.cfm">
					<cfelse>
						<cfif ActID neq 0>
							<cflocation url="session.cfm?ActID=#ActID#&SessID=#SessID#" addtoken="no">
						<cfelse>
							<cflocation url="materials.cfm?LibID=#SESSION.LibID#" addtoken="no">
						</cfif>
					</cfif>
				</cfif>
			<cfelse>
				<cfinclude template="uspAddNewMaterial.cfm">
				<cfif not up2snuff>
					<cfinclude template="formMaterial.cfm">
				<cfelse>
					<cfif ActID neq 0>
						<cflocation url="session.cfm?ActID=#ActID#&SessID=#SessID#" addtoken="no">
					<cfelse>
						<cflocation url="materials.cfm?LibID=#SESSION.LibID#" addtoken="no">
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



