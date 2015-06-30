<cfinclude template="authenticateExe.cfm">
<cfif not isDefined("FORM.Submit")>
	<cfscript>
		pageTitle = "Error!";
		up2snuff = 0;
		em = 'Error!';
		// check required variables
		if (not isDefined("FORM.ClassID") or not isNumeric(FORM.ClassID))
		{
			em = "Invalid or missing parameters";
		}
		else
		{
			ClassID = FORM.ClassID;
			up2snuff = 1;
			em = 'None';
		}
	</cfscript>
	<cfif not up2snuff>
		<cfinclude template="incBegin.cfm">
		<cfinclude template="incError.cfm">
	<cfelse>
		<cfscript>
			// initialize variables for uspGetClassroom
			ClassID = ClassID;
			SessID = 0;
			Set = 'One';
		</cfscript>
		<cfinclude template="uspGetClassroom.cfm">
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfinclude template="formClassroom.cfm">
		</cfif>
	</cfif>
<cfelse>
	<cfif FORM.Submit eq "Cancel">
		<cflocation url="classroom.cfm?ClassID=#FORM.ClassID#" addtoken="no">
	<cfelse>
		<cfscript>
			pageTitle = "Error!";
			up2snuff = 0;
			em = 'Error!';
			// check required variables
			if (not isDefined("FORM.ClassID") or not isNumeric(FORM.ClassID))
			{
				em = "Invalid or missing parameters";
			}
			else
			{
				ClassID = FORM.ClassID;
				up2snuff = 1;
				em = 'None';
			}
		</cfscript>
		<cfif not up2snuff>
			<cfinclude template="incBegin.cfm">
			<cfinclude template="incError.cfm">
		<cfelse>
			<cfscript>
				// initialize variables for uspGetClassroom
				ClassID = ClassID;
				SessID = 0;
				Set = 'One';
			</cfscript>
			<cfinclude template="uspGetClassroom.cfm">
			<cfif not up2snuff>
				<cfinclude template="incBegin.cfm">
				<cfinclude template="incError.cfm">
			<cfelse>
				<cfinclude template="incCheckForm.cfm">
				<cfif missingRequired>
					<cfinclude template="formClassroom.cfm">
				<cfelse>
					<cfinclude template="incCheckDataFormat.cfm">
					<cfif not up2snuff>
						<cfinclude template="formClassroom.cfm">
					<cfelse>
						<cfinclude template="uspUpdateClassroom.cfm">
						<cfif not up2snuff>
							<cfinclude template="formClassroom.cfm">
						<cfelse>
							<cflocation url="classroom.cfm?ClassID=#ClassID#" addtoken="no">
						</cfif>
					</cfif>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfif>
<cfinclude template="incEnd.cfm">