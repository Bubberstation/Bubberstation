/datum/supply_pack
	///Boolean to indicate if the pack has a custom name and description or not.
	var/auto_name = FALSE

/datum/supply_pack/New()
	. = ..()
	if (auto_name && length(contains))
		var/obj/item/first_item = contains[1]
		if(first_item)
			name = first_item.name
			desc = first_item.desc
