<cfif IsDefined("ReportID")>
	<cfif ReportID eq "1">
		<cfset pageTitle = "Orientations/Tours Report">
	</cfif>
	<cfif ReportID eq "2">
		<cfset pageTitle = "Class/Group Lectures Report">
	</cfif>
	<cfif ReportID eq "3">
		<cfset pageTitle = "Sponsored Classes Report">
	</cfif>
	<cfif ReportID eq "4">
		<cfset pageTitle = "Credit Courses Report">
	</cfif>
	<cfif ReportID eq "5">
		<cfset pageTitle = "Small Group Consultations Report">
	</cfif>
	<cfif ReportID eq "6">
		<cfset pageTitle = "ARL Report">
	</cfif>
	<cfif ReportID eq "7">
		<cfset pageTitle = "Coordinators Report">
	</cfif>
	<cfif ReportID eq "8">
		<cfset pageTitle = "Materials Report">
	</cfif>
	<cfif ReportID eq "9">
		<cfset pageTitle = "Outreach Report">
	</cfif>
	<cfif ReportID eq "10">
		<cfset pageTitle = "Contact Hours Report">
	</cfif>
	<cfif ReportID eq "11">
		<cfset pageTitle = "All Libraries Report">
	</cfif>
	<cfif ReportID eq "12">
		<cfset pageTitle = "My Report">
	</cfif>
	<cfif ReportID eq "14">
		<cfset pageTitle = "Scholarly Communication">
	</cfif>
	<cfif ReportID eq "16">
		<cfset pageTitle = "One-on-one consultation">
	</cfif>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
		<title>SIA Database:
			<cfif IsDefined("pageTitle")>
				<cfoutput>#pageTitle#</cfoutput>
			</cfif>
		</title>
		<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=iso-8859-1">
		<link href="css/global.css" rel="stylesheet" type="text/css">
                <script>
                  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                
                  ga('create', 'UA-32672693-3', 'auto');
                  ga('send', 'pageview');
                </script>                
	</head>
	<body>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr valign="middle">
				<td height="35" colspan="6" class="banner">
					<img src="images/SIA_S.gif" alt="UCLA Library SIA Database" width="235" height="30" hspace="15" border="0">
				</td>
			</tr>
		</table>
		<div id="liveArea">