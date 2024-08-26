
//Whitelist.
GLOBAL_LIST_INIT(heretical_mirroring_whitelist,list(
	/obj/item/weapon,
	/obj/item/clothing,
))

//Blacklist. Todo.
GLOBAL_LIST_INIT(heretical_mirroring_blacklist,list(

))

/obj/item/heretic_currency/mirroring
	name = "mirroring orb"
	icon_state = "mirroring"

/obj/item/heretic_currency/mirroring/pre_attack(obj/item/target, mob/living/user)
	. = ..()
	if(. || !istype(target))
		return

	if(target.item_flags & (DROPDEL | ABSTRACT))
		return

	var/whitelist_passed = FALSE
	for(var/whitelist_type in heretical_mirroring_whitelist)
		if(istype(target,whitelist_type))
			whitelist_passed = TRUE
			break

	if(!whitelist_passed)
		return

	for(var/blacklist_type in heretical_mirroring_blacklist)
		if(istype(target,blacklist_type))
			//Message goes here.
			return

	var/datum/component/fantasy/found_component = target.GetComponent(/datum/component/fantasy)
	var/list/saved_affixes
	var/saved_quality
	if(found_component)
		if(length(found_component.affixes))
			saved_affixes = found_component.affixes.Copy()
		if(found_component.quality)
			saved_quality = saved_quality

	var/obj/item/item_clone = new target.type
	if(saved_affixes)
		item_clone.AddComponent(/datum/component/fantasy,saved_quality,saved_affixes,FALSE,FALSE)

	qdel(src)