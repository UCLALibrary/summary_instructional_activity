<cfset sessionGrand = 0>
<cfset peopleGrand = 0>
<cfset durGrand = 0>
<cfset prepGrand = 0>

<cfset colSpan = 7>
<cfset spacer = 4>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<cfquery name="Types" datasource="#APPLICATION.dsn#">
	SELECT ActivityTypeID, Upper(ActivityType) AS ActivityType
	FROM dbo.ActivityTypeLookup WHERE Active = 1 ORDER BY ActivityTypeID
</cfquery>

<cfset sessionGrand = 0>
<cfset peopleGrand = 0>
<cfset durGrand = 0>
<cfset prepGrand = 0>

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Instruction Coordinators Report for Fiscal Year">
	<caption align="center" style="font-weight:bold">
		Instruction Coordinators Report
		<cfoutput>
			<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
				<cfif FORM.QuarterID eq 1>Fall</cfif>
				<cfif FORM.QuarterID eq 2>Winter</cfif>
				<cfif FORM.QuarterID eq 3>Spring</cfif>
				<cfif FORM.QuarterID eq 4>Summer</cfif>
				&nbsp;FY&nbsp;#fiscalYear#/#fiscalYear + 1#
			<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
				<cfif FORM.QuarterID eq 1>Fall</cfif>
				<cfif FORM.QuarterID eq 2>Winter</cfif>
				<cfif FORM.QuarterID eq 3>Spring</cfif>
				<cfif FORM.QuarterID eq 4>Summer</cfif>
				&nbsp;FY&nbsp;#FORM.FYear#/#FORM.FYear + 1#
			<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
				<cfif FORM.QuarterID eq 1>Fall</cfif>
				<cfif FORM.QuarterID eq 2>Winter</cfif>
				<cfif FORM.QuarterID eq 3>Spring</cfif>
				<cfif FORM.QuarterID eq 4>Summer</cfif>
				&nbsp;#FORM.CYear#
			<cfelseif FORM.FYear neq 0>
				&nbsp;FY&nbsp;#FORM.FYear#/#FORM.FYear + 1#
			<cfelseif FORM.CYear neq 0>
				&nbsp;#FORM.CYear#
			<cfelseif FORM.SessionDate neq "">
				&nbsp;#FORM.SessionDate#
			<cfelse>
				&nbsp;FY&nbsp;#fiscalYear#/#fiscalYear + 1#
			</cfif>
		</cfoutput>
	</caption>
</table>
<cfoutput query="Types">
	<cfset typeSessionCount = 0>
	<cfset typePeopleCount = 0>
	<cfset typeDurCount = 0>
	<cfset typePrepCount = 0>

	<cfset type="#Types.ActivityTypeID#">

	<h3>#Types.ActivityType#</h3>
	<cfinclude template="incCoordUnits.cfm">
	<cfloop query="Units">
		<cfset unitSessionCount = 0>
		<cfset unitPeopleCount = 0>
		<cfset unitDurCount = 0>
		<cfset unitPrepCount = 0>

		<h4>#Units.Unit#</h4>
		<cfset unitID="#Units.UnitID#">
		<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Report for #Types.ActivityType#">
			<tr>
				<th scope="col" align="left">Quarter</th>
				<th scope="col" align="left">Course or Group/Session name</th>
				<th scope="col" align="left">Presenter(s)</th>
				<th scope="col" align="left">Developer(s)</th>
				<th scope="col" align="left">Date</th>
				<th scope="col" align="right">Sessions</th>
				<th scope="col" align="right">People</th>
				<cfif FORM.Duration>
					<th scope="col" align="right" nowrap>Duration</th>
				</cfif>
				<cfif FORM.PrepTime>
					<th scope="col" align="right" nowrap>Dev./Prep. Time</th>
				</cfif>
			</tr>
			<cfinclude template="queryIncGeneralPlus.cfm">
			<cfloop query="Sessions">
				<tr>
					<td align="left">#Sessions.Quarter#</td>
					<td align="left">#Sessions.Title#</td>
					<td scope="col" align="left">#Sessions.Presenters#</td>
					<td scope="col" align="left">#Sessions.Developers#</td>
					<td scope="col" align="left">#Sessions.StyledSessionDateTime#</td>
					<td align="right">#Sessions.Sessions#</td>
					<td align="right">#Sessions.People#</td>
					<cfif FORM.Duration>
						<td align="right">#Sessions.Duration#</th>
					</cfif>
					<cfif FORM.PrepTime>
						<td align="right">#Sessions.PrepTime#</th>
					</cfif>
				</tr>
				<cfif FORM.Feedback>
					<tr>
						<td align="left">Evaluation/Feedback</td>
						<td align="left" colspan="#feedSpan#">#Sessions.FeedbackText#</td>
					</tr>
				</cfif>
				<cfset unitSessionCount = unitSessionCount + Sessions.Sessions>
				<cfset unitPeopleCount = unitPeopleCount + Sessions.People>
				<cfset unitDurCount = unitDurCount + Sessions.Duration>
				<cfset unitPrepCount = unitPrepCount + Sessions.PrepTime>
			</cfloop><!-- sessions -->
			<tr>
				<td align="left" colspan="#colSpan#">&nbsp;</td>
			</tr>
			<tr class="total">
				<td align="left">#Units.Unit# subtotal</td>
				<td align="left" colspan="#spacer#">&nbsp;</td>
				<td align="right">#unitSessionCount#</td>
				<td align="right">#unitPeopleCount#</td>
				<cfif FORM.Duration>
					<td align="right">#unitDurCount#</td>
				</cfif>
				<cfif FORM.PrepTime>
					<td align="right">#unitPrepCount#</td>
				</cfif>
			</tr>
		</table>
		<cfset typeSessionCount = typeSessionCount + unitSessionCount>
		<cfset typePeopleCount = typePeopleCount + unitPeopleCount>
		<cfset typeDurCount = typeDurCount + unitDurCount>
		<cfset typePrepCount = typePrepCount + unitPrepCount>
	</cfloop><!-- units -->
	<br/>
	<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Report for #Types.ActivityType#">
		<caption align="center" style="font-weight:bold">#Types.ActivityType# subtotal</caption>
		<tr style="color: white; background-color: black;">
			<th scope="col" align="left">Sessions</th>
			<th scope="col" align="left">People</th>
			<cfif FORM.Duration>
				<th scope="col" align="left">Duration</th>
			</cfif>
			<cfif FORM.PrepTime>
				<th scope="col" align="left">Dev/Prep. Time</th>
			</cfif>
		</tr>
		<tr class="total">
			<td align="right">#typeSessionCount#</td>
			<td align="right">#typePeopleCount#</td>
			<cfif FORM.Duration>
				<td align="right">#typeDurCount#</td>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right">#typePrepCount#</td>
			</cfif>
		</tr>
	</table>
	<cfset sessionGrand = sessionGrand + typeSessionCount>
	<cfset peopleGrand =  peopleGrand + typePeopleCount>
	<cfset durGrand =  durGrand + typeDurCount>
	<cfset prepGrand =  prepGrand + typePrepCount>

</cfoutput><!-- types -->
<br/><br/>
<cfoutput>
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Grand Totals">
	<caption align="center" style="font-weight:bold">Grand Totals</caption>
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Sessions</th>
		<th scope="col" align="left">People</th>
		<cfif FORM.Duration>
			<th scope="col" align="left">Duration</th>
		</cfif>
		<cfif FORM.PrepTime>
			<th scope="col" align="left">Dev/Prep. Time</th>
		</cfif>
	</tr>
	<tr class="total">
		<td align="right">#sessionGrand#</td>
		<td align="right">#peopleGrand#</td>
		<cfif FORM.Duration>
			<td align="right">#durGrand#</td>
		</cfif>
		<cfif FORM.PrepTime>
			<td align="right">#prepGrand#</td>
		</cfif>
	</tr>
</table>
</cfoutput>
