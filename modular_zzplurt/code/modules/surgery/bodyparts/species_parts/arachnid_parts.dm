/obj/item/bodypart/arm/left/arachnid
	limb_id = SPECIES_ARACHNID
	icon_static = 'modular_zzplurt/icons/mob/human/bodyparts.dmi'
	is_dimorphic = FALSE
	brute_modifier = 1.1
	biological_state = BIO_FLESH_BONE
	should_draw_greyscale = FALSE

	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/arm/right/arachnid
	limb_id = SPECIES_ARACHNID
	icon_static = 'modular_zzplurt/icons/mob/human/bodyparts.dmi'
	is_dimorphic = FALSE
	brute_modifier = 1.1
	biological_state = BIO_FLESH_BONE
	should_draw_greyscale = FALSE

	unarmed_attack_verbs = list("slash", "scratch", "claw")
	unarmed_attack_sound = 'sound/items/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/items/weapons/slashmiss.ogg'

/obj/item/bodypart/leg/left/arachnid
	limb_id = SPECIES_ARACHNID
	icon_static = 'modular_zzplurt/icons/mob/human/bodyparts.dmi'
	is_dimorphic = FALSE
	brute_modifier = 1.1
	biological_state = BIO_FLESH_BONE
	should_draw_greyscale = FALSE

/obj/item/bodypart/leg/right/arachnid
	limb_id = SPECIES_ARACHNID
	icon_static = 'modular_zzplurt/icons/mob/human/bodyparts.dmi'
	is_dimorphic = FALSE
	brute_modifier = 1.1
	biological_state = BIO_FLESH_BONE
	should_draw_greyscale = FALSE

/obj/item/bodypart/chest/arachnid
	limb_id = SPECIES_ARACHNID
	icon_static = 'modular_zzplurt/icons/mob/human/bodyparts.dmi'
	is_dimorphic = TRUE
	brute_modifier = 1.1
	biological_state = BIO_FLESH_BONE
	///Arachnids' phylum is arthropods, which include butterflies. Might as well hit them with moth wings.
	wing_types = list(/obj/item/organ/external/wings/functional/moth/megamoth, /obj/item/organ/external/wings/functional/moth/mothra)
	should_draw_greyscale = FALSE

/obj/item/bodypart/head/arachnid
	limb_id = SPECIES_ARACHNID
	icon_static = 'modular_zzplurt/icons/mob/human/bodyparts.dmi'
	is_dimorphic = TRUE
	biological_state = BIO_FLESH_BONE
	brute_modifier = 1.1
	should_draw_greyscale = FALSE

	head_flags = HEAD_LIPS|HEAD_DEBRAIN
