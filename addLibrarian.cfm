<cftry>
	<cfstoredproc procedure="uspListLibrarians" datasource="#APPLICATION.dsn#">
		<cfprocresult name="Librarians">
	</cfstoredproc>
	<cfcatch type="Database">
		<cfset up2snuff = 0>
		<cfset em = "Database query error">
	</cfcatch>
</cftry>
<cfinclude template="incBegin.cfm">
<body>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
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
					<input name="LibID" type="checkbox" value="#Librarians.LibrarianID#">
				</td>
				<td class="#class#"><a href="JavaScript:newWindow('infoLibrarian.cfm?LibID=#Librarians.LIbrarianID#','740','300','20','25','Librarian');">#Librarians.Librarian#</a></td><!---<cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>--->
				<td class="#class#">#Librarians.Unit#</td>
			</tr>
			<cfset x = x + 1>
		</cfoutput>
	</table>
</body>
</html>
				<!---th nowrap><a href="#sortURL#fld=ln&ord=#ord#" class="columnHeading">Name</a></th>
				<th nowrap><a href="#sortURL#fld=lu&ord=#ord#" class="columnHeading">Unit</a></th--->
