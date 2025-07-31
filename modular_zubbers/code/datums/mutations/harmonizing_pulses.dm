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

/datum/action/cooldown/mob_cooldown/turtle_tree/healer/harmonizing_pulses
	name = "Harmonizing Pulses"
	desc = "Emit pulses that heals plants and people alike."
	button_icon = 'modular_zubbers/icons/mob/actions/actions.dmi'
	button_icon_state = "harmonizing_pulses"
	tree_range = 3
	effect_path = /obj/effect/temp_visual/circle_wave/tree/harmonizing_pulses

/datum/action/cooldown/mob_cooldown/turtle_tree/healer/harmonizing_pulses/Activate(atom/target)
	. = ..()
	var/mob/living/owner_ref = owner
	owner_ref.adjust_pacifism((time_between_intervals * maximum_intervals) + 3 SECONDS)

/datum/action/cooldown/mob_cooldown/turtle_tree/healer/harmonizing_pulses/tree_effect()
	. = ..()
	for(var/mob/living/creature in oview(tree_range, owner))
		var/damage_total = creature.getBruteLoss() + creature.getFireLoss()
		if(!(creature.mob_biotypes & MOB_ORGANIC))
			return
		if (iscarbon(creature))
			damage_total = damage_total + creature.getToxLoss() + creature.getOxyLoss()
			if(!damage_total)
				return //Div by zero prevention
			creature.adjustToxLoss(-floor((heal_amount * (creature.getToxLoss() / damage_total)) + 0.5), updating_health = FALSE, forced = TRUE)
			creature.adjustOxyLoss(-floor((heal_amount * (creature.getOxyLoss() / damage_total)) + 0.5), updating_health = FALSE)
		if(!damage_total)
			return
		creature.adjustBruteLoss(-floor((heal_amount * (creature.getBruteLoss() / damage_total)) + 0.5), updating_health = FALSE)
		creature.adjustFireLoss(-floor((heal_amount * (creature.getFireLoss() / damage_total)) + 0.5), updating_health = FALSE)
		creature.updatehealth()

/obj/effect/temp_visual/circle_wave/tree/harmonizing_pulses
	color = "#1cad2d"
	amount_to_scale = 2


