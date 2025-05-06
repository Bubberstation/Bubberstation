GLOBAL_LIST_INIT(loadout_blacklist, list())

/proc/generate_loadout_list(desired_subtype,subtypes_only=TRUE)

	. = list()

	var/list/obj/item/found_types = typesof(desired_subtype)

	if(subtypes_only)
		found_types -= desired_subtype

	var/static/list/clothing_typecache = typecacheof(/obj/item/clothing)

	for(var/obj/item/found_item as anything in found_types)

		//Manually blacklisted.
		if(found_item in loadout_blacklist)
			continue

		//Resistance Flags
		if(found_item.resistance_flags & LOADOUT_BLACKLISTED_CLOTHING_RESISTANCES)
			continue

		//Makes you fast.
		if(slowdown < 0)
			continue

		//We're clothing.
		if(is_type_in_typecache(found_item,clothing_typecache)) //Supports paths.

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
			var/datum/armor/found_armor = initial(found_clothing.armor) ? GLOB.armor_by_type[initial(found_clothing)) : null
			if(found_armor)
				//Bio, Acid, Wounding, and Fire is excluded from here since some science related items have immunity from this.
				if(found_armor.get_rating(BOMB) > 0)
					continue
				if(found_armor.get_rating(BULLET) > 0)
					continue
				if(found_armor.get_rating(ENERGY) > 0)
					continue
				if(found_armor.get_rating(LASER) > 0)
					continue
				if(found_armor.get_rating(MELEE) > 0)
					continue

		//All good.
		. += found_item
