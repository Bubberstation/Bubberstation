/obj/item/heretic_currency/mirroring
	name = "mirroring orb"
	desc = "A thick and heavy handleless hand-mirror that does not seem to show your own reflection, despite showing the world around it. Spooky."
	icon_state = "mirroring"
	heretic_instructions = "Use on a weapon or clothing item to duplicate the item. Consumed on use."

/obj/item/heretic_currency/mirroring/pre_attack(obj/item/target, mob/living/user)

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

	var/turf/turf_to_create_at = get_turf(target)
	if(!turf_to_create_at)
		turf_to_create_at = get_turf(user)

	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	var/list/saved_affixes
	var/saved_quality
	if(found_component)
		if(length(found_component.affixes))
			saved_affixes = found_component.affixes.Copy()
		if(found_component.quality)
			saved_quality = found_component.quality

	var/obj/item/item_clone = new target.type(turf_to_create_at)
	if(saved_affixes)
		item_clone.AddComponent(/datum/component/fantasy,saved_quality,saved_affixes,FALSE,FALSE)

	target.balloon_alert(user, "[name] applied!")

	qdel(src)

	user.put_in_hands(item_clone)