/// Format: (reagent typepath -> list(amount to inject per bite, cooldown))
GLOBAL_LIST_INIT(venomous_bite_choice_specs, list(
	/datum/reagent/toxin/player_venom = list(4, 50 SECONDS),
	/datum/reagent/toxin/venom = list(2, 120 SECONDS), // this one is a serious toxin
	/datum/reagent/toxin/staminatoxin = list(3, 50 SECONDS),
	/datum/reagent/toxin/carpotoxin = list(2, 50 SECONDS), // very low dose
	/datum/reagent/toxin/slimejelly = list(3, 50 SECONDS), // low dose
	/datum/reagent/toxin/mutagen = list(2, 50 SECONDS), // low dose
	/datum/reagent/consumable/frostoil = list(5, 120 SECONDS),
	// medicine
	/datum/reagent/medicine/epinephrine = list(3, 20 SECONDS),
	/datum/reagent/medicine/omnizine = list(2, 30 SECONDS), // barely worth it due to the damage biting does
	// erp stuff
	/datum/reagent/drug/aphrodisiac/crocin = list(5, 2),
	/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = list(5, 5),
))

GLOBAL_LIST_INIT(venomous_bite_choices, generate_venomous_bite_choices())

GLOBAL_LIST_INIT(venemous_bite_venom_choice_titles, generate_venemous_bite_titles())

/proc/generate_venemous_bite_titles()
	RETURN_TYPE(/list)

	var/list/titles = list()

	for (var/datum/reagent/entry as anything in GLOB.venomous_bite_choice_specs)
		var/list/specs = GLOB.venomous_bite_choice_specs[entry]

		var/inject = specs[1]
		var/cooldown = specs[2]

		var/name = entry::name

		titles["[entry]"] = "[name] ([inject]u, [cooldown / 10] second cooldown)"

	return titles

/proc/generate_venomous_bite_choices()
	RETURN_TYPE(/list)

	var/list/choices = list()
	for (var/entry in GLOB.venomous_bite_choice_specs)
		choices += "[entry]"

	return choices

/datum/quirk/venemous_bite
	name = "Venomous Bite"
	desc = "You have a venom gland, and can bite people to inject them with a toxin of your choosing."
	icon = FA_ICON_TEETH_OPEN
	value = 8
	gain_text = span_notice("You feel a venom gland in the back of your throat.")
	lose_text = span_warning("Your venom gland vanishes.")
	medical_record_text = "Patient possesses a venom gland."

/datum/quirk/venemous_bite/add(client/client_source)
	var/datum/reagent/reagent = text2path(client_source?.prefs?.read_preference(/datum/preference/choiced/venemous_bite_venom))

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/mob_cooldown/venemous_bite/action = new /datum/action/cooldown/mob_cooldown/venemous_bite(human_holder, our_reagent = reagent)
	action.Grant(human_holder)

/datum/quirk/venemous_bite/remove()
	var/datum/action/cooldown/mob_cooldown/venemous_bite/action = locate(/datum/action/cooldown/mob_cooldown/venemous_bite) in quirk_holder.actions
	action.Remove()

	return ..()

/datum/quirk_constant_data/venemous_bite
	associated_typepath = /datum/quirk/venemous_bite
	customization_options = list(/datum/preference/choiced/venemous_bite_venom)

/datum/preference/choiced/venemous_bite_venom
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "venemous_bite_venom"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/venemous_bite_venom/init_possible_values()
	return GLOB.venomous_bite_choices

/datum/preference/choiced/venemous_bite_venom/create_default_value()
	return "/datum/reagent/toxin/player_venom"

/datum/preference/choiced/venemous_bite_venom/compile_constant_data()
	var/list/data = ..()

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = GLOB.venemous_bite_venom_choice_titles

	return data

/datum/preference/choiced/venemous_bite_venom/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Venomous Bite" in preferences.all_quirks

/datum/preference/choiced/venemous_bite_venom/apply_to_human(mob/living/carbon/human/target, value)
	return
