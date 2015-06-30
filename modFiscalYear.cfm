 <cfscript>
	sDate = ATTRIBUTES.sDate;
	m = DatePart("m", sDate);
	y = DatePart("yyyy", sDate);
	if (m gte 7 and m lte 12)
	{
		fiscalYear = y;
	}
	else
	{
		fiscalYear = y -1;
	}
	CALLER.fiscalYear = fiscalYear;
</cfscript>