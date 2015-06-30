<!---
// Required variables for uspAddLibrarianContact
LibID;
CntctID;
// Required variables for uspAddActivityContact
LibID;
ActID;
CntctID;
// Required variables for uspAddSessionContact
LibID;
SessID;
CntctID;
// Required variables for uspAddMaterialContact
LibID;
MatID;
CntctID;
--->
<cftry>
	<!---cfif ActID neq 0>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspAddActivityContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop--->
	<cfif SessID neq 0>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspAddActivityContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ActID" value="#FORM.ActID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>

		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspAddSessionContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@SessID" value="#FORM.SessID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>
	<cfelseif MatID neq 0>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspAddMaterialContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@MatID" value="#FORM.MatID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>
	<cfelse>
		<cfloop index="theContact" list="#FORM.CntctID#">
			<cfstoredproc procedure="uspAddLibrarianContact" datasource="#APPLICATION.dsn#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
				<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@CntctID" value="#theContact#">
			</cfstoredproc>
		</cfloop>
	</cfif>
	<cfcatch type="Database">
		<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		<cfscript>
			up2snuff = 0;
			//em = "Database insert error. Please try again.";
		</cfscript>
	</cfcatch>
</cftry>
<cfset cntctArray=ArrayNew(1)>
<cfif up2snuff>
	<cfloop index="theContact" list="#FORM.CntctID#">
		<cfset temp=ArrayAppend(cntctArray, "#theContact#")>
	</cfloop>
	<cfset cntctList=ArrayToList(cntctArray, ",")>
</cfif>