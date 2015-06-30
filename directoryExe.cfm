<cfscript>
	up2snuff = 1;
	em =	"Unknown";
	//error =	"Unknown";
	if (isDefined("FORM.qs") and FORM.qs neq "")
	{
		//qs_A = ListToArray(FORM.qs, " ");
		/*	2005-10-07 akohler
			Added Replace function against query string FORM.qs to replace hyphens with spaces
			This allows the LDAP partialName attribute to find the "chunks" of hyphenated names
		*/
		qs_A = ListToArray(Replace(FORM.qs, "-", " ", "all"), " ");
		qs_S = "";
		x = 1;
		while (x lte ArrayLen(qs_A))
		{
			qs_S = qs_S & '(partialName=*' & qs_A[x] & '*)';//ListAppend(qs_S, '(partialName=' & qs_A[x] & ')', " ");
			x = x + 1;
		}
		//ex_S = "";
	}
	else if ((isDefined("FORM.uid") and FORM.uid neq "")
		  or isDefined("URL.uid") and URL.uid neq "")
	{
		if (isDefined("FORM.uid"))
		{
			uid = FORM.uid;
		}
		else
		{
			uid = URL.uid;
		}
		qs_S = '(UID=' & uid & ')';
		//ex_S = "";
	}
	else
	{
		up2snuff = 0;
		em = "No search parameters provided";
		//error = "No search parameters provided";
	}
</cfscript>
<cfif up2snuff>
	<cftry>
		<cfldap action="query"
			name="Person"
			start="ou=person,dc=ldap,dc=ucla,dc=edu"
			scope="subtree"
			startrow="1"
			maxrows="250"
			attributes="uid,
				cn,
				sn,
				uclaPostalAddress,
				admCode,
				department,
				partialDepartment,
				l,
				mail,
				facsimileTelephoneNumber,
				postalCode,
				uclaHomePostalAddress,
				homePhone,
				pagerNumber,
				partialName,
				st,
				streetAddress,
				telephoneNumber,
				telephoneNumberExtension,
				title,
				url,
				asstName,
				asstPhone,
				asstEmail"
			filter="(&#qs_S#)"
			server="ldap.ucla.edu">
		<cfset cnA = ListToArray(#Person.cn#, ", ")>
		<cfcatch type="Any">
			<cfset up2snuff = 0>
			<!---cfset error = "Unable to connect to LDAP server"--->
			<!---cfset em = "Unable to connect to LDAP server"--->
			<cfset em = "#cfcatch.Message#" & "#cfcatch.Detail#">
		</cfcatch>
	</cftry>
</cfif>
<!---
		/*sw = "a,an,and,as,at,be,by,do,et,go,he,if,in,is,it,me,my,no,not,of,ok,on,or,so,the,to,up,us,we";
		swa = ListToArray(sw, ",");
		// loop over the query string to find stop words
		x = 1;
		while (x lte ArrayLen(qs_A))
		{
			y = 1;
			flag = 0;
			while (y lte ArrayLen(swa))
			{
				// if stop words are found, strip them from the query string
				if ((x lte ArrayLen(qs_A)) and (Trim(qs_A[x]) is swa[y]))
				{
					ArrayDeleteAt(qs_A,x);
					flag = 1;
				}
				y = y + 1;
			}
			if (not flag)
			{
				x = x + 1;
			}
			else
			{
				x = x;
			}
		}*/
--->
			<!---filter="(&#qs_S##ex_S#)"--->
			<!---sort="cn"--->
