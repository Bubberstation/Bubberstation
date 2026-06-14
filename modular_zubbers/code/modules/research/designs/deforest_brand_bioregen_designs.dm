// Designs for the DeForest Brand Bio-Regenerator
// Combines the Wall Med-Station with some of the medicines produced by the Colonial Supply Core,
// along with adding additional medicines to support certain quirks or treat specific conditions - mostly stuff available in your typical DeForest Med-Vend.

//// First Aid ////

// Burn Treatments

/datum/design/dfbbr_balm
	name = "Red Sun Balm"
	id = "dfbbr_sun_balm"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/medical/ointment/red_sun
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_ointment
	name = "Ointment"
	id = "dfbbr_ointment"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/medical/ointment
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_aseptic_gauze
	name = "Sealed Aseptic Gauze"
	id = "dfbbr_aseptic_gauze"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/medical/gauze/sterilized
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_mesh
	name = "Regenerative Mesh"
	id = "dfbbr_mesh"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/mesh
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_hemo_mesh
	name = "Hemostatic Mesh"
	id = "dfbbr_slavic_mesh"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/mesh/bloody
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Brute Treatments

/datum/design/dfbbr_bruise_pack
	name = "Bruise Packs"
	id = "dfbbr_bruise_packs"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/medical/bruise_pack
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_bandaid
	name = "First Aid Bandage"
	id = "dfbbr_bandaid"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/bandage
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_sutures
	name = "Sutures"
	id = "dfbbr_suture"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/suture
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_hemo_sutures
	name = "Hemostatic Sutures"
	id = "dfbbr_slavic_suture"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/suture/bloody
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Bleed Treatments

/datum/design/dfbbr_coagulant_f
	name = "Coagulant-F Packet"
	id = "dfbbr_coagulant_pack"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/medical/suture/coagulant
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_coagulant_rapid
	name = "Rapid Coagulant Applicator"
	id = "dfbbr_coagulant_rapid"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/wound_recovery/rapid_coagulant
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Synth Treatments

/datum/design/dfbbr_synth_patch
	name = "Robotic Repair Patch"
	id = "dfbbr_repair_patch"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_repair_foam
	name = "Robotic Repair Spray"
	id = "dfbbr_repair_foam"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/wound_recovery/robofoam
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_repair_foam_premium
	name = "Premium Robotic Repair Spray"
	id = "dfbbr_repair_foam_premium"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/stack/medical/wound_recovery/robofoam_super
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

// Fracture Treatments

/datum/design/dfbbr_gauze
	name = "Medical Gauze"
	id = "dfbbr_slavic_gauze"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/gauze
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_bone_gel
	name = "Bone Gel"
	id = "dfbbr_bone_gel"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/bone_gel
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_surgical_tape
	name = "Surgical Tape"
	id = "dfbbr_surgical_tape"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/sticky_tape/surgical
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

/datum/design/dfbbr_splint_applicator
	name = "Subdermal Splint Applicator"
	id = "dfbbr_splint_applicator"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/stack/medical/wound_recovery
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICAL)

//// Medicine ////

// Patches

/datum/design/dfbbr_bruise_patch
	name = "Bruise Patch"
	id = "dfbbr_bruise_patch"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/applicator/patch/libital
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_burn_patch
	name = "Burn Patch"
	id = "dfbbr_burn_patch"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/applicator/patch/aiuri
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_synthflesh_patch
	name = "Synthflesh Patch"
	id = "dfbbr_synthflesh_patch"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/applicator/patch/synthflesh
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Pills

/datum/design/dfbbr_amollin_pill
	name = "Amollin Painkiller"
	id = "dfbbr_amollin_pill"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/reagent_containers/applicator/pill/amollin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_iron_pill
	name = "Iron Pill"
	id = "dfbbr_iron_pill"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/reagent_containers/applicator/pill/iron
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_probital_pill
	name = "Probital Pill"
	id = "dfbbr_probital_pill"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/applicator/pill/probital
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_epi_pill
	name = "Epinephrine Pill"
	id = "dfbbr_epi"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/epinephrine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_conv_pill
	name = "Convermol Pill"
	id = "dfbbr_conv"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/convermol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_multiver_pill
	name = "Multiver Pill"
	id = "dfbbr_multiver"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/multiver
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_potassiodide_pill
	name = "Potassium Iodide Pill"
	id = "dfbbr_potassiodide"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/potassiodide
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Quirk Related Meds //

/datum/design/dfbbr_insulin_pill
	name = "Insulin Pill"
	id = "dfbbr_insulin"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/insulin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_psicodine_pill
	name = "Psicodine Pill"
	id = "dfbbr_psicodine"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/psicodine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Spacer, working in lavaland... or it is Ice Box. At least it also allows people with the Spacer quirk to visit safely.
/datum/design/dfbbr_ondansetron_pill
	name = "Ondansetron Pill"
	id = "dfbbr_ondansetron"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/ondansetron
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_sansufentanyl_pill
	name = "Sansufentanyl Pill"
	id = "dfbbr_sansufentanyl"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/applicator/pill/sansufentanyl
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// I don't know why you'd do it, but just in case someone plays with the brain degeneration.
/datum/design/dfbbr_mannitol_pill
	name = "Mannitol Pill"
	id = "dfbbr_mannitol"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/applicator/pill/mannitol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

/datum/design/dfbbr_neurine_pill
	name = "Neurine Pill"
	id = "dfbbr_neurine"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/reagent_containers/applicator/pill/neurine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

// Asthma, on lavaland, truly a genius move.
/datum/design/dfbbr_albuterol_canister
	name = "Albuterol Canister"
	id = "dfbbr_albuterol_canister"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/inhaler_canister/albuterol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_MEDICINE)

//// Autoinjectors ////

/datum/design/dfbbr_autoinjector_occuisate
	name = "Occuisate Sensory Restoration Injector"
	id = "dfbbr_autoinjector_occuisate"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/occuisate
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/dfbbr_autoinjector_calopine
	name = "Calopine Emergency Stabilizant Injector"
	id = "dfbbr_autoinjector_calopine"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/calopine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/dfbbr_autoinjector_halobinin
	name = "Halobinin Soberant Injector"
	id = "dfbbr_autoinjector_halobinin"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/halobinin
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/dfbbr_autoinjector_synthcleaner
	name = "Synthetic Cleaner Autoinjector"
	id = "dfbbr_autoinjector_synthcleaner"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)

/datum/design/dfbbr_autoinjector_liquidsolder
	name = "Synthetic Smart-Solder Autoinjector"
	id = "dfbbr_autoinjector_liquidsolder"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 500)
	build_path = /obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_DFBBR_INJECTORS)
