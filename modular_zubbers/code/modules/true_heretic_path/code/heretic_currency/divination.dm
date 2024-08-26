/obj/item/heretic_currency/divination
	name = "divination orb"
	icon_state = "divination"

/obj/item/heretic_currency/divination/pre_attack(obj/item/target, mob/living/user)
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
		user.balloon_alert(user, "not a fantasy item!")
		return

	found_component.random_quality()
	found_component.modify()

	user.balloon_alert(user, "[name] applied!")

	qdel(src)