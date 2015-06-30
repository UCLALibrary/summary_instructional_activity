<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfif isDefined("FORM.addRem")>
		<cfscript>
			if ( not isDefined("FORM.ActID") and
			     not isDefined("FORM.SessID") and
			     not isDefined("FORM.MatID") )
			{
				up2snuff = 0;
				em = "Invalid or missing parameters";
			}
			else
			{
				up2snuff = 1;
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
				if (isDefined("FORM.MatID"))
				{
					MatID = FORM.MatID;
				}
				else
				{
					MatID = 0;
				}
			}
		</cfscript>
		<cfinclude template="formLibrarianAddRemSwitch.cfm">
	<cfelseif isDefined("FORM.add")>
		<cfscript>
			if ( not isDefined("FORM.ActID") and
			     not isDefined("FORM.SessID") and
			     not isDefined("FORM.MatID") )
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
				if (isDefined("FORM.MatID"))
				{
					MatID = FORM.MatID;
				}
				else
				{
					MatID = 0;
				}
				// initialize variables for uspGetLibrarian stored procedure
				LibID = 0;
				UID = 0;
				DeptID = 0;
				CntctID = 0;
				ActID = ActID;
				SessID = SessID;
				MatID = MatID;
				Add = "1";
				Set = "neg";
			</cfscript>
			<cfinclude template="uspGetLibrarian.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="formLibrarianList.cfm">
			</cfif>
		</cfif>
	<cfelseif isDefined("FORM.Switch")>
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
			if (isDefined("FORM.MatID"))
			{
				MatID = FORM.MatID;
			}
			else
			{
				MatID = 0;
			}
		</cfscript>
		<cfif FORM.Switch eq "Cancel">
			<cfif ActID neq 0>
				<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no">
			<cfelseif SessID neq 0>
				<cflocation url="session.cfm?SessID=#SessID#" addtoken="no">
			<cfelseif MatID neq 0>
				<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
			</cfif>
		<cfelse>
			<cfscript>
				if ( not isDefined("FORM.ActID") and
					 not isDefined("FORM.SessID") and
					 not isDefined("FORM.MatID") )
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
					up2snuff = 1;
				}
			</cfscript>
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfscript>
					// initialize variables for uspGetLibrarian stored procedure
					LibID = 0;
					UID = 0;
					DeptID = 0;
					CntctID = 0;
					ActID = ActID;
					SessID = SessID;
					MatID = MatID;
					if (Add neq "0")
					{
						Set = "pos";
					}
					else
					{
						Set = "neg";
					}
				</cfscript>
				<cfinclude template="uspGetLibrarian.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfinclude template="formLibrarianList.cfm">
				</cfif>
			</cfif>
		</cfif>
	<cfelseif isDefined("URL.Add")>
		<cfscript>
			if ( ( isDefined("URL.ActID") and not isNumeric(URL.ActID) ) or
			     ( isDefined("URL.SessID") and not isNumeric(URL.SessID) ) or
			     ( isDefined("URL.MatID") and not isNumeric(URL.MatID) ) )
			{
				em = "Invalid or missing parameters";
			}
			else
			{
				up2snuff = 1;
				Add = URL.Add;
				if (isDefined("URL.ActID"))
				{
					ActID = URL.ActID;
				}
				else
				{
					ActID = 0;
				}
				if (isDefined("URL.SessID"))
				{
					SessID = URL.SessID;
				}
				else
				{
					SessID = 0;
				}
				if (isDefined("URL.MatID"))
				{
					MatID = URL.MatID;
				}
				else
				{
					MatID = 0;
				}
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetLibrarian stored procedure
				LibID = 0;
				UID = 0;
				DeptID = 0;
				CntctID = 0;
				ActID = ActID;
				SessID = SessID;
				MatID = MatID;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetLibrarian.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="formLibrarianList.cfm">
			</cfif>
		</cfif>
	</cfif>
<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		if ( not isDefined("FORM.ActID") and
		     not isDefined("FORM.SessID") and
		     not isDefined("FORM.MatID") )
		{
			em = "Invalid or missing parameters";
			up2snuff = 0;
			missingRequired = 0;
		}
		else
		{
			up2snuff = 1;
			missingRequired = 0;
			if (FORM.Submit eq "Add Selected")
			{
				Add = 1;
			}
			else if (FORM.Submit eq "Remove Selected")
			{
				Add = 0;
			}
			else
			{
				Add = -1;
			}
			if (isDefined("FORM.SessID"))
			{
				SessID = FORM.SessID;
			}
			else
			{
				SessID = 0;
			}
			if (isDefined("FORM.ActID"))
			{
				ActID = FORM.ActID;
			}
			else
			{
				ActID = 0;
			}
			if (isDefined("FORM.MatID"))
			{
				MatID = FORM.MatID;
			}
			else
			{
				MatID = 0;
			}
		}
		if ( ( Add neq -1 ) and ( not isDefined("FORM.LibID") ) )
		{
			up2snuff = 0;
			missingRequired = 1;
			if (Add eq "1")
			{
				em = "You must select a librarian to add.";
			}
			else if (Add eq "0")
			{
				em = "You must select a librarian to remove.";
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
			// initialize variables for uspGetLibrarian stored procedure
			LibID = 0;
			UID = 0;
			DeptID = 0;
			CntctID = 0;
			ActID = ActID;
			SessID = SessID;
			MatID = MatID;
			if (Add neq "0")
			{
				Set = "neg";
			}
			else
			{
				Set = "pos";
			}
		</cfscript>
		<cfinclude template="uspGetLibrarian.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfif missingRequired>
				<cfinclude template="formLibrarianList.cfm">
			<cfelse>
				<!---cfscript>
					LibID = FORM.LibID;
				</cfscript--->
				<cfif Add neq "-1">
					<cfif Add eq "1">
						<cfinclude template="uspAddLibrarian.cfm">
					<cfelseif Add eq "0">
						<cfinclude template="uspRemoveLibrarian.cfm">
					</cfif>
					<cfif not up2snuff>
						<cfinclude template="formLibrarianList.cfm">
					<cfelse>
						<cfif ActID neq 0>
							<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no">
						<cfelseif SessID neq 0>
							<cflocation url="session.cfm?SessID=#SessID#" addtoken="no">
						<cfelseif MatID neq 0>
							<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
						<cfelse>
							<cflocation url="contacts.cfm?LibID=#SESSION.LibID#" addtoken="no">
						</cfif>
					</cfif>
				<cfelse>
					<cfif ActID neq 0>
						<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no">
					<cfelseif SessID neq 0>
						<cflocation url="session.cfm?SessID=#SessID#" addtoken="no">
					<cfelseif MatID neq 0>
						<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
					<cfelseif LibID neq 0>
						<cflocation url="contacts.cfm?LibID=#LibID#" addtoken="no">
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