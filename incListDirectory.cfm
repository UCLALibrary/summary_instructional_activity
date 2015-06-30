<cfoutput query="MaterialFiles">
	<cfif MaterialFiles.Size neq 0>
#MaterialFiles.Name#--#MaterialFiles.Size#--#MaterialFiles.dateLastModified#<br>
	</cfif>
</cfoutput>
