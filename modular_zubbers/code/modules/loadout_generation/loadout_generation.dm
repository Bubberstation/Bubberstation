/datum/loadout_category/
	var/list/generation_subtypes_whitelist = list()
	var/list/generation_subtypes_blacklist = list()

/datum/loadout_category/get_items()

	if(!generation_subtypes_whitelist || !length(generation_subtypes_whitelist))
		return ..() //Default behavior

	var/list/generation_subtype = list()

	for(var/found_subtype in generation_subtypes_whitelist)
		generation_subtype += subtypesof(found_subtype)

	for(var/found_subtype in generation_subtypes_blacklist)
		generation_subtype -= subtypesof(found_subtype)

	var/list/obj/item/found_items = generate_loadout_list(generation_subtype)

	if(!length(found_items))
		stack_trace("Found zero subtypes for loadout category [src.type]!")
		continue

	. = list()

	for(var/obj/item/found_item as anything in found_items)
		if(!found_item)
			continue
		if(length(GLOB.loadout_item_path_to_datum) && GLOB.loadout_item_path_to_datum[found_item]) //Already exists.
			continue
		var/datum/loadout_item/loadout_item_datum = new type_to_generate(
			src,
			full_capitalize("[initial(found_item.name)]"), //The square brackets allow text macros to run.
			found_item
		)
		. += loadout_item_datum

/datum/loadout_item/New(...)
	. = ..()
	GLOB.loadout_item_path_to_datum[src.item_path] = src