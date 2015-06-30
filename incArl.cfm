<cfquery name="Sums" datasource="#APPLICATION.dsn#">
	<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
		SELECT Coalesce(dbo.count_attendees_by_qfy(#FORM.QuarterID#, #fiscalYear#), 0) AS People, Coalesce(dbo.total_sessions_by_qfy(#FORM.QuarterID#, #fiscalYear#), 0) AS Sessions
	<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
		SELECT Coalesce(dbo.count_attendees_by_qfy(#FORM.QuarterID#, #FORM.FYear#), 0) AS People, Coalesce(dbo.total_sessions_by_qfy(#FORM.QuarterID#, #FORM.FYear#), 0) AS Sessions
	<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
		SELECT Coalesce(dbo.count_attendees_by_qcy(#FORM.QuarterID#, #FORM.CYear#), 0) AS People, Coalesce(dbo.total_sessions_by_qcy(#FORM.QuarterID#, #FORM.CYear#), 0) AS Sessions
	<cfelseif FORM.FYear neq 0>
		SELECT Coalesce(dbo.count_attendees_by_fy(#FORM.FYear#), 0) AS People, Coalesce(dbo.total_sessions_by_fy(#FORM.FYear#), 0) AS Sessions
	<cfelseif FORM.CYear neq 0>
		SELECT Coalesce(dbo.count_attendees_by_cy(#FORM.CYear#), 0) AS People, Coalesce(dbo.total_sessions_by_cy(#FORM.CYear#), 0) AS Sessions
	<cfelseif FORM.SessionDate neq "">
		SELECT	Coalesce(Sum(s.NumAttendees), Sum(s.NumEnrolled), 0) AS People, Sum(dbo.total_sessions(s.SessionID)) AS Sessions
		FROM	dbo.Session s
				JOIN dbo.SessionActivity sa ON s.SessionID = sa.SessionID
				JOIN dbo.Activity a ON sa.ActivityID = a.ActivityID
		WHERE 	s.SessionDateTime between '#FORM.SessionDate# 00:00.0' and '#FORM.SessionDate# 23:59.0'
				AND a.ActivityTypeID != 6
				AND dbo.is_staff_or_scholar( s.SessionID ) != 1
	<cfelse>
		SELECT Coalesce(dbo.count_attendees_by_fy(#fiscalYear#), 0) AS People, Coalesce(dbo.total_sessions_by_fy(#fiscalYear#), 0) AS Sessions
	</cfif>
</cfquery>

<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="ARL Report for Fiscal Year">
	<caption align="center" style="font-weight:bold">
		ARL Report
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
	<tr>
		<th scope="col" align="right">Number of library presentations to groups</th>
		<th scope="col" align="right">Number of total participants in group presentations</th>
	</tr>
	<cfoutput query="Sums">
	<tr>
		<td align="right">#Sums.Sessions#</td>
		<td align="right">#Sums.People#</td>
	</tr>
	</cfoutput>
</table>

<!---cfif FORM.QuarterID neq 0 and FORM.Year neq 0>
	<cfquery name="Sums" datasource="#APPLICATION.dsn#">
		SELECT Coalesce(dbo.count_attendees_by_qfy(#FORM.QuarterID#, #FORM.Year#), 0) AS People, Coalesce(dbo.total_sessions_by_qfy(#FORM.QuarterID#, #FORM.Year#), 0) AS Sessions
	</cfquery>
<cfelseif FORM.Year neq 0>
	<cfquery name="Sums" datasource="#APPLICATION.dsn#">
		SELECT Coalesce(dbo.count_attendees_by_fy(#FORM.Year#), 0) AS People, Coalesce(dbo.total_sessions_by_fy(#FORM.Year#), 0) AS Sessions
	</cfquery>
<cfelse>
	<cfquery name="Sums" datasource="#APPLICATION.dsn#">
		SELECT Coalesce(dbo.count_attendees_by_fy(#fiscalYear#), 0) AS People, Coalesce(dbo.total_sessions_by_fy(#fiscalYear#), 0) AS Sessions
	</cfquery>
</cfif--->


<!---SELECT Coalesce(dbo.count_attendees_by_date(#FORM.SessionDate#), 0) AS People, Coalesce(dbo.total_sessions_by_date(#FORM.SessionDate#), 0) AS Sessions--->
