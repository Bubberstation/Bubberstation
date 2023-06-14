/datum/design/hemophage_heart
	name = "Pulsating Tumor"
	id = "hemophageheart"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/internal/heart/hemophage
	category = list(SPECIES_HEMOPHAGE)

/datum/design/hemophage_liver
	name = "Corrupted Liver"
	id = "hemophageliver"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/internal/liver/hemophage
	category = list(SPECIES_HEMOPHAGE)

/datum/design/hemophage_stomach
	name = "Corrupted Stomach"
	id = "hemophagestomach"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/internal/stomach/hemophage
	category = list(SPECIES_HEMOPHAGE)

/datum/design/hemophage_tongue
	name = "Corrupted Tongue"
	id = "hemophagetongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/internal/tongue/hemophage
	category = list(SPECIES_HEMOPHAGE)

/obj/item/disk/design_disk/limbs/hemophage
	name = "Hemophage Organ Design Disk"
	limb_designs = list(/datum/design/hemophage_heart, /datum/design/hemophage_liver, /datum/design/hemophage_stomach, /datum/design/hemophage_tongue)

/datum/design/limb_disk/hemophage
	name = "Hemophage Organ Design Disk"
	desc = "Contains designs for hemophage organs for the limbgrower - Tounges, livers, tumors, and stomachs."
	id = "limbdesign_hemophage"
	build_path = /obj/item/disk/design_disk/limbs/hemophage
