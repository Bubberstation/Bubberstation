

GLOBAL_LIST_INIT(heretical_suffixes,generate_heretical_affixes(AFFIX_SUFFIX))
GLOBAL_LIST_INIT(heretical_prefixes,generate_heretical_affixes(AFFIX_PREFIX))

/proc/generate_heretical_affixes(affix_type)
	. = list()
	for(var/T in subtypesof(/datum/fantasy_affix))
		var/datum/fantasy_affix/affix = T
		if(initial(T.placement) != affix_type)
			continue
		if(initial(T.alignment) & AFFIX_GOOD) //This also includes cosmetic types.
			continue
		.[new affix] = initial(affix.weight)
	return

/obj/item/heretic_currency
`	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_currency.dmi'

/obj/item/heretic_currency/proc/get_prefix()
	for(var/attempts = 8,attempts>0,attempts--)
		var/datum/fantasy/affix/affix = pick_weight(heretical_prefixes)
		if(!affix.validate(target))
			continue
		return affix

/obj/item/heretic_currency/proc/get_suffix()
	for(var/attempts = 8,attempts>0,attempts--)
		var/datum/fantasy/affix/affix = pick_weight(heretical_suffixes)
		if(!affix.validate(target))
			continue
		return affix
