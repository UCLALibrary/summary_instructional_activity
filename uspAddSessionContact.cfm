<cfparam name="InstrID" default="0">
<cfparam name="SessID" default="0">
<cfscript>
if (InstrID neq 0) {
	InstrID = InstrID;
}
else {
	InstrID = SESSION.InstrID;
}
if (SessID neq 0) {
	SessID = SessID;
}
else {
	SessID = SESSION.SessID;	
}
</cfscript>

<cfstoredproc procedure="uspAddSessionContact" datasource="#APPLICATION.dsn#">
	<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@InstrID" value="#InstrID#" null="no">
	<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#SessID#" null="no">
	<cfprocparam type="Out" cfsqltype="CF_SQL_INTEGER" variable="NewID" dbvarname="@NewID" null="yes">
</cfstoredproc>
<cflocation url="addActivity.cfm?exe=revActMat" addtoken="no">