<cfinclude template="queryIncArl.cfm">

<cfset sessionGrand = 0>
<cfset peopleGrand = 0>
<cfset grandDur = 0>
<cfset grandPrep = 0>

<table width="98%" summary="All-Library Report">
	<caption align="center" style="font-weight:bold">
	All-Library Report
	<cfoutput>
		<cfif FORM.QuarterID neq 0 and FORM.FYear eq 0 and FORM.CYear eq 0>
			<cfif FORM.QuarterID eq 1>Fall</cfif>
			<cfif FORM.QuarterID eq 2>Winter</cfif>
			<cfif FORM.QuarterID eq 3>Spring</cfif>
			<cfif FORM.QuarterID eq 4>Summer</cfif>
			&nbsp;FY&nbsp;#fiscalYear#/#fiscalYear + 1#
		<cfelseif FORM.QuarterID neq 0 and FORM.FYear neq 0>
			<cfif FORM.QuarterID eq 1>Fall</cfif>
			<cfif FORM.QuarterID eq 2>Winter</cfif>
			<cfif FORM.QuarterID eq 3>Spring</cfif>
			<cfif FORM.QuarterID eq 4>Summer</cfif>
			&nbsp;FY&nbsp;#FORM.FYear#/#FORM.FYear + 1#
		<cfelseif FORM.QuarterID neq 0 and FORM.CYear neq 0>
			<cfif FORM.QuarterID eq 1>Fall</cfif>
			<cfif FORM.QuarterID eq 2>Winter</cfif>
			<cfif FORM.QuarterID eq 3>Spring</cfif>
			<cfif FORM.QuarterID eq 4>Summer</cfif>
			&nbsp;#FORM.CYear#
		<cfelseif FORM.FYear neq 0>
			&nbsp;FY&nbsp;#FORM.FYear#/#FORM.FYear + 1#
		<cfelseif FORM.CYear neq 0>
			&nbsp;#FORM.CYear#
		<cfelseif FORM.SessionDate neq "">
			&nbsp;#FORM.SessionDate#
		<cfelse>
			&nbsp;FY&nbsp;#fiscalYear#/#fiscalYear + 1#
		</cfif>
	</cfoutput>
	</caption>
</table>

<!-- orientations/tours -->
<cfset colSpan = 7>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<h3>Orientations & Tours</h3>
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Orientations & Tours for Fiscal Year">
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Quarter</th>
		<th scope="col" align="left">Course: Group Name</th>
		<th scope="col" align="left">Presenter(s)</th>
		<th scope="col" align="left">Developer(s)</th>
		<th scope="col" align="left">Learner Category</th>
		<th scope="col" align="right">Sessions</th>
		<th scope="col" align="right">People</th>
		<cfif FORM.Duration>
			<th scope="col" align="right" nowrap>Duration</th>
		</cfif>
		<cfif FORM.PrepTime>
			<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
		</cfif>
	</tr>

	<cfset sessionCount = 0>
	<cfset peopleCount = 0>
	<cfset durCount = 0>
	<cfset prepCount = 0>

	<cfoutput query="Tours">
		<tr>
			<td align="left">#Tours.Quarter#</td>
			<td align="left">#Tours.Title#&nbsp;<cfif Tours.GroupName neq "N/A">(#Tours.GroupName#)</cfif></td>
			<td align="left">#Tours.Presenters#</td>
			<td align="left">#Tours.Developers#</td>
			<td align="left">#Tours.Learners#</td>
			<td align="right">#Tours.Sessions#</td>
			<td align="right">#Tours.People#</td>
			<cfif FORM.Duration>
				<td align="right">#Tours.display_dur#</th>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right">#Tours.display_prep#</th>
			</cfif>
		</tr>
		<cfif FORM.Feedback>
			<tr>
				<td align="left">Evaluation/Feedback</td>
				<td align="left" colspan="#feedSpan#">#Tours.FeedbackText#</td>
			</tr>
		</cfif>
		<cfset sessionCount = sessionCount + Tours.Sessions>
		<cfset peopleCount = peopleCount + Tours.People>
		<cfset durCount = durCount + Tours.Duration>
		<cfset prepCount = prepCount + Tours.PrepTime>
	</cfoutput>
	<tr style="font-weight:bold">
		<td align="left" colspan="5">Totals</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
		<cfif FORM.Duration>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
		</cfif>
		<cfif FORM.PrepTime>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
		</cfif>
	</tr>
</table>

<cfset sessionGrand = sessionGrand + sessionCount>
<cfset peopleGrand = peopleGrand + peopleCount>
<cfset grandDur = grandDur + durCount>
<cfset grandPrep = grandPrep + prepCount>

<!-- classes/groups -->
<cfset colSpan = 7>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<h3>Requested instruction to classes/groups</h3>
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Instruction to Classes/Groups for Fiscal Year">
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Quarter</th>
		<th scope="col" align="left">Course Number &amp; Title: Name of Group (Faculty)</th>
		<th scope="col" align="left">Presenter(s)</th>
		<th scope="col" align="left">Developer(s)</th>
		<th scope="col" align="left">Learner Department(s)</th>
		<th scope="col" align="right">Sessions</th>
		<th scope="col" align="right">People</th>
		<cfif FORM.Duration>
			<th scope="col" align="right" nowrap>Duration</th>
		</cfif>
		<cfif FORM.PrepTime>
			<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
		</cfif>
	</tr>

	<cfset sessionCount = 0>
	<cfset peopleCount = 0>
	<cfset durCount = 0>
	<cfset prepCount = 0>

	<cfoutput query="Lectures">
		<tr>
			<td align="left">#Lectures.Quarter#</td>
			<td align="left">#Lectures.Title#:&nbsp;#Lectures.GroupName#<cfif Len(Lectures.Faculty) gt 1>&nbsp;(#Lectures.Faculty#)<cfelse></cfif></td>
			<td align="left">#Lectures.Presenters#</td>
			<td align="left">#Lectures.Developers#</td>
			<td align="left">#Lectures.Department#
				<cfif Lectures.other_multi_dept neq "NULL" and Lectures.other_multi_dept neq "">
					(#Lectures.other_multi_dept#)
				</cfif>
			</td>
			<td align="right">#Lectures.Sessions#</td>
			<td align="right">#Lectures.People#</td>
			<cfif FORM.Duration>
				<td align="right">#Lectures.display_dur#</th>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right">#Lectures.display_prep#</th>
			</cfif>
		</tr>
		<cfif FORM.Feedback>
			<tr>
				<td align="left">Evaluation/Feedback</td>
				<td align="left" colspan="#feedSpan#">#Lectures.FeedbackText#</td>
			</tr>
		</cfif>
		<cfset sessionCount = sessionCount + Lectures.Sessions>
		<cfset peopleCount = peopleCount + Lectures.People>
		<cfset durCount = durCount + Lectures.Duration>
		<cfset prepCount = prepCount + Lectures.PrepTime>
	</cfoutput>
	<tr style="font-weight:bold">
		<td align="left" colspan="5">Totals</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
		<cfif FORM.Duration>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
		</cfif>
		<cfif FORM.PrepTime>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
		</cfif>
	</tr>
</table>

<cfset sessionGrand = sessionGrand + sessionCount>
<cfset peopleGrand = peopleGrand + peopleCount>
<cfset grandDur = grandDur + durCount>
<cfset grandPrep = grandPrep + prepCount>

<!-- classes/demonstrations -->
<cfset colSpan = 7>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<h3>Library-initiated instruction to classes/groups</h3>
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Library-initiated Classes and Demonstrations">
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Quarter</th>
		<th scope="col" align="left">Name of Session</th>
		<th scope="col" align="left">Presenter(s)</th>
		<th scope="col" align="left">Developer(s)</th>
		<th scope="col" align="left">Learner Department(s)</th>
		<th scope="col" align="right">Sessions</th>
		<th scope="col" align="right">People</th>
		<cfif FORM.Duration>
			<th scope="col" align="right" nowrap>Duration</th>
		</cfif>
		<cfif FORM.PrepTime>
			<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
		</cfif>
	</tr>

	<cfset sessionCount = 0>
	<cfset peopleCount = 0>
	<cfset durCount = 0>
	<cfset prepCount = 0>

	<cfoutput query="Classes">
		<tr>
			<td align="left">#Classes.Quarter#</td>
			<td align="left">#Classes.Title#</td>
			<td align="left">#Classes.Presenters#</td>
			<td align="left">#Classes.Developers#</td>
			<td align="left">#Classes.Department#
				<cfif Classes.other_multi_dept neq "NULL" and Classes.other_multi_dept neq "">
					(#Classes.other_multi_dept#)
				</cfif>
			</td>
			<td align="right">#Classes.Sessions#</td>
			<td align="right">#Classes.People#</td>
			<cfif FORM.Duration>
				<td align="right">#Classes.display_dur#</th>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right">#Classes.display_prep#</th>
			</cfif>
		</tr>
		<cfif FORM.Feedback>
			<tr>
				<td align="left">Evaluation/Feedback</td>
				<td align="left" colspan="#feedSpan#">#Classes.FeedbackText#</td>
			</tr>
		</cfif>
		<cfset sessionCount = sessionCount + Classes.Sessions>
		<cfset peopleCount = peopleCount + Classes.People>
		<cfset durCount = durCount + Classes.Duration>
		<cfset prepCount = prepCount + Classes.PrepTime>
	</cfoutput>
	<tr style="font-weight:bold">
		<td align="left" colspan="5">Totals</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
		<cfif FORM.Duration>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
		</cfif>
		<cfif FORM.PrepTime>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
		</cfif>
	</tr>
</table>

<cfset sessionGrand = sessionGrand + sessionCount>
<cfset peopleGrand = peopleGrand + peopleCount>
<cfset grandDur = grandDur + durCount>
<cfset grandPrep = grandPrep + prepCount>

<!-- credit courses -->
<cfset colSpan = 7>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<h3>UCLA credit course taught</h3>
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="UCLA Credit Course for Fiscal Year">
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Quarter</th>
		<th scope="col" align="left">Course &amp; Title</th>
		<th scope="col" align="left">Presenter(s)</th>
		<th scope="col" align="left">Developer(s)</th>
		<th scope="col" align="left">Learner Department(s)</th>
		<th scope="col" align="right">Sessions</th>
		<th scope="col" align="right">People</th>
		<cfif FORM.Duration>
			<th scope="col" align="right" nowrap>Duration</th>
		</cfif>
		<cfif FORM.PrepTime>
			<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
		</cfif>
	</tr>

	<cfset sessionCount = 0>
	<cfset peopleCount = 0>
	<cfset durCount = 0>
	<cfset prepCount = 0>

	<cfoutput query="Credits">
		<tr>
			<td align="left">#Credits.Quarter#</td>
			<td align="left">#Credits.Title#</td>
			<td align="left">#Credits.Presenters#</td>
			<td align="left">#Credits.Developers#</td>
			<td align="left">#Credits.Department#
				<cfif Credits.other_multi_dept neq "NULL" and Credits.other_multi_dept neq "">
					(#Credits.other_multi_dept#)
				</cfif>
			</td>
			<td align="right">#Credits.Sessions#</td>
			<td align="right">#Credits.People#</td>
			<cfif FORM.Duration>
				<td align="right">#Credits.display_dur#</th>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right">#Credits.display_prep#</th>
			</cfif>
		</tr>
		<cfif FORM.Feedback>
			<tr>
				<td align="left">Evaluation/Feedback</td>
				<td align="left" colspan="#feedSpan#">#Classes.FeedbackText#</td>
			</tr>
		</cfif>
		<cfset sessionCount = sessionCount + Credits.Sessions>
		<cfset peopleCount = peopleCount + Credits.People>
		<cfset durCount = durCount + Credits.Duration>
		<cfset prepCount = prepCount + Credits.PrepTime>
	</cfoutput>
	<tr style="font-weight:bold">
		<td align="left" colspan="5">Totals</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
		<cfif FORM.Duration>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
		</cfif>
		<cfif FORM.PrepTime>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
		</cfif>
	</tr>
</table>

<cfset sessionGrand = sessionGrand + sessionCount>
<cfset peopleGrand = peopleGrand + peopleCount>
<cfset grandDur = grandDur + durCount>
<cfset grandPrep = grandPrep + prepCount>

<!-- small groups -->
<cfset colSpan = 6>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<h3>Small group consultation</h3>
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Small Group Consultations for Fiscal Year">
	<tr style="color: white; background-color: black;">
		<th scope="col" align="left">Quarter</th>
		<th scope="col" align="left">Group And/Or User Category</th>
		<th scope="col" align="left">Presenter(s)</th>
		<th scope="col" align="left">Developer(s)</th>
		<th scope="col" align="right">Sessions</th>
		<th scope="col" align="right">People</th>
		<cfif FORM.Duration>
			<th scope="col" align="right" nowrap>Duration</th>
		</cfif>
		<cfif FORM.PrepTime>
			<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
		</cfif>
	</tr>

	<cfset sessionCount = 0>
	<cfset peopleCount = 0>
	<cfset durCount = 0>
	<cfset prepCount = 0>

	<cfoutput query="Consults">
		<tr>
			<td align="left">#Consults.Quarter#</td>
			<td align="left">#Consults.Title#</td>
			<td align="left">#Consults.Presenters#</td>
			<td align="left">#Consults.Developers#</td>
			<td align="right">#Consults.Sessions#</td>
			<td align="right">#Consults.People#</td>
			<cfif FORM.Duration>
				<td align="right">#Consults.display_dur#</th>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right">#Consults.display_prep#</th>
			</cfif>
		</tr>
		<cfif FORM.Feedback>
			<tr>
				<td align="left">Evaluation/Feedback</td>
				<td align="left" colspan="#feedSpan#">#Classes.FeedbackText#</td>
			</tr>
		</cfif>
		<cfset sessionCount = sessionCount + Consults.Sessions>
		<cfset peopleCount = peopleCount + Consults.People>
		<cfset durCount = durCount + Consults.Duration>
		<cfset prepCount = prepCount + Consults.PrepTime>
	</cfoutput>

	<tr style="font-weight:bold">
		<td align="left" colspan="4">Totals</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
		<cfif FORM.Duration>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
		</cfif>
		<cfif FORM.PrepTime>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
		</cfif>
	</tr>
</table>

<cfset sessionGrand = sessionGrand + sessionCount>
<cfset peopleGrand = peopleGrand + peopleCount>
<cfset grandDur = grandDur + durCount>
<cfset grandPrep = grandPrep + prepCount>

<!-- Liaison -->
<cfset colSpan = 6>
<cfif FORM.Duration>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.PrepTime>
	<cfset colSpan = colSpan + 1>
</cfif>
<cfif FORM.Feedback>
	<cfset feedSpan = colSpan - 1>
</cfif>

<h3>One-on-one consultation</h3>
<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Individual Liaisons for Fiscal Year">
  <tr style="color: white; background-color: black;">
    <th scope="col" align="left">Quarter</th>
    <th scope="col" align="left">Course: Group Name</th>
    <th scope="col" align="left">Presenter(s)</th>
    <th scope="col" align="left">Develop(s)</th>
    <th scope="col" align="right">Sessions</th>
    <th scope="col" align="right">People</th>
	<cfif FORM.Duration>
		<th scope="col" align="right" nowrap>Duration</th>
	</cfif>
	<cfif FORM.PrepTime>
		<th scope="col" align="right" nowrap>Dev/Prep. Time</th>
	</cfif>
  </tr>

  <cfset sessionCount = 0>
  <cfset peopleCount = 0>
  <cfset durCount = 0>
  <cfset prepCount = 0>

	<cfoutput query="Liaison">
		<tr>
			<td align="left">#Liaison.Quarter#</td>
			<td align="left">#Liaison.Title#:&nbsp;#Liaison.GroupName#</td>
			<td align="left">#Liaison.Presenters#</td>
			<td align="left">#Liaison.Developers#</td>
			<td align="right">#Liaison.Sessions#</td>
			<td align="right">#Liaison.People#</td>
			<cfif FORM.Duration>
				<td align="right">#Liaison.display_dur#</th>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right">#Liaison.display_prep#</th>
			</cfif>
		</tr>
		<cfif FORM.Feedback>
			<tr>
				<td align="left">Evaluation/Feedback</td>
				<td align="left" colspan="#feedSpan#">#Classes.FeedbackText#</td>
			</tr>
		</cfif>
		<cfset sessionCount = sessionCount + Liaison.Sessions>
		<cfset peopleCount = peopleCount + Liaison.People>
		<cfset durCount = durCount + Liaison.Duration>
		<cfset prepCount = prepCount + Liaison.PrepTime>
	</cfoutput>

	<tr style="font-weight:bold">
		<td align="left" colspan="4">Totals</td>
		<td align="right"><cfoutput>#sessionCount#</cfoutput></td>
		<td align="right"><cfoutput>#peopleCount#</cfoutput></td>
		<cfif FORM.Duration>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#durCount#></td>
		</cfif>
		<cfif FORM.PrepTime>
			<td align="right"><cfmodule template="convert_time.cfm" total_time=#prepCount#></td>
		</cfif>
	</tr>

</table>

<cfset sessionGrand = sessionGrand + sessionCount>
<cfset peopleGrand = peopleGrand + peopleCount>
<cfset grandDur = grandDur + durCount>
<cfset grandPrep = grandPrep + prepCount>

<br/><br/>
<cfoutput>
	<table width="98%" border="1" cellspacing="1" cellpadding="1" summary="Orientations & Tours Grand Totals">
		<caption align="center" style="font-weight:bold">Grand Totals</caption>
		<tr style="color: white; background-color: black;">
			<th scope="col" align="left">Sessions</th>
			<th scope="col" align="left">People</th>
			<cfif FORM.Duration>
				<th scope="col" align="left">Duration</th>
			</cfif>
			<cfif FORM.PrepTime>
				<th scope="col" align="left">Dev/Prep. Time</th>
			</cfif>
		</tr>
		<tr class="total">
			<td align="right">#sessionGrand#</td>
			<td align="right">#peopleGrand#</td>
			<cfif FORM.Duration>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#grandDur#></td>
			</cfif>
			<cfif FORM.PrepTime>
				<td align="right"><cfmodule template="convert_time.cfm" total_time=#grandPrep#></td>
			</cfif>
		</tr>
	</table>
</cfoutput>
