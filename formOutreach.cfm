<cfif IsDefined("Outreach.RecordCount") and Outreach.RecordCount eq 0>
	<cfset pageTitle = "No Outreach Log Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="first">No outreach found</td>
			</tr>
		</table>
	</div>
<cfelse>
	<cfscript>
		if (Find("addNewOutreach.cfm", SCRIPT_NAME))
		{
			pageTitle = "Create a New Outreach Log";
		}
		else if (Find("updateOutreach.cfm", SCRIPT_NAME))
		{
			pageTitle = "Update Outreach Log";
		}
		else
		{
			pageTitle = "Outreach Log";
		}
	</cfscript>
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incJSShowCalendar.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			// create a new object for each form element you need to validate
			var OutreachDT = new validation('the date of the outreach activity', 'OutreachDT', 'text', 'isDate(str)', 'mm/dd/yyyy');
			//var Purpose = new validation('purpose of the outreach activity', 'Purpose', 'text', 'isText(str)', null);
			var elts = new Array( OutreachDT ); //, Purpose );
			var allAtOnce = false;
			var beginRequestAlertForText = "Please include ";
			var beginRequestAlertGeneric = "Please choose ";
			var endRequestAlert = ".";
			var beginInvalidAlert = " is an invalid ";
			var endInvalidAlert = "!";
			var beginFormatAlert = "Use the format: ";

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
				//  alert("I am valid!"); //remove this when you use the code
				return true; //change this to return true
			}
		//-->
	</script>
	<cfoutput>
		<cfscript>
			if (Find("updateOutreach", SCRIPT_NAME))
			{
				Action = "updateOutreach.cfm";
			}
			else if (Find("addNewOutreach", SCRIPT_NAME))
			{
				Action = "addNewOutreach.cfm";
			}
		</cfscript>
		<form action="#Action#"
			  method="post"
			  name="Outreach"
			  id="Outreach"
			  onsubmit="JavaScript:return validateForm(this);">
			<span class="formSectionTitle">#pageTitle#</span>
			<div class="form">
				<cfif not up2snuff>
					<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
				</cfif>
				<table border="0" cellpadding="0" cellspacing="0">
					<cfif IsDefined("Contact.RecordCount")>
						<tr valign="top">
							<td colspan="3">
								Outreach to<br>
								<input name="Contact" type="text" disabled="true" value="#Contact.Contact#" size="40" readonly="true">
							</td>
						</tr>
					</cfif>
					<!---tr valign="top">
						<td colspan="2">
							<em class="required">*</em>
							<cfset elementName = "Title">
							<cfset elementLabel = "Activity/course title">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								name="Title"
								type="text"
								size="55"
								maxlength="255"
								<cfif IsDefined("FORM.Title")>
									value="#FORM.Title#"
								<cfelseif IsDefined("Outreach.Title")>
									value="#Outreach.Title#"
								<cfelse>
									value=""
								</cfif>
							>
							&nbsp;
							<a href="http://www.registrar.ucla.edu/schedule/" target="_blank" class="navLink0">Schedule of Classes</a>
						</td>
					</tr--->
					<tr valign="top">
						<td>
							<!--em class="required">*</em-->
							Department<br>
							<cfset Lookup = "Department">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="DepartmentID">
								<cfloop query="Department">
									<option
										value="#Department.DepartmentID#"
											<cfif IsDefined("FORM.DepartmentID") and FORM.DepartmentID eq Department.DepartmentID>
												selected
											<cfelseif IsDefined("Contact.DepartmentID") and Contact.DepartmentID eq Department.DepartmentID>
												selected
											<cfelseif IsDefined("Outreach.DepartmentID") and Outreach.DepartmentID eq Department.DepartmentID>
												selected
											<cfelse>
											</cfif>
										>
										#Department.Department#
									</option>
								</cfloop>
							</select>
						</td>
						<td align="center" valign="top"><b>OR</b></td>
						<td>
							Other department, college, etc.<br>
							<input
								name="FacultyGroup"
								type="text"
								size="25"
								maxlength="255"
								<cfif isDefined("FORM.FacultyGroup")>
									value="#FORM.FacultyGroup#"
								<cfelseif isDefined("Contact.FacultyGroup")>
									value="#Contact.FacultyGroup#"
								<cfelseif isDefined("Outreach.FacultyGroup")>
									value="#Contact.FacultyGroup#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td>
							<em class="required">*</em>Quarter<br>
							<cfset Lookup = "Quarter">
							<cfset Header = "-select-">
							<cfinclude template="uspGetLookup.cfm">
							<select name="QuarterID">
								<cfloop query="Quarter">
									<option value="#Quarter.QuarterID#"
										<cfif IsDefined("FORM.QuarterID") and FORM.QuarterID eq Quarter.QuarterID>
											selected
										<cfelseif IsDefined("Outreach.QuarterID") and Outreach.QuarterID eq Quarter.QuarterID>
											selected
										<cfelse>
										</cfif>
									>#Quarter.Quarter#</option>
								</cfloop>
							</select>
						</td>
						<td>
							<em class="required">*</em>
							<cfset elementName = "OutreachDT">
							<cfset elementLabel = "Outreach date<br>(mm/dd/yyyy)">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<input
								type="text"
								name="OutreachDT"
								size="12"
								maxlength="10"
								<cfif IsDefined("FORM.OutreachDT")>
									value="#FORM.OutreachDT#"
								<cfelseif IsDefined("Outreach.OutreachDT")>
									value="#DateFormat(Outreach.OutreachDT, "mm/dd/yyyy")#"
								<cfelse>
									value=""
								</cfif>
							>
							<a href="javascript:ShowCalendar('Outreach','OutreachDT')">Select Date</a><!--EZ-D8 Select</a><sup>&reg;</sup-->
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr valign="top">
						<td colspan="3">
							<!---em class="required">*</em--->
							<cfset elementName = "Purpose">
							<cfset elementLabel = "Purpose">
							<cfinclude template="incHiLiteMissingElement.cfm"><br>
							<textarea name="Purpose" cols="48" rows="4"><cfif IsDefined("FORM.Purpose")>#FORM.Purpose#<cfelseif IsDefined("Outreach.Purpose")>#Outreach.Purpose#<cfelse></cfif></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td align="right">Outcome:</td>
						<td>
							<cfset Lookup = "OutreachOutcome">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<cfscript>
								splitRow = Ceiling(OutreachOutcome.RecordCount / 2);
							</cfscript>
							<cfset x = 0>
							<cfloop query="OutreachOutcome">
								<cfif x eq splitRow></td><td></cfif>
								<input
									type="checkbox"
									name="Outcome"
									value="#OutreachOutcome.OutreachOutcomeID#"
									<cfif IsDefined("FORM.Outcome")>
										<cfloop index="oID" list="#FORM.Outcome#" delimiters=",">
											<cfif oID eq OutreachOutcome.OutreachOutcomeID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelseif IsDefined("Outreach.Outcome")>
										<cfloop index="oID" list="#Outreach.Outcome#" delimiters=",">#x#
											<cfif oID eq OutreachOutcome.OutreachOutcomeID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelse>
									</cfif>
								>#OutreachOutcome.OutreachOutcome#<br>
								<cfset x = x + 1>
							</cfloop>
							</input>
						</td>
					</tr>
					<tr valign="top">
						<td align="right">&nbsp;</td>
						<td align="left">
							<i>If &quot;Other&quot; please explain:</i>&nbsp;
							<input
								name="OutcomeOther"
								type="text"
								size="55"
								maxlength="255"
								<cfif IsDefined("FORM.OutcomeOther")>
									value="#FORM.OutcomeOther#"
								<cfelseif IsDefined("Outreach.OutcomeOther")>
									value="#Outreach.OutcomeOther#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td align="right">Initiated<br>at/by:</td>
						<td>
							<cfset Lookup = "OutreachInitiate">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<cfscript>
								splitRow = Ceiling(OutreachInitiate.RecordCount / 2);
							</cfscript>
							<cfset x = 0>
							<cfloop query="OutreachInitiate">
								<cfif x eq splitRow></td><td></cfif>
								<input
									type="checkbox"
									name="Initiate"
									value="#OutreachInitiate.OutreachInitiateID#"
									<cfif IsDefined("FORM.Initiate")>
										<cfloop index="iID" list="#FORM.Initiate#" delimiters=",">
											<cfif iID eq OutreachInitiate.OutreachInitiateID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelseif IsDefined("Outreach.Initiate")>
										<cfloop index="iID" list="#Outreach.Initiate#" delimiters=",">#x#
											<cfif iID eq OutreachInitiate.OutreachInitiateID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelse>
									</cfif>
								>#OutreachInitiate.OutreachInitiate#<br>
								<cfset x = x + 1>
							</cfloop>
							</input>
						</td>
					</tr>
					<tr valign="top">
						<td align="right">&nbsp;</td>
						<td align="left">
							<i>If &quot;Other&quot; please explain:</i>&nbsp;
							<input
								name="InitiateOther"
								type="text"
								size="55"
								maxlength="255"
								<cfif IsDefined("FORM.InitiateOther")>
									value="#FORM.InitiateOther#"
								<cfelseif IsDefined("Outreach.InitiateOther")>
									value="#Outreach.InitiateOther#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
					<tr valign="top">
						<td align="right">Contact<br>method:</td>
						<td>
							<cfset Lookup = "OutreachMethod">
							<cfset Header = "">
							<cfinclude template="uspGetLookup.cfm">
							<cfscript>splitRow = Ceiling(OutreachMethod.RecordCount / 2);</cfscript>
							<cfset x = 0>
							<cfloop query="OutreachMethod">
								<cfif x eq splitRow></td><td></cfif>
								<input
									type="checkbox"
									name="Method"
									value="#OutreachMethod.OutreachMethodID#"
									<cfif IsDefined("FORM.Method")>
										<cfloop index="imID" list="#FORM.Method#" delimiters=",">
											<cfif imID eq OutreachMethod.OutreachMethodID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelseif IsDefined("Outreach.Method")>
										<cfloop index="mID" list="#Outreach.Method#" delimiters=",">#x#
											<cfif mID eq OutreachMethod.OutreachMethodID>
												checked
												<cfbreak>
											</cfif>
										</cfloop>
									<cfelse>
									</cfif>
								>#OutreachMethod.OutreachMethod#<br>
								<cfset x = x + 1>
							</cfloop>
							</input>
						</td>
					</tr>
					<tr valign="top">
						<td align="right">&nbsp;</td>
						<td align="left">
							<i>If &quot;Other&quot; please explain:</i>&nbsp;
							<input
								name="MethodOther"
								type="text"
								size="55"
								maxlength="255"
								<cfif IsDefined("FORM.MethodOther")>
									value="#FORM.MethodOther#"
								<cfelseif IsDefined("Outreach.MethodOther")>
									value="#Outreach.MethodOther#"
								<cfelse>
									value=""
								</cfif>
							>
						</td>
					</tr>
				</table>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<cfif ListContains("addNewOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
								<input name="CntctID" type="hidden" value="#CntctID#">
							<cfelse>
								<input name="OutID" type="hidden" value="#OutID#">
							</cfif>
							<input name="reqElements" type="hidden" value="OutreachDT,Date of the outreach activity"><!--;Purpose,Purpose of the outreach activity"-->
							<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
							</form>
						</td>
						<td>
							<cfif ListContains("addNewOutreach.cfm", Replace(Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), "sia",""), ",")>
								<form action="contact.cfm?CntctID=#CntctID#" method="post">
							<cfelse>
								<form action="outreach.cfm?OutID=#OutID#" method="post">
							</cfif>
							<input type="submit" class="mainControl" value="Cancel">
							</form>
						</td>
					</tr>
				</table>
			</cfoutput>
	</div>
</cfif>
