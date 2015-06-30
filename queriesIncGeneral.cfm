<cfquery name="Tours" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		a.Title,
		a.QuarterID,
		ql.Quarter,
		dbo.total_sessions(a.ActivityID) AS Sessions,
		dbo.count_attendees_by_activity(a.ActivityID) AS People,
		Coalesce(dbo.total_duration(a.ActivityID), 0) AS Duration,
		dbo.get_display_time((Coalesce(dbo.total_duration(a.ActivityID), 0))) AS display_dur,
		Coalesce(dbo.total_prep_time(a.ActivityID), 0) AS PrepTime,
		dbo.get_display_time((Coalesce(dbo.total_prep_time(a.ActivityID), 0))) AS display_prep,
		Coalesce(dbo.total_dev_time(a.ActivityID), 0) AS DevTime,
		dbo.get_display_time((Coalesce(dbo.total_dev_time(a.ActivityID), 0))) AS display_dev
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		JOIN dbo.QuarterLookup ql ON s.QuarterID = ql.QuarterID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID
		LEFT JOIN dbo.UnitLookup u ON sl.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.SessionPreparationTime spt ON s.SessionID = spt.SessionID
		LEFT JOIN dbo.ActivityDevelopmentTime adt ON a.ActivityID = adt.ActivityID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
	WHERE
		a.ActivityTypeID = 1
		<cfif FORM.QuarterID neq 0 and FORM.Year neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND Datepart(Year, s.SessionDateTime) = #FORM.Year#
			)
		<cfelseif FORM.SessionDate neq "">
			AND s.SessionDateTime = '#FORM.SessionDate#'
		<cfelse>
			AND
			(
					(Datepart(Year, s.SessionDateTime) = #fiscalYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
					 OR (Datepart(Year, s.SessionDateTime) = #fiscalYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif FORM.OwnerID neq 0>
			AND sl.LibrarianID = #FORM.OwnerID#
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.ClassID neq 0>
			AND scl.ClassroomID = #FORM.ClassID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif FORM.LearnerCategoryID neq 0>
			AND s.LearnerCategoryID = #FORM.LearnerCategoryID#
		</cfif>
		<cfif FORM.AffiliationID neq 0>
			AND s.AffiliationID = #FORM.AffiliationID#
		</cfif>
		<cfif FORM.DeliveryModeID neq 0>
			AND a.DeliveryModeID = #FORM.DeliveryModeID#
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND sl.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		a.ActivityTypeID,
		a.QuarterID,
		a.Title
</cfquery>

<cfquery name="Lectures" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		a.Title,
		a.QuarterID,
		ql.Quarter,
		dbo.total_sessions(a.ActivityID) AS Sessions,
		dbo.count_attendees_by_activity(a.ActivityID) AS People,
		Coalesce(dbo.total_duration(a.ActivityID), 0) AS Duration,
		dbo.get_display_time((Coalesce(dbo.total_duration(a.ActivityID), 0))) AS display_dur,
		Coalesce(dbo.total_prep_time(a.ActivityID), 0) AS PrepTime,
		dbo.get_display_time((Coalesce(dbo.total_prep_time(a.ActivityID), 0))) AS display_prep,
		Coalesce(dbo.total_dev_time(a.ActivityID), 0) AS DevTime,
		dbo.get_display_time((Coalesce(dbo.total_dev_time(a.ActivityID), 0))) AS display_dev
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		JOIN dbo.QuarterLookup ql ON s.QuarterID = ql.QuarterID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID
		LEFT JOIN dbo.UnitLookup u ON sl.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.SessionPreparationTime spt ON s.SessionID = spt.SessionID
		LEFT JOIN dbo.ActivityDevelopmentTime adt ON a.ActivityID = adt.ActivityID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
	WHERE
		a.ActivityTypeID = 2
		<cfif FORM.QuarterID neq 0 and FORM.Year neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND Datepart(Year, s.SessionDateTime) = #FORM.Year#
			)
		<cfelseif FORM.SessionDate neq "">
			AND s.SessionDateTime = '#FORM.SessionDate#'
		<cfelse>
			AND
			(
					(Datepart(Year, s.SessionDateTime) = #fiscalYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
					 OR (Datepart(Year, s.SessionDateTime) = #fiscalYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif FORM.OwnerID neq 0>
			AND sl.LibrarianID = #FORM.OwnerID#
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.ClassID neq 0>
			AND scl.ClassroomID = #FORM.ClassID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif FORM.LearnerCategoryID neq 0>
			AND s.LearnerCategoryID = #FORM.LearnerCategoryID#
		</cfif>
		<cfif FORM.AffiliationID neq 0>
			AND s.AffiliationID = #FORM.AffiliationID#
		</cfif>
		<cfif FORM.DeliveryModeID neq 0>
			AND a.DeliveryModeID = #FORM.DeliveryModeID#
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND sl.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		a.ActivityTypeID,
		a.QuarterID,
		a.Title
</cfquery>

<cfquery name="Classes" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		a.Title,
		a.QuarterID,
		ql.Quarter,
		dbo.total_sessions(a.ActivityID) AS Sessions,
		dbo.count_attendees_by_activity(a.ActivityID) AS People,
		Coalesce(dbo.total_duration(a.ActivityID), 0) AS Duration,
		dbo.get_display_time((Coalesce(dbo.total_duration(a.ActivityID), 0))) AS display_dur,
		Coalesce(dbo.total_prep_time(a.ActivityID), 0) AS PrepTime,
		dbo.get_display_time((Coalesce(dbo.total_prep_time(a.ActivityID), 0))) AS display_prep,
		Coalesce(dbo.total_dev_time(a.ActivityID), 0) AS DevTime,
		dbo.get_display_time((Coalesce(dbo.total_dev_time(a.ActivityID), 0))) AS display_dev
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		JOIN dbo.QuarterLookup ql ON s.QuarterID = ql.QuarterID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID
		LEFT JOIN dbo.UnitLookup u ON sl.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.SessionPreparationTime spt ON s.SessionID = spt.SessionID
		LEFT JOIN dbo.ActivityDevelopmentTime adt ON a.ActivityID = adt.ActivityID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
	WHERE
		a.ActivityTypeID = 3
		<cfif FORM.QuarterID neq 0 and FORM.Year neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND Datepart(Year, s.SessionDateTime) = #FORM.Year#
			)
		<cfelseif FORM.SessionDate neq "">
			AND s.SessionDateTime = '#FORM.SessionDate#'
		<cfelse>
			AND
			(
					(Datepart(Year, s.SessionDateTime) = #fiscalYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
					 OR (Datepart(Year, s.SessionDateTime) = #fiscalYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif FORM.OwnerID neq 0>
			AND sl.LibrarianID = #FORM.OwnerID#
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.ClassID neq 0>
			AND scl.ClassroomID = #FORM.ClassID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif FORM.LearnerCategoryID neq 0>
			AND s.LearnerCategoryID = #FORM.LearnerCategoryID#
		</cfif>
		<cfif FORM.AffiliationID neq 0>
			AND s.AffiliationID = #FORM.AffiliationID#
		</cfif>
		<cfif FORM.DeliveryModeID neq 0>
			AND a.DeliveryModeID = #FORM.DeliveryModeID#
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND sl.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		a.ActivityTypeID,
		a.QuarterID,
		a.Title
</cfquery>

<cfquery name="Credits" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		a.Title,
		a.QuarterID,
		ql.Quarter,
		dbo.total_sessions(a.ActivityID) AS Sessions,
		dbo.count_attendees_by_activity(a.ActivityID) AS People,
		Coalesce(dbo.total_duration(a.ActivityID), 0) AS Duration,
		dbo.get_display_time((Coalesce(dbo.total_duration(a.ActivityID), 0))) AS display_dur,
		Coalesce(dbo.total_prep_time(a.ActivityID), 0) AS PrepTime,
		dbo.get_display_time((Coalesce(dbo.total_prep_time(a.ActivityID), 0))) AS display_prep,
		Coalesce(dbo.total_dev_time(a.ActivityID), 0) AS DevTime,
		dbo.get_display_time((Coalesce(dbo.total_dev_time(a.ActivityID), 0))) AS display_dev
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		JOIN dbo.QuarterLookup ql ON s.QuarterID = ql.QuarterID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID
		LEFT JOIN dbo.UnitLookup u ON sl.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.SessionPreparationTime spt ON s.SessionID = spt.SessionID
		LEFT JOIN dbo.ActivityDevelopmentTime adt ON a.ActivityID = adt.ActivityID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
	WHERE
		a.ActivityTypeID = 4
		<cfif FORM.QuarterID neq 0 and FORM.Year neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND Datepart(Year, s.SessionDateTime) = #FORM.Year#
			)
		<cfelseif FORM.SessionDate neq "">
			AND s.SessionDateTime = '#FORM.SessionDate#'
		<cfelse>
			AND
			(
					(Datepart(Year, s.SessionDateTime) = #fiscalYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
					 OR (Datepart(Year, s.SessionDateTime) = #fiscalYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif FORM.OwnerID neq 0>
			AND sl.LibrarianID = #FORM.OwnerID#
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.ClassID neq 0>
			AND scl.ClassroomID = #FORM.ClassID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif FORM.LearnerCategoryID neq 0>
			AND s.LearnerCategoryID = #FORM.LearnerCategoryID#
		</cfif>
		<cfif FORM.AffiliationID neq 0>
			AND s.AffiliationID = #FORM.AffiliationID#
		</cfif>
		<cfif FORM.DeliveryModeID neq 0>
			AND a.DeliveryModeID = #FORM.DeliveryModeID#
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND sl.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		a.ActivityTypeID,
		a.QuarterID,
		a.Title
</cfquery>

<cfquery name="Consults" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		a.Title,
		a.QuarterID,
		ql.Quarter,
		dbo.total_sessions(a.ActivityID) AS Sessions,
		dbo.count_attendees_by_activity(a.ActivityID) AS People,
		Coalesce(dbo.total_duration(a.ActivityID), 0) AS Duration,
		dbo.get_display_time((Coalesce(dbo.total_duration(a.ActivityID), 0))) AS display_dur,
		Coalesce(dbo.total_prep_time(a.ActivityID), 0) AS PrepTime,
		dbo.get_display_time((Coalesce(dbo.total_prep_time(a.ActivityID), 0))) AS display_prep,
		Coalesce(dbo.total_dev_time(a.ActivityID), 0) AS DevTime,
		dbo.get_display_time((Coalesce(dbo.total_dev_time(a.ActivityID), 0))) AS display_dev
	FROM
		dbo.Activity a
		JOIN dbo.SessionActivity sa ON a.ActivityID = sa.ActivityID
		JOIN dbo.Session s ON sa.SessionID = s.SessionID
		JOIN dbo.QuarterLookup ql ON s.QuarterID = ql.QuarterID
		LEFT JOIN dbo.SessionLibrarian sl ON s.SessionID = sl.SessionID
		LEFT JOIN dbo.UnitLookup u ON sl.UnitID = u.UnitID
		LEFT JOIN dbo.SessionContact sco ON s.SessionID = sco.SessionID
		LEFT JOIN dbo.SessionClassroom scl ON s.SessionID = scl.SessionID
		LEFT JOIN dbo.ActivityMaterial am ON a.ActivityID = am.ActivityID
		LEFT JOIN dbo.Material m ON am.MaterialID = m.MaterialID
		LEFT JOIN dbo.SessionPreparationTime spt ON s.SessionID = spt.SessionID
		LEFT JOIN dbo.ActivityDevelopmentTime adt ON a.ActivityID = adt.ActivityID
		LEFT JOIN dbo.Contact c ON sco.ContactID = c.ContactID
	WHERE
		a.ActivityTypeID = 5
		<cfif FORM.QuarterID neq 0 and FORM.Year neq 0>
			AND
			(
				s.QuarterID = #FORM.QuarterID# AND Datepart(Year, s.SessionDateTime) = #FORM.Year#
			)
		<cfelseif FORM.SessionDate neq "">
			AND s.SessionDateTime = '#FORM.SessionDate#'
		<cfelse>
			AND
			(
					(Datepart(Year, s.SessionDateTime) = #fiscalYear# AND Datepart(Month, s.SessionDateTime) BETWEEN 7 AND 12)
					 OR (Datepart(Year, s.SessionDateTime) = #fiscalYear# + 1 AND Datepart(Month, s.SessionDateTime) BETWEEN 1 AND 6)
			)
		</cfif>
		<cfif FORM.OwnerID neq 0>
			AND sl.LibrarianID = #FORM.OwnerID#
		</cfif>
		<cfif FORM.CntctID neq 0>
			AND sco.ContactID = #FORM.CntctID#
		</cfif>
		<cfif FORM.ClassID neq 0>
			AND scl.ClassroomID = #FORM.ClassID#
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			AND s.DepartmentID = #FORM.DepartmentID#
		</cfif>
		<cfif FORM.LearnerCategoryID neq 0>
			AND s.LearnerCategoryID = #FORM.LearnerCategoryID#
		</cfif>
		<cfif FORM.AffiliationID neq 0>
			AND s.AffiliationID = #FORM.AffiliationID#
		</cfif>
		<cfif FORM.DeliveryModeID neq 0>
			AND a.DeliveryModeID = #FORM.DeliveryModeID#
		</cfif>
		<cfif FORM.MaterialTypeID neq 0>
			AND m.MaterialTypeID = #FORM.MaterialTypeID#
		</cfif>
		<cfif FORM.UnitID neq 0>
			AND sl.UnitID = #FORM.UnitID#
		</cfif>
		<cfif FORM.FacultyGroup neq "">
			AND c.FacultyGroup = '#FORM.FacultyGroup#'
		</cfif>
	ORDER BY
		a.ActivityTypeID,
		a.QuarterID,
		a.Title
</cfquery>
