/**
 * Tests that the random hallucination weighted list is actually pickable.
 *
 * pick_weight() only works with integer weights - a pool whose weights add up to a
 * fractional total can roll a number higher than that total and hand back null, which
 * then blows up in cause_hallucination() at random.
 */
/datum/unit_test/hallucination_weights

/datum/unit_test/hallucination_weights/Run()
	for(var/tier in GLOB.random_hallucination_weighted_list)
		var/list/tier_pool = GLOB.random_hallucination_weighted_list[tier]
		if(!length(tier_pool))
			TEST_FAIL("Hallucination tier [tier] is present in the weighted list but has no hallucinations in it.")
			continue

		for(var/datum/hallucination/hallucination_type as anything in tier_pool)
			var/weight = tier_pool[hallucination_type]
			if(weight > 0 && weight == round(weight))
				continue

			TEST_FAIL("Hallucination [hallucination_type] has a weight of [weight] in tier [tier]. \
				Weights in the random hallucination list must be positive integers, or pick_weight() can return null.")

	// Every tier that can actually be rolled needs to hand back a real hallucination, strict or not.
	for(var/tier in HALLUCINATION_TIER_COMMON to HALLUCINATION_TIER_VERYSPECIAL)
		for(var/strict in list(TRUE, FALSE))
			var/datum/hallucination/picked = get_random_hallucination(tier, strict)
			if(ispath(picked, /datum/hallucination))
				continue

			TEST_FAIL("get_random_hallucination(tier = [tier], strict = [strict ? "TRUE" : "FALSE"]) \
				returned [picked || "null"] instead of a hallucination type.")
