<cfquery name="Librarians" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		l.LastName,
		l.FirstName,
		l.LibrarianID
	FROM
		dbo.Librarian l
		JOIN dbo.SessionLibrarian sl ON l.LibrarianID = sl.LibrarianID
		JOIN dbo.Accounts a ON l.LibrarianID = a.LibrarianID
	WHERE
		--l.Active = 1 AND
		a.UserLevelID = 1
	<cfif SESSION.UserLevelID eq 2>
		AND l.UnitID = #SESSION.UID#
	</cfif>
	ORDER BY
		l.LastName
</cfquery>

<cfquery name="Contacts" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		c.LastName,
		c.FirstName,
		c.ContactID
	FROM
		dbo.Contact c
		JOIN dbo.SessionContact sc ON c.ContactID = sc.ContactID
	ORDER BY
		c.LastName
</cfquery>

<cfquery name="Classrooms" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT
		c.Name,
		c.Building,
		c.RoomNumber,
		c.ClassroomID
	FROM
		dbo.Classroom c
		JOIN dbo.SessionClassroom sc ON c.ClassroomID = sc.ClassroomID
	ORDER BY
		c.Name
</cfquery>

<cfquery name="Years" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT Datepart(Year, SessionDateTime) AS TheYear from dbo.Session ORDER BY TheYear
</cfquery>

<cfquery name="Reports" datasource="#APPLICATION.dsn#">
	SELECT * FROM dbo.Reports WHERE Active = 1 ORDER BY SortBy
</cfquery>

<cfquery name="Durations" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT Duration FROM dbo.Session WHERE Duration IS NOT NULL
</cfquery>

<cfquery name="PrepTimes" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT PrepTime FROM dbo.SessionPreparationTime WHERE PrepTime IS NOT NULL
</cfquery>

<cfquery name="DevTimes" datasource="#APPLICATION.dsn#">
	SELECT DISTINCT DevTime FROM dbo.ActivityDevelopmentTime WHERE DevTime IS NOT NULL
</cfquery>
