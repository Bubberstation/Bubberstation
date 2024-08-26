/obj/item/heretic_currency/exalting
	name = "exalting orb"
	icon_state = "exalting"


/obj/item/heretic_currency/exalting/pre_attack(obj/item/target, mob/living/user)
	. = ..()
	if(. || !istype(target))
		return
	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	if(!found_component)
		return

	if(!length(found_component.affixes))
		//uhhhhh
		return

	if(length(found_component.affixes) >= 2))
		return

	var/datum/fantasy_affix/affix_to_add

	var/datum/fantasy_affix/found_affix = found_component.affixes[1]
	if(found_affix.placement & AFFIX_SUFFIX)
		affix_to_add = get_prefix()
	else
		affix_to_add = get_suffix()

	if(!affix_to_add)
		return

	affix_to_add = new affix_to_add

	found_component.unmodify() //Clear existing (but we saved the existing one)
	found_component.affixes += found_affix
	found_component.affixes += affix_to_add
	found_component.modify()

	qdel(src)

