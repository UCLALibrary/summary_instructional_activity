// check for IE3
var isIE3 = (navigator.appVersion.indexOf('MSIE 3') != -1);

// object definition
function validation(realName, formEltName, eltType, upToSnuff, format)
{
	this.realName = realName;
	this.formEltName = formEltName;
	this.eltType = eltType;
	this.upToSnuff = upToSnuff;
	this.format = format;
}

function isText(str)
{
	return (str != "");
}

function isSelect(formObj)
{
	return (formObj.selectedIndex != 0);
}

function isRadio(formObj)
{
	for (j=0; j<formObj.length; j++)
	{
		if (formObj[j].checked)
		{
			return true;
		}
	}
	return false;
}

function isEmail(str) 
{
	return ((str != "") && (str.indexOf("@") != -1) && (str.indexOf(".") != -1));
}

function isDate(str)
{
	if (str.length != 10)
	{
		return false;
	}

	for (j=0; j<str.length; j++)
	{
		if ((j == 2) || (j == 5))
		{
			if (str.charAt(j) != "/")
			{
				return false;
			}
		}
		else
		{
			if ((str.charAt(j) < "0") || (str.charAt(j) > "9"))
			{
				return false;
			}
		}
	}

	var month = str.charAt(0) == "0" ? parseInt(str.substring(1,2)) : parseInt(str.substring(0,2));
	var day = str.charAt(3) == "0" ? parseInt(str.substring(4,5)) : parseInt(str.substring(3,5));
	var begin = str.charAt(6) == "0" ? (str.charAt(7) == "0" ? (str.charAt(8) == "0" ? 9 : 8) : 7) : 6;
	var year = parseInt(str.substring(begin, 10));

	if (day == 0)
	{
		return false;
	}
	if (month == 0 || month > 12)
	{
		return false;
	}
	if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
	{
		if (day > 31)
		{
			return false;
		}
	}
	else
	{
		if (month == 4 || month == 6 || month == 9 || month == 11)
		{
			if (day > 30)
			{
				return false;
			}
		}
		else
		{
			if (year%4 != 0)
			{
				if (day > 28)
				{
					return false;
				}
			}
			else
			{
				if (day > 29)
				{
					return false;
				}
			}
		}
	}
	return true;
}

function isCheck(formObj, form, begin, num) 
{
  for (j=begin; j<begin+num; j++) 
  {
    if (form.elements[j].checked) 
    {
      return true;
    }
  }
  return false;
}

function ShowDirectory(formName)
{
	var url = "directory.cfm?formName=" + formName;
	window.open(url, "DirectoryWindow", "width=600,height=350,left=250,top=100,resizable=1,scrollbars=1");
	//	document.Session.SessionDate.value = '';
}

function setVersion(form, newValue)
{
	form.version.value = newValue;
}

