<cfset pageTitle = "Password Changed">
<cfinclude template="incBegin.cfm">
<cfmodule template="incConfirmTrans.cfm"
	dataSectionTitle = "Password Changed"
	message = "Your password has been changed."
	submitCaption = "Return to My Profile"
	redirectURL = "updatedLibrarian.cfm">
<cfinclude template="incEnd.cfm">
