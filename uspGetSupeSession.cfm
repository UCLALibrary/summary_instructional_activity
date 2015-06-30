<!---
		QuartID = FORM.QuartID;
		Year = FORM.Year;
		SessionDate = FORM.SessionDate;
		DepID = FORM.DepartmentID;
		UID = FORM.UnitID;
		ActTypeID = FORM.ActivityTypeID;
		ModeID = FORM.DeliveryModeID;
		FiscalY = SESSION.fiscalYear;
--->
<cfset up2snuff = 1>
<cfquery name="Sessions" datasource="#APPLICATION.dsn#">
	SELECT
		vS.*,
		dbo.get_copresenters_by_session(vS.SessionID) AS CoLibs,
		dbo.count_attendees_by_session(vS.SessionID) AS Attendees,
		dbo.get_faculty_by_session(vS.SessionID) AS Faculty
	FROM vSession vS
	WHERE
	<cfif QuartID neq 0 and Year neq 0>
		(vS.QuarterID = #QuartID# AND dbo.quarter_matches_year(vS.SessionID, vS.QuarterID, #Year#) = 1)
--		(vS.QuarterID = #QuartID# AND DATEPART(year, vS.SessionDateTime) = #Year#)
	<cfelseif SessionDate neq "">
		(
			DATEPART(year, vS.SessionDateTime) = DATEPART(year, '#SessionDate#') AND
			DATEPART(month, vS.SessionDateTime) = DATEPART(month, '#SessionDate#') AND
			DATEPART(day, vS.SessionDateTime) = DATEPART(day, '#SessionDate#')
		)
	<cfelse>
		(
			(DATEPART(year, vS.SessionDateTime) = #FiscalY# AND DATEPART(month, vS.SessionDateTime) BETWEEN 7 AND 12)
			OR
			(DATEPART(year, vS.SessionDateTime) = #FiscalY# + 1 AND DATEPART(month, vS.SessionDateTime) BETWEEN 1 AND 6)
		)
	</cfif>
	<cfif DepID neq 0>
		AND vS.SessionDepartmentID = #DepID#
	</cfif>
	<cfif UnitID neq 0>
		AND vS.UnitID = #UID#
	</cfif>
	<cfif ActTypeID neq 0>
		AND vS.ActivityTypeID = #ActTypeID#
	</cfif>
	<cfif ModeID neq 0>
		AND vS.DeliveryModeID = #ModeID#
	</cfif>
	ORDER BY SessionDateTime DESC
</cfquery>

<!--- lookup query for departments --->
<cfif DepID neq 0>
	<cfscript>
		Lookup = "Department";
	</cfscript>
	<cfinclude template="uspGetLookup.cfm">
	<cfif up2snuff and Department.RecordCount neq 0>
		<cfquery name="Department" dbtype="query">
			SELECT * FROM Department WHERE DepartmentID = #DepID#
		</cfquery>
	</cfif>
</cfif>
<!--- lookup query for units --->
<cfif UID neq 0>
	<cfscript>
		Lookup = "Unit";
	</cfscript>
	<cfinclude template="uspGetLookup.cfm">
	<cfif up2snuff and Unit.RecordCount neq 0>
		<cfquery name="Unit" dbtype="query">
			SELECT * FROM Unit WHERE UnitID = #UID#
		</cfquery>
	</cfif>
</cfif>
<!--- lookup query for quarters --->
<cfif Year neq "" and QuartID neq 0>
	<cfscript>
		Lookup = "Quarter";
	</cfscript>
	<cfinclude template="uspGetLookup.cfm">
	<cfif up2snuff and Quarter.RecordCount neq 0>
		<cfquery name="Quarter" dbtype="query">
			SELECT * FROM Quarter WHERE QuarterID = #QuartID#
		</cfquery>
	</cfif>
</cfif>
<!--- lookup query for mode --->
<cfif ModeID neq 0>
	<cfscript>
		Lookup = "DeliveryMode";
	</cfscript>
	<cfinclude template="uspGetLookup.cfm">
	<cfif up2snuff and DeliveryMode.RecordCount neq 0>
		<cfquery name="DeliveryMode" dbtype="query">
			SELECT * FROM DeliveryMode WHERE DeliveryModeID = #ModeID#
		</cfquery>
	</cfif>
</cfif>
<!--- lookup query for type --->
<cfif ActTypeID neq 0>
	<cfscript>
		Lookup = "ActivityType";
	</cfscript>
	<cfinclude template="uspGetLookup.cfm">
	<cfif up2snuff and ActivityType.RecordCount neq 0>
		<cfquery name="ActivityType" dbtype="query">
			SELECT * FROM ActivityType WHERE ActivityTypeID = #ActTypeID#
		</cfquery>
	</cfif>
</cfif>

<!---cfif Sessions.RecordCount neq 0>
	<cfscript>
		if (not isDefined("URL.fld")) {fld = "sd";}
		else {fld = URL.fld;}
		if (not isDefined("URL.ord")) {ord = "a";}
		else {ord = URL.ord;}
	</cfscript>
	<cfquery name="Sessions" dbtype="query">
		SELECT *
		FROM Sessions
		ORDER BY
		<cfswitch expression="#fld#">
			<cfcase value="st">Title #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="sc">ContactLastName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="sq">Quarter #IIf(ord eq "a", DE("DESC"), DE("ASC"))#, SessionDateTime DESC</cfcase>
			<cfcase value="sd">SessionDateTime #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="sh">SessionHour #IIf(ord eq "a", DE("DESC"), DE("ASC"))#, SessionDateTime DESC</cfcase>
			<cfcase value="sl">FullName #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="su">Unit #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="sp">SessionDepartment #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="scp">CoLibs #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="sa">Attendees #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="sv">ActivityType #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfcase value="fa">Faculty #IIf(ord eq "a", DE("DESC"), DE("ASC"))#</cfcase>
			<cfdefaultcase>SessionDateTime DESC</cfdefaultcase>
		</cfswitch>
	</cfquery>
	<cfscript>
		ord = IIf(ord eq "d", DE("a"), DE("d"));
	</cfscript>
</cfif--->