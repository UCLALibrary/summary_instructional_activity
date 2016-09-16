<!--

user clicks add department button on session form
window pops up
departments get listed as checkboxes
user selects 1+ departments & submits
javascript loops through checked names, splits name & id, adds each to string: ; seperator for names, , for ids
pass back lists of names/ids to session form fiels ala contact select

-->

<cfset Lookup = "Department">
<cfset Header = "">
<cfinclude template="uspGetLookup.cfm">
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
					function SetDept(localForm)
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
					Add Department | Unit | Group to this Instructional Session
				</cfoutput>
			</span><br/><br/>
			<form action="" method="" name="LibList" id="LibList" onSubmit="SetDept(LibList)">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="2">
							<input type="button" name="Submit" class="mainControl" style="width:100px;" value="Add" onClick="javascript:SetDept(LibList);">
						</td>
						<td>
							<input type="reset" class="mainControl" style="width:100px;" value="Cancel"/>
						</td>
					</tr>
					<tr><td colspan="3">&nbsp;</td></tr>
					<tr valign="top">
						<cfoutput>
							<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
							<th nowrap>Department</th>
						</cfoutput>
					</tr>
					<cfset x = 0>
					<cfoutput query="Department" group="DepartmentID">
						<cfset class="#IIF(Department.CurrentRow eq 1, DE('first'), DE('rest'))#">
						<tr valign="top">
							<td class="#class#">
								<input name="NameID" type="checkbox" value="#Department.DepartmentID#~#Department.Department#"
									<cfif IsDefined("URL.deptIDs") and URL.deptIDs neq "NULL" and URL.deptIDs neq "undefined">
										<cfloop index="theDept" list="#URL.deptIDs#">
											<cfif Department.DepartmentID eq theDept>
											checked
											</cfif>
										</cfloop>
									</cfif>
								>
							</td>
							<td class="#class#">#Department.Department#</a></td>
						</tr>
						<cfset x = x + 1>
					</cfoutput>
					<tr><td colspan="3">&nbsp;</td></tr>
					<tr>
						<td colspan="2">
							<input type="button" name="Submit" class="mainControl" style="width:100px;" value="Add" onClick="javascript:SetDept(LibList);">
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