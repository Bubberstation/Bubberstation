/datum/design/biogen/organic_printer
	name = "Organic Printer"
	id = DESIGN_ID_IGNORE
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/medical
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_DEFOREST_MEDICAL,
	)

/datum/design/biogen/organic_printer/bruise_pack
	name = "Bruise Packs"
	id = "organic_bruise_packs"
	materials = list(/datum/material/biomass = 4) // 6 per stacks
	build_path = /obj/item/stack/medical/bruise_pack

/datum/design/biogen/organic_printer/ointment
	name = "Ointment"
	id = "organic_ointment"
	materials = list(/datum/material/biomass = 3) // 8 per stacks
	build_path = /obj/item/stack/medical/ointment

/datum/design/biogen/organic_printer/suture
	name = "Suture"
	id = "organic_suture"
	materials = list(/datum/material/biomass = 8) // 10 per stacks
	build_path = /obj/item/stack/medical/suture

/datum/design/biogen/organic_printer/regenerative_mesh
	name = "Regenerative Mesh"
	id = "organic_regenerative_mesh"
	materials = list(/datum/material/biomass = 6) // 15 per stacks
	build_path = /obj/item/stack/medical/mesh

/datum/design/biogen/organic_printer/medical_gauze
	name = "Medical Gauze"
	id = "organic_medical_gauze"
	materials = list(/datum/material/biomass = 5) // 6 per stacks
	build_path = /obj/item/stack/medical/wrap/gauze

/datum/design/biogen/organic_printer/balm
	name = "Red Sun Balm"
	id = "organic_sun_balm"
	materials = list(/datum/material/biomass = 9) // 12 per stacks
	build_path = /obj/item/stack/medical/ointment/red_sun

/datum/design/biogen/organic_printer/gauze
	name = "Sealed Aseptic Gauze"
	id = "organic_aseptic_gauze"
	materials = list(/datum/material/biomass = 8) // 6 per stacks
	build_path = /obj/item/stack/medical/wrap/gauze/sterilized

/datum/design/biogen/organic_printer/coagulant_f
	name = "Coagulant-F Packet"
	id = "organic_coagulant_pack"
	materials = list(/datum/material/biomass = 5) // 12 per stacks
	build_path = /obj/item/stack/medical/suture/coagulant

/datum/design/biogen/organic_printer/amollin_pill
	name = "Amollin Painkiller"
	id = "organic_printer_amollin_pill"
	build_path = /obj/item/reagent_containers/applicator/pill/amollin

/datum/design/biogen/organic_printer/bandaid
	name = "First Aid Bandage"
	id = "organic_bandaid"
	build_path = /obj/item/stack/medical/bandage

/datum/design/biogen/organic_printer/synth_patch
	name = "Robotic Repair Patch"
	id = "organic_repair_patch"
	build_path = /obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair

/datum/design/biogen/organic_printer/repair_foam
	name = "Robotic Repair Spray"
	id = "organic_repair_foam"
	materials = list(/datum/material/biomass = 40) // 2 per stacks
	build_path = /obj/item/stack/medical/wound_recovery/robofoam

/datum/design/biogen/organic_printer/bone_gel
	name = "Bone Gel"
	id = "organic_bone_gel"
	build_path = /obj/item/stack/medical/bone_gel

/datum/design/biogen/organic_printer/surgical_tape
	name = "Surgical Tape"
	id = "organic_surgical_tape"
	build_path = /obj/item/stack/medical/wrap/sticky_tape/surgical
