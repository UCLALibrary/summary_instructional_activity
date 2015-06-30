<!--

user clicks add presenter/developer button on session form
window pops up
page header says select presenters/developers per request url
librarians get listed as checkboxes
librarian who matches user is default checked
user selects 1+ librarians & submits
javascript loops through checked names, splits name & id, adds each to string: ; seperator for names, , for ids
pass back lists of names/ids to session form fiels ala contact select

-->
<cftry>
	<cfstoredproc procedure="uspListLibrarians" datasource="#APPLICATION.dsn#">
		<cfprocresult name="Librarians">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset up2snuff = 0>
		<cfset em = "Database query error">
	</cfcatch>
</cftry>
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
				//--->
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
					function SetLibs(localForm)
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
			<span class="dataSectionTitle">
				<cfoutput>
					Add <cfif URL.type eq "pres">Presenter(s)<cfelse>Developer(s)</cfif> to this Instructional Session
				</cfoutput>
			</span><br/><br/>
			<form action="" method="" name="LibList" id="LibList" onSubmit="SetLibs(LibList)">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2">
							<input type="button" name="Submit" class="mainControl" style="width:100px;" value="Add" onClick="javascript:SetLibs(LibList);">
						</td>
						<td>
							<input type="reset" class="mainControl" style="width:100px;" value="Cancel"/>
						</td>
					</tr>
					<tr><td colspan="3">&nbsp;</td></tr>
					<tr valign="top">
						<cfoutput>
							<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
							<th nowrap>Name</th>
							<th nowrap>Unit</th>
						</cfoutput>
					</tr>
					<cfset x = 0>
					<cfoutput query="Librarians" group="LibrarianID">
						<cfset class="#IIF(Librarians.CurrentRow eq 1, DE('first'), DE('rest'))#">
						<tr valign="top">
							<td class="#class#">
								<input name="NameID" type="checkbox" value="#Librarians.LibrarianID#~#Librarians.Librarian#"
									<cfif IsDefined("URL.cctIDs") and URL.cctIDs neq "NULL" and URL.cctIDs neq "undefined">
										<cfloop index="theCct" list="#URL.cctIDs#">
											<cfif Librarians.LibrarianID eq theCct>
											checked
											</cfif>
										</cfloop>
									<cfelseif IsDefined("URL.cctIDs") and URL.cctIDs eq "undefined" and Librarians.LibrarianID eq SESSION.LibID>checked
									</cfif>
								>
							</td>
							<td class="#class#"><a href="JavaScript:newWindow('infoLibrarian.cfm?LibID=#Librarians.LIbrarianID#','740','300','20','25','Librarian');">#Librarians.Librarian#</a></td><!---<cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>--->
							<td class="#class#">#Librarians.Unit#</td>
						</tr>
						<cfset x = x + 1>
					</cfoutput>
					<tr><td colspan="3">&nbsp;</td></tr>
					<tr>
						<td colspan="2">
							<input type="button" name="Submit" class="mainControl" style="width:100px;" value="Add" onClick="javascript:SetLibs(LibList);">
						</td>
						<td>
							<input type="reset" class="mainControl" style="width:100px;" value="Cancel"/>
						</td>
					</tr>
				</table>
			</form>
		</body>
	</html>
</cfif>