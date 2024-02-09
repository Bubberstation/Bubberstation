/obj/item/knife/brand
/* 	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "rods-1" */
	name = "branding knife"
	icon = 'modular_skyrat/modules/modular_ert/icons/pizza/hotknife.dmi'
	icon_state = "hotknife"
	inhand_icon_state = "hotknife"
	desc = "Once known as Lightbringer, this sword has been demoted to a simple pizza cutting knife... It may still have its fire attack powers."
	righthand_file = 'modular_skyrat/modules/modular_ert/icons/pizza/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_ert/icons/pizza/lefthand.dmi'
//	var/list/static/possible_crimes = list()

/obj/item/knife/brand/attack(mob/living/victim, mob/living/attacker, params)
	var/list/branding_with = typesof(/datum/status_effect/branded)
	branding_with -= /datum/status_effect/branded
/* 	var/list/preset_brandable_crimes = list()
	for(var/i in branding_with)
		preset_brandable_crimes |= i.initial(id) */
	if(!istype(victim, /mob/living/carbon))
		return
	var/datum/status_effect/branded/current_branding = tgui_input_list(attacker, "What crime are you branding them with?", "Branding", branding_with) // todo, make names show

	if(!attacker.combat_mode && do_after(attacker, 6 SECONDS, victim))
		victim.apply_status_effect(current_branding)
		to_chat(attacker, span_userdanger("You brand [victim] with the mark of [initial(current_branding.id)]"))

		var/obj/item/bodypart/branded_limb = victim.get_bodypart(deprecise_zone(BODY_ZONE_CHEST))
		branded_limb.force_wound_upwards(/datum/wound/burn/flesh/critical, wound_source = "Branding")
		var/particles/smoke/steam/particles = new /particles/smoke/steam/mild(victim)
		particles.position = list(-6, 0, 0)
		QDEL_IN(particles, 10 SECONDS)
		victim.adjustFireLoss(60)
		victim.emote("scream")
	return ..()


/datum/status_effect/branded
	id = "nothing"
	duration = -1
	alert_type = null

/datum/status_effect/branded/get_examine_text()
	return span_warning("[owner.p_They()] bear branding makes for the crime of [id]!")

/datum/status_effect/branded/murder
	id = "Murderer"

/datum/status_effect/branded/thief
	id = "Thief"

/datum/status_effect/branded/mutiny
	id = "Mutiny"

/datum/status_effect/branded/eoc
	id = "Enemy of Corporation"

/datum/status_effect/branded/terror
	id = "Terrorist"

/datum/status_effect/branded/heresy
	id = "Heresy"

/datum/status_effect/branded/sabotage
	id = "Sabotage"

/datum/status_effect/branded/disrespect
	id = "Disrespect"


/obj/structure/closet/secure_closet/hos/PopulateContents()
	. = ..()

	new /obj/item/knife/brand(src)
