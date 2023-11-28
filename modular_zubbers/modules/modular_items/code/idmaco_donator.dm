//@EspeciallyStrange & @Mishanook
// Sprites are donated from either project kepler or hand done by me for this occasion, They can be used for anything else
//Will also be available for usage in Foundation 19
// Placed in these file so that You and others may remove them if I am not playing here anymore, or if it were to be used for anything else!

//These are also additionally handed out to snaffle as they were a major player in the NRI events <3

/datum/loadout_item/suit/idmarsuit
	name = "IDMA service jacket"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/security/idma_jacket
	ckeywhitelist = list("especiallystrange", "mishanok", "snaffle15")
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC) //Secure Personnel Only. It is a round start armor even if the actual armor can be ordered for cheap

/datum/loadout_item/suit/idmardjacket
	name = "silicon administrator vest"
	item_path = /obj/item/clothing/suit/jacket/vera_jacket
	ckeywhitelist = list("especiallystrange") // Specific to me
	restricted_roles = list(JOB_RESEARCH_DIRECTOR) // and otherwise if not, specific to the RD

/datum/loadout_item/suit/idmasnowfatigue
	name = "IDMA service uniform"
	item_path = /obj/item/clothing/under/idma_fatigue
	ckeywhitelist = list("especiallystrange", "mishanok", "snaffle15")

/datum/loadout_item/suit/idmafatigue
	name = "IDMA service uniform"
	item_path = /obj/item/clothing/under/idma_fatigue/alt
	ckeywhitelist = list("especiallystrange", "mishanok", "snaffle15")

/datum/loadout_item/suit/idmaberet
	name = "IDMA beret"
	item_path = /obj/item/clothing/head/idma_beret
	ckeywhitelist = list("especiallystrange", "mishanok", "snaffle15")

/datum/loadout_item/suit/idmahelmet
	name = "IDMA service helmet"
	item_path = /obj/item/clothing/head/helmet/idma_helmet
	ckeywhitelist = list("especiallystrange", "mishanok", "snaffle15")
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_SECURITY_MEDIC) //Secure Personnel Only. It is a round start armor even if the actual armor can be ordered for cheap

/obj/item/clothing/head/helmet/idma_helmet
	name = "ironmoon service helmet."
	desc = "A helmet worn by the romulus expeditionary force."
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	icon_state = "romulusmarine"

/obj/item/clothing/head/idma_beret
	name = "ironmoon service beret."
	desc = "A beret worn by the romulus national guard during ceremonies or in time of peace as it provides no protection whatsoever."
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	icon_state = "romulusberet"
//provide no armor because it's a ceremonial piece. meant to be available across all role

/obj/item/clothing/under/idma_fatigue
	name = "ironmoon service fatigue"
	desc = "An old snow pattern uniform worn by the romulus expeditionary force during the kepler emergency."
	icon_state = "romulusmarine"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'

/obj/item/clothing/under/idma_fatigue/alt
	name = "argnostan service fatigue"
	desc = "An old desert uniform worn by the romulus expeditionary force up until march 21st 2181. Attached to it is a silver medal"
	icon_state = "argnostanuniform"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'

/obj/item/clothing/suit/jacket/vera_jacket
	name = "silicon administrator vest"
	desc = "An old ."
	icon_state = "verajacket"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	allowed = list(
		/obj/item/biopsy_tool,
		/obj/item/dnainjector,
		/obj/item/flashlight/pen,
		/obj/item/healthanalyzer,
		/obj/item/paper,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/gun/syringe,
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/mask/cigarette,
		/obj/item/disk,
		/obj/item/lighter,
		/obj/item/melee,
		/obj/item/reagent_containers/cup/glass/flask,
		/obj/item/stamp,
		/obj/item/storage/box/matches,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/lockbox/medal,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
	)
armor_type = /datum/armor/skyrat_rd // It's a really advanced labcoat at the end of the day

//This is meant to be a functional wintercoat
/obj/item/clothing/suit/hooded/wintercoat/security/idma_jacket
	name = "ironmoon service coat"
	desc = "A heavy jacket worn by the romulus expeditionary force, contains ablative plating underneaths to protect the wearer from harms."
	icon_state = "romulusofficer"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/idma_hood

/obj/item/clothing/head/hooded/winterhood/security/idma_hood
	name = "ironmoon winterhood"
	desc = "A white, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes."
	icon_state = "romulushood"
	icon = 'modular_zubbers/icons/donator/idmaco.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/idmaco_worn.dmi'

