/obj/item/heretic_currency/alchemical
	name = "alchemical orb"
	desc = "A mysterious rock-like orb that smells of sulfur. It has a weird organic root growing out the side."
	icon_state = "alchemical"
	heretic_instructions = "Use on a weapon or clothing item without fantasy modifiers to turn it into an item with fantasy modifiers. Consumed on use."

/obj/item/heretic_currency/alchemical/pre_attack(obj/item/target, mob/living/user)

	. = ..()

	if(.)
		return

	if(!istype(target))
		target.balloon_alert(user, "not a weapon or clothing item!")
		return

	if(HAS_TRAIT(target, TRAIT_INNATELY_FANTASTICAL_ITEM))
		target.balloon_alert(user, "has no effect!")
		return

	if(target.item_flags & (DROPDEL | ABSTRACT))
		return

	if(!target.force && !target.throwforce && !isclothing(target) && !isgun(target))
		target.balloon_alert(user, "not a valid weapon or clothing item!")
		return

	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	if(found_component)
		target.balloon_alert(user, "already a fantasy item!")
		return

	var/datum/fantasy_affix/desired_affix

	if(prob(50))
		desired_affix = get_prefix(target)

	if(!desired_affix)
		desired_affix = get_suffix(target)

	if(!desired_affix)
		target.balloon_alert(user, "something went wrong!")
		return

	desired_affix = new desired_affix.type
	target.AddComponent(/datum/component/fantasy, null, list(desired_affix), FALSE, FALSE)
	target.balloon_alert(user, "[src] applied!")
	qdel(src)
