<!---
// CFFILE variables
attemptedServerFile : LA_Restaurants.pdf
clientDirectory : C:\Documents and Settings\davmoto\Desktop
clientFile : LA_Restaurants.pdf
clientFileExt : pdf
clientFileName : LA_Restaurants
contentSubType : pdf
contentType : application
dateLastAccessed : {d '2005-07-26'}
fileExisted : YES
fileSize : 301684
fileWasAppended : NO
fileWasOverwritten : YES
fileWasRenamed : NO
fileWasSaved : YES
oldFileSize : 301684
serverDirectory : f:\Inetpub\wwwroot\mainlib_test\sia\files\krisk
serverFile : LA_Restaurants.pdf
serverFileExt : pdf
serverFileName : LA_Restaurants
timeCreated : {ts '2005-07-26 08:43:17'}
timeLastModified : {ts '2005-07-26 08:46:16'}
--->
<cfif FORM.overWrite>
	<cftry>
		<cffile action="upload"
			destination="#SESSION.FileLocation#"
			filefield="FileLocation"
			nameconflict="overwrite">
		<cfcatch type="Any">
			<cfset up2snuff = 0>
			<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
			<!---cfset em = "An error ocurred while attempting to upload the file. Please try again."--->
		</cfcatch>
	</cftry>
<cfelse>
	<cftry>
		<cffile action="upload"
			destination="#SESSION.FileLocation#"
			filefield="FileLocation"
			nameconflict="error">
		<cfcatch type="Any">
			<cfset up2snuff = 0>
			<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
			<!---cfset em = "The file could not be uploaded because a file with the same name already exists."--->
		</cfcatch>
	</cftry>
</cfif>
<!---
<cfoutput>
attemptedServerFile : #attemptedServerFile#<br>
clientDirectory : #clientDirectory#<br>
clientFile : #clientFile#<br>
clientFileExt : #clientFileExt#<br>
clientFileName : #clientFileName#<br>
contentSubType : #contentSubType#<br>
contentType : #contentType#<br>
dateLastAccessed : #dateLastAccessed#<br>
fileExisted : #fileExisted#<br>
fileSize : #fileSize#<br>
fileWasAppended : #fileWasAppended#<br>
fileWasOverwritten : #fileWasOverwritten#<br>
fileWasRenamed : #fileWasRenamed#<br>
fileWasSaved : #fileWasSaved#<br>
oldFileSize : #oldFileSize#<br>
serverDirectory : #serverDirectory#<br>
serverFile : #serverFile#<br>
serverFileExt : #serverFileExt#<br>
serverFileName : #serverFileName#<br>
timeCreated : #timeCreated#<br>
timeLastModified : #timeLastModified#<br>
</cfoutput>
--->