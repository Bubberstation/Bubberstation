/obj/item/mod/core/standard/protean
	name = "\improper MOD Protean core"
	icon_state = "mod-core-ethereal"
	desc = "If you see this, go scream at a coder and tell them how you managed to do this."

	/// We handle as many interactions as possible through the species datum
	/// The species handles cleanup on this
	var/datum/species/protean/linked_species

/obj/item/mod/core/standard/protean/Destroy()
	linked_species = null
	return ..()
