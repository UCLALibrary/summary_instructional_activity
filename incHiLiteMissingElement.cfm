<cfoutput>
	<cfif isDefined("missingRequired") and missingRequired>
		<cfif StructKeyExists(missingElements, elementName)>
			<span class="error">#elementLabel#</span>
		<cfelse>
			#elementLabel#
		</cfif>
	<cfelseif isDefined("badDataType") and badDataType eq elementName>
		<span class="error">#elementLabel#</span>
	<cfelse>
		#elementLabel#
	</cfif>
</cfoutput>