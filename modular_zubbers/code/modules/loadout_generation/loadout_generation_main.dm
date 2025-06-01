GLOBAL_LIST_INIT(loadout_blacklist,list())

/proc/generate_loadout_list(desired_subtype,subtypes_only=TRUE) as /list

	. = list()

	if(!length(GLOB.armor_by_type))
		stack_trace("Loadout nonsense generated before armor stuff could initialize! Shit's fucked!")
		return .

	var/list/obj/item/found_types = typesof(desired_subtype)

	if(subtypes_only)
		found_types -= desired_subtype

	for(var/obj/item/found_item as anything in found_types)

		//Manually blacklisted.
		if(length(GLOB.loadout_blacklist) && GLOB.loadout_blacklist[found_item])
			continue

		if(!initial(found_item.name) || !initial(found_item.desc))
			continue

		//Resistance Flags
		if(found_item.resistance_flags & LOADOUT_BLACKLISTED_CLOTHING_RESISTANCES)
			continue

		//Makes you fast.
		if(found_item.slowdown < 0)
			continue

		//We're clothing.
		if(ispath(found_item,/obj/item/clothing/))

			var/obj/item/clothing/found_clothing = found_item

			//Flash Protection
			if(found_clothing.flash_protect)
				continue

			//Clothing Flags
			var/all_flags = 0x0
			if(found_clothing.visor_flags)
				all_flags |= found_clothing.visor_flags
			if(found_clothing.clothing_flags)
				all_flags |= found_clothing.clothing_flags
			if(all_flags & LOADOUT_BLACKLISTED_CLOTHING_TRAITS)
				continue

			//Pepperspray Flags
			if(found_clothing.flags_cover & PEPPERPROOF)
				continue

			//Armor Stuff
			var/datum/armor/found_armor = initial(found_clothing.armor)
			if(found_armor)
				found_armor = GLOB.armor_by_type[found_armor]
				//Bio, Acid, and Wounding are excluded from here since some science related items have immunity from this.
				if(found_armor.get_rating(MELEE) > 0)
					continue
				if(found_armor.get_rating(BULLET) > 0)
					continue
				if(found_armor.get_rating(BOMB) > 0)
					continue
				if(found_armor.get_rating(ENERGY) > 0)
					continue
				if(found_armor.get_rating(LASER) > 0)
					continue
				if(found_armor.get_rating(FIRE) > 0)
					continue

		//All good.
		. += found_item
