<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		up2snuff = 1;
	</cfscript>
	<cfinclude template="formActivity.cfm">
<cfelseif isDefined("FORM.Submit")>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="activities.cfm?LibID=#SESSION.LibID#" addtoken="no">
	<cfelse>
		<cfscript>
			up2snuff = 1;
		</cfscript>
		<cfinclude template="incCheckForm.cfm">
		<cfif missingRequired>
			<cfinclude template="formActivity.cfm">
		<cfelse>
			<cfinclude template="incCheckDataFormat.cfm">
			<cfif not up2snuff>
				<cfinclude template="formActivity.cfm">
			<cfelse>
				<cfinclude template="uspAddActivity.cfm">
				<cfif not up2snuff>
					<cfinclude template="formActivity.cfm">
				<cfelse>
					<cflocation url="addSession.cfm" addtoken="no">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
</cfif>
<cfinclude template="incEnd.cfm">