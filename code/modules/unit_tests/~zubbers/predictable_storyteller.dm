/datum/unit_test/predictable_storyteller
	var/expected_result = 0.35

/datum/unit_test/predictable_storyteller/Run()

	var/datum/job/assistant_job = SSjob.GetJobType(/datum/job/assistant)
	var/datum/job/head_of_security_job = SSjob.GetJobType(/datum/job/head_of_security)

	var/list/testing_minds = list()
	for(var/i=1,i<=10,i++)

		var/mob/living/carbon/human/dummy = allocate(/mob/living/carbon/human/consistent)
		dummy.mind_initialize()

		if(i<=2)
			dummy.mind.set_assigned_role(head_of_security_job)
		else
			dummy.mind.set_assigned_role(assistant_job)

		if(i==2 || i==3) //Should result in 1 antag hos, 1 antag assistant
			dummy.mind.add_antag_datum(/datum/antagonist/traitor)

		testing_minds += dummy.mind

	var/returning_ratio = storyteller_get_antag_to_crew_ratio(do_debug=TRUE,minds_to_use_override=testing_minds)

	TEST_ASSERT_EQUAL(returning_ratio, expected_result, "Predictable storyteller did not have the correct antag ratio! Expected result: [expected_result], actual: [returning_ratio].")
