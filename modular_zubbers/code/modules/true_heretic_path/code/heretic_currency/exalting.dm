/obj/item/heretic_currency/exalting
	name = "exalting orb"
	desc = "An amorphous golden blob of a three-headed figurine. You feel that it is shifting... but it isn't."
	icon_state = "exalting"


/obj/item/heretic_currency/exalting/pre_attack(obj/item/target, mob/living/user)
	. = ..()

	if(.)
		return

	if(!istype(target))
		user.balloon_alert(user, "not an item!")
		return

	if(HAS_TRAIT(target, TRAIT_INNATELY_FANTASTICAL_ITEM))
		user.balloon_alert(user, "has no effect!")
		return

	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	if(!found_component)
		return

	if(!length(found_component.affixes))
		user.balloon_alert(user, "something went wrong!")
		return

	if(length(found_component.affixes) >= 2)
		user.balloon_alert(user, "already has two affixes!")
		return

	var/datum/fantasy_affix/affix_to_add

	var/datum/fantasy_affix/found_affix = found_component.affixes[1]
	if(found_affix.placement & AFFIX_SUFFIX)
		affix_to_add = get_prefix(target)
	else
		affix_to_add = get_suffix(target)

	if(!affix_to_add)
		user.balloon_alert(user, "something went wrong!")
		return

	affix_to_add = new affix_to_add.type

	found_component.unmodify() //Clear existing (but we saved the existing one)
	found_component.affixes += affix_to_add
	found_component.modify()

	user.balloon_alert(user, "[name] applied!")

	qdel(src)

