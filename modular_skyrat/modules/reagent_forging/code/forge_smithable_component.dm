
/datum/component/forge_smithable/
	///the item that the component is attached to
	var/obj/item/parent_item
	///required type to attach to
	var/obj/item/required_type = /obj/item

	///the quality points of the incomplete item; goes up on good/perfect hits, goes down on bad hits
	var/quality_points = 0
	///the quality points required for it to be considered usable for crafting
	var/completion_quality_points = 30
	///the required time before each strike to prevent spamming
	var/average_wait = 1 SECONDS
	///total current bad hits
	var/bad_hits_total = 0
	///the bad hits required for it to break; exceeding this will break the item
	var/bad_hit_maximum = 5

	///func to call when

/datum/component/reagent_imbued/Initialize(completion_needed, max_perfection, max_breakage, wait_time, on_quench)
	if(!istype(parent, required_type))
		return COMPONENT_INCOMPATIBLE
	parent_item = parent
	RegisterSignal(parent_item, COMSIG_SMITHING_DONE, TYPE_PROC_REF(parent_item.type, on_quench))
