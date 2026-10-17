/datum/design/leftarm
	category = list(
		RND_CATEGORY_INITIAL,
		SPECIES_HUMAN,
		SPECIES_FELINE,
		SPECIES_LIZARD,
		SPECIES_MOTH,
		SPECIES_PLASMAMAN,
		SPECIES_ETHEREAL,
		SPECIES_TAJARAN,
		HEMOPHAGE,
		SPECIES_SHADEKIN,
		SPECIES_TESHARI,
	)

/datum/design/rightarm
	category = list(
		RND_CATEGORY_INITIAL,
		SPECIES_HUMAN,
		SPECIES_FELINE,
		SPECIES_LIZARD,
		SPECIES_MOTH,
		SPECIES_PLASMAMAN,
		SPECIES_ETHEREAL,
		SPECIES_TAJARAN,
		HEMOPHAGE,
		SPECIES_SHADEKIN,
		SPECIES_TESHARI,
	)

/datum/design/leftleg
	category = list(
		RND_CATEGORY_INITIAL,
		SPECIES_HUMAN,
		SPECIES_FELINE,
		SPECIES_LIZARD,
		SPECIES_MOTH,
		SPECIES_PLASMAMAN,
		SPECIES_ETHEREAL,
		SPECIES_TAJARAN,
		HEMOPHAGE,
		SPECIES_SHADEKIN,
		SPECIES_TESHARI,
	)

/datum/design/rightleg
	category = list(
		RND_CATEGORY_INITIAL,
		SPECIES_HUMAN,
		SPECIES_FELINE,
		SPECIES_LIZARD,
		SPECIES_MOTH,
		SPECIES_PLASMAMAN,
		SPECIES_ETHEREAL,
		SPECIES_TAJARAN,
		HEMOPHAGE,
		SPECIES_SHADEKIN,
		SPECIES_TESHARI,
	)

/datum/design/cat_tail
	category = list(SPECIES_FELINE, RND_CATEGORY_INITIAL)

/datum/design/cat_ears
	category = list(SPECIES_FELINE, RND_CATEGORY_INITIAL)

/datum/design/cat_tongue
	category = list(SPECIES_FELINE, RND_CATEGORY_INITIAL)

/datum/design/ethereal_stomach
	category = list(SPECIES_ETHEREAL, RND_CATEGORY_INITIAL)

/datum/design/ethereal_tongue
	category = list(SPECIES_ETHEREAL, RND_CATEGORY_INITIAL)

/datum/design/ethereal_lungs
	category = list(SPECIES_ETHEREAL, RND_CATEGORY_INITIAL)

/datum/design/ethereal_heart
	category = list(SPECIES_ETHEREAL, RND_CATEGORY_INITIAL)

/datum/design/lizard_tail
	category = list(SPECIES_LIZARD, RND_CATEGORY_INITIAL)

/datum/design/lizard_tongue
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	category = list(SPECIES_LIZARD, RND_CATEGORY_INITIAL)

/datum/design/plasmaman_lungs
	category = list(SPECIES_PLASMAMAN, RND_CATEGORY_INITIAL)

/datum/design/plasmaman_tongue
	category = list(SPECIES_PLASMAMAN, RND_CATEGORY_INITIAL)

/datum/design/plasmaman_liver
	category = list(SPECIES_PLASMAMAN, RND_CATEGORY_INITIAL)

/datum/design/plasmaman_stomach
	category = list(SPECIES_PLASMAMAN, RND_CATEGORY_INITIAL)

/datum/design/humanoidbrain
	name = "Brain"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 100)
	build_path = /obj/item/organ/brain
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)

/datum/design/nitrogen_lungs
	name = "Nitrogen-Adapted Lungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 20)
	build_path = /obj/item/organ/lungs/nitrogen
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)

/datum/design/vox_nitrogen_lungs
	name = "Vox Nitrogen Lungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 20)
	build_path = /obj/item/organ/lungs/nitrogen/vox
	category = list(SPECIES_VOX, RND_CATEGORY_INITIAL)

/datum/design/cold_lungs
	name = "Cold-Adapted Lungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 35)
	build_path = /obj/item/organ/lungs/adaptive/cold
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)

/datum/design/hot_lungs
	name = "Heat-Adapted Lungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 35)
	build_path = /obj/item/organ/lungs/adaptive/hot
	category = list(SPECIES_HUMAN)

/datum/design/oxy_lungs
	name = "Low-Oxygen-Adapted Lungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 35)
	build_path = /obj/item/organ/lungs/oxy
	category = list(SPECIES_HUMAN)

/datum/design/tox_lungs
	name = "Toxin-Adapted Lungs"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 35)
	build_path = /obj/item/organ/lungs/toxin
	category = list(SPECIES_HUMAN)

/datum/design/hemophage_heart
	name = "Pulsating Tumor"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 25, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/heart/hemophage
	category = list(HEMOPHAGE, RND_CATEGORY_INITIAL)

/datum/design/hemophage_liver
	name = "Corrupted Liver"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 15, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/liver/hemophage
	category = list(HEMOPHAGE, RND_CATEGORY_INITIAL)

/datum/design/hemophage_stomach
	name = "Corrupted Stomach"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/stomach/hemophage
	category = list(HEMOPHAGE, RND_CATEGORY_INITIAL)

/datum/design/hemophage_tongue
	name = "Corrupted Tongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 5, /datum/reagent/blood = 10)
	build_path = /obj/item/organ/tongue/hemophage
	category = list(HEMOPHAGE, RND_CATEGORY_INITIAL)

//Shadekin organs
/datum/design/shadekin_ears
	name = "Shadekin Ears"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 15)
	build_path = /obj/item/organ/ears/shadekin
	category = list(SPECIES_SHADEKIN, RND_CATEGORY_INITIAL)

/datum/design/shadekin_eyes
	name = "Shadekin Eyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 15)
	build_path = /obj/item/organ/eyes/shadekin
	category = list(SPECIES_SHADEKIN, RND_CATEGORY_INITIAL)

//Tajaran organs
/datum/design/tajaran_ears
	name = "Tajaran Ears"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/ears/cat/tajaran
	category = list(SPECIES_TAJARAN, RND_CATEGORY_INITIAL)

/datum/design/tajaran_eyes
	name = "Tajaran Eyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/eyes/tajaran
	category = list(SPECIES_TAJARAN, RND_CATEGORY_INITIAL)

/datum/design/tajaran_tongue
	name = "Tajaran Tongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/tongue/cat/tajaran
	category = list(SPECIES_TAJARAN, RND_CATEGORY_INITIAL)

//Teshari organs
/datum/design/teshari_ears
	name = "Teshari Ears"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/ears/teshari
	category = list(SPECIES_TESHARI, RND_CATEGORY_INITIAL)

/datum/design/teshari_eyes
	name = "Teshari Eyes"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/eyes/teshari
	category = list(SPECIES_TESHARI, RND_CATEGORY_INITIAL)

/datum/design/teshari_tongue
	name = "Teshari Tongue"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 10)
	build_path = /obj/item/organ/tongue/teshari
	category = list(SPECIES_TESHARI, RND_CATEGORY_INITIAL)

/datum/design/wholehuman
	name = "Blank Body"
	build_type = LIMBGROWER
	reagents_list = list(/datum/reagent/medicine/c2/synthflesh = 600)
	build_path = /mob/living/carbon/human/empty
	category = list(SPECIES_HUMAN, RND_CATEGORY_INITIAL)

/// Available through TECHWEB_NODE_CYBER_ORGANS_UPGRADED
/obj/item/disk/design_disk/limbs/adaptive_lungs
	name = "adaptive lungs organ design disk"
	blueprints = list(/datum/design/hot_lungs, /datum/design/oxy_lungs, /datum/design/tox_lungs)

/// Available through TECHWEB_NODE_CYBER_ORGANS_UPGRADED
/datum/design/limb_disk/adaptive_lungs
	name = "Adaptive Lungs Organ Design Disk"
	desc = "Contains designs for genetically modified adaptive lungs for the limbgrower."
	build_path = /obj/item/disk/design_disk/limbs/adaptive_lungs
