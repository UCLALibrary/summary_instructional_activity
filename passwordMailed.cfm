<span class="formSectionTitle">#pageTitle#</span>
<div class="form">
	<div style="width:50%">
		<cfif isDefined("up2snuff") and not up2snuff>
			<div class="formSectionTitleErr">#em#<br></div>
		<cfelse>
			<p>Your password has been mailed to you.</p>
			<p>Click <a href="index.cfm">here</a> to login.</p>
		</cfif>
	</div>
</div>