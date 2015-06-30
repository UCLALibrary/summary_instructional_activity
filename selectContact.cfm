<cfheader name = "Expires" value = "#Now()#">
<cfif not isDefined("URL.formName")>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
		<head>
			<title>SIA Database</title>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			<link href="css/global.css" rel="stylesheet" type="text/css">
			<script language="JavaScript" type="text/javascript">
				<!--
					setTimeout('window.close()',1000);
				//-->
			</script>
		</head>
		<body>
			<div style="position:absolute;top:50%;width:100%;text-align:center;">
				<strong>Error!</strong>
			</div>
		</body>
	</html>
	<cfabort>
<cfelse>
	<cfscript>
		formName = URL.formName;
		displayName = URL.displayName;
		valueName = URL.valueName;
		cctIDs = URL.cctIDs;
		up2snuff = 1;
	</cfscript>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
		<head>
			<title>SIA Database</title>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			<link href="css/global.css" rel="stylesheet" type="text/css">
		</head>
		<body style="margin:0;background-color:#FFFFFF;">
			<script language = "JavaScript" type="text/javascript">
				<!--
					// function to populate the date on the form and to close this window. --->
					function ShowContact(CnctName, CnctID)
					{
						<cfoutput>
							eval("self.opener.document.#formName#.#displayName#.value = CnctName");
							eval("self.opener.document.#formName#.#valueName#.value = CnctID");
							setTimeout('window.close()',500);
						</cfoutput>
					}
					function SetContacts(localForm)
					{
						var names = "";
						var ids = "";

						for (var i = 0; i < localForm.NameID.length; i++)
						{
							if (localForm.NameID[i].checked)
							{
								var theID = localForm.NameID[i].value.split("~")[0];
								var theName = localForm.NameID[i].value.split("~")[1];
								ids = ids + theID + ",";
								names = names + theName + ";";
							}
						}
						ids = ids.substr(0, ids.length - 1);
						names = names.substr(0, names.length - 1);

						<cfoutput>
							eval("self.opener.document.#formName#.#displayName#.value = names");
							eval("self.opener.document.#formName#.#valueName#.value = ids");
							setTimeout('window.close()',500);
						</cfoutput>
					}
				//-->
			</script>
			<span class="dataSectionTitle"><cfoutput>Add a Contact to this Instructional Session</cfoutput></span>
			<div class="data">
				<p>
					The following contacts currently in the SIA Database are
					available to add to this instructional session.
				</p>
				<!--p>To prevent duplication, contacts you are already associated with do not appear on this list.</p-->
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<th class="columnHeading" colspan="7">Click a letter to see contacts</th>
					</tr>
					<cfoutput>
						<tr valign="top">
							<td><a href="selectContact.cfm?formName=#formName#&displayName=#displayName#&valueName=#valueName#&cctIDs=#cctIDs#&start=A&end=B" class="columnHeading">A</a></td>
							<td><a href="selectContact.cfm?formName=#formName#&displayName=#displayName#&valueName=#valueName#&cctIDs=#cctIDs#&start=B&end=H" class="columnHeading">B-G</a></td>
							<td><a href="selectContact.cfm?formName=#formName#&displayName=#displayName#&valueName=#valueName#&cctIDs=#cctIDs#&start=H&end=M" class="columnHeading">H-L</a></td>
							<td><a href="selectContact.cfm?formName=#formName#&displayName=#displayName#&valueName=#valueName#&cctIDs=#cctIDs#&start=M&end=O" class="columnHeading">M-N</a></td>
							<td><a href="selectContact.cfm?formName=#formName#&displayName=#displayName#&valueName=#valueName#&cctIDs=#cctIDs#&start=O&end=S" class="columnHeading">O-R</a></td>
							<td><a href="selectContact.cfm?formName=#formName#&displayName=#displayName#&valueName=#valueName#&cctIDs=#cctIDs#&start=S&end=T" class="columnHeading">S</a></td>
							<td><a href="selectContact.cfm?formName=#formName#&displayName=#displayName#&valueName=#valueName#&cctIDs=#cctIDs#&start=T&end=a" class="columnHeading">T-Z</a></td>
						</tr>
						<tr><td colspan="7">&nbsp;</td></tr>
					</cfoutput>
				</table>
				<cfif IsDefined("URL.start")>
					<cfquery name="Contacts" datasource="#APPLICATION.dsn#">
						SELECT
							vC.ContactID,
							SIA.dbo.replace_apostrophe(vC.Contact) AS Contact,
							vC.Department,
							vC.ContactStatus,
							vC.Unit
						FROM   vContact vC
						WHERE
							<cfif URL.start neq 'T'>
								vC.LastName BETWEEN '#URL.start#' AND '#URL.end#'
							<cfelse>
								vC.LastName >= '#URL.start#'
							</cfif>
						ORDER BY vC.LastName, vC.FirstName
					</cfquery>
					<!---cftry>
						<cfstoredproc procedure="uspGetAlphaContact" datasource="#APPLICATION.dsn#">
							<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Start" value="#URL.start#" null="no">
							<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@End" value="#URL.end#" null="no">
							<cfprocresult name="Contacts">
						</cfstoredproc>
						<cfcatch type="Database">
							<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
							<cfscript>
								up2snuff = 0;
							</cfscript>
						</cfcatch>
					</cftry>
					<cfif not up2snuff>
						<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
					<cfelse--->
						<cfoutput>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<form action="addContact.cfm" method="post" name="add">
											<input type="submit" name="submit" value="Add a New Contact">
											<input type="hidden" name="formName" value="#formName#">
											<input type="hidden" name="displayName" value="#displayName#">
											<input type="hidden" name="valueName" value="#valueName#">
											<input type="hidden" name="adding" value="0">
										</form>
									</td>
								</tr>
								<tr><td>&nbsp;</td></tr>
							</table>
						</cfoutput>
						<form action="" method="" name="CctList" id="CctList" onSubmit="SetContacts(CctList)">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="2">
										<input type="button" name="Submit" class="mainControl" style="width:100px;" value="Add" onClick="javascript:SetContacts(CctList);">
									</td>
									<td colspan="2">
										<input type="reset" class="mainControl" style="width:100px;" value="Cancel"/>
									</td>
								</tr>
								<tr><td colspan="4">&nbsp;</td></tr>
								<tr valign="top">
									<th nowrap>Name</th>
									<th nowrap>Department</th>
									<th nowrap>Status</th>
									<th nowrap>Unit</th>
								</tr>
								<cfoutput query="Contacts" group="ContactID">
									<cfset class="#IIF(Contacts.CurrentRow eq 1, DE('first'), DE('rest'))#">
									<tr valign="top">
										<td class="#class#">
											<a href='javascript:ShowContact("#Contacts.Contact#",#Contacts.ContactID#)'>#Contacts.Contact#</a>
											<!---input name="NameID" type="checkbox" value="#Contacts.ContactID#~#Contacts.Contact#"
												<cfif IsDefined("URL.cctIDs") and URL.cctIDs neq "NULL" and URL.cctIDs neq "undefined">
													<cfloop index="theCct" list="#URL.cctIDs#">
														<cfif Contacts.ContactID eq theCct>
														checked
														</cfif>
													</cfloop>
												</cfif>
											>#Contacts.Contact#--->
										</td>
										<td class="#class#">
											<cfif Contacts.Department neq "">#Contacts.Department#<cfelse>#APPLICATION.nullCaption#</cfif>
										</td>
										<td class="#class#">
											<cfif Contacts.ContactStatus neq "">#Contacts.ContactStatus#<cfelse>#APPLICATION.nullCaption#</cfif>
										</td>
										<td class="#class#"><cfif Contacts.Unit neq "">#Contacts.Unit#<cfelse>--</cfif></td>
									</tr>
								</cfoutput>
								<tr><td colspan="4">&nbsp;</td></tr>
								<tr>
									<td colspan="2">
										<input type="button" name="Submit" class="mainControl" style="width:100px;" value="Add" onClick="javascript:SetContacts(CctList);">
									</td>
									<td colspan="2">
										<input type="reset" class="mainControl" style="width:100px;" value="Cancel"/>
									</td>
								</tr>
							</table>
						</form>
						<cfoutput>
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr><td>&nbsp;</td></tr>
								<tr>
									<td>
										<form action="addContact.cfm" method="post" name="add">
											<input type="submit" name="submit" value="Add a New Contact">
											<input type="hidden" name="formName" value="#formName#">
											<input type="hidden" name="displayName" value="#displayName#">
											<input type="hidden" name="valueName" value="#valueName#">
											<input type="hidden" name="adding" value="0">
										</form>
									</td>
								</tr>
							</table>
						</cfoutput>
					<!---/cfif--->
				</cfif>
			</div>
		</body>
	</html>
</cfif>