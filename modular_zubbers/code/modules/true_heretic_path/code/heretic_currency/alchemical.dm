/obj/item/heretic_currency/alchemical
	name = "alchemical orb"
	icon_state = "alchemical"


/obj/item/heretic_currency/alchemical/pre_attack(obj/item/target, mob/living/user)

	. = ..()

	if(. || !istype(target))
		return

	var/datum/fantasy/affix/desired_affix

	if(prob(50))
		desired_affix = get_prefix()

	if(!desired_affix)
		desired_affix = get_suffix()

	if(!desired_affix)
		return

	desired_affix = new desired_affix
	target.AddComponent(/datum/component/fantasy, null, list(desired_affix), FALSE, FALSE)
	qdel(src)