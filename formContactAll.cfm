					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<cfoutput>
							<tr valign="top">
								<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
								<th nowrap><a href="#sortURL#fld=cn&ord=#ord#" class="columnHeading">Name</a></th>
								<th nowrap><a href="#sortURL#fld=cd&ord=#ord#" class="columnHeading">Department</a></th>
								<th nowrap><a href="#sortURL#fld=cs&ord=#ord#" class="columnHeading">Status</a></th>
								<th nowrap><a href="#sortURL#fld=cc&ord=#ord#" class="columnHeading">Member since</a></th>
								<th nowrap><a href="#sortURL#fld=cl&ord=#ord#" class="columnHeading">Associated with</a></th>
								<th nowrap><a href="#sortURL#fld=cu&ord=#ord#" class="columnHeading">Unit</a></th>
							</tr>
						</cfoutput>
						<cfset x = 0>
						<cfoutput query="Contact" group="ContactID">
							<cfset class="#IIF(Contact.CurrentRow eq 1, DE('first'), DE('rest'))#">
							<tr valign="top">
								<td class="#class#">
									<input name="CntctID" type="checkbox" value="#Contact.ContactID#">
								</td>
								<td class="#class#">
									<a href="JavaScript:newWindow('infoContact.cfm?CntctID=#Contact.ContactID#','740','300','20','25','Contact');" <cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>>#Contact.LastName#, #Contact.FirstName#</a>
								</td>
								<td class="#class#">
									<cfif Contact.Department neq "">#Contact.Department#<cfelse>#APPLICATION.nullCaption#</cfif>
								</td>
								<td class="#class#">
									<cfif Contact.ContactStatus neq "">#Contact.ContactStatus#<cfelse>#APPLICATION.nullCaption#</cfif>
								</td>
								<td class="#class#">#DateFormat(Contact.DBRCreatedDT, "mm/dd/yy")#</td>
								<td class="#class#">
									<cfif Contact.LibrarianLastName neq ""><cfoutput>#Contact.LibrarianLastName#<br></cfoutput><cfelse>--</cfif>
								</td>
								<td class="#class#"><cfif Contact.Unit neq "">#Contact.Unit#<cfelse>--</cfif></td>
							</tr>
							<cfset x = x + 1>
						</cfoutput>
					</table>
