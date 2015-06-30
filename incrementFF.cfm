function increment(e)
{
//Firefox: 0 = left, 2 = right
	var TypeID = this.name.substr(7,2);
	var left = 0;
	var right = 2;

	if (e.button == left)
	{
		// if the field is empty, then set the value to 1
		if (isNaN(parseInt(this.value)))
		{
			this.value = 1;
		}
		// if the field contained a numeric value and the question was a reference question, increment the value
		else
		{
			this.value = parseInt(this.value) + 1;
		}
		//if the the question was a reference question then increment transaction count
		if (TypeID == '02' ||
			TypeID == '03' ||
			TypeID == '04' ||
			TypeID == '05' ||
			TypeID == '06' ||
			TypeID == '08' ||
			TypeID == '00')
		{
			//if no transactions set transaction count to 1
			if (!Transaction)
			{
				document.KeyPad.BIO04010000.value = 1;
				Transaction = true;
			}
			//otherwise increment transaction count
			else
			{
				document.KeyPad.BIO04010000.value = parseInt(document.KeyPad.BIO04010000.value) + 1;
			}
		}
	}
	// if the action is a right mouse button click
	if (e.button == right)
	{
		// if the the field contains a number and it is greater than 1, then decrement the value
		if (!isNaN(parseInt(this.value)))
		{
			if (parseInt(this.value) > 1)
			{
				this.value = parseInt(this.value) - 1;
			}
			// if the field contains a number and it is less than or equal to 1, then set the value to blank
			else
			{
				this.value = "";
			}
		}
		if (TypeID == '02' ||
			TypeID == '03' ||
			TypeID == '04' ||
			TypeID == '05' ||
			TypeID == '06' ||
			TypeID == '08' ||
			TypeID == '00')
		{
			if (!isNaN(parseInt(document.KeyPad.BIO04010000.value)))
			{
				if (parseInt(document.KeyPad.BIO04010000.value) > 1)
				{
					document.KeyPad.BIO04010000.value = parseInt(document.KeyPad.BIO04010000.value) - 1;
				}
				// if the field contains a number and it is less than or equal to 1, then set the value to blank
				else
				{
					document.KeyPad.BIO04010000.value = "";
					Transaction = false;
				}
			}
		}
	}
}

var BIO04010101 = document.getElementById('BIO04010101');
var BIO04010102 = document.getElementById('BIO04010102');
var BIO04010201 = document.getElementById('BIO04010201');
var BIO04010202 = document.getElementById('BIO04010202');
var BIO04010301 = document.getElementById('BIO04010301');
var BIO04010302 = document.getElementById('BIO04010302');
var BIO04010401 = document.getElementById('BIO04010401');
var BIO04010402 = document.getElementById('BIO04010402');
var BIO04010501 = document.getElementById('BIO04010501');
var BIO04010502 = document.getElementById('BIO04010502');

if( BIO04010101.addEventListener )
{
  BIO04010101.addEventListener('mousedown',increment,false);
}
else if( BIO04010101.attachEvent )
{
  BIO04010101.attachEvent('onmousedown',increment);
}
if( BIO04010102.addEventListener )
{
  BIO04010102.addEventListener('mousedown',increment,false);
}
else if( BIO04010102.attachEvent )
{
  BIO04010102.attachEvent('onmousedown',increment);
}

if( BIO04010201.addEventListener )
{
  BIO04010201.addEventListener('mousedown',increment,false);
}
else if( BIO04010201.attachEvent )
{
  BIO04010201.attachEvent('onmousedown',increment);
}
if( BIO04010202.addEventListener )
{
  BIO04010202.addEventListener('mousedown',increment,false);
}
else if( BIO04010202.attachEvent )
{
  BIO04010202.attachEvent('onmousedown',increment);
}

if( BIO04010301.addEventListener )
{
  BIO04010301.addEventListener('mousedown',increment,false);
}
else if( BIO04010301.attachEvent )
{
  BIO04010301.attachEvent('onmousedown',increment);
}
if( BIO04010302.addEventListener )
{
  BIO04010302.addEventListener('mousedown',increment,false);
}
else if( BIO04010302.attachEvent )
{
  BIO04010302.attachEvent('onmousedown',increment);
}

if( BIO04010401.addEventListener )
{
  BIO04010401.addEventListener('mousedown',increment,false);
}
else if( BIO04010401.attachEvent )
{
  BIO04010401.attachEvent('onmousedown',increment);
}
if( BIO04010402.addEventListener )
{
  BIO04010402.addEventListener('mousedown',increment,false);
}
else if( BIO04010402.attachEvent )
{
  BIO04010402.attachEvent('onmousedown',increment);
}

if( BIO04010501.addEventListener )
{
  BIO04010501.addEventListener('mousedown',increment,false);
}
else if( BIO04010501.attachEvent )
{
  BIO04010501.attachEvent('onmousedown',increment);
}
if( BIO04010502.addEventListener )
{
  BIO04010502.addEventListener('mousedown',increment,false);
}
else if( BIO04010502.attachEvent )
{
  BIO04010502.attachEvent('onmousedown',increment);
}

