/obj/item/riding_saddle
	name = "generic riding saddle"
	desc = "someone spawned a basetype!"
	slot_flags = ITEM_SLOT_BELT

	icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon_taur_snake = 'modular_zubbers/icons/mob/taur/saddles.dmi'

/obj/item/riding_saddle/Initialize(mapload)
	. = ..()
	if(type == /obj/item/riding_saddle) // don't even let these prototypes exist
		return INITIALIZE_HINT_QDEL

	AddComponent(/datum/component/carbon_saddle, RIDING_TAUR) // FREE HANDS
	AddComponent(/datum/component/taur_clothing_offset)

/obj/item/riding_saddle/leather
	name = "riding saddle"
	desc = "A thick leather riding saddle. Typically used for animals, this one has been designed for use by the taurs of the galaxy. \n\
		This saddle has specialized footrests that will allow a rider to <b>use both their hands</b> while riding."

	icon_state = "saddle_leather_item"
	worn_icon_state = "saddle_leather"

	inhand_icon_state = "syringe_kit" // placeholder
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

/obj/item/riding_saddle/leather/peacekeeper
	name = "peacekeeper saddle"
	icon_state = "saddle_sec_item"
	worn_icon_state = "saddle_sec"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/riding_saddle/leather/peacekeeper/Initialize(mapload)
	. = ..()
	desc += " This one is painted in peacekeeper livery, and equipped with a mounting slot for cuffs and \
	a baton. Unfortunately this makes it a tad bulkier."
	create_storage(storage_type = /datum/storage/sec_saddle)

/obj/item/riding_saddle/leather/peacekeeper/update_icon(updates)
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/wearer = loc
		if(wearer.belt == src)
			wearer.update_worn_belt()

/obj/item/riding_saddle/leather/peacekeeper/worn_overlays(mutable_appearance/standing, isinhands, icon_file, mutant_styles)
	. = ..()
	if(isnull(atom_storage) || isinhands)
		return
	// This is extremely snowflake, if you decide to make saddlebelts(TM)
	// more common, consider using a method similar to /obj/item/storage/belt/update_overlays()
	//
	if(locate(/obj/item/restraints/handcuffs) in contents)
		. += mutable_appearance('modular_zubbers/icons/mob/taur/saddles.dmi', "cuffs_over")
	if(locate(/obj/item/melee/baton/security) in contents)
		. += mutable_appearance('modular_zubbers/icons/mob/taur/saddles.dmi', "baton_over")

/datum/storage/sec_saddle
	max_slots = 2

/datum/storage/sec_saddle/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(list(
		/obj/item/restraints/handcuffs,
		/obj/item/melee/baton/security
	))

/obj/item/storage/backpack/saddlebags
	name = "saddlebags"
	desc = "A collection of small pockets bound together by belt, typically used on caravan animals due to their superior storage capacity. This one has been designed for use by the taurs of the galaxy. \n\
		These saddlebags can be accessed by anyone if they <b>alt-click</b> the wearer.\n\
		Additionally, they have been modified with a hand grip that would allow <b>one free hand</b> during riding."
	gender = PLURAL

	slot_flags = ITEM_SLOT_BACK

	icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon = 'modular_zubbers/icons/mob/taur/saddles.dmi'
	worn_icon_taur_snake = 'modular_zubbers/icons/mob/taur/saddles.dmi'

	storage_type = /datum/storage/saddlebags

	icon_state = "saddle_satchel_item"
	worn_icon_state = "saddle_satchel"

// slightly better than a backpack, but accessable_storage counterbalances this
/datum/storage/saddlebags
	max_total_storage = 26
	max_slots = 21

/obj/item/storage/backpack/saddlebags/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/carbon_saddle, RIDING_TAUR|RIDER_NEEDS_ARM) // one arm
	AddComponent(/datum/component/accessable_storage)
	AddComponent(/datum/component/taur_clothing_offset)
