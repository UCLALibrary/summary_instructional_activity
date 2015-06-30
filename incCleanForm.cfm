<cfscript>
	for ( keyName in FORM )
	{
		if ( keyName neq "FileLocation" )
		{
			FORM[ keyName ] = ReReplace( FORM[ keyName ], "[[:cntrl:]]", " ", "ALL" );
			FORM[ keyName ] = ReReplace( FORM[keyName], "#Chr(32)#+", " ", "ALL" );
		}
	}
</cfscript>

