<cfheader name = "Expires" value = "#Now()#">
<cfif not isDefined("URL.formName")>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
		<head>
			<title>SIA Database</title>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			<link href="css/global.css" rel="stylesheet" type="text/css">
			<script language="JavaScript" type="text/javascript">
				<!--
					setTimeout('window.close()',1000);
				//-->
			</script>
		</head>
		<body>
			<div style="position:absolute;top:50%;width:100%;text-align:center;">
				<strong>Error!</strong>
			</div>
		</body>
	</html>
	<cfabort>
<cfelse>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
		<head>
			<title>SIA Database</title>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
			<link href="css/global.css" rel="stylesheet" type="text/css">
		</head>
		<body style="margin:0;background-color:#FFFFFF;">
			<!--- Set the month and year parameters to equal the current values if they do not exist. --->
			<cfparam name="month" default="#DatePart('m', Now())#">
			<cfparam name="year" default="#DatePart('yyyy', Now())#">
			<cfscript>
				formName = URL.formName;
				// Set the requested (or current) month/year date and determine the number of days in the month.
				ThisMonthYear = CreateDate(year, month, '1');
				Days = DaysInMonth(ThisMonthYear);
				// Set the values for the previous and next months for the back/next links.
				LastMonthYear = DateAdd('m', -1, ThisMonthYear);
				LastMonth = DatePart('m', LastMonthYear);
				LastYear = DatePart('yyyy', LastMonthYear);
				NextMonthYear = DateAdd('m', 1, ThisMonthYear);
				NextMonth = DatePart('m', NextMonthYear);
				NextYear = DatePart('yyyy', NextMonthYear);
			</cfscript>
			<script language = "JavaScript" type="text/javascript">
				<!--
					// function to populate the date on the form and to close this window. --->
					function ShowDate(DayOfMonth)
					{
						if (DayOfMonth < 10)
						{
							DayOfMonth = "0" + DayOfMonth;
						}
						<cfoutput>
							var DateToShow = "<cfif month LT 10>0</cfif>#month#/" + DayOfMonth + "/#year#";
							eval("self.opener.document.#URL.formName#.#URL.elementName#.value = DateToShow");
							setTimeout('window.close()',500);
						</cfoutput>
					}
				//-->
			</script>
			<table width="240" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="150" align="center" valign="middle">
						<div class="calendar">
							<cfoutput>
								<table width="200" border="0" cellspacing="0" cellpadding="0">
									<tr bgcolor="##cccccc">
										<td width="20" align="center" class="anyDay">
											<a href = "SelectDate.cfm?formName=#formName#&elementName=#URL.elementName#&month=#LastMonth#&year=#LastYear#">
												<img src="images/arrow_l_blk.gif" alt="#MonthAsString(LastMonth)#" width="11" height="11" border="0">
											</a>
										</td>
										<td width="160" colspan="5" align="center" class="anyDay">
											<strong>#MonthAsString(month)#&nbsp;#year#</strong>
										</td>
										<td width="20" align="right" class="anyDay">
											<a href = "SelectDate.cfm?formName=#formName#&elementName=#URL.elementName#&month=#NextMonth#&year=#NextYear#">
												<img src="images/arrow_r_blk.gif" alt="#MonthAsString(NextMonth)#" width="11" height="11" border="0">
											</a>
										</td>
									</tr>
									<tr>
										<cfloop from = "1" to = "7" index = "LoopDay">
											<td width="40" align="center" class="anyDay">#Left(DayOfWeekAsString(LoopDay), 1)#</td>
										</cfloop>
									</tr>
									<cfset ThisDay = 0>
									<cfloop condition = "ThisDay LTE Days">
										<tr>
											<cfloop from = "1" TO = "7" index = "LoopDay">
												<cfif ThisDay IS 0>
													<cfif DayOfWeek(ThisMonthYear) IS LoopDay>
														<cfset ThisDay = 1>
													</cfif>
												</cfif>
												<cfif (ThisDay IS NOT 0) AND (ThisDay LTE Days)>
													<td align="center"
													<cfif #CreateDate(year, month, ThisDay)# IS #DateFormat(Now())#>
														class="thisDay"
													<cfelse>
														class="anyDay"
													</cfif>>
													<a href = "javascript:ShowDate(#NumberFormat(ThisDay, 00)#)"
														class="<cfif #CreateDate(year, month, ThisDay)# is #DateFormat(Now())#>thisDay<cfelse>anyDay</cfif>">
															#ThisDay#
														</a>
													</td>
													<cfset ThisDay = ThisDay + 1>
												<cfelse>
													<td class="anyDay">&nbsp;</td>
												</cfif>
											</cfloop>
										</tr>
									</cfloop>
								</table>
							</cfoutput>
						</div>
					</td>
				</tr>
			</table>
		</body>
	</html>
</cfif>
