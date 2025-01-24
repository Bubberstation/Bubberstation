/datum/quirk/venomous_bite
	name = "Venomous Bite"
	desc = "You have a venom gland, and can bite people to inject them with a toxin of your choosing."
	icon = FA_ICON_TEETH_OPEN
	value = 8
	gain_text = span_notice("You feel a venom gland in the back of your throat.")
	lose_text = span_warning("Your venom gland vanishes.")
	medical_record_text = "Patient possesses a venom gland."

/datum/quirk/venomous_bite/add(client/client_source)
	var/datum/reagent/reagent = text2path(client_source?.prefs?.read_preference(/datum/preference/choiced/venomous_bite_venom))

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/mob_cooldown/venomous_bite/action = new /datum/action/cooldown/mob_cooldown/venomous_bite(human_holder, our_reagent = reagent)
	action.Grant(human_holder)

/datum/quirk/venomous_bite/remove()
	var/datum/action/cooldown/mob_cooldown/venomous_bite/action = locate(/datum/action/cooldown/mob_cooldown/venomous_bite) in quirk_holder.actions
	action.Remove()

	return ..()

/datum/quirk_constant_data/venomous_bite
	associated_typepath = /datum/quirk/venomous_bite
	customization_options = list(/datum/preference/choiced/venomous_bite_venom)

/datum/preference/choiced/venomous_bite_venom
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "venomous_bite_venom"
	savefile_identifier = PREFERENCE_CHARACTER
	/// Format: (reagent typepath -> list(amount to inject per bite, cooldown, can be milked (venom_milker.dm)))
	var/static/list/venomous_bite_choice_specs = list(
		/datum/reagent/toxin/player_venom = list(5, 80 SECONDS, FALSE),
		/datum/reagent/toxin/venom = list(5, 180 SECONDS, FALSE),
		/datum/reagent/toxin/staminatoxin = list(5, 120 SECONDS, FALSE),
		/datum/reagent/toxin/carpotoxin = list(5, 60 SECONDS, FALSE), // less powerful than the zootoxin
		// medicine
		/datum/reagent/medicine/epinephrine = list(5, 20 SECONDS, FALSE),
		/datum/reagent/medicine/omnizine = list(5, 90 SECONDS, FALSE), // barely worth it due to the damage biting does
		// drugs
		/datum/reagent/drug/space_drugs = list(5, 60 SECONDS, TRUE),
		/datum/reagent/toxin/mindbreaker = list(5, 60 SECONDS, FALSE),
		// erp stuff
		/datum/reagent/drug/aphrodisiac/crocin = list(5, 2 SECONDS, TRUE),
		/datum/reagent/drug/aphrodisiac/crocin/hexacrocin = list(5, 5 SECONDS, TRUE),
)
	var/static/list/milkable_venoms = generate_milkable_venom_list()
	var/static/milkable_string = generate_milkable_venom_string()

/proc/generate_milkable_venom_list()
	RETURN_TYPE(/list)

	var/list/milkable = list()

	for (var/datum/reagent/typepath as anything in /datum/preference/choiced/venomous_bite_venom::venomous_bite_choice_specs)
		var/list/spec = /datum/preference/choiced/venomous_bite_venom::venomous_bite_choice_specs[typepath]

		if (spec[3])
			milkable += typepath

	return milkable

/proc/generate_milkable_venom_string()
	var/milkable_string = ""
	for (var/datum/reagent/typepath as anything in /datum/preference/choiced/venomous_bite_venom::milkable_venoms)
		if (length(milkable_string))
			milkable_string += " "
		milkable_string += typepath::name
	return milkable_string

/datum/preference/choiced/venomous_bite_venom/init_possible_values()
	var/list/choices = list()
	for (var/entry in venomous_bite_choice_specs)
		choices += "[entry]"

	return choices

/datum/preference/choiced/venomous_bite_venom/create_default_value()
	return "/datum/reagent/toxin/player_venom"

/datum/preference/choiced/venomous_bite_venom/compile_constant_data()
	var/list/data = ..()

	var/list/titles = list()

	for (var/datum/reagent/entry as anything in venomous_bite_choice_specs)
		var/list/specs = venomous_bite_choice_specs[entry]

		var/inject = specs[1]
		var/cooldown = specs[2]

		var/name = entry::name

		titles["[entry]"] = "[name] ([inject]u, [cooldown / 10] second cooldown)"

	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = titles

	return data

/datum/preference/choiced/venomous_bite_venom/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return "Venomous Bite" in preferences.all_quirks

/datum/preference/choiced/venomous_bite_venom/apply_to_human(mob/living/carbon/human/target, value)
	return
