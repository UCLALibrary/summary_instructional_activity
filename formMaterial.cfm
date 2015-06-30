<cfif isDefined("Material.RecordCount") and Material.RecordCount eq 0>
	<cfset pageTitle = "No Instructional Material Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No instructional material found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfscript>
		if (Find("addNewMaterial.cfm", SCRIPT_NAME))
		{
			if (FORM.IsFile)
			{
				pageTitle = "Add a Local File";
			}
			else
			{
				pageTitle = "Add an Online Resource";
			}
		}
		else if (Find("updateMaterial.cfm", SCRIPT_NAME))
		{
			pageTitle = "Update Instructional Material";
		}
		else
		{
			pageTitle = "Instructional Material";
		}
	</cfscript>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incJSShowCalendar.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			var MaterialTitle = new validation('a title', 'MaterialTitle', 'text', 'isText(str)', null);
			var MaterialTypeID = new validation('a material type', 'MaterialTypeID', 'select', 'isSelect(formObj)', null);
			var QuarterID = new validation('a quarter', 'QuarterID', 'select', 'isSelect(formObj)', null);
			<cfif Find("addMaterial", SCRIPT_NAME)>
				<cfif FORM.IsFile>
					var FileLocation = new validation('a file location', 'FileLocation', 'text', 'isText(str)', null);
				<cfelse>
					var URL = new validation('a resource location \(URL\)', 'URL', 'text', 'isText(str)', null);
				</cfif>
			<cfelseif Find("updateMaterial", SCRIPT_NAME)>
				<cfif not Material.IsFile>
					var URL = new validation('a resource location \(URL\)', 'URL', 'text', 'isText(str)', null);
				</cfif>
			</cfif>
			var elts = new Array( MaterialTitle, MaterialTypeID, QuarterID
				<cfif Find("addMaterial", SCRIPT_NAME)>
					<cfif FORM.IsFile>
						, FileLocation
					<cfelse>
						, URL
					</cfif>
				<cfelseif Find("updateMaterial", SCRIPT_NAME)>
					<cfif not Material.IsFile>
						, URL
					</cfif>
				</cfif>
			);
			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please choose ";
			var endRequestAlert = ".";
			var beginInvalidAlert = " is an invalid ";
			var endInvalidAlert = "!";
			var beginFormatAlert = "  Use this format: ";

			function validateForm(form)
			{
				var formEltName = "";
				var formObj = "";
				var str = "";
				var realName = "";
				var alertText = "";
				var firstMissingElt = null;
				var hardReturn = "\r\n";

				for (i=0; i<elts.length; i++)
				{
					formEltName = elts[i].formEltName;
					formObj = eval("form." + formEltName);
					realName = elts[i].realName;

					if (elts[i].eltType == "text")
					{
						str = formObj.value;
						if (eval(elts[i].upToSnuff))
							continue;
						if (str == "")
						{
							if (allAtOnce)
							{
								alertText += beginRequestAlertForText + realName + endRequestAlert + hardReturn;
								if (firstMissingElt == null)
								{
									firstMissingElt = formObj;
								}
							}
							else
							{
								alertText = beginRequestAlertForText + realName + endRequestAlert + hardReturn;
								alert(alertText);
							}
						}
						else
						{
							if (allAtOnce)
							{
								alertText += str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
							}
							else
							{
								alertText = str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
							}
							if (elts[i].format != null)
							{
								alertText += beginFormatAlert + elts[i].format + hardReturn;
							}
							if (allAtOnce)
							{
								if (firstMissingElt == null)
								{
									firstMissingElt = formObj;
								}
							}
							else
							{
								alert(alertText);
							}
						}
					}
					else
					{
						if (eval(elts[i].upToSnuff))
							continue;
						if (allAtOnce)
						{
							alertText += beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
							if (firstMissingElt == null)
							{
								firstMissingElt = formObj;
							}
						}
						else
						{
							alertText = beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
							alert(alertText);
						}
					}
					if (!isIE3)
					{
						var goToObj = (allAtOnce) ? firstMissingElt : formObj;
						if (goToObj.select)
							goToObj.select();
						if (goToObj.focus)
							goToObj.focus();
					}
					if (!allAtOnce)
					{
						return false;
					}
				}
				if (allAtOnce)
				{
					if (alertText != "")
					{
						alert(alertText);
						return false;
					}
				}
				return true; //change this to return true
			}
		//-->
	</script>
	<cfscript>
		if (Find("updateMaterial", SCRIPT_NAME))
		{
			Action = "updateMaterial.cfm";
		}
		else if (Find("addNewMaterial", SCRIPT_NAME))
		{
			Action = "addNewMaterial.cfm";
		}
	</cfscript>
	<cfoutput>
	<form action="#Action#"
		  method="post"
		  enctype="multipart/form-data"
		  name="Material"
		  id="Material"
		  onsubmit="JavaScript:return validateForm(this);">
		<span class="formSectionTitle">#pageTitle#</span>
		<div class="form">
			<cfif not up2snuff>
				<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
			</cfif>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<em class="required">*</em>
						<cfset elementName = "Title">
						<cfset elementLabel = "Title">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="MaterialTitle"
							type="text"
							size="55"
							maxlength="255"
							<cfif isDefined("FORM.MaterialTitle")>
								value="#FORM.MaterialTitle#"
							<cfelseif isDefined("Material.MaterialTitle")>
								value="#Material.MaterialTitle#"
							<cfelse>
								value=""
							</cfif>
						>
					</td>
				</tr>
				<tr>
					<td>
						<em class="required">*</em>
						Material type<br>
						<cfset Lookup = "MaterialType">
						<cfset Header = "-select-">
						<cfinclude template="uspGetLookup.cfm">
						<select name="MaterialTypeID">
							<cfloop query="MaterialType">
								<option value="#MaterialType.MaterialTypeID#"
									<cfif isDefined("FORM.MaterialTypeID") and FORM.MaterialTypeID eq MaterialType.MaterialTypeID>
										selected
									<cfelseif isDefined("Material.MaterialTypeID") and Material.MaterialTypeID eq MaterialType.MaterialTypeID>
										selected
									<cfelse>
									</cfif>
								>#MaterialType.MaterialType#</option>
							</cfloop>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Description<br>
						<textarea name="Description" cols="48" rows="4"><cfif isDefined("FORM.Description")>#FORM.Description#<cfelseif isDefined("Material.Description")>#Material.Description#<cfelse></cfif></textarea>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td nowrap>
						<cfset elementName = "CompletionDT">
						<cfset elementLabel = "Completed on<br>(mm/dd/yyyy)">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							type="text"
							name="CompletionDT"
							size="12"
							maxlength="10"
							<cfif isDefined("FORM.CompletionDT")>
								value="#FORM.CompletionDT#"
							<cfelseif isDefined("Material.CompletionDT")>
								value="#DateFormat(Material.CompletionDT, "mm/dd/yyyy")#"
							<cfelse>
								value=""
							</cfif>
						><br>
						<a href="javascript:ShowCalendar('Material','CompletionDT')">Select Date</a><!--EZ-D8 Select</a><sup>&reg;</sup-->
					</td>
					<td nowrap>
						<em class="required">*</em>
						Quarter<br>
						<cfset Lookup = "Quarter">
						<cfset Header = "-select-">
						<cfinclude template="uspGetLookup.cfm">
						<select name="QuarterID">
							<cfloop query="Quarter">
								<option value="#Quarter.QuarterID#"
									<cfif isDefined("FORM.QuarterID") and FORM.QuarterID eq Quarter.QuarterID>
										selected
									<cfelseif isDefined("Material.QuarterID") and Material.QuarterID eq Quarter.QuarterID>
										selected
									<cfelse>
									</cfif>
								>#Quarter.Quarter#</option>
							</cfloop>
						</select>
					</td>
					<!---td nowrap>
						Development time:<br>
						<input
							name="DevTime"
							type="text"
							style="text-align:right;"
							size="5"
							maxlength="6"
							<cfif isDefined("FORM.DevTime")>
								value="#FORM.DevTime#"
							<cfelseif isDefined("Material.DevTime")>
								value="#Material.DevTime#"
							<cfelse>
								value=""
							</cfif>
						> min.
					</td--->
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<!---tr valign="top">
					<td>
						Development time comments<br>
						<textarea name="DevComment" cols="48" rows="4"><cfif isDefined("FORM.DevComment")>#FORM.DevComment#<cfelseif isDefined("Material.DevComment")>#Material.DevComment#</cfif></textarea>
					</td>
				</tr--->
				<cfif (isDefined("FORM.IsFile") and not FORM.IsFile) or (isDefined("Material.IsFIle") and not Material.IsFile)>
					<tr>
						<td>
							<em class="required">*</em>
							<cfset elementName = "URL">
							<cfset elementLabel = 'Resource location (including "http[s]://")'>
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="URL"
								type="text"
								size="55"
								maxlength="255"
								<cfif isDefined("FORM.URL")>
									value="#FORM.URL#"
								<cfelseif isDefined("Material.URL")>
									value="#Material.URL#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
				<cfelseif (isDefined("FORM.IsFile") and FORM.IsFile) or (isDefined("Material.IsFile") and Material.IsFile)>
					<tr>
						<td>
							<em class="required">*</em>
								File location and name<br>
								<input
									name="FileLocation"
									type="file"
									size="45"
								>
						</td>
					</tr>
					<tr>
						<td>
							Overwrite existing files with same name<br>
							<input name="OverWrite" type="radio" value="1" checked> Yes<br>
							<input name="OverWrite" type="radio" value="0"> No
						</td>
					</tr>
				<cfelse>
				</cfif>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<cfif Find("addNewMaterial", SCRIPT_NAME)>
							<cfif FORM.IsFile>
								<input name="reqElements" type="hidden" value="MaterialTitle,Title;MaterialTypeID,Material resource type;QuarterID, Quarter;FileLocation;File location">
								<input name="IsFile" type="hidden" value="1">
							<cfelse>
								<input name="reqElements" type="hidden" value="MaterialTitle,Title;MaterialTypeID,Material resource type;QuarterID, Quarter;URL;Resource location">
								<input name="IsFile" type="hidden" value="0">
							</cfif>
						<cfelseif Find("updateMaterial", SCRIPT_NAME)>
							<cfif FORM.IsFile>
								<input name="reqElements" type="hidden" value="MaterialTitle,Title;MaterialTypeID,Material resource type;QuarterID, Quarter">
								<input name="IsFile" type="hidden" value="1">
							<cfelse>
								<input name="reqElements" type="hidden" value="MaterialTitle,Title;MaterialTypeID,Material resource type;QuarterID, Quarter;URL;Resource location">
								<input name="IsFile" type="hidden" value="0">
							</cfif>
							<input name="MatID" type="hidden" value="#Material.MaterialID#">
						</cfif>
						<cfif isDefined("ActID")>
							<input name="ActID" type="hidden" value="#ActID#">
						</cfif>
						<cfif isDefined("SessID")>
							<input name="SessID" type="hidden" value="#SessID#">
						</cfif>
						<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
						</form>
					</td>
					<td>
						<cfif (isDefined("ActID") and ActID neq 0) and not Find("addNewMaterial", SCRIPT_NAME)>
							<form action="session.cfm?ActID=#FORM.ActID#&SessID=#FORM.SessID#" method="post">
						<cfelse>
							<form action="materials.cfm?LibID=#SESSION.LibID#" method="post">
						</cfif>
						<input type="submit" class="mainControl" value="Cancel">
						</form>
					</td>
				</tr>
			</table>
		</cfoutput>
	</div>
</cfif>