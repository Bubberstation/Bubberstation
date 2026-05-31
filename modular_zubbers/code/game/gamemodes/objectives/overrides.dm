/datum/antagonist/traitor/forge_single_generic_objective()
	if(prob(KILL_PROB))

		var/datum/objective/gimmick/gimmick_objective = new()
		gimmick_objective.owner = owner
		return gimmick_objective

	var/datum/objective/steal/steal_objective = new()
	steal_objective.owner = owner
	steal_objective.find_target()
	return steal_objective

/datum/uplink_handler/generate_objectives()
	on_update()
	return FALSE

/datum/objective_item/steal/hoslaser
	name = "the head of security's service weapon"
	targetitem = /obj/item/hos_primary_case
	steal_hint = "A gun case found in the Head of Security's locker."

/datum/objective_item/steal/compactshotty
	name = "the warden's kaza ruk gloves"
	targetitem = /obj/item/clothing/gloves/kaza_ruk/sec/warden
	steal_hint = "A reinforced set of kaza ruk gloves found in the Warden's locker."
