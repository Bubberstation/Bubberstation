/datum/loadout_category/
	var/list/generation_subtypes_whitelist = list()
	var/list/generation_subtypes_blacklist = list()

/datum/loadout_category/proc/generate_from_config()

	if(!type_to_generate)
		return 0

	//Generate what we have configs for.
	for(var/datum/loadout_item/found_type as anything in typesof(type_to_generate))

		if(found_type == found_type.abstract_type)
			continue

		var/obj/item/item_path = found_type.item_path

		if(!item_path)
			continue

		if(!ispath(item_path, /obj/item))
			stack_trace("Loadout get_items(): Attempted to instantiate a loadout item ([found_type]) with an invalid or null typepath! (got path: [found_type.item_path])")
			continue

		var/item_name = full_capitalize("[item_path.name]") //The square brackets allow text macros to run.
		var/datum/loadout_item/loadout_item_datum = new found_type(
			src,
			"[item_name] (config)",
			item_path
		)
		src.associated_items += loadout_item_datum

	return length(src.associated_items) > 0

/datum/loadout_category/proc/generate_from_world()

	if(!type_to_generate)
		return 0

	if(!length(generation_subtypes_whitelist))
		return 0

	//Generate everything else.
	var/list/generation_subtype = list()

	for(var/found_subtype in generation_subtypes_whitelist)
		generation_subtype |= typesof(found_subtype)

	for(var/found_subtype in generation_subtypes_blacklist)
		generation_subtype -= typesof(found_subtype)

	for(var/obj/item/item_to_check as anything in generation_subtype)
		if(!is_loadout_safe(item_to_check))
			continue
		var/item_name = full_capitalize("[item_to_check.name] (gen)") //The square brackets allow text macros to run.
		var/datum/loadout_item/loadout_item_datum = new type_to_generate(
			src,
			item_name,
			item_to_check
		)
		loadout_item_datum.generated = TRUE
		src.associated_items += loadout_item_datum

	return length(src.associated_items) > 0


