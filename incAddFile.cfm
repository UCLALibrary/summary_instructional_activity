<cfif FileLocation eq "">
	<cfset pageTitle = "Add Supplementary Materials">
	<cfinclude template="incBegin.cfm">
	<span class="formSectionTitle">Add Supplementary Materials</span>
	<div class="form">
	<p>You did not specify a local file to upload.</p>
	</div>
	<div class="controlArea">
	<form>
	<table align="center">
		<tr valign="top">
			<td><input type="button" class="mainControl" onClick="JavaScript:history.back();"  value="&lt;&lt; Back"></td>
		</tr>
	</table>
	</form>
	</div>
	<cfinclude template="incEnd.cfm">
<cfelse>
	<cfif OverWrite>
		<cftry>
			<cffile action="upload"
			  	    destination="f:\Inetpub\wwwroot\mainlib_test\sia\files"
					filefield="FileLocation"
					nameconflict="overwrite">
			<cfcatch type="Any">
				<cfset up2snuff = 0>
				<cfset pageTitle = "Add Supplementary Materials">
				<cfinclude template="incBegin.cfm">
				<span class="formSectionTitle">Add Supplementary Materials</span>
				<div class="form">
				<p>An error occurred while uploading your file.</p>
				</div>
				<div class="controlArea">
				<form>
				<table border="0" align="center" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td><input type="button" class="mainControl" onClick="JavaScript:history.back();"  value="&lt;&lt; Back"></td>
					</tr>
				</table>
				</form>
				</div>
				<cfinclude template="incEnd.cfm">
			</cfcatch>
		</cftry>
	<cfelse>
		<cftry>
			<cffile action="upload"
					destination="f:\Inetpub\wwwroot\mainlib_test\sia\files"
					filefield="FileLocation"
					nameconflict="error">
			<cfcatch type="Any">
				<cfset up2snuff = 0>
				<cfset pageTitle = "Add Supplementary Materials">
				<cfinclude template="incBegin.cfm">
				<span class="formSectionTitle">Add Supplementary Materials</span>
				<div class="form">
				<cfif FILE.fileExisted>
					<p>'<cfoutput><strong>#FILE.clientFileName#.#FILE.clientFileExt#</strong></cfoutput>'
					could not be uploaded because a file with the same name already exists.</p>
				<cfelse>
					<p>An error occurred while uploading your file.</p>
				</cfif>	
				</div>
				<div class="controlArea">
				<form>
				<table border="0" align="center" cellpadding="0" cellspacing="0">
					<tr valign="top">
						<td><input type="button" class="mainControl" onClick="JavaScript:history.back();"  value="&lt;&lt; Back"></td>
					</tr>
				</table>
				</form>
				</div>
				<cfinclude template="incEnd.cfm">
			</cfcatch>
		</cftry>
	</cfif>
</cfif>	