/datum/mutation/harmonizing_pulses
	name = "Harmonizing Pulses"
	desc = "Allows the user to heal plants and creatures at the cost of pacifying themself"
	quality = POSITIVE
	difficulty = 16
	locked = TRUE
	text_gain_indication = span_notice("You feel in harmony with your surroundings.")
	text_lose_indication = span_notice("You lose you're sense of harmony.")
	power_path = /datum/action/cooldown/mob_cooldown/turtle_tree/healer/harmonizing_pulses
	instability = POSITIVE_INSTABILITY_MAJOR

/datum/action/cooldown/mob_cooldown/turtle_tree/healer/harmonizing_pulse
	name = "Harmonizing Pulses"
	desc = "Emit pulses that heals plants and people alike."
	tree_range = 3
	effect_path = /obj/effect/temp_visual/circle_wave/tree/harmonizing_pulses

/datum/action/cooldown/mob_cooldown/turtle_tree/healer/harmonizing_pulses/tree_effect()
	. = ..()
	var/mob/living/owner_ref = owner
	owner_ref.adjust_pacifism((time_between_intervals * maximum_intervals) + 3 SECONDS)
	for(var/mob/living/creature in oview(tree_range, owner))
		if(!(creature.mob_biotypes & MOB_ORGANIC))
			return
		creature.adjustBruteLoss(-heal_amount, updating_health = FALSE)
		creature.adjustFireLoss(-heal_amount, updating_health = FALSE)
		if (iscarbon(creature))
			creature.adjustToxLoss(-heal_amount, updating_health = FALSE, forced = TRUE)
			creature.adjustOxyLoss(-heal_amount, updating_health = FALSE)
		creature.updatehealth()

/obj/effect/temp_visual/circle_wave/tree/harmonizing_pulses
	color = "#1cad2d"


