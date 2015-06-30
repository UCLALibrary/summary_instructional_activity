<cfscript>
if ( StructKeyExists( FORM, "setUID" ) )
{
	if ( FORM.setUID eq 0 )
	{
		up2snuff = 0;
		badDataType = "setUID";
		em = "You must select a unit.";
	}
}

if ( ( StructKeyExists( FORM, "SessionDate" ) or
       StructKeyExists( FORM, "CompletionDT" ) ) and
     StructKeyExists( FORM, "QuarterID" ) )
{
	if ( FORM.QuarterID neq 0 )
	{
		if ( isDefined( "FORM.SessionDate" ) and FORM.SessionDate eq "")
		{
			up2snuff = 0;
			badDataType = "SessionDate";
			em = "You must include a session date if you specify a quarter";
		}
		/*if ( isDefined( "FORM.CompletionDT" ) and FORM.CompletionDT eq "" )
		{
			up2snuff = 0;
			badDataType = "CompletionDT";
			em = "You must include a completion date if you specify a quarter.";
		}*/
	}
}

if ( StructKeyExists( FORM, "URL" ) or
     StructKeyExists( FORM, "CalendarURL" ) )
{
	for ( keyName in FORM )
	{
		if ( keyName eq "URL" or keyName eq "CalendarURL" )
		{
			if ( FORM[ keyName ] neq "" )
			{
				InURL = FORM[ keyName ];
				if ( Left( InURL, 7 ) neq "http://" and Left( InURL, 8 ) neq "https://" )
				{
					up2snuff = 0;
					badDataType = keyName;
					em = "The URL you have entered is invalid.";
					break;
				}
			}
		}
	}
}

if ( StructKeyExists( FORM, "FeedbackStudentID" ) and
     FORM.FeedbackStudentID contains 6 and
     not StructKeyExists( FORM, "ClassroomAssessmentID" ) )
{
	up2snuff = 0;
	badDataType = "FeedbackStudentID";
	em = "If you specify 'Classroom assessment technique' for 'Feedback from students', you must specify one or more sub-type(s).";
}

if ( StructKeyExists( FORM, "SessionDate" ) or
     StructKeyExists( FORM, "OutreachDate" ) or
     StructKeyExists( FORM, "CompletionDT" ) )
{
	for ( keyName in FORM )
	{
		if ( keyName eq "SessionDate" or
		     keyName eq "OutreachDate" or
		     keyName eq "CompletionDT" )
		{
			if ( FORM[ keyName ] neq "" )
			{
				Date = FORM[ keyName ];
				if ( not isDate( Date ) )
				{
					up2snuff = 0;
					badDataType = keyName;
					em = "The date you have entered is invalid.";
					break;
				}
				else if ( Date neq DateFormat( Date, "mm/dd/yyyy" ) )
				{
					up2snuff = 0;
					badDataType = keyName;
					em = "The date you have entered is invalid.";
					break;
				}
			}
		}
	}
}

if ( StructKeyExists( FORM, "Duration" ) or
     StructKeyExists( FORM, "DevTime" ) or
     StructKeyExists( FORM, "NumAttendees" ) or
     StructKeyExists( FORM, "NumEnrolled" ) )
{
	for (keyName in FORM)
	{
		if ( keyName eq "Duration" or
		     keyName eq "DevTime" or
		     keyName eq "NumAttendees" or
		     keyName eq "NumEnrolled" )
		{
			if ( FORM[ keyName ] neq "" )
			{
				Number = FORM[ keyName ];
				if ( Int( Number ) neq Number )
				{
					up2snuff = 0;
					badDataType = keyName;
					em = "The the field labeled in red must contain a whole number.";
					break;
				}
			}
		}
	}
}

if ( StructKeyExists( FORM, "Email" ) )
{
	for ( keyName in FORM )
	{
		if ( keyName eq "Email" )
		{
			if ( FORM[ keyName ] neq "" )
			{
				if ( not ReFind( "[A-Za-z0-9]@[A-Za-z0-9]", FORM.Email ) or
				     not ReFind( "[A-Za-z0-9]\.[A-Za-z0-9]", FORM.Email ) )
				{
					up2snuff = 0;
					badDataType = "Email";
					em = FORM.Email & " is an invalid email address.";
					break;
				}
			}
		}
	}
}
/*
if ( StructKeyExists( FORM, "Telephone" ) or
     StructKeyExists( FORM, "TelephoneMobile" ) or
     StructKeyExists( FORM, "Fax" ) )
{
	for ( keyName in FORM )
	{
		if ( keyName eq "Telephone" or
		     keyName eq "TelephoneMobile" or
		     keyName eq "Fax" )
		{
			if ( FORM[ keyName ] neq "" )
			{
				Number = FORM[ keyName ];
				if ( Len( Number ) lt 12 or
				     Len( Number ) gt 12 or
				     ReFind( "[^-0-9]", Number ) )
				{
					up2snuff = 0;
					badDataType = keyName;
					em = FORM[keyName] & " is an invalid telephone or fax number.";
					break;
				}
				else
				{
					for ( i = 1; i lte Len( Number ); i = i + 1 )
					{
						if ( i eq 4 or i eq 8 )
						{
							if ( Mid( Number, i, 1 ) neq "-" )
							{
								up2snuff = 0;
								badDataType = keyName;
								em = "Please input telephone and/or fax numbers in the format '310-123-4567'.";
							}
						}
						else
						{
							if ( Asc( Mid( Number, i, 1 ) ) lt 48 or
							     Asc( Mid( Number, i, 1 ) ) gt 57 )
							{
								up2snuff = 0;
								badDataType = keyName;
								em = FORM[keyName] & " is an invalid telephone or fax number.";
							}
						}
					}
				}
			}
		}
	}
}
*/
</cfscript>