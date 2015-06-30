<cfscript>
	if (not isDefined("URL.fld")) {fld = "dt";}
	else {fld = URL.fld;}
	if (not isDefined("URL.ord")) {ord = "d";}
	else {ord = URL.ord;}
	if (ord eq "d") {ord = "DESC";}
	else if (ord eq "a") {ord = "AC";}
	switch(fld) {
		case "mn":
			Sort = "Name " & ord;
		break;
		case "sz":
			Sort = "Size " & ord;
		break;
		case "dt":
			Sort = "dateLastModified " & ord;
		break;
		default:
			Sort = "dateLastModified " & ord;
		break;
	}
</cfscript>
<cftry>
	<cfdirectory
		directory = "#SESSION.FileLocation#"
		action = "list"
		name = "DirectoryFiles"
		sort="#Sort#">
	<cfcatch type="Any">
		<cfset up2snuff = 0>
		<cfset em = "An error ocurred while attempting to list the directory contents">
	</cfcatch>
</cftry>
<cfscript>
	ord = IIf(ord eq "d", DE("a"), DE("d"));
</cfscript>
