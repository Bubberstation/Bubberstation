// Advanced brainwash disk
/obj/item/disk/nifsoft_uploader/dorms/hypnosis/brainwashing
	name = "mesmer eye"
	loaded_nifsoft = /datum/nifsoft/action_granter/hypnosis/brainwashing

// More advanced variant for full brainwashing
/datum/nifsoft/action_granter/hypnosis/brainwashing
	name = "Mesmer Eye"
	program_desc = "Based on illegal abductor technology, the Mesmer Eye NIFSoft allows the user to completely control others actions. Unlike Libidine Eye, victims are unable to resist once given an order. You will be held responsible for your target's actions."

	// Has a cost
	active_cost = 0.1
	activation_cost = 1

	// Cannot be kept
	able_to_keep = FALSE

	// Grants different action
	action_to_grant = /datum/action/cooldown/hypnotize/brainwash
