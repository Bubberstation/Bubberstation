/*
	// UNDER
*/

/obj/item/clothing/under/rank/security/officer/viro/security_medic
	name = "security medic turtleneck"
	desc = "Standard-issue turtleneck given to the security medics of Nanotrasen Corporate Security."
	icon_state = "secmed_turtleneck"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/officer/viro/security_medic/skirt
	name = "security medic skirtleneck"
	desc = "A comfy turtleneck with a white armband, denoting the wearer as a security medic."
	icon_state = "secmed_skirtleneck"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/officer/viro/security_medic/jumpsuit
	name = "security medic jumpsuit"
	desc = "The previous standard-issue attire for security medics, technically antiquated but still popular with utilitarian medics."
	icon_state = "secmed_jumpsuit"

/obj/item/clothing/under/rank/security/officer/viro/security_medic/jumpsuit/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/obj/item/clothing/under/rank/security/officer/viro/security_medic/scrubs
	name = "security medic scrubs"
	desc = "Sterile, anti-bacterial scrubs for intense medical work while tending to the valuable employees of Nanotrasen Corporate Security."
	icon_state = "secmed_scrubs"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/officer/viro/security_medic/scrubs/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)

/*
	// ARMOUR
*/

/obj/item/clothing/suit/armor/vest/security_medic
	name = "security medic armour vest"
	desc = "A security medic's armor vest, with little pockets for little things."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "secmed_armor"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/cup/bottle, /obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/applicator/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/suit/armor/vest/security_medic/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha, effect_type = EMISSIVE_SPECULAR)


/obj/item/clothing/suit/armor/vest/security_medic/jacket
	name = "security medic jacket"
	desc = "A lightweight vest worn by the Security Medic."
	icon_state = "secmed_labcoat"
	blood_overlay_type = "coat"

/obj/item/clothing/suit/armor/vest/security_medic/hazvest
	name = "security medic hazard vest"
	desc = "A lightweight vest worn by the Security Medic."
	icon_state = "secmed_hazvest"

/*
	// HEADWEAR
*/

/obj/item/clothing/head/beret/sec/viro/security_medic // not greyscaled so its easier to do this then make it a subtype of regular berets
	name = "security medic beret"
	desc = "A robust beret with the medical insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon_state = "secmed_beret"

/obj/item/clothing/head/helmet/sec/secmed
	name = "security medic helmet"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "secmed_helmet"
	base_icon_state = "secmed_helmet"

/obj/item/clothing/head/soft/sec/secmed
	name = "security medic cap"
	desc = "An armoured black baseball cap, attached on front are embroided red letters stating '/DETECTIVE'/"
	icon_state = "secmedsoft"
	soft_type = "secmed"

/*
	// ACCESSORIES
*/

/obj/item/storage/belt/security/medic
	name = "security medic belt"
	desc = "A fancy looking security belt emblazoned with markings of the security medic. Sadly only holds security gear."
	icon = 'modular_zubbers/icons/obj/clothing/belt.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	icon_state = "secmed_belt"
	content_overlays = FALSE
	alternate_worn_layer = LOW_NECK_LAYER

/obj/item/storage/belt/security/medic/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

/obj/item/clothing/gloves/latex/nitrile/security
	name = "security nitrile gloves"
	desc = "Anti-bacterial, medical-grade nitrile gloves reinforced for Corporate Security work, designed to prevent contamination when handling cadavers or open wounds."
	icon_state = "secmed_gloves"
	inhand_icon_state = "greyscale_gloves"
	greyscale_colors = "#8d2424"
