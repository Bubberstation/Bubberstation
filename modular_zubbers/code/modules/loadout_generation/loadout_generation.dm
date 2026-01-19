/datum/loadout_category/
	var/list/generation_subtypes_whitelist = list()
	var/list/generation_subtypes_blacklist = list()

/datum/loadout_category/get_items()

	if(!generation_subtypes_whitelist || !length(generation_subtypes_whitelist))
		return ..() //Default behavior

	if(!type_to_generate)
		stack_trace("Loadout category [src.type] didn't have a type to generate!")
		return ..()

	. = list()

	var/list/loadout_config_items = list() //So things aren't double generated.

	//Generate what we have configs for.
	/*
	for(var/datum/loadout_item/found_type as anything in typesof(type_to_generate))

		if(!found_type.ckeywhitelist && !found_type.restricted_roles && !found_type.blacklisted_roles && !found_type.restricted_species && !found_type.donator_only && !found_type.required_season && !found_type.erp_item)
			continue

		if(found_type == found_type.abstract_type)
			continue

		var/obj/item/item_path = found_type.item_path

		if(!item_path)
			continue

		if(!ispath(item_path, /obj/item))
			stack_trace("Loadout get_items(): Attempted to instantiate a loadout item ([found_type]) with an invalid or null typepath! (got path: [found_type.item_path])")
			continue

		loadout_config_items[item_path] = TRUE

		var/datum/loadout_item/loadout_item_datum = new type_to_generate(
			src,
			full_capitalize("[item_path.name]"), //The square brackets allow text macros to run.
			item_path
		)
		. += loadout_item_datum
	*/

	//Generate everything else.

	var/list/generation_subtype = list()

	for(var/found_subtype in generation_subtypes_whitelist)
		generation_subtype |= typesof(found_subtype)

	for(var/found_subtype in generation_subtypes_blacklist)
		generation_subtype -= typesof(found_subtype)

	var/list/obj/item/found_items = generate_loadout_list(generation_subtype)

	if(!length(found_items))
		stack_trace("Found zero subtypes for loadout category [src.type]!")
		return

	for(var/obj/item/found_item as anything in found_items)
		if(!found_item)
			continue
		if(length(loadout_config_items) && loadout_config_items[found_item]) //Already exists.
			continue
		if(length(GLOB.all_loadout_datums) && GLOB.all_loadout_datums[found_item]) //Already exists.
			continue
		var/datum/loadout_item/loadout_item_datum = new type_to_generate(
			src,
			full_capitalize("[found_item.name]"), //The square brackets allow text macros to run.
			found_item
		)
		loadout_config_items[found_item] = TRUE
		. += loadout_item_datum
