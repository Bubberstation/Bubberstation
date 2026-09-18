/datum/antagonist/traitor/forge_single_generic_objective()
	if(prob(KILL_PROB))

		var/datum/objective/gimmick/gimmick_objective = new()
		gimmick_objective.owner = owner
		return gimmick_objective

	var/datum/objective/steal/steal_objective = new()
	steal_objective.owner = owner
	steal_objective.find_target()
	return steal_objective

/datum/objective_item/steal/hoslaser
	name = "the head of security's service weapon"
	targetitem = /obj/item/gun/energy/e_gun/hos
	altitems = list(/obj/item/hos_primary_case)
	steal_hint = "A gun case found in the Head of Security's locker."

/datum/objective_item/steal/compactshotty
	name = "the warden's kaza ruk gloves"
	targetitem = /obj/item/gun/ballistic/shotgun/automatic/combat/compact
	altitems = list(/obj/item/clothing/gloves/kaza_ruk/sec/warden)
	steal_hint = "A reinforced set of kaza ruk gloves found in the Warden's locker."

/datum/objective_item/steal/compactshotty/check_special_completion(obj/item/thing)
	return istype(thing, /obj/item/clothing/gloves/kaza_ruk/sec/warden)
