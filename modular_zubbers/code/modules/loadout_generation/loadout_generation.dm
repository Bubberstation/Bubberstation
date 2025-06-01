/datum/loadout_category/
	var/list/generation_subtypes = list()

/datum/loadout_category/get_items()

	if(!generation_subtypes || !length(generation_subtypes))
		return ..() //Default behavior

	. = list()

	for(var/obj/item/generation_subtype as anything in generation_subtypes)
		var/list/obj/item/found_items = generate_loadout_list(generation_subtype)
		if(!length(found_items))
			stack_trace("Found zero subtypes of \"[generation_subtype]\" for loadout category [src.type]!")
			continue
		for(var/obj/item/found_item as anything in found_items)
			if(!found_item)
				stack_trace("Found item was somehow null in generation of [generation_subtype] or [src.type]!")
				continue
			if(length(GLOB.loadout_item_path_to_datum) && GLOB.loadout_item_path_to_datum[found_item])
				var/datum/loadout_item/conflicting_datum = GLOB.loadout_item_path_to_datum[found_item]
				stack_trace("Loadout item collision - [found_item] is shared between multiple loadout categories ([src.type] and [conflicting_datum.category.type] ).")
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