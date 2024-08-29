

GLOBAL_LIST_INIT(heretical_affixes_blacklist,list(
	/datum/fantasy_affix/summoning = TRUE,
	/datum/fantasy_affix/curse_of_polymorph = TRUE,
	/datum/fantasy_affix/venomous = TRUE //Too strong.
))

GLOBAL_LIST_INIT(heretical_suffixes,generate_heretical_affixes(AFFIX_SUFFIX))
GLOBAL_LIST_INIT(heretical_prefixes,generate_heretical_affixes(AFFIX_PREFIX))

/proc/generate_heretical_affixes(affix_type)

	. = list()

	for(var/datum/fantasy_affix/affix as anything in subtypesof(/datum/fantasy_affix))
		if(initial(affix.placement) != affix_type)
			continue
		if(GLOB.heretical_affixes_blacklist[affix])
			continue
		.[new affix] = initial(affix.weight)

	return

/obj/item/heretic_currency
	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_currency.dmi'

	w_class = WEIGHT_CLASS_TINY

	var/heretic_instructions //This is displayed to heretics on examine only.

/obj/item/heretic_currency/examine(mob/user)
	. = ..()
	if(heretic_instructions && IS_HERETIC(user))
		. += span_velvet(heretic_instructions)

/obj/item/heretic_currency/proc/get_prefix(obj/item/target)
	for(var/attempts = 8,attempts>0,attempts--)
		var/datum/fantasy_affix/affix = pick_weight(GLOB.heretical_prefixes)
		if(!affix.validate(target))
			continue
		return affix

/obj/item/heretic_currency/proc/get_suffix(obj/item/target)
	for(var/attempts = 8,attempts>0,attempts--)
		var/datum/fantasy_affix/affix = pick_weight(GLOB.heretical_suffixes)
		if(!affix.validate(target))
			continue
		return affix

/obj/item/storage/box/heretic_currency_debug_box
	name = "heretic currency debug box"
	desc = "Does not contain fishing mechanics."
	illustration = "fish"

/obj/item/storage/box/heretic_currency_debug_box/PopulateContents()

	for(var/obj/item/found_currency as anything in subtypesof(/obj/item/heretic_currency))
		for(var/i in 1 to 5)
			new found_currency(src)
