<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfif isDefined("FORM.addRemClass")>
		<cfscript>
			if (not isDefined("FORM.SessID") or not isDefined("FORM.ActID"))
			{
				up2snuff = 0;
				em = "Invalid or missing parameters";
			}
			else
			{
				up2snuff = 1;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="formClassroomAddRemSwitch.cfm">
		</cfif>
	<cfelseif isDefined("FORM.Add")>
		<cfscript>
			if (not isDefined("FORM.SessID") or not isDefined("FORM.ActID"))
			{
				up2snuff = 0;
				em = "Invalid or missing parameters";
			}
			else
			{
				if (FORM.Add neq "0")
				{
					Add = "1";
				}
				else
				{
					Add = "0";
				}
				SessID = FORM.SessID;
				ActID = FORM.ActID;
				up2snuff = 1;
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetClassroom
				ClassID = 0;
				SessID = SessID;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetClassroom.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfif Classroom.RecordCount eq 0>
					<cfinclude template="formClassroom.cfm">
				<cfelse>
					<cfinclude template="formClassroomList.cfm">
				</cfif>
			</cfif>
		</cfif>
	<cfelseif isDefined("URL.Add")>
		<cfscript>
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
				// initialize variables for uspGetClassroom
				ClassID = 0;
				SessID = SessID;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetClassroom.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="formClassroomList.cfm">
			</cfif>
		</cfif>
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		if (not isDefined("FORM.SessID"))
		{
			em = "Invalid or missing parameters";
			up2snuff = 0;
			missingRequired = 0;
		}
		else
		{
			SessID = FORM.SessID;
			ActID = FORM.ActID;
		}
		if ((FORM.Submit eq "Assign Selected" or FORM.Submit eq "Remove Selected") and (not isDefined("FORM.ClassID")))
		{
			up2snuff = 0;
			missingRequired = 1;
			if (Add eq "1")
			{
				em = "You must select a new classroom to assign to this instructional session.";
			}
			else if (Add eq "0")
			{
				em = "You must select a classroom to remove from this instructional session.";
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
			if ((FORM.Submit eq "Change to Selected") or (FORM.Submit eq "Assign Selected"))
			{
				Add = 1;
			}
			else
			{
				Add = 0;
			}
		}
	</cfscript>
	<cfif not up2snuff and not missingRequired>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
			up2snuff = 1;
			// initialize variables for uspGetClassroom
			ClassID = 0;
			SessID = SessID;
			if (Add neq "0")
			{
				Set = "neg";
			}
			else
			{
				Set = "pos";
			}
		</cfscript>
		<cfif FORM.Submit eq "Add New Classroom">
			<cflocation url="addNewClassroom.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
		<cfelseif FORM.Submit eq "Cancel">
			<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
		<cfelse>
			<cfinclude template="uspGetClassroom.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfif missingRequired>
					<cfinclude template="formClassroomList.cfm">
				</cfif>
				<cfscript>
					// initialize variables for uspAddClassroom and uspRemove Classroom stored procedures
					SessID = FORM.SessID;
					ActID = FORM.ActID;
					ClassID = FORM.ClassID;
					LibID = SESSION.LibID;
				</cfscript>
				<cfif Add eq "1">
					<cfinclude template="uspAddClassroom.cfm">
				<cfelseif Add eq "0">
					<cfinclude template="uspRemoveClassroom.cfm">
				</cfif>
				<cfif not up2snuff>
					<cfinclude template="formClassroomList.cfm">
				<cfelse>
					<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
</cfif>