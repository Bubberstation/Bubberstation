/datum/disease/transformation_race
	name = "Transformation"
	max_stages = 5
	spread_text = "Acute"
	spread_flags = DISEASE_SPREAD_SPECIAL
	cure_text = "Faith"
	agent = "Shenanigans"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/alien)
	severity = DISEASE_SEVERITY_BIOHAZARD
	stage_prob = 5
	visibility_flags = HIDDEN_SCANNER|HIDDEN_PANDEMIC
	disease_flags = CURABLE
	bypasses_immunity = TRUE
	var/list/stage1 = list("You feel unremarkable.")
	var/list/stage2 = list("You feel boring.")
	var/list/stage3 = list("You feel utterly plain.")
	var/list/stage4 = list("You feel white bread.")
	var/list/stage5 = list("Oh the humanity!")
	var/race = /datum/species/human

/datum/disease/transformation_race/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			if(length(stage1) && SPT_PROB(stage_prob, seconds_per_tick))
				to_chat(affected_mob, pick(stage1))
		if(2)
			if(length(stage2) && SPT_PROB(stage_prob, seconds_per_tick))
				to_chat(affected_mob, pick(stage2))
		if(3)
			if(length(stage3) && SPT_PROB(stage_prob * 2, seconds_per_tick))
				to_chat(affected_mob, pick(stage3))
		if(4)
			if(length(stage4) && SPT_PROB(stage_prob * 2, seconds_per_tick))
				to_chat(affected_mob, pick(stage4))
		if(5)
			var/datum/species/species_type = race
			affected_mob.set_species(species_type, icon_update = TRUE, pref_load = FALSE)
			to_chat(affected_mob, span_warning("You've become \a [LOWER_TEXT(initial(species_type.name))]!"))
			cure()

/datum/disease/transformation_race/hemophage
	name = "Hemophagic Viral Infection"
	cure_text = "Garlic"
	cures = list(/datum/reagent/consumable/garlic)
	agent = "Hemophagic Viral Infection"
	desc = "A gift of the night"
	cure_chance = 2.5
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list("You dont feel very well")
	stage2 = list("You feel cold")
	stage3 = list(span_danger("Your heart skips a beat"), span_danger("You have a dull pain in your heart"))
	stage4 = list(span_danger("You're hungry but normal food does not seem appetizing"))
	stage5 = list(span_danger("Blood....Blood..."))
	race = /datum/species/hemophage
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD

/datum/disease/transformation_race/synthetic
	name = "Synthetic Conversion Nanites"
	cure_text = "An injection of copper."
	cures = list(/datum/reagent/copper)
	cure_chance = 2.5
	agent = "C3P0 Nanomachines"
	desc = "A acute nanomachine infection that converts the victim into a synthetic lifeform"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list()
	stage2 = list(span_danger ("Your joints feel stiff."))
	stage3 = list(
		span_danger("You can feel something move...inside."),
		span_danger("Your joints feel very stiff."),
		span_warning("Your skin feels loose."),
	)
	stage4 = list(span_danger("You can feel... something...inside you."), span_danger("Your skin feels very loose."),)
	stage5 = list(span_danger("Your skin feels as if it's about to burst off!"))
	race = /datum/species/synthetic
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_ROBOTIC

/datum/disease/transformation_race/android
	name = "Android Conversion Nanites"
	cure_text = "An injection of copper."
	cures = list(/datum/reagent/copper)
	cure_chance = 2.5
	agent = "BB-8 Nanomachines"
	desc = "A acute nanomachine infection that converts the victim into an android"
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list()
	stage2 = list(span_danger ("Your joints feel stiff."))
	stage3 = list(
		span_danger("You can feel something move...inside."),
		span_danger("Your joints feel very stiff."),
		span_warning("Your skin feels loose."),
	)
	stage4 = list(span_danger("You can feel... something...inside you."), span_danger("Your skin feels very loose."),)
	stage5 = list(span_danger("Your skin feels as if it's about to burst off!"))
	race = /datum/species/android
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD|MOB_ROBOTIC

/datum/disease/transformation/xeno
	new_form = /mob/living/carbon/alien/adult/skyrat/drone
