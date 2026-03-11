/datum/robotic_style
	var/name = "None"
	/// The .dmi path for this robotic style
	var/icon = "None"
	/// If this style should override the default limb_id
	var/limb_id_override
	/// If this style's source utilizes a dimorphic bodypart, it goes in this list assoc list keyed to the body_zone
	var/list/dimorphic_overrides

/datum/robotic_style/New()
	if(LAZYLEN(dimorphic_overrides))
		dimorphic_overrides = string_assoc_list(dimorphic_overrides)
	return ..()

/datum/robotic_style/scrappyipc
	name = "Scrappy"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/scrappyipc.dmi' // for ones that don't have associated limb atoms just setting icon works fine

/datum/robotic_style/scrappyipc_greyscale
	name = "Scrappy (Greyscale)"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/scrappyipc_greyscale.dmi'

/datum/robotic_style/surplus
	name = "Surplus"
	icon = 'icons/mob/augmentation/surplus_augments.dmi'

/datum/robotic_style/cyborg
	name = "Cyborg"
	icon = 'icons/mob/augmentation/augments.dmi'

/datum/robotic_style/engineering
	name = "Engineering"
	icon = 'icons/mob/augmentation/augments_engineer.dmi'

/datum/robotic_style/mining
	name = "Mining"
	icon = 'icons/mob/augmentation/augments_mining.dmi'

/datum/robotic_style/security
	name = "Security"
	icon = 'icons/mob/augmentation/augments_security.dmi'

/datum/robotic_style/mcgipc
	name = "Morpheus Cyberkinetics"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/mcgipc.dmi'

/datum/robotic_style/bshipc
	name = "Bishop Cyberkinetics"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/bshipc.dmi'

/datum/robotic_style/bs2ipc
	name = "Bishop Cyberkinetics 2.0"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/bs2ipc.dmi'

/datum/robotic_style/e3n
	name = "E3N AI"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/e3n.dmi'

/datum/robotic_style/hsiipc
	name = "Hephaestus Industries"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/hsiipc.dmi'

/datum/robotic_style/hi2ipc
	name = "Hephaestus Industries 2.0"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/hi2ipc.dmi'

/datum/robotic_style/sgmipc
	name = "Shellguard Munitions Standard Series"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/sgmipc.dmi'

/datum/robotic_style/wtmipc
	name = "Ward-Takahashi Manufacturing"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/wtmipc.dmi'

/datum/robotic_style/xmgipc
	name = "Xion Manufacturing Group"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/xmgipc.dmi'

/datum/robotic_style/xm2ipc
	name = "Xion Manufacturing Group 2.0"
	icon ='modular_zubbers/master_files/icons/mob/augmentation/xm2ipc.dmi'

/datum/robotic_style/zhpipc
	name = "Zeng-Hu Pharmaceuticals"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/zhpipc.dmi'

/datum/robotic_style/mariinskyipc
	name = "Mariinsky Ballet Company"
	icon = 'modular_zubbers/master_files/icons/mob/augmentation/mariinskyipc.dmi'

/datum/robotic_style/dimorphic // subtype so we don't have to define dimorphic head+chest every single time
	abstract_type = /datum/robotic_style/dimorphic
	dimorphic_overrides = list(
		BODY_ZONE_HEAD = TRUE,
		BODY_ZONE_CHEST = TRUE,
	)

/datum/robotic_style/dimorphic/akula
	name = "Akula"
	icon = BODYPART_ICON_AKULA
	limb_id_override = /obj/item/bodypart/chest/mutant/akula::limb_id

/datum/robotic_style/dimorphic/anthro
	name = "Anthro"
	icon = BODYPART_ICON_MAMMAL
	limb_id_override = /obj/item/bodypart/chest/mutant::limb_id

/datum/robotic_style/dimorphic/lizard
	name = "Lizard"
	icon = BODYPART_ICON_LIZARD
	limb_id_override = /obj/item/bodypart/chest/lizard::limb_id
	dimorphic_overrides = list(
		BODY_ZONE_HEAD = FALSE,
		BODY_ZONE_CHEST = TRUE,
	)

/datum/robotic_style/dimorphic/moth
	name = "Moth"
	icon = BODYPART_ICON_MOTH
	limb_id_override = /obj/item/bodypart/chest/moth::limb_id

/datum/robotic_style/dimorphic/ramatan
	name = "Ramatan"
	icon = BODYPART_ICON_RAMATAE
	limb_id_override = /obj/item/bodypart/chest/mutant/ramatae::limb_id

/datum/robotic_style/dimorphic/vox
	name = "Vox"
	icon = BODYPART_ICON_VOX
	limb_id_override = /obj/item/bodypart/chest/mutant/vox::limb_id

/datum/robotic_style/dimorphic/xenohybrid
	name = "Xenohybrid"
	icon = BODYPART_ICON_XENO
	limb_id_override = /obj/item/bodypart/chest/mutant/xenohybrid::limb_id

// kept at the bottom for parity with other augment dropdowns
/datum/robotic_style/none
	icon = 'icons/mob/augmentation/augments.dmi'
