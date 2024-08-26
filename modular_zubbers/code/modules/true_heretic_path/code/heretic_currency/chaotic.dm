/obj/item/heretic_currency/chaotic
	name = "chaotic orb"
	desc = "A solid golden figurine of three heads combined into one. Looking at it makes you feel uncertainty."
	icon_state = "chaotic"

/obj/item/heretic_currency/chaotic/pre_attack(obj/item/target, mob/living/user)

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

	var/datum/fantasy_affix/desired_prefix = get_prefix(target)
	var/datum/fantasy_affix/desired_suffix = get_suffix(target)

	if(desired_prefix && desired_suffix)
		if(prob(50)) //Chance to clear one.
			if(prob(50))
				desired_prefix = null
			else
				desired_suffix = null
	else if(!desired_prefix && !desired_suffix)
		user.balloon_alert(user, "something went wrong!")
		return

	found_component.unmodify() //Clear existing

	found_component.affixes.Cut()

	if(desired_prefix)
		found_component.affixes += new desired_prefix.type

	if(desired_suffix)
		found_component.affixes += new desired_suffix.type

	found_component.quality = found_component.random_quality()

	found_component.modify()

	user.balloon_alert(user, "[name] applied!")

	qdel(src)