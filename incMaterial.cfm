<cfif Material.RecordCount eq 0>
	<cfset pageTitle = "No Instructional Material Found">
	<cfif Find("infoMaterial.cfm", SCRIPT_NAME)>
		<cfinclude template="incBeginInfo.cfm">
	<cfelse>
		<cfinclude template="incBegin.cfm">
	</cfif>
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">No instructional material found</td>
		</tr>
	</table>
	</div>
<cfelse>
	<cfif not Find("deleteMaterial.cfm", SCRIPT_NAME)>
		<cfset pageTitle = Material.MaterialTitle>
		<cfif Find("infoMaterial.cfm", SCRIPT_NAME)>
			<cfinclude template="incBeginInfo.cfm">
		<cfelse>
			<cfinclude template="incBegin.cfm">
		</cfif>
	</cfif>
	<span class="dataSectionTitle">Instructional Material Information</span>
	<div class="data">
	<cfoutput query="Material" group="MaterialID">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td width="49%">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td width="10%" nowrap class="fieldLabel">Material title:</td>
						<td width="90%" class="fieldValue"><strong>
		<cfif Material.IsFile>
			<a href="#APPLICATION.FilePath##Material.FileDirectory#/#Material.FileName#" target="blank">#Material.MaterialTitle#</a>
		<cfelse>
			<a href="#Material.URL#" target="blank">#Material.MaterialTitle#</a>
		</cfif></strong></td>
					</tr>
		<cfif not Material.IsFile>
						<tr valign="top">
							<td nowrap class="fieldLabel">URL:</td>
							<td class="fieldValue"><cfif not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="#Material.URL#" target="blank">#Material.URL#</a><cfelse>#Material.URL#</cfif></td>
						</tr>
		</cfif>
					<tr valign="top">
						<td nowrap class="fieldLabel">Material type:</td>
						<td class="fieldValue"><cfif not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="materials.cfm?MatTypID=#Material.MaterialTypeID#">#Material.MaterialType#</a><cfelse>#Material.MaterialType#</cfif>
						</td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Description:</td>
						<td class="fieldValue">
		<cfif Material.Description neq "">
			#Material.Description#
		<cfelse>
			#APPLICATION.nullCaption#
		</cfif>
						</td>
					</tr>
		<cfif Material.IsFile>
					<tr valign="top">
						<td nowrap class="fieldLabel">File name:</td>
						<td class="fieldValue"><a href="#APPLICATION.FilePath##Material.FileDirectory#/#Material.FileName#" target="_blank">#Material.FileName#</a></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">File MIME type:</td>
						<td class="fieldValue">#Material.FileContentType#/#Material.FileContentSubType#</td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">File created:</td>
						<td class="fieldValue">#DateFormat(Material.FileCreatedDT, APPLICATION.dateFormat)# #TimeFormat(Material.FileCreatedDT, APPLICATION.timeFormat)#</td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">File updated:</td>
						<td class="fieldValue">#DateFormat(Material.FileUpdatedDT, APPLICATION.dateFormat)# #TimeFormat(Material.FileUpdatedDT, APPLICATION.timeFormat)#</td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">File size:</td>
						<td class="fieldValue">#Round(Evaluate(Material.FileSize / 1000))# KB</td>
					</tr>
		</cfif>
					<tr valign="top">
						<td nowrap class="fieldLabel">Developed for:</td>
						<td class="fieldValue">
		<cfif not IsDefined("Contact")>
			<cfscript>
				// initialize variables for uspGetContact stored procedure
				LibID = 0;
				CntctID = 0;
				StatID = 0;
				DeptID = 0;
				SessID = 0;
				ActID = 0;
				MatID = MatID;
				UID = 0;
				sDT = '';
				eDT = '';
				FiscalY = 0;
				Set = '';
			</cfscript>
			<cfinclude template="uspGetContact.cfm">
		</cfif>
		<cfif Contact.RecordCount neq 0>
			<cfloop query="Contact">
				<cfif not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="contact.cfm?CntctID=#Contact.ContactID#">#Contact.Contact#</a><cfelse>#Contact.Contact#</cfif><br>
			</cfloop>
		<cfelse>
			#APPLICATION.nullCaption#<br>
		</cfif>
		<cfif ("1,5" contains SESSION.UserLevelID)
		      and ListContains(MatEditorID, SESSION.LibID, ",")
			  and (not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ","))>
			<form action="addRemoveContact.cfm" method="post">
			<input name="MatID" type="hidden" value="#MatID#">
			<cfif Contact.RecordCount gt 0>
				<input name="addRem" type="submit" class="subControl" value="Add/Remove Contact">
			<cfelse>
				<input name="add" type="submit" class="subControl" value="Add Contact">
			</cfif>
			</form>
		</cfif>
						</td>
					</tr>

				</table>
			<td width="2%">&nbsp;</td>
			<td width="49%">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td nowrap class="fieldLabel">Developed by:</td>
						<td class="fieldValue"><cfset x = 0><cfoutput><cfif not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="librarian.cfm?LibID=#Material.LibrarianID#">#Material.LibrarianLastName#</a> (<a href="materials.cfm?UID=#Material.UnitID#">#Material.Unit#</a>)<cfelse>#Material.LibrarianLastName# (#Material.Unit#)</cfif><br><cfset x = x + 1></cfoutput>
		<cfif ("1,5" contains SESSION.UserLevelID)
		      and (SESSION.LibID eq DBRCreatorID)
			  and (not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ","))>
			<form action="addRemoveLibrarian.cfm" method="post">
			<input name="MatID" type="hidden" value="#MatID#">
			<cfif x gte 2>
				<input name="addRem" type="submit" class="subControl" value="Add/Remove Developer">
			<cfelse>
				<input name="add" type="submit" class="subControl" value="Add Developer">
			</cfif>
			</form>
		</cfif>
						</td>
					</tr>
					<!---tr valign="top">
						<td nowrap class="fieldLabel">Dev. time:</td>
						<td class="fieldValue"><cfif Material.DevTime neq ""><cfif SESSION.UserLevelID lt 2>#Material.DevTime#<cfelse>#Material.TotalDevTime#</cfif> min.<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Dev. comment:</td>
						<td class="fieldValue"><cfif Material.DevComment neq "">#Material.DevComment#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr--->
					<tr valign="top">
						<td nowrap class="fieldLabel">Completed on:</td>
						<td class="fieldValue"><cfif Material.CompletionDT neq "">#DateFormat(Material.CompletionDT, APPLICATION.dateFormat)#<cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Quarter:</td>
						<td class="fieldValue"><cfif Material.CompletionDT neq "" and Material.Quarter neq ""><cfif not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="materials.cfm?Yr=#DatePart("yyyy", Material.CompletionDT)#&QuartID=#Material.QuarterID#">'#Right(DatePart("yyyy", Material.CompletionDT), 2)# #Material.Quarter#</a><cfelse> '#Right(DatePart("yyyy", Material.CompletionDT), 2)# #Material.Quarter#</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Input on:</td>
						<td class="fieldValue">#DateFormat(Material.DBRCreatedDT, APPLICATION.dateFormat)# #TimeFormat(Material.DBRCreatedDT, APPLICATION.timeFormat)# by <cfif not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="librarian.cfm?LibID=#Material.DBRCreatorID#">#Material.DBRCreator#</a><cfelse>#Material.DBRCreator#</cfif></td>
					</tr>
					<tr valign="top">
						<td nowrap class="fieldLabel">Last updated:</td>
						<td class="fieldValue">#DateFormat(Material.DBRUpdatedDT, APPLICATION.dateFormat)# #TimeFormat(Material.DBRUpdatedDT, APPLICATION.timeFormat)# by <cfif not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")><a href="librarian.cfm?LibID=#Material.DBRUpdaterID#">#Material.DBRUpdater#</a><cfelse>#Material.DBRUpdater#</cfif></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
		<cfif ("1,5" contains SESSION.UserLevelID)
		      and ListContains(MatEditorID, SESSION.LibID, ",")
			  and (not ListContains("infoMaterial.cfm,deleteMaterial.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ","))>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
			<form action="updateMaterial.cfm" method="post">
			<input type="submit" class="mainControl" value="Update Material">
			<input name="MatID" type="hidden" value="#Material.MaterialID#">
			<input name="IsFile" type="hidden" value="#Material.IsFile#">
			<input name="refURL" type="hidden" value="#SCRIPT_NAME#<cfif QUERY_STRING neq "">?#QUERY_STRING#</cfif>">
			</form>
			</td>
			<td width="12">&nbsp;</td>
			<td>
			<form action="deleteMaterial.cfm" method="post">
			<input name="MatID" type="hidden" value="#Material.MaterialID#">
			<input type="submit" class="mainControl" value="Delete Material"
			<cfif (SESSION.LibID neq Material.DBRCreatorID) or (Relationships.Total gt 0)>
				disabled="true"
			</cfif>
			>
			</form>
			</td>
		</tr>
	</table>
		</cfif>
	</cfoutput>
	</div>
</cfif>