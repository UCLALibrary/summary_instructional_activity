<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfif isDefined("FORM.addRem")>
		<cfscript>
			if (not IsDefined("FORM.ActID") or not IsDefined("FORM.SessID"))
			{
				up2snuff = 0;
				em = "Invalid or missing parameters";
			}
			else
			{
				ActID = FORM.ActID;
				SessID = FORM.SessID;
				up2snuff = 1;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="formMaterialAddRemSwitch.cfm">
		</cfif>
	<cfelseif isDefined("FORM.Add")>
		<cfscript>
			if (not IsDefined("FORM.ActID") or not IsDefined("FORM.SessID"))
			{
				up2snuff = 0;
				em = "Invalid or missing parameters";
			}
			else
			{
				Add = FORM.Add;
				ActID = FORM.ActID;
				SessID = FORM.SessID;
				up2snuff = 1;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetMaterial stored procedure
				MatID = 0;
				MatTypID = 0;
				LibID = 0;
				ActID = ActID;
				CntctID = 0;
				UID = SESSION.UID;
				sDT = '';
				eDT = '';
				QuartID = 0;
				Yr = 0;
				FiscalY = 0;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetMaterial.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfif Material.RecordCount eq 0>
					<cfinclude template="formMaterialTypeSwitch.cfm">
				<cfelse>
					<cfif Add neq "0">
						<cfinclude template="formMateriaExstNewSwitch.cfm">
					<cfelse>
						<cfinclude template="formMaterialList.cfm">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	<cfelseif isDefined("FORM.newMat")>
		<cfif FORM.newMat eq "1">
			<cfinclude template="formMaterialTypeSwitch.cfm">
		<cfelse>
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
				up2snuff = 1;
				Add = 1;
				// initialize variables for uspGetMaterial stored procedure
				MatID = 0;
				MatTypID = 0;
				LibID = 0;
				ActID = ActID;
				CntctID = 0;
				UID = SESSION.UID;
				sDT = '';
				eDT = '';
				QuartID = 0;
				Yr = 0;
				FiscalY = 0;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetMaterial.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="formMaterialList.cfm">
			</cfif>
		</cfif>
	<cfelseif isDefined("FORM.isFile")>
		<cfinclude template="formMaterial.cfm">
	<cfelseif isDefined("URL.Add")>
		<cfscript>
			if (isDefined("URL.ActID"))
			{
				if (not isNumeric(URL.ActID))
				{
					up2snuff = 0;
					em = "Invalid or missing parameters";
				}
				else
				{
					ActID = URL.ActID;
					up2snuff = 1;
				}
			}
			else
			{
				ActID = 0;
			}
			if (isDefined("URL.SessID"))
			{
				if (not isNumeric(URL.SessID))
				{
					up2snuff = 0;
					em = "Invalid or missing parameters";
				}
				else
				{
					SessID = URL.SessID;
					up2snuff = 1;
				}
			}
			else
			{
				SessID = 0;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				Add = URL.Add;
				// initialize variables for uspGetMaterial stored procedure
				MatID = 0;
				MatTypID = 0;
				LibID = 0;
				ActID = ActID;
				CntctID = 0;
				UID = SESSION.UID;
				sDT = '';
				eDT = '';
				QuartID = 0;
				Yr = 0;
				FiscalY = 0;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetMaterial.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="formMaterialList.cfm">
			</cfif>
		</cfif>
	<cfelse>
		<cfinclude template="formMaterialTypeSwitch.cfm">
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		if (not isDefined("FORM.MatID") and
			not isDefined("FORM.ActID"))
		{
			em = "Invalid or missing parameters";
			up2snuff = 0;
			missingRequired = 0;
		}
		else
		{
			if (FORM.Submit eq "Add Selected")
			{
				Add = 1;
			}
			else
			{
				Add = 0;
			}
			if (isDefined("FORM.ActID"))
			{
				ActID = FORM.ActID;
			}
			else if (isDefined("URL.ActID"))
			{
				ActID = URL.ActID;
			}
			else
			{
				ActID = 0;
			}
			if (isDefined("FORM.SessID"))
			{
				SessID = FORM.SessID;
			}
			else if (isDefined("URL.SessID"))
			{
				SessID = URL.SessID;
			}
			else
			{
				SessID = 0;
			}
		}
		if (not isDefined("FORM.MatID"))
		{
			up2snuff = 0;
			missingRequired = 1;
			if (FORM.Submit eq "Add Selected")
			{
				em = "You must select a material to add.";
			}
			else if (FORM.Submit eq "Remove Selected")
			{
				em = "You must select a material to remove.";
			}
			else
			{
				em = "Invalid or missing parameters";
			}
		}
		else
		{
			up2snuff = 1;
			missingRequired = 0;
		}
	</cfscript>
	<cfif not up2snuff and not missingRequired>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
		up2snuff = 1;
		// initialize variables for uspGetMaterial stored procedure
		MatID = 0;
		MatTypID = 0;
		LibID = 0;
		ActID = ActID;
		CntctID = 0;
		UID = SESSION.UID;
		sDT = '';
		eDT = '';
		QuartID = 0;
		Yr = 0;
		FiscalY = 0;
		if (Add neq "0")
		{
			Set = "neg";
		}
		else
		{
			Set = "pos";
		}
		</cfscript>
		<cfinclude template="uspGetMaterial.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfif missingRequired>
				<cfinclude template="formMaterialList.cfm">
			<cfelse>
				<cfif Add eq "1">
					<cfscript>
						// initialize variables for uspAddMaterial stored procedure
						ActID = ActID;
						MatID = FORM.MatID;
					</cfscript>
					<cfinclude template="uspAddMaterial.cfm">
					<cfif not up2snuff>
						<cfinclude template="incBegin.cfm">
						<cfinclude template="incError.cfm">
					<cfelse>
						<cflocation url="session.cfm?ActID=#ActID#&SessID=#SessID#" addtoken="no">
					</cfif>
				<cfelseif Add eq "0">
					<cfscript>
						// initialie variables for uspRemoveMaterial stored procedure
						ActID = ActID;
						MatID = FORM.MatID;
					</cfscript>
					<cfinclude template="uspRemoveMaterial.cfm">
					<cfif not up2snuff>
						<cfinclude template="incBegin.cfm">
						<cfinclude template="incError.cfm">
					<cfelse>
						<cflocation url="session.cfm?ActID=#ActID#&SessID=#SessID#" addtoken="no">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
</cfif>