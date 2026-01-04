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


//teshari stuff
/datum/design/teshari_leftarm
	name = "Left Wing"
	id = "arm/teshleft"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 25)
	build_path = /obj/item/bodypart/arm/left/mutant/teshari
	category = list(SPECIES_TESHARI)

/datum/design/teshari_rightarm
	name = "Right Wing"
	id = "arm/teshright"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 25)
	build_path = /obj/item/bodypart/arm/right/mutant/teshari
	category = list(SPECIES_TESHARI)

/datum/design/teshari_leftleg
	name = "Left Leg"
	id = "leg/teshleft"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 25)
	build_path = /obj/item/bodypart/leg/left/mutant/teshari
	category = list(SPECIES_TESHARI, RND_CATEGORY_LIMBS_DIGITIGRADE)

/datum/design/teshari_rightleg
	name = "Right Leg"
	id = "leg/teshright"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 25)
	build_path = /obj/item/bodypart/leg/right/mutant/teshari
	category = list(SPECIES_TESHARI, RND_CATEGORY_LIMBS_DIGITIGRADE)

/datum/design/teshari_ear
	name = "Teshari Ears"
	id = "teshari_ear"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/ears/teshari
	category = list(SPECIES_TESHARI)

/datum/design/teshari_tail
	name = "Teshari Tail"
	id = "teshari_tail"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/ears/teshari
	category = list(SPECIES_TESHARI)

/datum/design/limb_disk/teshari
	name = "Teshari Organ Design Disk"
	desc = "Contains designs for teshari organs for the limbgrower - Wings, legs, ears, and tail."
	id = "limbdesign_teshari"
	build_path = /obj/item/disk/design_disk/limbs/teshari

/obj/item/disk/design_disk/limbs/teshari
	name = "Teshari Organ Design Disk"
	limb_designs = list(
		/datum/design/teshari_rightleg,
		/datum/design/teshari_leftleg,
		/datum/design/teshari_rightarm,
		/datum/design/teshari_leftarm,
		/datum/design/teshari_tail,
		/datum/design/teshari_ear,
	)

/obj/machinery/limbgrower/Initialize(mapload)
	categories += list(
		SPECIES_HEMOPHAGE,
		SPECIES_TAJARAN,
		SPECIES_TESHARI,
	)
	. = ..()


