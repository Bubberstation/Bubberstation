/datum/loadout_item/gloves/bubber/clown //I would job lock these but, they're just gloves.
	name = "Pink Clown Gloves"
	item_path = /obj/item/clothing/gloves/bubber/clussy

/datum/loadout_item/gloves/lace_gloves
	name = "Lace Gloves"
	item_path = /obj/item/clothing/gloves/evening/lace
	donator_only = TRUE

/datum/loadout_item/gloves/rubber_gloves
	name = "Long Rubber Gloves"
	item_path = /obj/item/clothing/gloves/longrubbergloves

/datum/loadout_item/gloves/rubber_gloves/med
	name = "Long Rubber Medical Gloves"
	item_path = /obj/item/clothing/gloves/latex/nitrile/longrubbergloves
	restricted_roles = list(ALL_JOBS_MEDICAL, JOB_GENETICIST)

/datum/loadout_item/gloves/tactical_maid //Donor item for skyefree
	name = "Tactical Maid Gloves"
	item_path = /obj/item/clothing/gloves/tactical_maid
	donator_only = TRUE

/datum/loadout_item/gloves/color/black/security
	name = "Security gloves"
	item_path = /obj/item/clothing/gloves/color/black/security
	restricted_roles = list(ALL_JOBS_SEC)
	can_be_reskinned = TRUE

/datum/loadout_item/gloves/combat/peacekeeper/armadyne
	name = "Armadyne combat gloves"
	item_path = /obj/item/clothing/gloves/combat/peacekeeper/armadyne
	restricted_roles = list(ALL_JOBS_SEC)

/datum/loadout_item/gloves/frontier_colonist
	name = "Frontier Gloves"
	item_path =/obj/item/clothing/gloves/frontier_colonist/loadout
