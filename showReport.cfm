<cfinclude template="authenticateExe.cfm">
<cfset fiscalYear = 0>
<cfmodule template="modFiscalYear.cfm" sDate = #Now()#>
<cfinclude template="incBeginReport.cfm">
<cfif FORM.ReportID eq "1">
	<cfinclude template="incTour.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "2">
	<cfinclude template="incLectures.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "3">
	<cfinclude template="incClasses.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "4">
	<cfinclude template="incCredit.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "5">
	<cfinclude template="incConsult.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "13">
	<cfinclude template="incLiaison.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "14">
	<cfinclude template="incScholar.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "6">
	<cfinclude template="incArl.cfm"><!-- updated -->
</cfif>
<cfif (FORM.ReportID eq "7" and SESSION.UserLevelID neq 3) or FORM.ReportID eq "12">
	<cfinclude template="incGeneral.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "7" and SESSION.UserLevelID eq 3>
	<cfinclude template="incGeneralPlus.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "8">
	<cfinclude template="incMatRpt.cfm"><!-- updated -->
</cfif>
<cfif FORM.ReportID eq "9">
	<cfinclude template="incOutRpt.cfm"><!-- updated -->
</cfif>
<cfif FORM.ReportID eq "10">
	<cfinclude template="incHours.cfm"><!-- need to update this for new date combos & create/verify funcs -->
	<!---cfinclude template="incHoursAlt.cfm"--->
</cfif>
<cfif FORM.ReportID eq "11">
	<cfinclude template="incAllLib.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "15">
	<cfinclude template="incAahsl.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "16">
	<cfinclude template="incAahsl.cfm"><!-- updated 20130619 -->
</cfif>
<cfif FORM.ReportID eq "17">
	<cfinclude template="incLCS.cfm"><!-- updated 20130619 -->
</cfif>
<cfinclude template="incRepEnd.cfm">