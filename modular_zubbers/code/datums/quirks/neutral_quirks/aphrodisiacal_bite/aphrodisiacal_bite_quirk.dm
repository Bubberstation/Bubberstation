/datum/quirk/aphrodisiacal_bite
	name = "Aphrodisiacal Bite"
	desc = "You have a aphrodisiacal gland, and can bite people to inject them with an aphrodisiac of your choosing."
	icon = FA_ICON_ICICLES
	value = 0
	gain_text = span_notice("You feel a aphrodisiacal gland in the back of your throat.")
	lose_text = span_warning("Your aphrodisiacal gland vanishes.")
	medical_record_text = "Patient possesses an aphrodisiacal gland."

/datum/quirk/aphrodisiacal_bite/add(client/client_source)
	var/datum/reagent/reagent = text2path(client_source?.prefs?.read_preference(/datum/preference/choiced/aphrodisiacal_bite_venom))

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/action = new /datum/action/cooldown/mob_cooldown/aphrodisiacal_bite(human_holder, our_reagent = reagent)
	action.Grant(human_holder)

/datum/quirk/aphrodisiacal_bite/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite/action = locate(/datum/action/cooldown/mob_cooldown/aphrodisiacal_bite) in quirk_holder.actions
	action.Remove()

	return ..()

/datum/quirk_constant_data/aphrodisiacal_bite
	associated_typepath = /datum/quirk/aphrodisiacal_bite
	customization_options = list(/datum/preference/choiced/aphrodisiacal_bite_venom)

/datum/preference/choiced/aphrodisiacal_bite_venom
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "aphrodisiacal_bite_venom"
	savefile_identifier = PREFERENCE_CHARACTER
	/// Format: (reagent typepath -> list(amount to inject per bite, cooldown, can be milked (venom_milker.dm)))
	var/static/list/aphrodisiacal_bite_choice_specs = list(
		/datum/reagent/drug/aphrodisiac/crocin = list(5, 2 SECONDS, TRUE),
		/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = list(5, 5 SECONDS, TRUE),
		/datum/reagent/drug/aphrodisiac/succubus_milk = list(5, 2 SECONDS, TRUE),
		/datum/reagent/drug/aphrodisiac/incubus_draft = list(5, 2 SECONDS, TRUE),
)
	var/static/list/milkable_venoms = generate_milkable_venom_list()
	var/static/filter_immune_string = generate_filter_immune_string()

/**
 * Generates a static list of /datum/reagent that will not be transformed into [/datum/reagent/generic_milked_venom] upon being milked by a venom milker.
 *
 * Ran once, then never again.
 */
/proc/generate_milkable_venom_list()
	RETURN_TYPE(/list)

	var/list/milkable = list()

	for (var/datum/reagent/typepath as anything in /datum/preference/choiced/aphrodisiacal_bite_venom::aphrodisiacal_bite_choice_specs)
		var/list/spec = /datum/preference/choiced/aphrodisiacal_bite_venom::aphrodisiacal_bite_choice_specs[typepath]

		if (spec[3])
			milkable += typepath

	return milkable

/**
 * Generates a static string appended to the venom milker's description, detailing which reagents available to the venom quirk will not be transformed into [/datum/reagent/generic_milked_venom].
 *
 * Ran once, then never again.
 */
/proc/generate_filter_immune_string()
	var/filter_immune_string = ""
	for (var/datum/reagent/typepath as anything in /datum/preference/choiced/aphrodisiacal_bite_venom::milkable_venoms)
		if (length(filter_immune_string))
			filter_immune_string += ", "
		filter_immune_string += typepath::name
	return filter_immune_string

/datum/preference/choiced/aphrodisiacal_bite_venom/init_possible_values()
	var/list/choices = list()
	for (var/entry in aphrodisiacal_bite_choice_specs)
		choices += "[entry]"

	return choices

/datum/preference/choiced/aphrodisiacal_bite_venom/create_default_value()
	return "/datum/reagent/drug/aphrodisiac/crocin"

/datum/preference/choiced/aphrodisiacal_bite_venom/compile_constant_data()
	var/list/data = ..()

	var/list/titles = list()

	for (var/datum/reagent/entry as anything in aphrodisiacal_bite_choice_specs)
		var/list/specs = aphrodisiacal_bite_choice_specs[entry]

		var/inject = specs[1]
		var/cooldown = specs[2]

		var/name = entry::name

		titles["[entry]"] = "[name] ([inject]u, [cooldown / 10] second cooldown)"

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = titles

	return data

/datum/preference/choiced/aphrodisiacal_bite_venom/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Aphrodisiacal Bite" in preferences.all_quirks

/datum/preference/choiced/aphrodisiacal_bite_venom/apply_to_human(mob/living/carbon/human/target, value)
	return
