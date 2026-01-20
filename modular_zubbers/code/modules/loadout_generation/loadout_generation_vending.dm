/proc/generate_loadout_list_from_vendor(obj/machinery/vending/vendor_to_check, restricted_roles, processed_loadout_categories)

	var/obj/machinery/vending/created_vendor = new vendor_to_check

	stack_trace("Checking [length(created_vendor.products)] products for [vendor_to_check]...")

	for(var/found_item as anything in created_vendor.products)

		//Only get clothing items!
		//For loops check for types, not paths.
		if(!ispath(found_item,/obj/item/clothing))
			continue

		var/obj/item/clothing/found_clothing = found_item

		if(length(GLOB.all_loadout_datums) && GLOB.all_loadout_datums[found_clothing]) //Already exists.
			var/datum/loadout_item/existing_loadout = GLOB.all_loadout_datums[found_clothing]
			if(length(existing_loadout.restricted_roles)) //Expand the allowed roles, only if there is restrictions in the first place.
				existing_loadout.restricted_roles |= restricted_roles
			continue

		stack_trace("Checking [found_clothing]...")

		var/created_item = FALSE
		for(var/datum/loadout_category/found_category as anything in processed_loadout_categories) //Search the loadout categories.

			for(var/possible_subtype_path as anything in found_category.generation_subtypes_whitelist)

				if(!ispath(found_clothing,possible_subtype_path))
					continue

				//We're the right path as one of the subtypes.
				var/datum/loadout_item/loadout_item_datum = new found_category.type_to_generate(
					found_category,
					full_capitalize("[found_clothing.name]"),
					found_clothing
				)
				loadout_item_datum.restricted_roles = restricted_roles
				loadout_item_datum.group = "Job Items"
				found_category.associated_items += loadout_item_datum
				created_item = TRUE
				break

			if(created_item)
				break

		if(created_item)
			stack_trace("Found an appropriate category for [found_clothing]!")
		else
			stack_trace("Could not find an appropraite category for [found_clothing].")

	qdel(created_vendor)
