<cfcookie name="cookieOn" value="1">
<cfparam name="URL.action" default="">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>UCLA Library Summary of Instructional Activities Database</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<style>
			/*
			UCLA Blue
			RGB 83 R | 104 G | 149 B
			Web 536895

			UCLA Gold
			RGB 254 R | 187 G | 54B
			Web FFB300
			*/
			body {
				margin: 0;
				height: 100%;
				font-family: Verdana, Arial, Helvetica, sans-serif;
				font-size: small;
				background-color: #536895;
			}
			a:link, a:visited {
				color: #000000;
			}
			#top {
				background-color: #536895;
				position: absolute;
				top: 0px;
				width: 100%;
				height: 50%;
			}
			#title {
				position: absolute;
				bottom: 25%;
				left: 10%;
			}
			#middle {
				background-color: #FFB300;
				position: absolute;
				top: 45%;
				width: 100%;
				height: 160px;
			}
			#form {
				position: absolute;
				top: 10px;
				left: 25%;
			}
			.form form {
				margin: 0;
			}
			.form td {
				font-size: 100%;
				color: #000000;
				padding: 0 1em .5em 0;
			}
			.formSectionTitle {
				font-family: Arial, Helvetica, sans-serif;
				font-size: 150%;
				font-weight: bold;
			}
			.formSectionTitleErr {
				font-family: Arial, Helvetica, sans-serif;
				font-size: 150%;
				font-weight: bold;
				color: #cc0000;
			}
		</style>
		<script language="JavaScript" type="text/javascript" src="js/incFunctions.js"></script>
		<script language="JavaScript" type="text/javascript">
			<!--
				function sf()
				{
					document.Login.UserName.focus();
				}
			//-->
		</script>
                <script>
                  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
                  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
                
                  ga('create', 'UA-32672693-3', 'auto');
                  ga('send', 'pageview');
                </script>
    	</head>
	<body onLoad="JavaScript:sf();">
		<div id = "top">
			<img src="images/titleL.gif" alt="UCLA Library Summary of Instructional Activity Database" width="489" height="104" id="title">
		</div>
		<div id = "rule"></div>
		<div id = "middle">
			<div id="form">
				<script language="JavaScript" type="text/javascript">
					<!--
						// create a new object for each form element you need to validate
						var UserName = new validation('your user name', 'UserName', 'text', 'isText(str)', null);
						var Password = new validation('your password', 'Password', 'text', 'isText(str)', null);
						var elts = new Array( UserName, Password );
						var allAtOnce = false;
						var beginRequestAlertForText = "Please include ";
						var beginRequestAlertGeneric = "Please choose ";
						var endRequestAlert = ".";
						var beginInvalidAlert = " is an invalid ";
						var endInvalidAlert = "!";
						var beginFormatAlert = "  Use this format: ";

						function validateForm(form)
						{
							var formEltName = "";
							var formObj = "";
							var str = "";
							var realName = "";
							var alertText = "";
							var firstMissingElt = null;
							var hardReturn = "\r\n";

							for (i=0; i<elts.length; i++)
							{
								formEltName = elts[i].formEltName;
								formObj = eval("form." + formEltName);
								realName = elts[i].realName;
								if (elts[i].eltType == "text")
								{
									str = formObj.value;
									if (eval(elts[i].upToSnuff))
										continue;
									if (str == "")
									{
										if (allAtOnce)
										{
											alertText += beginRequestAlertForText + realName + endRequestAlert + hardReturn;
											if (firstMissingElt == null)
											{
												firstMissingElt = formObj;
											}
										}
										else
										{
											alertText = beginRequestAlertForText + realName + endRequestAlert + hardReturn;
											alert(alertText);
										}
									}
									else
									{
										if (allAtOnce)
										{
											alertText += str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
										}
										else
										{
											alertText = str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
										}
										if (elts[i].format != null)
										{
											alertText += beginFormatAlert + elts[i].format + hardReturn;
										}
										if (allAtOnce)
										{
											if (firstMissingElt == null)
											{
												firstMissingElt = formObj;
											}
										}
										else
										{
											alert(alertText);
										}
									}
								}
								else
								{
									if (eval(elts[i].upToSnuff))
										continue;
									if (allAtOnce)
									{
										alertText += beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
										if (firstMissingElt == null)
										{
											firstMissingElt = formObj;
										}
									}
									else
									{
										alertText = beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
										alert(alertText);
									}
								}
								if (!isIE3)
								{
									var goToObj = (allAtOnce) ? firstMissingElt : formObj;
									if (goToObj.select)
										goToObj.select();
									if (goToObj.focus)
										goToObj.focus();
								}
								if (!allAtOnce)
								{
									return false;
								}
							}
							if (allAtOnce)
							{
								if (alertText != "")
								{
									alert(alertText);
									return false;
								}
							}
							return true; //change this to return true
						}

					//-->
				</script>
				<div class="form">
					<form action="loginExe.cfm"
						  method="post"
						  name="Login"
						  id="Login"
						  onsubmit="JavaScript:return validateForm(this);">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td></td>
								<td colspan="2">
									<cfif URL.action eq "deny">
										<div class="formSectionTitleErr">Log in error! Try again.</div>
									<cfelseif URL.action eq "nc">
										<div class="formSectionTitleErr">This site required cookies.</div>
									<cfelse>
										<div class="formSectionTitle">Log In</div>
									</cfif>
								</td>
							</tr>
<tr>
<td colspan="2">
<cfoutput>#APPLICATION.HostServer#</cfoutput>
</td>
</tr>
							<tr>
								<td align="right">User name</td>
								<td>
									<input name="UserName" type="text" size="15" maxlength="255">
								</td>
							</tr>
							<tr>
								<td align="right">Password</td>
								<td>
									<input name="Password" type="password" size="15" maxlength="255">
								</td>
							</tr>
							<tr>
								<td></td>
								<td align="right">
									<input type="submit" class="mainControl" value="Log In">
								</td>
								<td valign="top">
									<a href="createAccount.cfm">Create your account</a><br>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td valign="top">
									<a href="getPassword.cfm">Forgot your password?</a><br>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>