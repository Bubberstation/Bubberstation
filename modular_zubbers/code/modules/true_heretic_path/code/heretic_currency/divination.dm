/obj/item/heretic_currency/divination
	name = "divination orb"
	icon_state = "divination"

/obj/item/heretic_currency/divination/pre_attack(obj/item/target, mob/living/user)
	. = ..()
	if(. || !istype(target))
		return
	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	if(!found_component)
		return
	found_component.random_quality()
	found_component.modify()
	qdel(src)