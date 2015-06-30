<cfinclude template="authenticateExe.cfm">
<cfset StructClear(SESSION)>
<cflock timeout="#CreateTimeSpan(0, 0, 120, 0)#" type="readonly" scope="session">
	<cfset SESSION.isAuthentic = 0>
</cflock>
<cflocation url="index.cfm" addtoken="no">