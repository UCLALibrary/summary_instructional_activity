<cfoutput>
	<cfset pageTitle = "Add an Instructional Session: Contact Time Data for #Activity.Title#">
	<cfinclude template="incBegin.cfm">
	<cfinclude template="incJSShowCalendar.cfm">
	<script language="JavaScript" type="text/javascript">
		<!--
			function validateForm(form)
			{
				if (form.QuarterID.options[ form.QuarterID.selectedIndex ].value == 0)
				{
					alert("Please select session quarter");
					return false;
				}
				if (form.Hour.options[ form.Hour.selectedIndex ].value == "")
				{
					alert("Please select session start time");
					return false;
				}
				if (form.Marker.options[ form.Marker.selectedIndex ].value == "")
				{
					alert("Please select AM or PM for the session start time");
					return false;
				}
				if (form.SessionDate.value == "")
				{
					alert("Please include session date");
					return false;
				}
				if (form.Duration.value == "")
				{
					alert("Please include session duration");
					return false;
				}
				/*if (form.SessionCount.value == "")
				{
					alert("Please include session count");
					return false;
				}
				if (form.DevTime.value == "")
				{
					alert("Please include session development time");
					return false;
				}*/
				if (form.PrepTime.value == "")
				{
					alert("Please include session preparation time");
					return false;
				}
				return true;
			}
		-->
	</script>
	<form action="addSession.cfm"
		  method="post"
		  name="Session"
		  id="Session"
		  onsubmit="JavaScript:return validateForm(this);">
		<span class="formSectionTitle">#pageTitle#</span>
		<cfif isDefined("up2snuff") and not up2snuff>
			<div class="formSectionTitleErr" style="width:50%;">#em#<br></div>
		</cfif>
		<div class="form">
			<input type="hidden" name="version" value="" />
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<em class="required">*</em>Quarter<br>
						<cfset Lookup = "Quarter">
						<cfset Header = "-select-">
						<cfinclude template="uspGetLookup.cfm">
						<select name="QuarterID">
							<cfloop query="Quarter">
								<option value="#Quarter.QuarterID#"
										<cfif isDefined("FORM.QuarterID") and FORM.QuarterID eq Quarter.QuarterID>
											selected
										<cfelseif isDefined("Sess.QuarterID") and Sess.QuarterID eq Quarter.QuarterID>
											selected
										<cfelse>
										</cfif>
								>#Quarter.Quarter#</option>
							</cfloop>
						</select>
					</td>
					<td>
						<em class="required">*</em>
						<cfset elementName = "SessionDate">
						<cfset elementLabel = "Session date<br>(mm/dd/yyyy)">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							type="text"
							name="SessionDate"
							size="12"
							maxlength="10"
							<cfif isDefined("FORM.SessionDate")>
								value="#FORM.SessionDate#"
							<cfelseif isDefined("FORM.sDT")>
								value="#FORM.sDT#"
							<cfelse>
								value=""
							</cfif>
						><br>
						<a href="javascript:ShowCalendar('Session','SessionDate')">Select Date</a><!--EZ-D8 Select</a><sup>&reg;</sup-->
					</td>
					<td nowrap>
						<em class="required">*</em>Session start time<br>
						<select name="Hour">
							<option value="">--</option>
							<cfloop index="Hr" from="1" to="12" step="1">
								<option value="#Hr#"
									<cfif isDefined("FORM.Hour") and FORM.Hour eq Hr>
										selected
									</cfif>
								>#Hr#</option>
							</cfloop>
						</select>
						<span style="font-size:150%;">:</span>
						<select name="Minute">
							<cfloop index="Minute" from="0" to="55" step="5">
								<option value="#TimeFormat(CreateTime(00, Minute, 00), "mm")#"
									<cfif isDefined("FORM.Minute") and TimeFormat(CreateTime(00, Minute, 00), "mm") eq FORM.Minute>
										selected
									<cfelse>
									</cfif>
								>#TimeFormat(CreateTime(00, Minute, 00), "mm")#</option>
							</cfloop>
						</select>
						<select name="Marker">
							<option value="">--</option>
							<cfif isDefined("FORM.Marker")>
								<option value="AM" <cfif FORM.Marker eq "AM">selected</cfif>>A.M.</option>
								<option value="PM" <cfif FORM.Marker eq "PM">selected</cfif>>P.M.</option>
							<cfelse>
								<option value="AM">A.M.</option>
								<option value="PM">P.M.</option>
							</cfif>
						</select>
					</td>
				</tr>
				<tr><td colspan="3" style="font-size: small;">For whole courses taught, enter date of first session.</td></tr>
				<tr><td colspan="3"><hr size="1"></td></tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td>
						<em class="required">*</em>
						<cfset elementName = "Duration">
						<cfset elementLabel = "Duration">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="Duration"
							type="text"
							style="text-align:right;" size="5" maxlength="6"
							<cfif isDefined("FORM.Duration")>
							value="#FORM.Duration#"
							<cfelseif isDefined("Sess.Duration")>
							value="#Sess.Duration#"
							<cfelse>
							value=""
							</cfif>
						>  min.<br>
						<p style="font-size: small;">
							For whole courses taught, enter duration of one session
							<b>and</b><br>enter the number of sessions in the whole course:
							<input
								name="SessionCount"
								type="text"
								style="text-align:right;" size="5" maxlength="6"
								<cfif isDefined("FORM.SessionCount")>
								value="#FORM.SessionCount#"
								<cfelseif isDefined("Activity.SessionCount")>
								value="#Activity.SessionCount#"
								<cfelse>
								value=""
								</cfif>
							>
						</p>
					</td>
				</tr>
				<tr valign="top">
					<td>
						<em class="required">*</em>
						<cfset elementName = "PrepTime">
						<cfset elementLabel = "Development & Preparation time">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="PrepTime"
							type="text"
							style="text-align:right;"
							size="5"
							maxlength="6"
							<cfif isDefined("FORM.PrepTime")>
								value="#FORM.PrepTime#"
							<cfelseif isDefined("Sess.PrepTime")>
								value="#Sess.PrepTime#"
							<cfelse>
								value=""
							</cfif>
						> min.
					</td>
				</tr>
				<tr valign="top">
					<td>
						Development & Preparation time comments<br>
						<textarea name="PrepComment" cols="48" rows="4"><cfif isDefined("FORM.PrepComment")>#FORM.PrepComment#<cfelseif isDefined("Sess.PrepComment")>#Sess.PrepComment#<cfelse></cfif></textarea>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td>
						<input name="caller" type="hidden" value="formB">
						<input name="ActID" type="hidden" value="#SESSION.ActID#">
						<input name="SessID" type="hidden" value="#SESSION.SessID#">
						<input name="Submit" type="submit" class="mainControl" style="width:100px;" value="OK" onclick="JavaScript:setVersion(Session, 'main');">
					</td>
					<td>
						<input name="Submit" type="submit" class="mainControl" value="Cancel" onclick="JavaScript:setVersion(Session, 'alt');">
					</td>
				</tr>
			</table>
		</div>
	</form>
</cfoutput>
					<!---td>
						<em class="required">*</em>
						<cfset elementName = "SessionCount">
						<cfset elementLabel = "Number of Sessions">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="SessionCount"
							type="text"
							style="text-align:right;" size="5" maxlength="6"
							<cfif isDefined("FORM.SessionCount")>
							value="#FORM.SessionCount#"
							<cfelseif isDefined("Activity.SessionCount")>
							value="#Activity.SessionCount#"
							<cfelse>
							value=""
							</cfif>
						>
					</td--->
				<!--tr valign="top">
					<td colspan="3">
						Activity Comments<br>
						<textarea name="Comments" cols="48" rows="4"><cfif isDefined("FORM.Comments")>#FORM.Comments#<cfelseif isDefined("Sess.Comments")>#Sess.Comments#<cfelse></cfif></textarea>
					</td>
				</tr-->
						<!--input name="reqElements" type="hidden" value="QuarterID,a quarter;SessionDate,a sesssion date;Hour,a session time;Marker,AM or PM for the session time"--> <!--;GroupName, a group name"-->
							<!---cfelseif isDefined("Sess.SessionDateTime")>
								value="#DateFormat(Sess.SessionDateTime, "mm/dd/yyyy")#"--->
									<!---cfelseif isDefined("Sess.SessionDateTime") and TimeFormat(Sess.SessionDateTime, "h") eq Hr>
										selected--->
									<!---cfelseif isDefined("Sess.SessionDateTime") and TimeFormat(CreateTime(00, Minute, 00), "mm") eq Minute(Sess.SessionDateTime)>
										selected--->
							<!---cfelseif isDefined("Sess.SessionDateTime")>
								<option value="AM" <cfif Hour(Sess.SessionDateTime) lt 12>selected</cfif>>A.M.</option>
								<option value="PM" <cfif Hour(Sess.SessionDateTime) gt 11>selected</cfif>>P.M.</option--->
				<!---tr valign="top">
					<td>
						<em class="required">*</em>
						<cfset elementName = "DevTime">
						<cfset elementLabel = "Development time">
						<cfinclude template="incHiLiteMissingElement.cfm"><br>
						<input
							name="DevTime"
							type="text"
							style="text-align:right;"
							size="5"
							maxlength="6"
							<cfif isDefined("FORM.DevTime")>
								value="#FORM.DevTime#"
							<cfelseif isDefined("Activity.DevTime")>
								value="#Activity.DevTime#"
							<cfelse>
								value=""
							</cfif>
						> min.
					</td>
				</tr>
				<tr valign="top">
					<td>
						Development time comments<br>
						<textarea name="DevComment" cols="48" rows="4" ><cfif isDefined("FORM.DevComment")>#FORM.DevComment#<cfelseif isDefined("Activity.DevComment")>#Activity.DevComment#<cfelse></cfif></textarea>
					</td>
				</tr--->
