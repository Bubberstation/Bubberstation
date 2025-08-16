
/datum/species/monkey
	mutantheart = /obj/item/organ/heart/monkey
	remove_features = TRUE

/datum/species/monkey/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Monkey", FALSE),
	)

/datum/species/monkey/randomize_features()
	var/list/features = ..()
	features["tail"] = pick(SSaccessories.tails_list_monkey - list("None")) // No tail-less monkeys.
	return features

/datum/species/monkey/prepare_human_for_preview(mob/living/carbon/human/monke)
	monke.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Monkey", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	regenerate_organs(monke, src, visual_only = TRUE)
	monke.update_body(is_creating = TRUE)

/datum/species/monkey/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_monkey

/datum/species/monkey/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_monkey = icon

/datum/species/monkey/get_species_description()
	return list("Monkeys are a type of primate that exist between humans and animals on the evolutionary chain. \
		Every year, on Monkey Day, Nanotrasen shows their respect for the little guys by allowing them to roam the station freely.",)
