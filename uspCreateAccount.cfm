<!---
// Required variables for uspCreateAccount
@UserName VARCHAR(50),
@Email VARCHAR(50),
@LastName VARCHAR(50),
@FirstName VARCHAR(50),
@tempPassword VARCHAR(50),
@Title VARCHAR(50),
@Telephone VARCHAR(50),
@CampusAddress VARCHAR(255),
@CampusMailCode VARCHAR(255)
--->
<cftry>
	<cfstoredproc procedure="uspCreateAccount" datasource="#APPLICATION.dsn#">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@UserName" value="#UserName#" null="no">	
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@Email" value="#Email#" null="no">	
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@LastName" value="#LastName#" null="no">	
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@FirstName" value="#FirstName#" null="no">	
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@tempPassword" value="#tempPassword#" null="no">
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@Title" value="#Title#" null="no">	
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@Telephone" value="#Telephone#" null="no">	
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@CampusAddress" value="#CampusAddress#" null="no">	
		<cfprocparam type = "In" CFSQLType = "CF_SQL_VARCHAR" dbvarname="@CampusMailCode" value="#MailCode#" null="no">	
	</cfstoredproc>
	<cfcatch type="Database">
		<cfscript>
			up2snuff = 0;
			em = "Database insert error";
		</cfscript>
	</cfcatch>	
</cftry>	