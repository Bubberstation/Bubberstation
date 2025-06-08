/obj/item/clothing/neck
	///How much faster does the wearer gain weight? 1 = 100% faster
	var/weight_gain_rate_modifier = 0

/obj/item/clothing/neck/equipped(mob/user, slot)
	. = ..()

	var/mob/living/carbon/wearer = user
	if(!weight_gain_rate_modifier)
		return FALSE

	if(!iscarbon(wearer) || slot !=ITEM_SLOT_NECK || !wearer?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_items))
		return FALSE

	wearer.weight_gain_rate = wearer.weight_gain_rate * weight_gain_rate_modifier

/obj/item/clothing/neck/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/wearer = user
	if(!weight_gain_rate_modifier)
		return FALSE

	if(!iscarbon(wearer) || !(wearer.get_item_by_slot(ITEM_SLOT_NECK) == src) || !wearer?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_items))
		return FALSE

	wearer.weight_gain_rate = (wearer.weight_gain_rate / weight_gain_rate_modifier)


/obj/item/clothing/neck/petcollar/calorite
	name = "calorite collar"
	desc = "A modified pet collar infused with calorite, magnifying the caloric impact of any food the wearer eats"
	weight_gain_rate_modifier = 1.5

/obj/item/clothing/neck/petcollar/locked/calorite
	name = "locked calorite collar"
	desc = "A modified locked collar infused with calorite, magnifying the caloric impact of any food the wearer eats"
	weight_gain_rate_modifier = 1.5

/datum/crafting_recipe/calorite_collar
	name = "Calorite Collar"
	result = /obj/item/clothing/neck/petcollar/calorite
	time = 25
	reqs = list(/obj/item/clothing/neck/petcollar = 1,
				/obj/item/stack/sheet/mineral/calorite = 3)
	category = CAT_CLOTHING

/datum/crafting_recipe/locked_calorite_collar
	name = "Locked Calorite Collar"
	result = /obj/item/clothing/neck/petcollar/locked/calorite
	time = 25
	reqs = list(/obj/item/clothing/neck/petcollar/locked = 1,
				/obj/item/stack/sheet/mineral/calorite = 3)
	category = CAT_CLOTHING
