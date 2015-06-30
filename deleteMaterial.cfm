<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.MatID") or not isNumeric(FORM.MatID)) {
			em = "Invalid or missing parameters";
		}
		else {
			MatID = FORM.MatID;
			up2snuff = 1;
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
// initialize variables for uspCheckRelationships stored procedure
			LibID = SESSION.LibID;
			CntctID = 0;
			ActID = 0;
			SessID = 0;
			MatID = MatID;
			ClassID = 0;
		</cfscript>
		<cfinclude template="uspCheckRelationships.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfif Relationships.Total gt 0>
				<cfinclude template="incDenyDelete.cfm">
			<cfelse>
				<cfscript>
// initialize variables for uspGetMaterial stored procedure
					MatID = FORM.MatID;
					MatTypID = 0;
					LibID = 0;
					ActID = 0;
					CntctID = 0;
					UID = 0;
					sDT = '';
					eDT = '';
					QuartID = 0;
					Yr = 0;
					FiscalY = 0;
					Set = "";
				</cfscript>
				<cfinclude template="uspGetMaterial.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfscript>
// initialize variables for uspGetContact stored procedure
						LibID = 0;
						CntctID = 0;
						StatID = 0;
						DeptID = 0;
						SessID = 0;
						ActID = 0;
						MatID = MatID;
						UID = 0;
						sDT = '';
						eDT = '';
						FiscalY = 0;
						Set = '';
					</cfscript>
					<cfinclude template="uspGetContact.cfm">
					<cfif not up2snuff>
						<cfinclude template="incBegin.cfm">
						<cfinclude template="incError.cfm">
					<cfelse>
						<cfinclude template="formDeleteMaterial.cfm">
						<cfinclude template="incMaterial.cfm">
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
<cfelse>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
// check required variables
		if (not isDefined("FORM.MatID") or not isNumeric(FORM.MatID)) {
			em = "Invalid or missing parameters";
		}
		else {
			MatID = FORM.MatID;
			up2snuff = 1;
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
// initialize variables for uspGetMaterial and uspDeleteMaterial stored procedures
			MatID = FORM.MatID;
			MatTypID = 0;
			LibID = 0;
			ActID = 0;
			CntctID = 0;
			UID = 0;
			sDT = '';
			eDT = '';
			QuartID = 0;
			Yr = 0;
			FiscalY = 0;
			Set = "";
		</cfscript>
		<cfinclude template="uspGetMaterial.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfif Material.IsFile>
				<cfinclude template="incGetDirectory.cfm">
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cfloop query="DirectoryFiles">
						<cfif Material.FileName eq DirectoryFiles.Name>
							<cfset fileInDir = 1>
							<cfbreak>
						</cfif>
					</cfloop>		
					<cfif fileInDir>
						<cftry>
							<cffile action="delete" file="#SESSION.FileLocation##Material.FileName#">
							<cfcatch type="Any">
								<cfset up2snuff = 0>
								<cfset em = "An error ocurred while attempting to delete the file.">
							</cfcatch>
						</cftry>
					</cfif>
				</cfif>		
			</cfif>
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="uspDeleteMaterial.cfm">				
				<cfif not up2snuff>
					<cfinclude template="incBegin.cfm">
					<cfinclude template="incError.cfm">
				<cfelse>
					<cflocation url="materials.cfm?LibID=#SESSION.LibID#" addtoken="no">
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">