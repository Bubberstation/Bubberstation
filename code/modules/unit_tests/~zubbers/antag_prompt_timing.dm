/datum/unit_test/antag_prompt_defers_event_start

/datum/round_event/antagonist/prompt_timing
	/// length(setup_minds) at the moment start() ran, -1 if start() never ran.
	var/minds_at_start = -1
	var/prompt_done = FALSE

/datum/round_event/antagonist/prompt_timing/start()
	minds_at_start = length(setup_minds)

/datum/round_event/antagonist/prompt_timing/proc/prompt_for_test(datum/round_event_control/antagonist/cast_control, list/candidates)
	prompt_candidates(cast_control, candidates)
	prompt_done = TRUE

/datum/unit_test/antag_prompt_defers_event_start/Run()
	CONFIG_SET(number/antag_prompt_time, 5)
	CONFIG_SET(number/antag_prompt_fake_chance, 0)
	CONFIG_SET(flag/antag_prompt_poll_everyone, TRUE)

	var/datum/round_event_control/antagonist/cast_control = new
	cast_control.antag_flag = ROLE_TRAITOR
	cast_control.antag_datum = /datum/antagonist/traitor

	var/datum/round_event/antagonist/prompt_timing/event = new(TRUE, cast_control)
	event.antag_count = 1
	SSevents.running -= event

	TEST_ASSERT(event.processing, "the event should start out processing, otherwise this test proves nothing")

	var/mob/living/carbon/human/candidate = allocate(/mob/living/carbon/human/consistent)
	INVOKE_ASYNC(event, TYPE_PROC_REF(/datum/round_event/antagonist/prompt_timing, prompt_for_test), cast_control, list(candidate))
	sleep(1 SECONDS)

	TEST_ASSERT(!event.prompt_done, "the prompt resolved before it could be tested, raise antag_prompt_time")
	TEST_ASSERT(!event.processing, "the event kept processing while its prompt was open")

	event.process()
	TEST_ASSERT_EQUAL(event.activeFor, 0, "activeFor advanced while the prompt was still open")
	TEST_ASSERT_EQUAL(event.minds_at_start, -1, "start() fired before the prompt resolved, so no antagonist would be created")

	UNTIL(event.prompt_done)
	TEST_ASSERT(event.processing, "processing was not restored after the prompt resolved")

	event.process()
	TEST_ASSERT_EQUAL(event.minds_at_start, 0, "start() did not run once the prompt had resolved")

	qdel(event)
	qdel(cast_control)
