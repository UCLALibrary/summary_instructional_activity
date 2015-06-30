<cfscript>
	pageTitle = "Error!";
	em = 'Error!';
	up2snuff = 1;
	missingRequired =0;
</cfscript>
<cfif isDefined("FORM.qs")>
	<cfinclude template="incCheckForm.cfm">
	<cfif missingRequired>
		<cfinclude template="incBeginInfo.cfm">
		<cfinclude template="formDirectory.cfm">
	<cfelse>
		<cfinclude template="directoryExe.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBeginInfo.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfif Person.RecordCount eq 0>
				<cfset pageTitle = "UCLA Directory Search Results">
				<cfinclude template="incBeginInfo.cfm">
				<cfinclude template="formDirectory.cfm">
			<cfelse>
				<cfif Person.RecordCount eq 1>
					<cfset pageTitle = Person.cn>
					<cfinclude template="incBeginInfo.cfm">
					<cfinclude template="incDirectoryEntry.cfm">
				<cfelse>
					<cfscript>
						if (Person.RecordCount gt 1) {
							caption = " People Found in the UCLA Directory";
						}
						else {
							caption = " Person Found in the UCLA Directory";
						}
						
					 </cfscript>
					<cfset pageTitle = Person.RecordCount & caption>
					<cfinclude template="incBeginInfo.cfm">
					<cfinclude template="incDirectoryList.cfm">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfif isDefined("URL.uid")>
		<cfinclude template="directoryExe.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBeginInfo.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfif Person.RecordCount eq 0>
				<cfset pageTitle = "UCLA Directory Search Results">			
				<cfinclude template="incBeginInfo.cfm">
				<cfinclude template="formDirectory.cfm">
			<cfelse>
				<cfset pageTitle = Person.cn>
				<cfinclude template="incBeginInfo.cfm">
				<cfinclude template="incDirectoryEntry.cfm">
			</cfif>
		</cfif>	
	<cfelse>
		<cfset pageTitle = "Search the UCLA Directory">
		<cfinclude template="incBeginInfo.cfm">
		<cfinclude template="formDirectory.cfm">
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">