<cfscript>
	total_time = attributes.total_time;

	hours = total_time \ 60;
	minutes = total_time mod 60;
	if ( minutes lt 10 )
		minutes = "0" & minutes;

	writeOutput(hours & ':' & minutes);
</cfscript>