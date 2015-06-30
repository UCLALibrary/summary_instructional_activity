<cfinclude template="authenticateExe.cfm">

<!--- page called/loaded without "Submit" variable --->
<cfif not isDefined("FORM.Submit")>
	<!--- load add-remove switch template --->
	<cfif isDefined("FORM.addRem")>
		<cfscript>
			if ( not isDefined( "FORM.ActID" ) and not isDefined( "FORM.SessID" ) and
			     not isDefined( "FORM.MatID" ) and not isDefined( "FORM.LibID" ) )
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
				if (isDefined("FORM.LibID"))
				{
					LibID = FORM.LibID;
				}
				else
				{
					LibID = 0;
				}
			}
		</cfscript>
		<cfinclude template="formContactAddRemSwitch.cfm">
	<!--- process add-remove switch template based on form submit --->
	<cfelseif isDefined("FORM.Add")>
		<cfscript>
			if ( not isDefined( "FORM.ActID" ) and not isDefined( "FORM.SessID" ) and
			     not isDefined( "FORM.MatID" ) and not isDefined( "FORM.LibID" ) )
			{
				up2snuff = 0;
				em = "Invalid or missing parameters";
			}
			else
			{
				if ( FORM.Add neq "0" )
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
		<!--- bad add-remove switch input --->
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
				if (isDefined("FORM.LibID"))
				{
					LibID = FORM.LibID;
				}
				else
				{
					LibID = 0;
				}
				// initialize variables for uspGetContact stored procedure
				LibID = LibID;
				CntctID = 0;
				StatID = 0;
				DeptID = 0;
				SessID = SessID;
				ActID = ActID;
				MatID = MatID;
				UID = 0;
				sDT = '';
				eDT = '';
				FiscalY = 0;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetContact.cfm">
			<!--- bad results from uspGetContact --->
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfif Contact.RecordCount eq 0>
					<cfinclude template="formContact.cfm">
				<cfelse>
					<cfinclude template="formContactList.cfm">
				</cfif><!--- load single-or-multi contact template --->
			</cfif><!--- good or bad from uspGetContact --->
		</cfif><!--- good or bad add-remove switch input based on form submit --->
	<!--- load add-remove switch template based on link click --->
	<cfelseif isDefined("URL.Add")>
		<cfscript>
			if ( (isDefined("URL.LibID") and not isNumeric(URL.LibID)) or
			     (isDefined("URL.ActID") and not isNumeric(URL.ActID)) or
			     (isDefined("URL.SessID") and not isNumeric(URL.SessID)) or
			     (isDefined("URL.MatID") and not isNumeric(URL.MatID)) )
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
				if (isDefined("URL.LibID"))
				{
					LibID = URL.LibID;
				}
				else
				{
					LibID = 0;
				}
			}
		</cfscript>
		<!--- bad add-remove url input --->
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetContact stored procedure
				LibID = LibID;
				CntctID = 0;
				StatID = 0;
				DeptID = 0;
				SessID = SessID;
				ActID = ActID;
				MatID = MatID;
				UID = 0;
				sDT = '';
				eDT = '';
				FiscalY = 0;
				if (Add neq "0")
				{
					Set = "neg";
				}
				else
				{
					Set = "pos";
				}
			</cfscript>
			<cfinclude template="uspGetContact.cfm">
			<!--- bad results from uspGetContact --->
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="formContactList.cfm">
			</cfif><!--- good or bad from uspGetContact --->
		</cfif><!--- good or bad add-remove switch input based on link click --->
	</cfif><!--- add-remove based on link click --->

<cfelseif isDefined("FORM.Submit")>
	<cfscript>
		if ( not isDefined("FORM.ActID") and
		     not isDefined("FORM.SessID") and
		     not isDefined("FORM.MatID") and
		     not isDefined("FORM.LibID") )
		{
			up2snuff = 0;
			missingRequired = 0;
			em = "Invalid or missing parameters";
		}
		else
		{
			if ( FORM.Submit eq "Add Selected" )
			{
				Add = 1;
			}
			else if ( FORM.Submit eq "Remove Selected" )
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
			if (isDefined("FORM.LibID"))
			{
				LibID = FORM.LibID;
			}
			else
			{
				LibID = 0;
			}
		}
		if ( ( Add neq -1 ) and ( not isDefined("FORM.CntctID") ) )
		{
			up2snuff = 0;
			missingRequired = 1;
			if (Add eq "1")
			{
				em = "You must select a contact to add.";
			}
			else if (Add eq "0")
			{
				em = "You must select a contact to remove.";
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
	<!--- bad form input --->
	<cfif not up2snuff and not missingRequired>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
			up2snuff = 1;
			// initialize variables for uspGetContact stored procedure
			LibID = LibID;
			CntctID = 0;
			StatID = 0;
			DeptID = 0;
			SessID = SessID;
			ActID = ActID;
			MatID = MatID;
			UID = 0;
			sDT = '';
			eDT = '';
			FiscalY = 0;
			if (Add neq "0")
			{
				Set = "neg";
			}
			else
			{
				Set = "pos";
			}
		</cfscript>
		<cfinclude template="uspGetContact.cfm">
		<!--- bad return from uspGetContact --->
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<!--- missing input values --->
			<cfif missingRequired>
				<cfinclude template="formContactList.cfm">
			<cfelse>
				<!--- add/remove contact or other action --->
				<cfif Add neq "-1">
					<!--- adding contact --->
					<cfif Add eq "1">
						<cfinclude template="uspAddContact.cfm">
					<cfelseif Add eq "0">
						<cfinclude template="uspRemoveContact.cfm">
					</cfif><!--- add-remove contact --->
					<!--- bad results from add-remove contact --->
					<cfif not up2snuff>
						<cfinclude template="formContactList.cfm">
					<cfelse>
						<!--- determine redirect URL --->
						<!---cfif ActID neq 0>
							<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no"--->
						<cfif SessID neq 0>
							<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
						<cfelseif MatID neq 0>
							<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
						<cfelse>
							<cfif IsDefined("cntctList")>
								<cflocation url="contacts.cfm?LibID=#SESSION.LibID#&cntctList=#cntctList#" addtoken="no">
							<cfelse>
								<cflocation url="contacts.cfm?LibID=#SESSION.LibID#" addtoken="no">
							</cfif>
						</cfif><!--- redirect URL --->
					</cfif><!--- add-remove results --->
				<cfelse>
					<!--- redirect to add new --->
					<cfif FORM.Submit eq "Add a New Contact">
						<cfset NextPage="addNewContact.cfm">
						<!---cfif ActID neq 0>
							<cfset NextPageVName="ActID">
							<cfset NextPageVValue="#ActID#"--->
						<cfif SessID neq 0>
							<cfset NextPageVName="SessID">
							<cfset NextPageVValue="#SessID#&ActID=#ActID#">
						<cfelseif MatID neq 0>
							<cfset NextPageVName="MatID">
							<cfset NextPageVValue="#MatID#">
						<cfelseif LibID neq 0>
							<cfset NextPageVName="LibID">
							<cfset NextPageVValue="#LibID#">
						</cfif>
						<cflocation url="#NextPage#?#NextPageVName#=#NextPageVValue#" addtoken="no">
					<cfelse>
						<!---cfif ActID neq 0>
							<cflocation url="activity.cfm?ActID=#ActID#" addtoken="no"--->
						<cfif SessID neq 0>
							<cflocation url="session.cfm?SessID=#SessID#&ActID=#ActID#" addtoken="no">
						<cfelseif MatID neq 0>
							<cflocation url="material.cfm?MatID=#MatID#" addtoken="no">
						<cfelseif LibID neq 0>
							<cflocation url="contacts.cfm?LibID=#LibID#" addtoken="no">
						</cfif>
					</cfif><!--- non-add/remove action --->
				</cfif><!--- add/remove or other --->
			</cfif>	<!--- good or bad input --->
		</cfif><!--- good or bad from uspGetContact --->
	</cfif><!--- good or bad input --->


<!--- unknown input --->
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incError.cfm">
</cfif>
<cfinclude template="incEnd.cfm">