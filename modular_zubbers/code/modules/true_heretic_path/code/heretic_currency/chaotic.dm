/obj/item/heretic_currency/chaotic
	name = "chaotic orb"
	icon_state = "chaotic"

/obj/item/heretic_currency/chaotic/pre_attack(obj/item/target, mob/living/user)
	. = ..()
	if(. || !istype(target))
		return
	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	if(!found_component)
		return

	var/datum/fantasy/affix/desired_prefix = get_prefix()
	var/datum/fantasy/affix/desired_suffix = get_suffix()


	if(desired_prefix && desired_suffix)
		if(prob(50)) //Chance to clear one.
			if(prob(50)
				desired_prefix = null
			else
				desired_suffix = null
	else if(!desired_prefix && !desired_suffix)
		//Something went wrong.
		return

	found_component.unmodify() //Clear existing

	if(desired_prefix)
		found_component.affixes += new desired_prefix

	if(desired_suffix)
		found_component.affixes += new desired_affix

	found_component.modify()

	qdel(src)