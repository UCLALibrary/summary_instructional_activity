<!--- Set the month and year parameters to equal the current values if they do not exist. --->
<cfparam name="m" default="#DatePart('m', DateAdd('m', -1, Now()))#">
<cfparam name="y" default="#DatePart('yyyy', DateAdd('Y', -1, Now()))#">
<cfset class="anyDay">
<cfscript>
	OneMonthYear = CreateDate(y, m, '1');
	OneMonthDays = DaysInMonth(OneMonthYear);

	TwoMonthYear = DateAdd('m', 1, OneMonthYear);
	TwoMonth = DatePart('m', TwoMonthYear);
	TwoMonthDays = DaysInMonth(TwoMonthYear);

	ThreeMonthYear = DateAdd('m', 2, OneMonthYear);
	ThreeMonth = DatePart('m', ThreeMonthYear);
	ThreeMonthDays = DaysInMonth(ThreeMonthYear);

	PrevMonthYear = DateAdd('m', -3, OneMonthYear);
	PrevMonth = DatePart('m', PrevMonthYear);

	NextMonthYear = DateAdd('m', 3, OneMonthYear);
	NextMonth = DatePart('m', NextMonthYear);

// initialize variable for uspGetSession stored procedure
	LibID = 0;
	SessID = 0;
	sDT = DateFormat(OneMonthYear, 'mm/dd/yyyy');
	eDT = DateFormat(NextMonthYear, 'mm/dd/yyyy');
	CntctID = 0;
	DeptID = 0;
	ActID = 0;
	QuartID = 0;
	Yr = 0;
	Hr = 0;
	UID = 0;
	FiscalY = 0;
	OutID = 0;
	ClassID = 0;
	ShowAll = 0;
</cfscript>
<cfinclude template="uspGetSession.cfm">
<cfif not up2snuff>
	<span class="dataSectionTitle">Error!</span>
	<div class="data">
		<p>Unable to display calendar.</p>
	</div>
<cfelse>
	<a name="calendar"></a>
	<span class="dataSectionTitle">
		Calendar
		<cfoutput>
			<cfif (DatePart("yyyy", OneMonthYear) neq DatePart("yyyy", TwoMonthYear))>
				'#Right(DatePart("yyyy", OneMonthYear), 2)#/'#Right(DatePart("yyyy", TwoMonthYear), 2)#
			<cfelseif (DatePart("yyyy", TwoMonthYear) neq DatePart("yyyy", ThreeMonthYear))>
				'#Right(DatePart("yyyy", TwoMonthYear), 2)#/'#Right(DatePart("yyyy", ThreeMonthYear), 2)#
			<cfelse>
				'#Right(DatePart("yyyy", TwoMonthYear), 2)#
			</cfif>
		</cfoutput>
	</span>
	<div class="data">
		<p>Library-wide instructional activity calendar</p>
		<cfoutput>
			<div style="margin-top:.1em;"></div>
			<cfset x = 1>
			<cfloop index="loopMonth" list="#m#,#TwoMonth#,#ThreeMonth#" delimiters=",">
				<cfswitch expression="#x#">
					<cfcase value="1">
						<cfset ThisMonthYear = OneMonthYear>
						<cfset ThisMonthDays = OneMonthDays>
						<cfset ThisYear = DatePart("yyyy", OneMonthYear)>
						<cfset ThisMonth = DatePart("m", OneMonthYear)>
					</cfcase>
					<cfcase value="2">
						<cfset ThisMonthYear = TwoMonthYear>
						<cfset ThisMonthDays = TwoMonthDays>
						<cfset ThisYear = DatePart("yyyy", TwoMonthYear)>
						<cfset ThisMonth = DatePart("m", TwoMonthYear)>
					</cfcase>
					<cfcase value="3">
						<cfset ThisMonthYear = ThreeMonthYear>
						<cfset ThisMonthDays = ThreeMonthDays>
						<cfset ThisYear = DatePart("yyyy", ThreeMonthYear)>
						<cfset ThisMonth = DatePart("m", ThreeMonthYear)>
					</cfcase>
				</cfswitch>
				<div class="calendar">
					<table width="180" border="0" cellpadding="0" cellspacing="0">
						<tr valign="middle" bgcolor="##cccccc">
							<td align="center" class="anyDay">
								<cfif x eq 1>
									<a href = "mySIA.cfm?y=#DatePart("yyyy", PrevMonthYear)#&m=#PrevMonth#">
										<img src="images/arrow_l_blk.gif" alt="Previous three months" width="11" height="11" hspace="5" border="0" align="left">
									</a>
								<cfelse>
									&nbsp;
								</cfif>
							</td>
							<td colspan="5" align="center" class="anyDay">
								<strong>#MonthAsString(loopMonth)#
									&nbsp;
									<cfswitch expression="#x#">
										<cfcase value="1">
											#DatePart("yyyy", OneMonthYear)#
										</cfcase>
										<cfcase value="2">
											#DatePart("yyyy", TwoMonthYear)#
										</cfcase>
										<cfcase value="3">
											#DatePart("yyyy", ThreeMonthYear)#
										</cfcase>
									</cfswitch>
								</strong>
							</td>
							<td align="right" class="anyDay">
								<cfif x eq 3>
									<a href = "mySIA.cfm?y=#DatePart("yyyy", NextMonthYear)#&m=#NextMonth#">
										<img src="images/arrow_r_blk.gif" alt="Next three months" width="11" height="11" hspace="5" border="0">
									</a>
								<cfelse>
									&nbsp;
								</cfif>
							</td>
						</tr>
						<!--tr-->
						<tr>
							<cfloop from = "1" to = "7" index = "LoopDay">
								<td align="center" class="anyDay">#Left(DayOfWeekAsString(LoopDay), 1)#</td>
							</cfloop>
						</tr>
						<cfset ThisDay = 0>
						<cfloop condition = "ThisDay LTE ThisMonthDays">
							<tr>
								<cfloop from = "1" TO = "7" INDEX = "LoopDay">
									<cfif ThisDay IS 0>
										<cfif DayOfWeek(ThisMonthYear) IS LoopDay>
											<cfset ThisDay = 1>
										</cfif>
									</cfif>
									<cfif (ThisDay IS NOT 0) AND (ThisDay LTE ThisMonthDays)>
										<cfif Sess.RecordCount neq 0>
											<cfloop query="Sess">
												<cfif (CreateDate(ThisYear, ThisMonth, ThisDay) eq DateFormat(Now())) and
												      (DateFormat(Sess.SessionDateTime) eq DateFormat(CreateDate(ThisYear, ThisMonth, ThisDay)))>
													<cfset class="thisDaySession">
													<cfbreak>
												<cfelseif (CreateDate(ThisYear, ThisMonth, ThisDay) neq DateFormat(Now())) and
												          (DateFormat(Sess.SessionDateTime) eq DateFormat(CreateDate(ThisYear, ThisMonth, ThisDay)))>
													<cfset class="anyDaySession">
													<cfbreak>
												<cfelseif (CreateDate(ThisYear, ThisMonth, ThisDay) eq DateFormat(Now())) and
												          (DateFormat(Sess.SessionDateTime) neq DateFormat(CreateDate(ThisYear, ThisMonth, ThisDay)))>
													<cfset class="thisDay">
													<cfbreak>
												<cfelse>
													<cfset class="anyDay">
												</cfif>
											</cfloop>
										<cfelse>
											<cfloop index="n" from="1" to="#ThisMonthDays#" step="1">
												<cfif (CreateDate(ThisYear, ThisMonth, ThisDay) eq DateFormat(Now()))>
													<cfset class="thisDay">
													<cfbreak>
												<cfelse>
													<cfset class="anyDay">
												</cfif>
											</cfloop>
										</cfif>
										<td align="center" class="#class#">
											<a href = "sessions.cfm?sDT=#URLEncodedFormat(DateFormat(CreateDate(ThisYear, ThisMonth, ThisDay), "mm/dd/yyyy"))#" class="#class#">#ThisDay#</a>
										</td>
										<cfset ThisDay = ThisDay + 1>
									<cfelse>
										<td class="anyDay">&nbsp;</td>
									</cfif>
								</cfloop>
							</tr>
						</cfloop>
					</table>
				</div>
				<cfif x lt 3>
					<br>
				</cfif>
				<cfset x = x + 1>
			</cfloop>
		</cfoutput>
	</div>
</cfif>