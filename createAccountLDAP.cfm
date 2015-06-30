<cfif not Find("createAccount.cfm", PATH_INFO)>
	<cflocation url="index.cfm" addtoken="no">
	<cfabort>
</cfif>
<cfscript>
	// LDAPFilter = '(&(mail=' & Email & ')(partialname=' & LastName & ')(partialName=' & FirstName & '))';
	/*	2005-10-07 akohler
	UCLA's LDAP server breaks multi-term names into "words", and puts each word in a partialName attribute.
	This means that a last name like Bell-Gam gets stored as partialName=Bell and partialName=Gam, but
	not as partialName=Bell-Gam.
	Changed the LDAPFilter assignment to use be more flexible; now looks for:
	mail=Email AND partialName=FirstName AND (sn=LastName OR partialName=LastName)
	*/
	LDAPFilter = '(&(mail=' & Email & ')(partialName=' & FirstName & ')(|(sn=' & LastName & ')(partialName=' & LastName & ')))';
</cfscript>
<cftry>
	<cfldap	action="query"
		name="Person"
		start="ou=Faculty and Staff,ou=person,dc=ldap,dc=ucla,dc=edu"
		scope="subtree"
		startrow="1"
		maxrows="100"
		attributes="cn,
		mail,
		postalCode,
		telephoneNumber,
		title,
		uclaPostalAddress"
		filter="#LDAPFilter#"
		server="ldap.ucla.edu">
	<cfcatch type="Any">
	<cfscript>
		up2snuff = 0;
		error = "Unable to connect to LDAP server";
	</cfscript>
	</cfcatch>
</cftry>
<cfif up2snuff>
	<cfif Person.RecordCount eq 0>
		<cfscript>
			goodCredential = 0;
			em = 'Your identity could not be verified with the UCLA employee database.';
		</cfscript>
	</cfif>
</cfif>