<cfinclude template="incCleanForm.cfm">
<cfscript>
	up2snuff = 0;
	missingRequired = 0;
	em = "";
	if ( not IsDefined( "FORM.reqElements" ) )
	{
		em = "Input value (reqElements) specifying required form fields must be provided";
	}
	else
	{
		if (FORM.reqElements eq "none")
		{
			missingRequired = 0;
			up2snuff = 1;
		}
		else
		{
			elementValue = StructNew();
			if ( not StructIsEmpty( FORM ) )
			{
				up2snuff = 1;
				for (keyName in FORM)
				{
					if (not FindNoCase("fieldnames", keyName) and
						not FindNoCase("reqElements", keyName))
					{
						val = StructInsert(elementValue, keyName, FORM[keyName], "TRUE");
					}
				}
			}
			else
			{
				em = "A blank form cannot be submitted";
			}
			if (up2snuff)
			{
				reqElementsArray = ArrayNew(2);
				pairArray = ListToArray(reqElements, ";");
				x = 1;
				while ( x lte ArrayLen( pairArray ) )
				{
					reqElementsArray[ x ][ 1 ] = SpanExcluding( pairArray[ x ], "," );
					pairArray[ x ] = RemoveChars( pairArray[ x ], 1, Evaluate( Len( SpanExcluding( pairArray[ x ], "," ) ) + 1 ) );
					reqElementsArray[ x ][ 2 ] = pairArray[ x ];
					x = x + 1;
				}
				missingElements = StructNew();
				x = 1;
				while ( x lte ArrayLen( reqElementsArray ) )
				{
					for ( keyName in elementValue )
					{
						if ( reqElementsArray[ x ][ 1 ] eq keyName and
						     elementValue[ keyName ] eq "" )
						{
							val = StructInsert( missingElements, keyName, elementValue[ keyName ], "TRUE" );
						}
					}
					x = x + 1;
				}
				if ( not StructIsEmpty( missingElements ) )
				{
					up2snuff = 0;
					em = "Fields labeled in red are required.";
					missingRequired = 1;
				}
				else
				{
					up2snuff = 1;
					missingRequired = 0;
				}
			}
		}
	}
</cfscript>