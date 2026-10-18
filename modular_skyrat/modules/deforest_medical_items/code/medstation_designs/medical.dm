/datum/design/biogen/organic_printer
	name = "Frontier Medicine"
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/medical
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_DEFOREST_MEDICAL,
	)

/datum/design/biogen/organic_printer/bruise_pack
	name = "Bruise Packs"
	materials = list(/datum/material/biomass = 4) // 6 per stacks
	build_path = /obj/item/stack/medical/bruise_pack

/datum/design/biogen/organic_printer/ointment
	name = "Ointment"
	materials = list(/datum/material/biomass = 3) // 8 per stacks
	build_path = /obj/item/stack/medical/ointment

/datum/design/biogen/organic_printer/suture
	name = "Suture"
	materials = list(/datum/material/biomass = 8) // 10 per stacks
	build_path = /obj/item/stack/medical/suture

/datum/design/biogen/organic_printer/regenerative_mesh
	name = "Regenerative Mesh"
	materials = list(/datum/material/biomass = 6) // 15 per stacks
	build_path = /obj/item/stack/medical/mesh

/datum/design/biogen/organic_printer/medical_gauze
	name = "Medical Gauze"
	materials = list(/datum/material/biomass = 5) // 6 per stacks
	build_path = /obj/item/stack/medical/wrap/gauze

/datum/design/biogen/organic_printer/balm
	name = "Red Sun Balm"
	materials = list(/datum/material/biomass = 9) // 12 per stacks
	build_path = /obj/item/stack/medical/ointment/red_sun

/datum/design/biogen/organic_printer/gauze
	name = "Sealed Aseptic Gauze"
	materials = list(/datum/material/biomass = 8) // 6 per stacks
	build_path = /obj/item/stack/medical/wrap/gauze/sterilized

/datum/design/biogen/organic_printer/coagulant_f
	name = "Coagulant-F Packet"
	materials = list(/datum/material/biomass = 5) // 12 per stacks
	build_path = /obj/item/stack/medical/suture/coagulant

/datum/design/biogen/organic_printer/amollin_pill
	name = "Amollin Painkiller"
	build_path = /obj/item/reagent_containers/applicator/pill/amollin

/datum/design/biogen/organic_printer/bandaid
	name = "First Aid Bandage"
	build_path = /obj/item/stack/medical/bandage

/datum/design/biogen/organic_printer/synth_patch
	name = "Robotic Repair Patch"
	build_path = /obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair

/datum/design/biogen/organic_printer/repair_foam
	name = "Robotic Repair Spray"
	materials = list(/datum/material/biomass = 40) // 2 per stacks
	build_path = /obj/item/stack/medical/wound_recovery/robofoam

/datum/design/biogen/organic_printer/bone_gel
	name = "Bone Gel"
	build_path = /obj/item/stack/medical/bone_gel

/datum/design/biogen/organic_printer/surgical_tape
	name = "Surgical Tape"
	build_path = /obj/item/stack/medical/wrap/sticky_tape/surgical
