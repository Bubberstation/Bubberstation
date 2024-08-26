/obj/item/heretic_currency/alchemical
	name = "alchemical orb"
	icon_state = "alchemical"

/obj/item/heretic_currency/alchemical/pre_attack(obj/item/target, mob/living/user)

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
	if(found_component)
		user.balloon_alert(user, "already a fantasy item!")
		return

	var/datum/fantasy_affix/desired_affix

	if(prob(50))
		desired_affix = get_prefix(target)

	if(!desired_affix)
		desired_affix = get_suffix(target)

	if(!desired_affix)
		user.balloon_alert(user, "something went wrong!")
		return

	desired_affix = new desired_affix.type
	target.AddComponent(/datum/component/fantasy, null, list(desired_affix), FALSE, FALSE)
	user.balloon_alert(user, "[src] applied!")
	qdel(src)
