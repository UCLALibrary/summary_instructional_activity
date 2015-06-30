<cfscript>
	sectionTitle = "Classrooms";
	sortURL = APPLICATION.HostServer & SCRIPT_NAME & '?';
</cfscript>
<cfif Classroom.RecordCount eq 0>
	<span class="dataSectionTitle">No Classrooms Currently in the SIA Database</span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
		<td class="first">No classrooms currently in the SIA Database</td>
		</tr>
	</table>
	<cfif SESSION.UserLevelID lt 3 and ListContains("classrooms.cfm", Replace(SCRIPT_NAME, APPLICATION.Path, "", "all"), ",")>
		<form action="addNewClassroom.cfm" method="post">
		<input name="Add" type="submit" class="mainControl" value="Add Classroom">
		</form>
	</cfif>
	</div>
<cfelse>
	<span class="dataSectionTitle"><cfoutput>#sectionTitle#</cfoutput></span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
	<cfoutput>
			<th nowrap><a href="#sortURL#fld=na&ord=#ord#" class="columnHeading">Classroom name</a></th>
			<th nowrap><a href="#sortURL#fld=lo&ord=#ord#" class="columnHeading">Bldg./room num.</a></th>
			<th nowrap><a href="#sortURL#fld=dp&ord=#ord#" class="columnHeading">Department</a></th>
			<th nowrap><a href="#sortURL#fld=pr&ord=#ord#" class="columnHeading">Projector</a></th>
			<th nowrap><a href="#sortURL#fld=sc&ord=#ord#" class="columnHeading">Screen</a></th>
			<th nowrap><a href="#sortURL#fld=cn&ord=#ord#" class="columnHeading">Contact</a></th>
	</cfoutput>
		</tr>
	<cfoutput query="Classroom" group="ClassroomID">
		<cfset class="#IIF(Classroom.CurrentRow eq 1, DE('first'), DE('rest'))#">
		<tr valign="top">
			<td class="#class#"><a href="classroom.cfm?ClassID=#Classroom.ClassroomID#">#Classroom.Name#</a></td>
			<td class="#class#"><cfif Classroom.Building eq "" and Classroom.RoomNumber eq "">#APPLICATION.nullCaption#<cfelse><cfif Classroom.Building neq "">#Classroom.Building#</cfif><cfif Classroom.RoomNumber neq "">, #Classroom.RoomNUmber#</cfif></cfif></td>
			<td class="#class#"><cfif Classroom.Department neq "">#Classroom.Department#<cfelse>#APPLICATION.nullCaption#</cfif></td>
			<td class="#class#"><cfif Classroom.ComputerProjector neq ""><cfif Classroom.ComputerProjector>Yes<cfelse>No</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
			<td class="#class#"><cfif Classroom.Screen neq ""><cfif Classroom.Screen>Yes<cfelse>No</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
			<td class="#class#"><cfif Classroom.ContactLastName neq "" and Classroom.ContactFirstName neq ""><cfif Classroom.Email neq ""><a href="mailto:Classroom.Email">#Classroom.ContactLastName#, #Classroom.ContactFirstName#</a><cfelse>#Classroom.ContactLastName#, #Classroom.ContactFirstName#</cfif><cfelse>#APPLICATION.nullCaption#</cfif></td>
		</tr>
	</cfoutput>
	</table>
	<cfoutput>
		<cfif "1,5" contains SESSION.UserLevelID>
			<form action="addNewClassroom.cfm" method="post">
			<input type="submit" class="mainControl" value="Add New Classroom">
			</form>
		</cfif>
	</cfoutput>
	</div>
</cfif>
