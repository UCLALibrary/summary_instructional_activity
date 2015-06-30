<!--
// Required variables for uspUpdateClassroom
@ClassID INT,
@LibID INT,
@Name VARCHAR(255) = NULL,
@Building VARCHAR(255),
@GeneralDescription TEXT = NULL,
@RoomNumber VARCHAR(255),
@ComputerProjector BIT = NULL,
@Screen BIT = NULL,
@ComputerInstructorDesc TEXT = NULL,
@ComputerStudentDesc TEXT = NULL,
@ADAAccessibility TEXT = NULL,
@RoomCapacity VARCHAR(255) = NULL,
@DepartmentID INT = NULL,
@CalendarURL VARCHAR(500) = NULL,
@ContactLastName VARCHAR(50) = NULL,
@ContactFirstName VARCHAR(50) = NULL,
@Telephone VARCHAR(50) = NULL,
@TelephoneMobile VARCHAR(50) = NULL,
@Fax VARCHAR(50) = NULL,
@Email VARCHAR(50) = NULL
--->
<cfinclude template="incCleanForm.cfm">
<cftry>
	<cfstoredproc procedure="uspUpdateClassroom" datasource="#APPLICATION.dsn#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@ClassID" value="#FORM.ClassID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@LibID" value="#SESSION.LibID#">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Name" value="#FORM.Name#" null="no">
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Building" value="#FORM.Building#" null="no">
		<cfif FORM.GeneralDescription neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@GeneralDescription" value="#FORM.GeneralDescription#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@GeneralDescription" null="yes">
		</cfif>		
		<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@RoomNumber" value="#FORM.RoomNumber#" null="no">
		<cfif isDefined("FORM.ComputerProjector")>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@ComputerProjector" value="#FORM.ComputerProjector#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@ComputerProjector" null="yes">
		</cfif>
		<cfif isDefined("FORM.Screen")>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@Screen" value="#FORM.Screen#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_BIT" dbvarname="@Screen" null="yes">
		</cfif>
		<cfif FORM.ComputerInstructorDesc neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ComputerInstructorDesc" value="#FORM.ComputerInstructorDesc#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ComputerInstructorDesc" null="yes">
		</cfif>
		<cfif FORM.ComputerStudentDesc neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ComputerStudentDesc" value="#FORM.ComputerStudentDesc#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ComputerStudentDesc" null="yes">
		</cfif>
		<cfif FORM.ADAAccessibility neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ADAAccessibility" value="#FORM.ADAAccessibility#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ADAAccessibility" null="yes">
		</cfif>
		<cfif FORM.RoomCapacity neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@RoomCapacity" value="#FORM.RoomCapacity#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@RoomCapacity" null="yes">
		</cfif>
		<cfif FORM.DepartmentID neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" value="#FORM.DepartmentID#">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_INTEGER" dbvarname="@DepartmentID" null="yes">
		</cfif>
		<cfif FORM.CalendarURL neq 0>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CalendarURL" value="#FORM.CalendarURL#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@CalendarURL" null="yes">
		</cfif>
		<cfif FORM.ContactLastName neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ContactLastName" value="#FORM.ContactLastName#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ContactLastName" null="yes">
		</cfif>
		<cfif FORM.ContactFirstName neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ContactFirstName" value="#FORM.ContactFirstName#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@ContactFirstName" null="yes">
		</cfif>
		<cfif FORM.Telephone neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Telephone" value="#FORM.Telephone#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Telephone" null="yes">
		</cfif>
		<cfif FORM.TelephoneMobile neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@TelephoneMobile" value="#FORM.TelephoneMobile#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@TelephoneMobile" null="yes">
		</cfif>
		<cfif FORM.Fax neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Fax" value="#FORM.Fax#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Fax" null="yes">
		</cfif>
		<cfif FORM.Email neq "">
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Email" value="#FORM.Email#" null="no">
		<cfelse>
			<cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" dbvarname="@Email" null="yes">
		</cfif>
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database update error. Please try again.";
		</cfscript>
	</cfcatch>	
</cftry>