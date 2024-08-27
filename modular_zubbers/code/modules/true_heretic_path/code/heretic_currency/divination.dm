/obj/item/heretic_currency/divination
	name = "divination orb"
	desc = "A smooth and shiny golden figurine of some bald woman's head. It is perfect in every way."
	icon_state = "divination"

/obj/item/heretic_currency/divination/pre_attack(obj/item/target, mob/living/user)
	. = ..()

	if(.)
		return

	if(!istype(target))
		target.balloon_alert(user, "not an item!")
		return

	if(HAS_TRAIT(target, TRAIT_INNATELY_FANTASTICAL_ITEM))
		target.balloon_alert(user, "has no effect!")
		return

	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	if(!found_component)
		target.balloon_alert(user, "not a fantasy item!")
		return

	found_component.unmodify()

	found_component.quality = found_component.random_quality()

	found_component.modify()

	target.balloon_alert(user, "[name] applied!")

	qdel(src)