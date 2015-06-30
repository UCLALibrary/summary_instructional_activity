<cftry>
	<cfstoredproc procedure="uspGetLookup" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" variable="@Lookup" value="#Lookup#" null="no">	
		<cfif isDefined("Header") and Header neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" variable="@Header" value="#Header#" null="no">
		</cfif>
		<cfprocresult name="#Lookup#">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset up2snuff = 0>
		<cfset em = "Lookup error">
	</cfcatch>
</cftry>