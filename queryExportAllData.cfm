<cfquery name="qryExportAllData" datasource="#APPLICATION.dsn#">
select 
	convert(varchar, s.SessionDateTime, 120) as SessionDateTime,
	atl.ActivityType as SessionType,
	'"' + replace(replace(coalesce(a.Title, 'N/A'), ',', ';'), '"', '''') + '"' As Title,
	'"' + coalesce(dbo.build_sess_dept_title(s.SessionID), 'N/A') + '"' as Departments,
	'"' + replace(replace(coalesce(s.CourseNumber, 'N/A'), ',', ';'), '"', '''')  + '"' as CourseNumber,
	'"' + replace(replace(coalesce(s.CourseSection, 'N/A'), ',', ';'), '"', '''')  + '"' as CourseSection,
	'"' + replace(replace(coalesce(s.GroupName, 'N/A'), ',', ';'), '"', '''')  + '"' as GroupName,
	'"' + replace(replace(cast(a.Description as varchar(max)), ',', ';'), '"', '''') + '"' as Description,
	dbo.build_learner_cats(s.SessionID) as LearnerTypes,
	case
		when NumAttendees IS not null then NumAttendees
		when NumEnrolled IS not null then NumEnrolled
		else null
	end as LearnerCount,
	dbo.total_sessions(s.SessionID) As SessionCount,
	coalesce(dbo.total_duration(s.sessionid), 0) as Duration,
	dbo.get_developers_by_session(a.ActivityID) as Developers,
	dbo.get_developer_units(a.ActivityID) as DeveloperUnits,
	dbo.get_presenters_by_session(s.SessionID) as Presenters,
	dbo.get_presenter_units(s.SessionID) as PresenterUnits,
	case
		when LEN('"' + coalesce(dbo.get_faculty_by_session(s.SessionID), 'N/A') + '"') = 2 then 'N/A'
		else '"' + coalesce(dbo.get_faculty_by_session(s.SessionID), 'N/A') + '"'
	end AS FacContacts,
	case
		when LEN('"' + coalesce(dbo.get_fac_email_by_session(s.SessionID), 'N/A') + '"') = 2 then 'N/A'
		else '"' + coalesce(dbo.get_fac_email_by_session(s.SessionID), 'N/A') + '"'
	end AS FacEmails,
	case
		when LEN('"' + coalesce(dbo.build_initiatives(s.SessionID), 'N/A') + '"') = 2 then 'N/A'
		else '"' + coalesce(dbo.build_initiatives(s.SessionID), 'N/A') + '"'
	end AS Initiatives
from 
	dbo.Session s
	join dbo.SessionActivity sa on s.SessionID = sa.SessionID
	join dbo.Activity a on sa.ActivityID = a.ActivityID
	join dbo.ActivityTypeLookup atl on a.ActivityTypeID = atl.ActivityTypeID
where s.SessionDateTime between '#m_start_date# 00:00:00' and '#m_end_date# 23:59:59'
order by s.SessionDateTime
</cfquery>
