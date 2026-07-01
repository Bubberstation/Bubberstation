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
	desc = "Contains designs for tajaran organs for the limbgrower - Ears, tounges, and eyes."
	id = "limbdesign_tajaran"
	build_path = /obj/item/disk/design_disk/limbs/tajaran

/obj/item/disk/design_disk/limbs/tajaran
	name = "Tajaran Organ Design Disk"
	limb_designs = list(/datum/design/tajaran_eyes, /datum/design/tajaran_tongue, /datum/design/tajaran_ears)

//Teshari organs
//Pour one out for the birds.
/datum/design/leftarm/New()
	category += list(SPECIES_TESHARI)
	return ..()

/datum/design/rightarm/New()
	category += list(SPECIES_TESHARI)
	return ..()

/datum/design/leftleg/New()
	category += list(SPECIES_TESHARI)
	return ..()

/datum/design/rightleg/New()
	category += list(SPECIES_TESHARI)
	return ..()

/datum/design/teshari_eyes
	name = "Teshari eyes"
	id = "tesharieyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/eyes/teshari
	category = list(SPECIES_TESHARI)

/datum/design/teshari_ears
	name = "Teshari ears"
	id = "teshariears"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/ears/teshari
	category = list(SPECIES_TESHARI)

/datum/design/teshari_tongue
	name = "Teshari tongue"
	id = "tesharitongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/tongue/teshari
	category = list(SPECIES_TESHARI)

/datum/design/cold_lungs
	name = "Cold-Adapted Lungs"
	id = "coldlungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 20)
	build_path = /obj/item/organ/lungs/adaptive/cold
	category = list(SPECIES_TESHARI)

/datum/design/limb_disk/teshari
	name = "Teshari Organ Design Disk"
	desc = "Contains designs for teshari organs for the limbgrower - Ears, tounges, and eyes."
	id = "limbdesign_teshari"
	build_path = /obj/item/disk/design_disk/limbs/teshari

/obj/item/disk/design_disk/limbs/teshari
	name = "Teshari Organ Design Disk"
	limb_designs = list(/datum/design/teshari_eyes, /datum/design/teshari_ears, /datum/design/teshari_tongue, /datum/design/cold_lungs)

/obj/machinery/limbgrower/Initialize(mapload)
	categories += list(
		SPECIES_HEMOPHAGE,
		SPECIES_TAJARAN,
		SPECIES_TESHARI
	)
	. = ..()
