/datum/quirk/moist_skin
	name = "Soaked"
	desc = "You are naturally soaked in some manner of substance. Stay away from carpets!"
	icon = FA_ICON_BUCKET
	quirk_flags = QUIRK_HUMAN_ONLY
	mob_trait = TRAIT_MOIST_SKIN
	gain_text = span_danger("You feel wet.")
	lose_text = span_notice("You suddenly feel dry.")
	medical_record_text = "Patient doesn't know how to use a towel."
	var/chosen_color

/datum/quirk_constant_data/uniquedropcolor
	associated_typepath = /datum/quirk/moist_skin
	customization_options = list(
		/datum/preference/color/input_dripping_color
		)

/datum/quirk/moist_skin/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_LIVING_IGNITED, PROC_REF(on_ignited))
	RegisterSignal(quirk_holder, COMSIG_LIVING_EXTINGUISHED, PROC_REF(on_extinguish))
	var/obj/effect/abstract/shared_particle_holder/holder = quirk_holder.add_shared_particles(/particles/droplets, "custom_drop")
	chosen_color = client_source?.prefs.read_preference(/datum/preference/color/input_dripping_color)
	if(!isnull(chosen_color))
		holder.particles.color = "[chosen_color]a0"

/datum/quirk/moist_skin/remove()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_IGNITED)
	UnregisterSignal(quirk_holder, COMSIG_LIVING_EXTINGUISHED)
	quirk_holder.remove_shared_particles(/particles/droplets)

/datum/quirk/moist_skin/proc/on_ignited()
	SIGNAL_HANDLER
	quirk_holder.remove_shared_particles(/particles/droplets)

/datum/quirk/moist_skin/proc/on_extinguish()
	SIGNAL_HANDLER
	var/obj/effect/abstract/shared_particle_holder/holder = quirk_holder.add_shared_particles(/particles/droplets, "custom_drop")
	if(!isnull(chosen_color))
		holder.particles.color = "[chosen_color]a0"
