				<!-- this is alpha list version -->
				<cfoutput>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<th class="columnHeading" colspan="7">Click a letter to see contacts</th>
						</tr>
						<tr valign="top">
							<td><a href="#sortURL#start=A&end=B&showButtons=T" class="columnHeading">A</a></td>
							<td><a href="#sortURL#start=B&end=H&showButtons=T" class="columnHeading">B-G</a></td>
							<td><a href="#sortURL#start=H&end=M&showButtons=T" class="columnHeading">H-L</a></td>
							<td><a href="#sortURL#start=M&end=O&showButtons=T" class="columnHeading">M-N</a></td>
							<td><a href="#sortURL#start=O&end=S&showButtons=T" class="columnHeading">O-R</a></td>
							<td><a href="#sortURL#start=S&end=T&showButtons=T" class="columnHeading">S</a></td>
							<td><a href="#sortURL#start=T&end=a&showButtons=T" class="columnHeading">T-Z</a></td>
						</tr>
					</table>
				</cfoutput>
				<p>&nbsp;</p>
				<cfif IsDefined("start")>
					<cfquery name="byletter" dbtype="query">
						SELECT *
						FROM Contact
						WHERE LastName BETWEEN '<cfoutput>#start#</cfoutput>' AND '<cfoutput>#end#</cfoutput>'
					</cfquery>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<cfoutput>
							<tr valign="top">
								<th nowrap><cfif isDefined("missingRequired") and missingRequired><span class="error">Select</span><cfelse>Select</cfif></th>
								<th nowrap><a href="#sortURL#fld=cn&ord=#ord#<cfif IsDefined("start")>&start=#start#&end=#end#</cfif>" class="columnHeading">Name</a></th>
								<th nowrap><a href="#sortURL#fld=cd&ord=#ord#<cfif IsDefined("start")>&start=#start#&end=#end#</cfif>" class="columnHeading">Department</a></th>
								<th nowrap><a href="#sortURL#fld=cs&ord=#ord#<cfif IsDefined("start")>&start=#start#&end=#end#</cfif>" class="columnHeading">Status</a></th>
								<th nowrap><a href="#sortURL#fld=cc&ord=#ord#<cfif IsDefined("start")>&start=#start#&end=#end#</cfif>" class="columnHeading">Member since</a></th>
								<th nowrap><a href="#sortURL#fld=cl&ord=#ord#<cfif IsDefined("start")>&start=#start#&end=#end#</cfif>" class="columnHeading">Associated with</a></th>
								<th nowrap><a href="#sortURL#fld=cu&ord=#ord#<cfif IsDefined("start")>&start=#start#&end=#end#</cfif>" class="columnHeading">Unit</a></th>
							</tr>
						</cfoutput>
						<cfset x = 0>
						<!-- this is the alpha version of listing -->
						<cfoutput query="byletter" group="ContactID">
							<cfset class="#IIF(byletter.CurrentRow eq 1, DE('first'), DE('rest'))#">
							<tr valign="top">
								<td class="#class#">
									<input name="CntctID" type="checkbox" value="#byletter.ContactID#">
								</td>
								<td class="#class#">
									<a href="JavaScript:newWindow('infoContact.cfm?CntctID=#byletter.ContactID#','740','300','20','25','Contact');" <cfif UniqueRec gt 1>onClick="JavaScript:selectRadio('#x#');"</cfif>>#byletter.LastName#, #byletter.FirstName#</a>
								</td>
								<td class="#class#">
									<cfif byletter.Department neq "">#byletter.Department#<cfelse>#APPLICATION.nullCaption#</cfif>
								</td>
								<td class="#class#">
									<cfif byletter.ContactStatus neq "">#byletter.ContactStatus#<cfelse>#APPLICATION.nullCaption#</cfif>
								</td>
								<td class="#class#">#DateFormat(byletter.DBRCreatedDT, "mm/dd/yy")#</td>
								<td class="#class#">
									<cfif byletter.LibrarianLastName neq ""><cfoutput>#byletter.LibrarianLastName#<br></cfoutput><cfelse>--</cfif>
								</td>
								<td class="#class#"><cfif byletter.Unit neq "">#byletter.Unit#<cfelse>--</cfif></td>
							</tr>
							<cfset x = x + 1>
						</cfoutput>
					</table>
				</cfif>
