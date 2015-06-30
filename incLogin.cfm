<script language="JavaScript" type="text/javascript">
<!--
// create a new object for each form element you need to validate
var UserName = new validation('your user name', 'UserName', 'text', 'isText(str)', null);
var Password = new validation('your password', 'Password', 'text', 'isText(str)', null);
var elts = new Array(
               UserName,
               Password
               );
var allAtOnce = false;
var beginRequestAlertForText = "Please include ";
var beginRequestAlertGeneric = "Please choose ";
var endRequestAlert = ".";
var beginInvalidAlert = " is an invalid ";
var endInvalidAlert = "!";
var beginFormatAlert = "  Use this format: ";

function validateForm(form) {
  var formEltName = "";
  var formObj = "";
  var str = "";
  var realName = "";
  var alertText = "";
  var firstMissingElt = null;
  var hardReturn = "\r\n";
  for (i=0; i<elts.length; i++) {
    formEltName = elts[i].formEltName;
    formObj = eval("form." + formEltName);
    realName = elts[i].realName;
    if (elts[i].eltType == "text") {
      str = formObj.value;
      if (eval(elts[i].upToSnuff)) continue;
      if (str == "") {
        if (allAtOnce) {
          alertText += beginRequestAlertForText + realName + endRequestAlert + hardReturn;
          if (firstMissingElt == null) {firstMissingElt = formObj};
        } else {
          alertText = beginRequestAlertForText + realName + endRequestAlert + hardReturn;
          alert(alertText);
        }
      } else {
        if (allAtOnce) {
          alertText += str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
        } else {
          alertText = str + beginInvalidAlert + realName + endInvalidAlert + hardReturn;
        }
        if (elts[i].format != null) {
          alertText += beginFormatAlert + elts[i].format + hardReturn;
        }
        if (allAtOnce) {
          if (firstMissingElt == null) {firstMissingElt = formObj};
        } else {
          alert(alertText);
        }
      }
    } else {
      if (eval(elts[i].upToSnuff)) continue;
      if (allAtOnce) {
        alertText += beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
        if (firstMissingElt == null) {firstMissingElt = formObj};
      } else {
        alertText = beginRequestAlertGeneric + realName + endRequestAlert + hardReturn;
        alert(alertText);
      }
    }
    if (!isIE3) {
      var goToObj = (allAtOnce) ? firstMissingElt : formObj;
      if (goToObj.select) goToObj.select();
      if (goToObj.focus) goToObj.focus();
    }
    if (!allAtOnce) {return false};
  }
  if (allAtOnce) {
    if (alertText != "") {
      alert(alertText);
      return false;
    }
  }
  return true; //change this to return true
}
//-->
</script>
<div class="form">
<form action="LoginExe.cfm"
      method="post"
      name="LoginExe"
      id="LoginExe"
      onsubmit="JavaScript:return validateForm(this);">

<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
User name
		</td>
		<td>
<input name="UserName" type="text" size="25" maxlength="255">
		</td>
		<td rowspan="3" valign="top">
<a href="">Request an account</a><br>
<a href="">Forgotten password?</a>
		</td>
	</tr>
	<tr>
		<td>
Password
		</td>
		<td>
<input name="Password" type="password" size="25" maxlength="255"><br>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
<input type="submit" class="mainControl" value="Log In">
		</td>
	</tr>
</table>
</form>
</div>