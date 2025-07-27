// Pre-packed medkit for healing synths and repairing their wounds rapidly in the field
/obj/item/storage/medkit/robotic_repair
	name = "robotic repair equipment kit"
	desc = "An industrial-strength plastic box filled with supplies for repairing synthetics from critical damage."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	icon_state = "synth_medkit"
	inhand_icon_state = "medkit"
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	worn_icon_state = "frontier"
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'
	storage_type = /datum/storage/medkit/robotic_repair

/datum/storage/medkit/robotic_repair/New()
	. = ..()
	set_holdable(list_of_everything_medkits_can_hold + list(
			/obj/item/stack/cable_coil,
			/obj/item/crowbar,
			/obj/item/screwdriver,
			/obj/item/wrench,
			/obj/item/weldingtool,
			/obj/item/wirecutters,
			/obj/item/multitool,
			/obj/item/plunger,
			/obj/item/clothing/head/utility/welding,
			/obj/item/clothing/glasses/welding,
		),
		list(),
		list(/obj/item/clothing/head/utility/welding,
		)
	)

/obj/item/storage/medkit/robotic_repair/stocked

/obj/item/storage/medkit/robotic_repair/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze = 1,
		/obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair = 2,
		/obj/item/stack/medical/wound_recovery/robofoam = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 1, // Coagulants help electrical damage
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/medkit/robotic_repair/preemo
	name = "premium robotic repair equipment kit"
	desc = "An industrial-strength plastic box filled with supplies for repairing synthetics from critical damage. \
		This one has extra storage on the sides for even more equipment than the standard medkit model, \
		and can also fit smaller tools and welding gear inside."
	icon_state = "synth_medkit_super"

/obj/item/storage/medkit/robotic_repair/preemo/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 12
	atom_storage.max_total_storage = 12 * WEIGHT_CLASS_SMALL

/obj/item/storage/medkit/robotic_repair/preemo/stocked

/obj/item/storage/medkit/robotic_repair/preemo/stocked/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/stack/cable_coil/thirty = 1,
		/obj/item/reagent_containers/applicator/pill/robotic_patch/synth_repair = 4,
		/obj/item/stack/medical/wound_recovery/robofoam = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/robot_system_cleaner = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/robot_liquid_solder = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 1,
		/obj/item/reagent_containers/spray/dinitrogen_plasmide = 1,
		/obj/item/healthanalyzer/simple = 1,
	)
	generate_items_inside(items_inside,src)
