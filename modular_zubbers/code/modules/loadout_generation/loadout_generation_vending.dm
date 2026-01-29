/proc/generate_loadout_list_from_vendor(obj/machinery/vending/vendor_to_check, list/restricted_roles, processed_loadout_categories, override_restricted_roles = FALSE)

	var/obj/machinery/vending/created_vendor = new vendor_to_check

	var/list/found_products

	if(length(created_vendor.products))
		found_products = created_vendor.products.Copy()
	else
		found_products = list()

	if(length(created_vendor.product_categories))
		for(var/product_category in created_vendor.product_categories)
			if(!length(product_category) || !length(product_category["products"]))
				continue
			for(var/product_item in product_category["products"])
				found_products |= product_item

	create_loadouts_from_list(
		found_products,
		restricted_roles,
		processed_loadout_categories,
		override_restricted_roles
	)

	qdel(created_vendor)


/proc/generate_loadout_list_from_access_vendor(obj/machinery/vending/access/vendor_to_check, processed_loadout_categories, override_restricted_roles = FALSE)

	var/obj/machinery/vending/access/created_vendor = new vendor_to_check
	created_vendor.access_lists = list()
	created_vendor.build_access_list(created_vendor.access_lists)

	for(var/access_flag in created_vendor.access_lists)
		var/list/found_products = created_vendor.access_lists[access_flag]

		if(!length(found_products))
			stack_trace("Could not find any products for [created_vendor.type]!")
			continue

		var/list/desired_restrictions = GLOB.access_string_to_job[access_flag]
		create_loadouts_from_list(
			found_products,
			desired_restrictions,
			processed_loadout_categories,
			override_restricted_roles
		)

	qdel(created_vendor)


/proc/create_loadouts_from_list(list/found_products,list/restricted_roles,processed_loadout_categories,override_restricted_roles)

	for(var/found_item as anything in found_products)

		//Only get clothing items!
		//For loops check for types, not paths.
		if(!ispath(found_item,/obj/item/clothing))
			continue

		var/obj/item/clothing/found_clothing = found_item

		if(length(GLOB.all_loadout_datums) && GLOB.all_loadout_datums[found_clothing]) //Already exists as a loadout item.
			var/datum/loadout_item/existing_loadout = GLOB.all_loadout_datums[found_clothing]
			if(existing_loadout.generated)
				if(override_restricted_roles)
					existing_loadout.restricted_roles = restricted_roles ? restricted_roles.Copy() : null
				else
					if(length(existing_loadout.restricted_roles)) //Expand the allowed roles, only if there is restrictions in the first place.
						existing_loadout.restricted_roles |= restricted_roles
			continue

		//Prevents a duplicate entry UI bug.
		if(length(GLOB.loadout_blacklist_names) && GLOB.loadout_blacklist_names[found_clothing.name])
			continue

		var/created_item = FALSE
		for(var/datum/loadout_category/found_category as anything in processed_loadout_categories) //Search the loadout categories.

			for(var/possible_subtype_path as anything in found_category.generation_subtypes_whitelist)

				if(!ispath(found_clothing,possible_subtype_path))
					continue

				//We're the right path as one of the subtypes.
				var/datum/loadout_item/loadout_item_datum = new found_category.type_to_generate(
					found_category,
					full_capitalize("[found_clothing.name] (Vend)"),
					found_clothing
				)
				loadout_item_datum.restricted_roles = restricted_roles ? restricted_roles.Copy() : null
				loadout_item_datum.group = "Job Items"
				loadout_item_datum.generated = TRUE
				found_category.associated_items += loadout_item_datum
				created_item = TRUE
				break

			if(created_item)
				break
