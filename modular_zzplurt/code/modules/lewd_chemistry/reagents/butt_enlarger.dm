/*
* BUTT ENLARGEMENT
* Normal function increases the player's butt size
* If the player's butt is near or at the maximum size and they're wearing clothing, they press against the player's clothes and causes brute damage
*/

/datum/reagent/drug/aphrodisiac/butt_enlarger
	name = "denbu tincture"
	description = "A mixture of natural vitamins and valentines plant extract, causing butt enlargement in humanoids."
	color = "#e8ff1b"
	taste_description = "butter with a sweet aftertaste"
	overdose_threshold = 17
	metabolization_rate = 0.25
	life_pref_datum = /datum/preference/toggle/erp/butt_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp

	/// Words for the butt when huge
	var/static/list/words_for_bigger = list(
		"huge",
		"massive",
		"jiggly",
		"hefty",
		"plump",
		"thick",
		"bubbling"
	)

	/// Wording chosen to expand the butt, shown only to the mob
	var/static/list/action_text_list = list(
		"expands outward to ",
		"grows out to ",
		"begins to plump up, growing to ",
		"suddenly expands to ",
		"swells out to "
	)

	/// Wording chosen to be seen by other mobs
	var/static/list/public_action_text_list = list(
		"expands outward.",
		"seems to grow larger.",
		"appears more plump than before.",
		"suddenly swells up."
	)

/datum/reagent/drug/aphrodisiac/butt_enlarger/life_effects(mob/living/carbon/human/exposed_mob)
	if(!ishuman(exposed_mob))
		return

	var/obj/item/organ/external/genital/butt/mob_butt = exposed_mob.get_organ_slot(ORGAN_SLOT_BUTT)

	// Create butt if they don't have one
	if(!mob_butt)
		create_butt(exposed_mob)
		return

	// Grow existing butt
	grow_butt(exposed_mob)

/datum/reagent/drug/aphrodisiac/butt_enlarger/growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/butt/mob_butt)
	if(!mob_butt)
		return

	if(mob_butt.genital_size >= (butt_max_size - 2))
		exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(words_for_bigger)] bottom [pick(public_action_text_list)]"))
		to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger)] bottom [pick(action_text_list)]size [mob_butt.genital_size]."))
	else
		exposed_mob.visible_message(span_notice("[exposed_mob]'s bottom [pick(public_action_text_list)]"))
		to_chat(exposed_mob, span_purple("Your bottom [pick(action_text_list)]size [mob_butt.genital_size]."))

/datum/chemical_reaction/butt_enlarger
	results = list(/datum/reagent/drug/aphrodisiac/butt_enlarger = 8)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1,
							/datum/reagent/consumable/sugar = 2,
							/datum/reagent/silicon = 3,
							/datum/reagent/drug/aphrodisiac/crocin = 2)
	mix_message = "the reaction gives off a sweet buttery aroma."
	erp_reaction = TRUE
