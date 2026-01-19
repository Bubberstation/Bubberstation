GLOBAL_LIST_INIT(loadout_blacklist_terms,list(
	"debug",
	"admin",
	"god",
	"dev",
	"centcom",
	"central com",

))

GLOBAL_LIST_INIT(loadout_blacklist,generate_loadout_blacklist())


GLOBAL_LIST_INIT(loadout_blacklist_names,list())

/proc/generate_loadout_blacklist() as /list

	. = list()

	//Prevents traitor items.
	for(var/datum/uplink_item/syndie_uplink_datum as anything in typesof(/datum/uplink_item))
		if(syndie_uplink_datum.item)
			.[syndie_uplink_datum.item] = TRUE

	//Prevents research items.
	for(var/datum/design/research_design as anything in typesof(/datum/design))
		if(research_design.build_path)
			.[research_design.build_path] = TRUE

	return .

/proc/is_loadout_safe(obj/item/item_to_check,do_debug=FALSE)

	//Manually blacklisted.
	if(length(GLOB.loadout_blacklist) && GLOB.loadout_blacklist[item_to_check])
		return FALSE

	if(length(GLOB.loadout_blacklist_names) && GLOB.loadout_blacklist[GLOB.loadout_blacklist_names])
		return FALSE

	if(item_to_check == item_to_check.abstract_type)
		return FALSE

	if(!item_to_check.name || !item_to_check.desc || !item_to_check.icon || !item_to_check.icon_state)
		return FALSE

	//Resistance Flags
	if(item_to_check.resistance_flags & LOADOUT_BLACKLISTED_CLOTHING_RESISTANCES)
		return FALSE

	//Item flags.
	if(item_to_check.item_flags & LOADOUT_BLACKLISTED_ITEM_FLAGS)
		return FALSE

	//Makes you fast.
	if(item_to_check.slowdown < 0)
		return FALSE

	//Gives you unreasonable shock resist.
	if(item_to_check.siemens_coefficient < 0.5) //0.5 is considered normal for most items.
		return FALSE

	//We're clothing.
	if(ispath(item_to_check,/obj/item/clothing/))

		var/obj/item/clothing/found_clothing = item_to_check

		//Flash Protection
		if(found_clothing.flash_protect > FLASH_PROTECTION_NONE)
			return FALSE

		//Clothing Flags
		var/all_flags = 0x0
		if(found_clothing.visor_flags)
			all_flags |= found_clothing.visor_flags
		if(found_clothing.clothing_flags)
			all_flags |= found_clothing.clothing_flags
		if(all_flags & LOADOUT_BLACKLISTED_CLOTHING_TRAITS)
			return FALSE

		//Pepperspray Flags
		if(found_clothing.flags_cover & PEPPERPROOF)
			return FALSE

		//Armor Stuff
		if(found_clothing.armor_type)
			var/datum/armor/found_armor = GLOB.armor_by_type[found_clothing.armor_type]
			if(found_armor)
				var/obj/item/clothing/abstract = found_clothing.abstract_type
				if(abstract && abstract.armor_type)
					var/datum/armor/found_abstract_armor = GLOB.armor_by_type[abstract.armor_type]
					if(found_abstract_armor)
						//If it's better than the abstract type (default), then it must be too good.
						if(found_armor.get_rating(BIO) > found_abstract_armor.get_rating(BIO))
							return FALSE
						if(found_armor.get_rating(ACID) > found_abstract_armor.get_rating(ACID))
							return FALSE
						if(found_armor.get_rating(WOUND) > found_abstract_armor.get_rating(WOUND))
							return FALSE
				//If it has anything in these armor categories, then it also must be too good.
				if(found_armor.get_rating(MELEE) > 0)
					return FALSE
				if(found_armor.get_rating(BULLET) > 0)
					return FALSE
				if(found_armor.get_rating(BOMB) > 0)
					return FALSE
				if(found_armor.get_rating(ENERGY) > 0)
					return FALSE
				if(found_armor.get_rating(LASER) > 0)
					return FALSE
				if(found_armor.get_rating(FIRE) > 0)
					return FALSE

	//Check for common debug/admin/dev nonsense
	if(length(GLOB.loadout_blacklist_terms))
		for(var/bad_word in GLOB.loadout_blacklist_terms)
			if(findtext(item_to_check.name,bad_word))
				return FALSE

	return TRUE




/proc/generate_loadout_list(list/possible_items) as /list

	. = list()

	if(!length(GLOB.armor_by_type))
		stack_trace("Loadout nonsense generated before armor stuff could initialize! Shit's fucked!")
		return

	for(var/obj/item/item_to_check as anything in possible_items)

		if(!is_loadout_safe(item_to_check))
			continue

		//All good.
		. += item_to_check
