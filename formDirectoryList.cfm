<form action="directoryExe.cfm" method="post" name="getPerson">
	<span class="dataSectionTitle"><cfoutput>#Person.RecordCount#</cfoutput> directory entries found</span>
	<div class="data">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<cfoutput query="Person">
				<cfset class="#IIF(Person.CurrentRow eq 1, DE('first'), DE('rest'))#">
				<tr>
					<td class="#class#"><input name="uid" type="radio" value="#Person.uid#"> #Person.cn#</td>
				</tr>
			</cfoutput>
		</table>
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<form action="updateActivity.cfm" method="post">
						<input type="submit" class="mainControl" value="Update Activity">
					</td>
					<td width="12">&nbsp;</td>
					<td>
						<input type="button" class="mainControl" onClick="JavaScript:history.back();"  value="&lt;&lt; Back">
					</form>
				</td>
			</tr>
		</table>
	</div>

