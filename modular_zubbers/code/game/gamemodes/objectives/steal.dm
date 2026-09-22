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

/datum/objective_item/steal/executive_hudsunglasses
	name = "the captain's executive HUDsunglasses"
	targetitem = /obj/item/clothing/glasses/hud/security/sunglasses/guard/command
	excludefromjob = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "Gold-plated sunglasses, worn by the Captain. Eleven sensor suites, two of which find booze and money."
