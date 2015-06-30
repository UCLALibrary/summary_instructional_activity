<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfif isDefined("FORM.SessID")>
		<cfscript>
			SessID = FORM.SessID;
			up2snuff = 1;
			// initialize variables for uspGetSession stored procedure
			LibID = 0;
			SessID = SessID;
			sDT = "";
			eDT = "";
			CntctID = 0;
			DeptID = 0;
			ActID = FORM.ActID;
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
			<cfinclude template="formClassroom.cfm">
		</cfif>
	<cfelseif isDefined("URL.SessID")>
		<cfscript>
			SessID = URL.SessID;
			up2snuff = 1;
			// initialize variables for uspGetSession stored procedure
			LibID = 0;
			SessID = SessID;
			sDT = "";
			eDT = "";
			CntctID = 0;
			DeptID = 0;
			ActID = URL.ActID;
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
			<cfinclude template="formClassroom.cfm">
		</cfif>
	<cfelse>
		<cfscript>
			SessID = 0;
			ActID = 0;
			up2snuff = 1;
		</cfscript>
		<cfinclude template="formClassroom.cfm">
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		if (isDefined("FORM.SessID"))
		{
			SessID = FORM.SessID;
			ActID = FORM.ActID;
		}
		else
		{
			SessID = 0;
		}
		up2snuff = 1;
	</cfscript>
	<cfif FORM.Submit eq "Cancel">
		<cfif SessID neq 0>
			<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
		<cfelse>
			<cflocation url="classrooms.cfm" addtoken="no">
		</cfif>
	<cfelse>
		<cfinclude template="incCheckForm.cfm">
		<cfif missingRequired>
			<cfinclude template="formClassroom.cfm">
		<cfelse>
			<cfinclude template="incCheckDataFormat.cfm">
			<cfif not up2snuff>
				<cfinclude template="formClassroom.cfm">
			<cfelse>
				<cfinclude template="uspAddNewClassroom.cfm">
				<cfif not up2snuff>
					<cfinclude template="formClassroom.cfm">
				<cfelse>
					<cfif SessID neq 0>
						<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
					<cfelse>
						<cflocation url="classroom.cfm?ClassID=#Classroom.ClassID#" addtoken="no">
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