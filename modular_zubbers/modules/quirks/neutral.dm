// Bubber quirks

/// 4/23 glowy_light value is null, failing to be assigned. dont know how to fix

/datum/quirk/glowy
	name = "Glowy"
	desc = "You emit a small amount of light. Geiger counters might hate you."
	value = 0
	medical_record_text = "Patient's body contains moderate levels of emissive radiation. This seems mostly harmless to the surroundings."
	icon = FA_ICON_BOLT_LIGHTNING
	var/glowy_color = null /// Holds player's selected color
	var/glowy_power = 1
	var/glowy_range = 1
	var/obj/effect/dummy/lighting_obj/moblight/glowy_light

/datum/quirk/glowy/add_unique(client/client_source)
	. = ..()
	glowy_color = client_source?.prefs.read_preference(/datum/preference/color/glowy_color)
	if (isnull(glowy_color))
		var/mob/living/carbon/human/human_holder = quirk_holder
		glowy_color = ("#[random_color()]")

/datum/quirk_constant_data/glowy
	associated_typepath = /datum/quirk/glowy
	customization_options = list(/datum/preference/color/glowy_color)

/datum/quirk/glowy/add(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	glowy_light = owner.mob_light()

/datum/quirk/glowy/remove()
	. = ..()

	if(QDELETED(quirk_holder))
		return
	QDEL_NULL(glowy_light)

// Client preference for glow color
/datum/preference/color/glowy_color
	savefile_key = "glowy_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED

/datum/preference/color/glowy_color/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return "Glowy" in preferences.all_quirks

/datum/preference/color/glowy_color/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/color/glowy_color/create_default_value()
	return ("#[random_color()]")


// Handles mutation conflicts
/datum/quirk/glowy/add(client/client_source)
    . = ..()
    RegisterSignal(quirk_holder, COMSIG_TRY_GAIN_MUTATION, PROC_REF(on_mutation_gained))

/datum/quirk/glowy/remove()
    . = ..()
    UnregisterSignal(quirk_holder, COMSIG_TRY_GAIN_MUTATION)

/datum/quirk/glowy/proc/on_mutation_gained(datum/mutation/source, mob/living/carbon/human/acquirer)
    if(istype(source, /datum/mutation/human/glow/anti))
        return TRUE
