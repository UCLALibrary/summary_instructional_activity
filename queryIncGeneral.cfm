<cfquery name="Sessions" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		a.Title,
		s.QuarterID,
		Coalesce(ql.Quarter, '&nbsp;') AS Quarter,
		s.SessionDateTime,
		Convert(varchar, s.SessionDateTime, 101) AS StyledSessionDateTime,
		dbo.get_developers_by_session(a.ActivityID) AS Developers,
		dbo.get_presenters_by_session(s.SessionID) AS Presenters,
		s.FeedbackText,
		dbo.total_sessions(s.SessionID) AS Sessions,
		dbo.count_attendees_by_session(s.SessionID) AS People,
		Coalesce(dbo.total_duration(s.SessionID), 0) AS Duration,
		dbo.get_display_time((Coalesce(dbo.total_duration(s.SessionID), 0))) AS display_dur,
		Coalesce(dbo.total_prep_time(s.SessionID), 0) AS PrepTime,
		dbo.get_display_time((Coalesce(dbo.total_prep_time(s.SessionID), 0))) AS display_prep
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		LEFT JOIN dbo.QuarterLookup ql ON s.QuarterID = ql.QuarterID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID-- AND s.CreatedBy = sl.LibrarianID
		LEFT JOIN dbo.ActivityLibrarian al ON a.ActivityID = al.ActivityID
		LEFT JOIN dbo.vSession vs ON s.SessionID = vs.SessionID
		LEFT JOIN dbo.Librarian l ON s.CreatedBy = l.LibrarianID
		LEFT JOIN dbo.UnitLookup u ON l.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
		LEFT JOIN dbo.SessionLearner slR ON s.SessionID = slR.SessionID
	WHERE
		<cfif type neq 8>
			a.ActivityTypeID = #type#
		<cfelse>
			a.ActivityTypeID IN (6,7,8)
		</cfif>
		<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year(s.SessionID, s.QuarterID, #fiscalYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND dbo.quarter_matches_year(s.SessionID, s.QuarterID, #FORM.FYear#) = 1
			)
		<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND Datepart(Year, s.SessionDateTime) = #FORM.CYear#
			)
		<cfelseif FORM.FYear neq 0>
			AND
			(
				(Datepart(Year, s.SessionDateTime) = #FORM.FYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
				 OR (Datepart(Year, s.SessionDateTime) = #FORM.FYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		<cfelseif FORM.CYear neq 0>
			AND
			(
				Datepart(Year, s.SessionDateTime) = #FORM.CYear#
			)
		<cfelseif FORM.SessionDate neq "">
			AND s.SessionDateTime between '#FORM.SessionDate# 00:00.0' and '#FORM.SessionDate# 23:59.9'
		<cfelse>
			AND
			(
				(Datepart(Year, s.SessionDateTime) = #fiscalYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
				 OR (Datepart(Year, s.SessionDateTime) = #fiscalYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif IsDefined("FORM.OwnerID")>
			AND (sl.LibrarianID = #FORM.OwnerID# OR al.LibrarianID = #FORM.OwnerID#)
		</cfif>
		<cfif IsDefined("FORM.Presenters")>
			AND sl.LibrarianID in (#FORM.Presenters#)
		</cfif>
		<cfif IsDefined("FORM.Developers")>
			AND al.LibrarianID in (#FORM.Developers#)
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif IsDefined("FORM.LearnerCategoryID")>
			AND slR.LearnerCategoryID IN (#FORM.LearnerCategoryID#)
		</cfif>
		<cfif IsDefined("FORM.DeliveryModes") and FORM.DeliveryModes neq "">
			AND (a.DeliveryModes like '%#ListFirst(FORM.DeliveryModes,",")#%'
			<cfloop index="delivID" list="#ListRest(FORM.DeliveryModes,',')#" delimiters=",">
				OR a.DeliveryModes like '%#delivID#%'
			</cfloop>
			)
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND l.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		s.QuarterID,
		a.Title,
		s.SessionDateTime
</cfquery>
