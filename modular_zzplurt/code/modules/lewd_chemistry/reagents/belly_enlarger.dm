/*
* BELLY ENLARGEMENT
* Normal function increases the player's belly size
* If the player's belly is near or at the maximum size and they're wearing clothing, they press against the player's clothes and causes brute damage
*/

/datum/reagent/drug/aphrodisiac/belly_enlarger
	name = "belladine nectar"
	description = "A volatile collodial mixture that encourages abdominal expansion via a potent gastric mix."
	color = "#01ff63"
	taste_description = "blueberry gum"
	overdose_threshold = 17
	metabolization_rate = 0.25
	life_pref_datum = /datum/preference/toggle/erp/belly_enlargement
	overdose_pref_datum = /datum/preference/toggle/erp

	/// Words for the belly when huge
	var/static/list/words_for_bigger = list(
		"huge",
		"massive",
		"distended",
		"bloated",
		"swollen",
		"rather large",
		"jiggly",
		"hefty"
	)

	/// Wording chosen to expand the belly, shown only to the mob
	var/static/list/action_text_list = list(
		"expands outward to ",
		"swells out to ",
		"begins to bloat, growing to ",
		"suddenly distends to ",
		"inflates to "
	)

	/// Wording chosen to be seen by other mobs
	var/static/list/public_action_text_list = list(
		"expands outward.",
		"seems to grow larger.",
		"appears more distended than before.",
		"suddenly swells up."
	)

/datum/reagent/drug/aphrodisiac/belly_enlarger/life_effects(mob/living/carbon/human/exposed_mob)
	if(!ishuman(exposed_mob))
		return

	var/obj/item/organ/external/genital/belly/mob_belly = exposed_mob.get_organ_slot(ORGAN_SLOT_BELLY)

	// Create belly if they don't have one
	if(!mob_belly)
		create_belly(exposed_mob)
		return

	// Grow existing belly
	grow_belly(exposed_mob)

/datum/reagent/drug/aphrodisiac/belly_enlarger/growth_to_chat(mob/living/carbon/human/exposed_mob, obj/item/organ/external/genital/belly/mob_belly)
	if(!mob_belly)
		return

	if(mob_belly.genital_size >= (belly_max_size - 2))
		exposed_mob.visible_message(span_notice("[exposed_mob]'s [pick(words_for_bigger)] belly [pick(public_action_text_list)]"))
		to_chat(exposed_mob, span_purple("Your [pick(words_for_bigger)] belly [pick(action_text_list)]size [mob_belly.genital_size]."))
	else
		exposed_mob.visible_message(span_notice("[exposed_mob]'s belly [pick(public_action_text_list)]"))
		to_chat(exposed_mob, span_purple("Your belly [pick(action_text_list)]size [mob_belly.genital_size]."))

/datum/chemical_reaction/belly_enlarger
	results = list(/datum/reagent/drug/aphrodisiac/belly_enlarger = 8)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1,
							/datum/reagent/consumable/nutriment = 3,
							/datum/reagent/silicon = 2,
							/datum/reagent/drug/aphrodisiac/crocin = 2)
	mix_message = "the reaction gives off a sweet aroma."
	erp_reaction = TRUE
