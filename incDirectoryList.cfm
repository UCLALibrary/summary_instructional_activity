<span class="formSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
<div class="form">
	<cfif Person.RecordCount eq APPLICATION.maxLdap>
		<span><i>This is the maximum number of entries
		retrievable from the directory, and may not represent all directory
		entries for the search term.</i></span>
		<br><br>
	</cfif>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<cfquery dbtype="query" name="SortedPerson">
			SELECT * FROM Person ORDER BY cn
		</cfquery>
		<!---cfoutput query="Person"--->
		<cfoutput query="SortedPerson">
			<cfset class="#IIF(SortedPerson.CurrentRow eq 1, DE('first'), DE('rest'))#">
			<tr>
				<td class="#class#"><a href="directory.cfm?uid=#SortedPerson.uid#">#SortedPerson.cn#</a></td>
			</tr>
		</cfoutput>
	</table>
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td>
				<form action="directory.cfm" method="post">
					<input type="submit" class="mainControl" value="&lt;&lt; Back">
				</form>
			</td>
		</tr>
	</table>
</div>