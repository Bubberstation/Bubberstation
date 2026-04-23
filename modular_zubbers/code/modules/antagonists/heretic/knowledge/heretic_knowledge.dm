/datum/heretic_knowledge
	var/combat_specialty = 0
	/// If not null, this will override the default shop drafting costs.
	var/drafting_cost
	/// If TRUE, will not trigger CI failures - this has been intentionally made unreachable.
	var/unreachable

/datum/heretic_knowledge/New()
	. = ..()

	// replacing items with harder ones
	for (var/atom/type as anything in required_atoms)
		if (ispath(type, /obj/item/knife))
			required_atoms -= type
			required_atoms[/obj/item/knife/kitchen] = 1
