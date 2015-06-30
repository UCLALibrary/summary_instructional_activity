<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		up2snuff = 1;
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
		if (isDefined("FORM.MatID"))
		{
			MatID = FORM.MatID;
		}
		else if (isDefined("URL.MatID"))
		{
			MatID = URL.MatID;
		}
		else
		{
			MatID = 0;
		}
	</cfscript>
	<cfif ActID neq 0>
		<cfscript>
			// initialize variables for uspGetActivity stored procedure
			LibID = 0;
			ActID = ActID;
			ActTypID = 0;
			DelModID = 0;
			MatID = 0;
			CntctID = 0;
			DBRCID = 0;
			UID = 0;
			sDT = '';
			eDT = '';
			QuartID = 0;
			Yr = 0;
			FiscalY = 0;
		</cfscript>
		<cfinclude template="uspGetActivity.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="formContact.cfm">
		</cfif>
	<!---/cfif--->
	<cfelseif SessID neq 0>
		<cfscript>
			// initialize variables for uspGetSession stored procedure
			LibID = 0;
			SessID = SessID;
			sDT = '';
			eDT = '';
			CntctID = 0;
			DeptID = 0;
			ActID = 0;
			LrCatID = 0;
			AffID = 0;
			QuartID = 0;
			Yr = 0;
			Hr = 0;
			UID = 0;
			FiscalY = 0;
			OutID = 0;
			ClassID = 0;
			ShowAll = 0;
		</cfscript>
		<cfinclude template="uspGetSession.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="formContact.cfm">
		</cfif>
	<!---/cfif--->
	<cfelseif MatID neq 0>
		<cfscript>
			// initialize variables for uspGetSession stored procedure
			MatID = MatID;
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
			<cfinclude template="formContact.cfm">
		</cfif>
	<cfelse>
		<cfinclude template="formContact.cfm">
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
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
		if (isDefined("FORM.MatID"))
		{
			MatID = FORM.MatID;
		}
		else if (isDefined("URL.MatID"))
		{
			MatID = URL.MatID;
		}
		else
		{
			MatID = 0;
		}
	</cfscript>
	<cfif FORM.Submit eq "Cancel">
		<!---cfif ActID neq 0>
			<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no"--->
		<cfif SessID neq 0>
			<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
		<cfelseif MatID neq 0>
			<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
		<cfelseif isDefined("FORM.refURL")>
			<cflocation url="#FORM.refURL#" addtoken="no">
		<cfelse>
			<cflocation url="mySIA.cfm" addtoken="no">
		</cfif>
	<cfelse>
		<cfscript>
			up2snuff = 1;
		</cfscript>
		<cfinclude template="incCheckForm.cfm">
		<cfif missingRequired>
			<cfinclude template="formContact.cfm">
		<cfelse>
			<cfinclude template="incCheckDataFormat.cfm">
			<cfif not up2snuff>
				<cfinclude template="formContact.cfm">
			<cfelse>
				<cfinclude template="uspAddNewContact.cfm">
				<cfif not up2snuff>
					<cfinclude template="formContact.cfm">
				<cfelse>
					<!---cfif ActID neq 0>
						<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no"--->
					<cfif SessID neq 0>
						<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
					<cfelseif MatID neq 0>
						<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
					<cfelse>
						<cflocation url="contacts.cfm?LibID=#SESSION.LibID#&newCntct=#newCntct#" addtoken="no">
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