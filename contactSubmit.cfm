<html>
	<head>
		<title>SIA Database</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<link href="css/global.css" rel="stylesheet" type="text/css">
		<script language = "JavaScript" type="text/javascript">
			<!--
				// function to populate the date on the form and to close this window. --->
				function ShowContact(CnctName, CnctID)
				{
					<cfoutput>
						eval("self.opener.document.#formName#.#displayName#.value = CnctName");
						eval("self.opener.document.#formName#.#valueName#.value = CnctID");
						setTimeout('window.close()',500);
					</cfoutput>
				}
			//-->
		</script>
	</head>
	<cfoutput>
		<body onLoad="javascript:ShowContact('#cnctName#',#cnctID#)"></body>
	</cfoutput>
</html>
