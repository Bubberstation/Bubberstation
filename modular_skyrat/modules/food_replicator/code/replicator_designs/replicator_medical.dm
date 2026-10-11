/datum/design/biogen/medical_replicator
	name = null
	build_path = /obj/item/storage/pouch
	materials = list(/datum/material/biomass = 250)
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_NRI_MEDICAL,
	)

/datum/design/biogen/medical_replicator/pocket_medkit
	name = "Empty Pocket First Aid Kit"
	build_path = /obj/item/storage/pouch/cin_medkit

/datum/design/biogen/medical_replicator/medipouch
	name = "Empty Medipen Pouch"
	build_path = /obj/item/storage/pouch/cin_medipens

/datum/design/biogen/medical_replicator/sutures
	name = "Hemostatic Sutures"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/suture/bloody

/datum/design/biogen/medical_replicator/mesh
	name = "Hemostatic Mesh"
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/mesh/bloody

/datum/design/biogen/medical_replicator/bruise_patch
	name = "Bruise Patch"
	build_path = /obj/item/reagent_containers/applicator/patch/libital

/datum/design/biogen/medical_replicator/burn_patch
	name = "Burn Patch"
	build_path = /obj/item/reagent_containers/applicator/patch/aiuri

/datum/design/biogen/medical_replicator/gauze
	name = "Medical Gauze"
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/wrap/gauze

/datum/design/biogen/medical_replicator/epi_pill
	name = "Epinephrine Pill"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/epinephrine

/datum/design/biogen/medical_replicator/conv_pill
	name = "Convermol Pill"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/convermol

/datum/design/biogen/medical_replicator/multiver_pill
	name = "Multiver Pill"
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/multiver
