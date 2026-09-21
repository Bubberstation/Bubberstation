/datum/quirk/moist_skin
	name = "Naturally Wet" //
	desc = "For whatever reason, you are naturally wet and dripping."
	icon = FA_ICON_DROPLET
	quirk_flags = QUIRK_HUMAN_ONLY
	mob_trait = TRAIT_MOIST_SKIN
	gain_text = span_danger("You feel wet.")
	lose_text = span_notice("You suddenly feel dry.")
	medical_record_text = "Patient was dripping wet during interview. Interviewing sofa suffered major water damage. "

/datum/quirk_constant_data/uniquedropcolor
	associated_typepath = /datum/quirk/moist_skin
	customization_options = list(
		/datum/preference/color/input_dripping_color
		)

var/obj/effect/abstract/shared_particle_holder/holder = quirk_holder.add_shared_particles(/particles/droplets, "custom_drop")
	if (!rainbow)
		holder.particles.color = "[slime_color]a0"

/datum/quirk/moist_skin/add(client/client_source)
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_LIVING_IGNITED, PROC_REF(on_ignited))
	RegisterSignal(quirk_holder, COMSIG_LIVING_EXTINGUISHED, PROC_REF(on_extinguish))
	quirk_holder.add_shared_particles(/particles/droplets)

/datum/quirk/moist_skin/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_IGNITED)
	UnregisterSignal(quirk_holder, COMSIG_LIVING_EXTINGUISHED)
	quirk_holder.remove_shared_particles(/particles/droplets)

/datum/quirk/moist_skin/proc/on_ignited()
	SIGNAL_HANDLER
	quirk_holder.remove_shared_particles(/particles/droplets)

/datum/quirk/moist_skin/proc/on_extinguish()
	SIGNAL_HANDLER
	quirk_holder.add_shared_particles(/particles/droplets)
