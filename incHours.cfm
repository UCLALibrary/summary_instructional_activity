<cfquery name="Hours" datasource="#APPLICATION.dsn#">
	SELECT
		atl.ActivityType,
		<cfif SESSION.UserLevelID eq 1>
			<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
				Coalesce(dbo.total_duration_by_type_fyear_quarter_user(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.LibID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter_user(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.LibID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_quarter_user(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.LibID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter_user(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.LibID#), 0)) AS display_prep
			<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
				Coalesce(dbo.total_duration_by_type_fyear_quarter_user(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.LibID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter_user(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.LibID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_quarter_user(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.LibID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter_user(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.LibID#), 0)) AS display_prep
			<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
				Coalesce(dbo.total_duration_by_type_cyear_quarter_user(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.LibID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear_quarter_user(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.LibID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_cyear_quarter_user(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.LibID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear_quarter_user(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.LibID#), 0)) AS display_prep
			<cfelseif FORM.FYear neq 0>
				Coalesce(dbo.total_duration_by_type_fyear_user(a.ActivityTypeID, #FORM.FYear#, #SESSION.LibID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_user(a.ActivityTypeID, #FORM.FYear#, #SESSION.LibID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_user(a.ActivityTypeID, #FORM.FYear#, #SESSION.LibID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_user(a.ActivityTypeID, #FORM.FYear#, #SESSION.LibID#), 0)) AS display_prep
			<cfelseif FORM.CYear neq 0>
				Coalesce(dbo.total_duration_by_type_cyear_user(a.ActivityTypeID, #FORM.CYear#, #SESSION.LibID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear_user(a.ActivityTypeID, #FORM.CYear#, #SESSION.LibID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_cyear_user(a.ActivityTypeID, #FORM.CYear#, #SESSION.LibID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear_user(a.ActivityTypeID, #FORM.CYear#, #SESSION.LibID#), 0)) AS display_prep
			<cfelseif FORM.SessionDate neq "">
				Coalesce(dbo.total_duration_by_type_date_user(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.LibID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_date_user(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.LibID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_date_user(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.LibID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_date_user(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.LibID#), 0)) AS display_prep
			<cfelse>
				Coalesce(dbo.total_duration_by_type_fyear_user(a.ActivityTypeID, #fiscalYear#, #SESSION.LibID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_user(a.ActivityTypeID, #fiscalYear#, #SESSION.LibID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_user(a.ActivityTypeID, #fiscalYear#, #SESSION.LibID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_user(a.ActivityTypeID, #fiscalYear#, #SESSION.LibID#), 0)) AS display_prep
			</cfif>
		<cfelseif SESSION.UserLevelID eq 2>
			<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
				Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.UID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.UID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.UID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #SESSION.UID#), 0)) AS display_prep
			<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
				Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.UID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.UID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.UID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #SESSION.UID#), 0)) AS display_prep
			<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
				Coalesce(dbo.total_duration_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.UID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.UID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.UID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #SESSION.UID#), 0)) AS display_prep
			<cfelseif FORM.FYear neq 0>
				Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#SESSION.UID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#SESSION.UID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#SESSION.UID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#SESSION.UID#), 0)) AS display_prep
			<cfelseif FORM.CYear neq 0>
				Coalesce(dbo.total_duration_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#SESSION.UID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#SESSION.UID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#SESSION.UID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#SESSION.UID#), 0)) AS display_prep
			<cfelseif FORM.SessionDate neq "">
				Coalesce(dbo.total_duration_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.UID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.UID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.UID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #SESSION.UID#), 0)) AS display_prep
			<cfelse>
				Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#SESSION.UID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#SESSION.UID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#SESSION.UID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#SESSION.UID#), 0)) AS display_prep
			</cfif>
		<cfelse>
			<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
				Coalesce(dbo.total_duration_by_type_fyear_quarter(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_quarter(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#), 0)) AS display_prep
			<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
				Coalesce(dbo.total_duration_by_type_fyear_quarter(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear_quarter(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#), 0)) AS display_prep
			<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
				Coalesce(dbo.total_duration_by_type_cyear_quarter(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear_quarter(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_cyear_quarter(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear_quarter(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#), 0)) AS display_prep
			<cfelseif FORM.FYear neq 0>
				Coalesce(dbo.total_duration_by_type_fyear(a.ActivityTypeID, #FORM.FYear#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear(a.ActivityTypeID, #FORM.FYear#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear(a.ActivityTypeID, #FORM.FYear#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear(a.ActivityTypeID, #FORM.FYear#), 0)) AS display_prep
			<cfelseif FORM.CYear neq 0>
				Coalesce(dbo.total_duration_by_type_cyear(a.ActivityTypeID, #FORM.CYear#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear(a.ActivityTypeID, #FORM.CYear#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_cyear(a.ActivityTypeID, #FORM.CYear#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear(a.ActivityTypeID, #FORM.CYear#), 0)) AS display_prep
			<cfelseif FORM.SessionDate neq "">
				Coalesce(dbo.total_duration_by_type_date(a.ActivityTypeID, '#FORM.SessionDate#'), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_date(a.ActivityTypeID, '#FORM.SessionDate#'), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_date(a.ActivityTypeID, '#FORM.SessionDate#'), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_date(a.ActivityTypeID, '#FORM.SessionDate#'), 0)) AS display_prep
			<cfelse>
				Coalesce(dbo.total_duration_by_type_fyear(a.ActivityTypeID, #fiscalYear#), 0) AS Duration,
				dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear(a.ActivityTypeID, #fiscalYear#), 0)) AS display_dur,
				Coalesce(dbo.total_prep_time_by_type_fyear(a.ActivityTypeID, #fiscalYear#), 0) AS PrepTime,
				dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear(a.ActivityTypeID, #fiscalYear#), 0)) AS display_prep
			</cfif>
		</cfif>
	FROM
		dbo.Activity a
		JOIN dbo.ActivityTypeLookup atl ON a.ActivityTypeID = atl.ActivityTypeID
	GROUP BY
		atl.ActivityType,
		a.ActivityTypeID
	ORDER BY
		atl.ActivityType
</cfquery>

<cfquery name="Units" datasource="#APPLICATION.dsn#">
	SELECT * FROM dbo.UnitLookup ORDER BY Unit
</cfquery>

<cfset durCount = 0>
<cfset prepCount = 0>

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Contact Hours for Fiscal Year">
	<caption align="center" style="font-weight:bold">
		Contact Hours<cfif SESSION.UserLevelID gt 2> For All Libraries</cfif>
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
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Session Type</th>
		<th scope="col" align="right" nowrap>Duration of Session</th>
		<th scope="col" align="right" nowrap>Dev./Prep. Time</th>
	</tr>
	<cfoutput query="Hours">
		<tr>
			<td align="left">#Hours.ActivityType#</td>
			<td align="right">#Hours.display_dur#</th>
			<td align="right">#Hours.display_prep#</th>
			<cfset durCount = durCount + Hours.Duration>
			<cfset prepCount = prepCount + Hours.PrepTime>
		</tr>
	</cfoutput>
	<tr>
		<td align="left">&nbsp;</td>
		<td align="left">&nbsp;</td>
		<td align="left">&nbsp;</td>
	</tr>
	<cfoutput>
	<tr class="total">
		<td align="left">Grand Totals</td>
		<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
		<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
	</tr>
	</cfoutput>
</table>

<cfif SESSION.UserLevelID gt 2>
	<cfoutput query="Units">
		<cfset durCount = 0>
		<cfset prepCount = 0>

		<cfquery name="HoursByUnit" datasource="#APPLICATION.dsn#">
			SELECT
				atl.ActivityType,
				<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
					Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #Units.UnitID#), 0) AS Duration,
					dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #Units.UnitID#), 0)) AS display_dur,
					Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #Units.UnitID#), 0) AS PrepTime,
					dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #fiscalYear#, #FORM.QuarterID#, #Units.UnitID#), 0)) AS display_prep
				<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
					Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #Units.UnitID#), 0) AS Duration,
					dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #Units.UnitID#), 0)) AS display_dur,
					Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #Units.UnitID#), 0) AS PrepTime,
					dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_quarter_unit(a.ActivityTypeID, #FORM.FYear#, #FORM.QuarterID#, #Units.UnitID#), 0)) AS display_prep
				<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
					Coalesce(dbo.total_duration_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #Units.UnitID#), 0) AS Duration,
					dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #Units.UnitID#), 0)) AS display_dur,
					Coalesce(dbo.total_prep_time_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #Units.UnitID#), 0) AS PrepTime,
					dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear_quarter_unit(a.ActivityTypeID, #FORM.CYear#, #FORM.QuarterID#, #Units.UnitID#), 0)) AS display_prep
				<cfelseif FORM.FYear neq 0>
					Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#Units.UnitID#), 0) AS Duration,
					dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#Units.UnitID#), 0)) AS display_dur,
					Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#Units.UnitID#), 0) AS PrepTime,
					dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#FORM.FYear#,#Units.UnitID#), 0)) AS display_prep
				<cfelseif FORM.CYear neq 0>
					Coalesce(dbo.total_duration_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#Units.UnitID#), 0) AS Duration,
					dbo.get_display_time(Coalesce(dbo.total_duration_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#Units.UnitID#), 0)) AS display_dur,
					Coalesce(dbo.total_prep_time_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#Units.UnitID#), 0) AS PrepTime,
					dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_cyear_unit(a.ActivityTypeID,#FORM.CYear#,#Units.UnitID#), 0)) AS display_prep
				<cfelseif FORM.SessionDate neq "">
					Coalesce(dbo.total_duration_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #Units.UnitID#), 0) AS Duration,
					dbo.get_display_time(Coalesce(dbo.total_duration_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #Units.UnitID#), 0)) AS display_dur,
					Coalesce(dbo.total_prep_time_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #Units.UnitID#), 0) AS PrepTime,
					dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_date_unit(a.ActivityTypeID, '#FORM.SessionDate#', #Units.UnitID#), 0)) AS display_prep
				<cfelse>
					Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#Units.UnitID#), 0) AS Duration,
					dbo.get_display_time(Coalesce(dbo.total_duration_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#Units.UnitID#), 0)) AS display_dur,
					Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#Units.UnitID#), 0) AS PrepTime,
					dbo.get_display_time(Coalesce(dbo.total_prep_time_by_type_fyear_unit(a.ActivityTypeID,#fiscalYear#,#Units.UnitID#), 0)) AS display_prep
				</cfif>
			FROM
				dbo.Activity a
				JOIN dbo.ActivityTypeLookup atl ON a.ActivityTypeID = atl.ActivityTypeID
			GROUP BY
				atl.ActivityType,
				a.ActivityTypeID
			ORDER BY
				atl.ActivityType
		</cfquery>

		<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Contact Hours for Fiscal Year">
			<caption align="center" style="font-weight:bold">
				Contact Hours For #Units.Unit#
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
			</caption>
			<tr style="color: white; background-color: black;">
				<th scope="col" align="left">Session Type</th>
				<th scope="col" align="right" nowrap>Duration of Session</th>
				<th scope="col" align="right" nowrap>Dev./Prep. Time</th>
			</tr>
			<cfloop query="HoursByUnit">
				<tr>
					<td align="left">#HoursByUnit.ActivityType#</td>
					<td align="right">#HoursByUnit.display_dur#</th>
					<td align="right">#HoursByUnit.display_prep#</th>
					<cfset durCount = durCount + HoursByUnit.Duration>
					<cfset prepCount = prepCount + HoursByUnit.PrepTime>
				</tr>
			</cfloop>
			<tr>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
				<td align="left">&nbsp;</td>
			</tr>
			<tr class="total">
				<td align="left">#Units.Unit# Totals</td>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
			</tr>
		</table>
	</cfoutput>
</cfif>