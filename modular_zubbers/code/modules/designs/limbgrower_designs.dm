/datum/design/hemophage_heart
	name = "Pulsating Tumor"
	id = "hemophageheart"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/heart/hemophage
	category = list(SPECIES_HEMOPHAGE)

/datum/design/hemophage_liver
	name = "Corrupted Liver"
	id = "hemophageliver"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/liver/hemophage
	category = list(SPECIES_HEMOPHAGE)

/datum/design/hemophage_stomach
	name = "Corrupted Stomach"
	id = "hemophagestomach"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/stomach/hemophage
	category = list(SPECIES_HEMOPHAGE)

/datum/design/hemophage_tongue
	name = "Corrupted Tongue"
	id = "hemophagetongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/tongue/hemophage
	category = list(SPECIES_HEMOPHAGE)

/obj/item/disk/design_disk/limbs/hemophage
	name = "Hemophage Organ Design Disk"
	limb_designs = list(/datum/design/hemophage_heart, /datum/design/hemophage_liver, /datum/design/hemophage_stomach, /datum/design/hemophage_tongue)

/datum/design/limb_disk/hemophage
	name = "Hemophage Organ Design Disk"
	desc = "Contains designs for hemophage organs for the limbgrower - Tounges, livers, tumors, and stomachs."
	id = "limbdesign_hemophage"
	build_path = /obj/item/disk/design_disk/limbs/hemophage

//Tajaran organs
/datum/design/tajaran_eyes
	name = "Tajaran eyes"
	id = "tajaraneyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/eyes/tajaran
	category = list(SPECIES_TAJARAN)

/datum/design/tajaran_tongue
	name = "Tajaran tounge"
	id = "tajarantounge"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/tongue/cat/tajaran
	category = list(SPECIES_TAJARAN)

/datum/design/tajaran_ears
	name = "Tajaran ears"
	id = "tajaranears"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/ears/cat/tajaran
	category = list(SPECIES_TAJARAN)

/datum/design/limb_disk/tajaran
	name = "Tajaran Organ Design Disk"
	desc = "Contains designs for tajaran organs for the limbgrower - Tounges and eyes."
	id = "limbdesign_tajaran"
	build_path = /obj/item/disk/design_disk/limbs/tajaran

/obj/item/disk/design_disk/limbs/tajaran
	name = "Tajaran Organ Design Disk"
	limb_designs = list(/obj/item/organ/tongue/cat/tajaran, /obj/item/organ/eyes/tajaran, /obj/item/organ/ears/cat/tajaran)

/obj/machinery/limbgrower/Initialize(mapload)
	categories += list(
		SPECIES_HEMOPHAGE,
		SPECIES_TAJARAN
	)
	. = ..()
