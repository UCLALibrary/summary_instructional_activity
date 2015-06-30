<cfif isDefined("Classroom.RecordCount") and Classroom.RecordCount eq 0>
	<cfset pageTitle = "No Classroom Log Found">
	<cfinclude template="incBegin.cfm">
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td class="first">No classroom found</td>
		</tr>
	</table>
	</div>
<cfelse>
	<cfinclude template="incBegin.cfm">
	<cfoutput>	
<form action="deleteClassroomExe.cfm"
	method="post"
	name="deleteCassroom"
	id="deleteClassroom">
<span class="formSectionTitle">#pageTitle#</span>
<div class="form">
<table width="400" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
<p class="error">You are about to delete the record below. Are you sure you want to do this?</p>
		</td>
	</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<input name="ClassID" type="hidden" value="#Classroom.ClassroomID#">
		<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK">
		</form>
		</td>
		<td>
		<form action="classroom.cfm?ClassID=#Classroom.ClassroomID#" method="post">
		<input type="submit" class="mainControl" value="Cancel">				
		</form>
		</td>
	</tr>
</table>
	</cfoutput>
</div>
</cfif>