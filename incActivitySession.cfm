<span class="dataSectionTitle"><cfoutput>#pageTitle#</cfoutput></span>
<div class="data">
<cfoutput query="Activity" group="ActivityID">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr valign="top">
		<td nowrap class="fieldLabel">Activity/<br>course title:</td>
		<td class="fieldValue"><strong>#Activity.Title#</strong></td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Activity/course type:</td>
		<td class="fieldValue">#Activity.ActivityType#</td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Mode of delivery:</td>
		<td class="fieldValue"><cfif Activity.DeliveryMode neq "">#Activity.DeliveryMode#<cfelse>#APPLICATION.nullCaption#</cfif></td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Description:</td>
		<td class="fieldValue"><cfif Activity.Description neq "">#Activity.Description#<cfelse>#APPLICATION.nullCaption#</cfif></td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Approximate duration:</td>
		<td class="fieldValue"><cfif Activity.Duration neq "">#Activity.Duration# min.<cfelse>#APPLICATION.nullCaption#</cfif></td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Development time:</td>
		<td class="fieldValue"><cfif Activity.DevTime neq "">#Activity.DevTime# min.<cfelse>#APPLICATION.nullCaption#</cfif></td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Comment:</td>
		<td class="fieldValue"><cfif Activity.DevComment neq "">#Activity.DevComment#<cfelse>#APPLICATION.nullCaption#</cfif></td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Supplementary materials:</td>
		<td class="fieldValue">
	<cfscript>
// initialize variables for uspGetMaterial stored procedure
		MatID = 0;
		MatTypID = 0;
		LibID = SESSION.LibID;
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
	<cfif Material.RecordCount neq 0>
		<ul>
		<cfloop query="Material">
		<li><a href="material.cfm?MatID=#Material.MaterialID#">#Material.MaterialTitle#</a></li>
		</cfloop>		
		</ul>
	<cfelse>
		None<br>
	</cfif>	
	<form action="addMaterial.cfm" method="post">
		<input type="submit" class="subControl" value="Add/Update Material">
		<input name="exe" type="hidden" value="addMat">
		<input name="ActID" type="hidden" value="#ActID#">
	</form>
		</td>
	</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Created:</td>
		<td class="fieldValue">#DateFormat(Activity.DBRCreatedDT, APPLICATION.dateFormat)#, #TimeFormat(Activity.DBRCreatedDT, APPLICATION.timeFormat)# by <a href="librarian.cfm?LibID=#Activity.DBRCreatorID#">#Activity.DBRCreator#</a> (#Activity.DBRCreatorUnit#)</td>
		</tr>
	<tr valign="top">
		<td nowrap class="fieldLabel">Updated:</td>
		<td class="fieldValue">#DateFormat(Activity.DBRUpdatedDT, APPLICATION.dateFormat)#, #TimeFormat(Activity.DBRUpdatedDT, APPLICATION.timeFormat)# by <a href="librarian.cfm?LibID=#Activity.DBRUpdaterID#">#Activity.DBRUpdater#</a> (#Activity.DBRUpdaterUnit#)</td>
	</tr>
</table>
</cfoutput>	
</div>
