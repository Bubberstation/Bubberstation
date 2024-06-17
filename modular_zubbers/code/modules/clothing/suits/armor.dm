/obj/item/clothing/suit/armor/metrocop //Sprite done by Gat1Day#2892
	name = "Civil Protection Suit"
	desc = "Standard issue armor for Civil Protection."
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	cold_protection = CHEST|ARMS|GROIN|LEGS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|ARMS|GROIN|LEGS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hardsuit-metrocop"
	inhand_icon_state =  null
	blood_overlay_type = "hardsuit-metrocop"
	armor_type =/datum/armor/suit_armor

/obj/item/clothing/suit/armor/metrocopriot //Sprite done by Gat1Day#2892
	name = "Riot Civil Protection Suit"
	desc = "A Suit of armor to help Civil Protection deal with unruly citizens."
	icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hardsuit-metrocop-RL"
	inhand_icon_state =  null
	blood_overlay_type = "hardsuit-metrocop-RL"
	armor_type = /datum/armor/armor_riot

/obj/item/clothing/suit/armor/vest/collared_vest//Sprite done by offwrldr
	name = "Collared Vest"
	desc = "An armored vest with an attached collar, adorned with a blue stripe on the right breastplate. It is unlikely the collar adds any additional protective qualities."
	icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	worn_icon = 'modular_zubbers/icons/obj/clothing/suits/collared_vest.dmi'
	icon_state = "vest_worn"
	inhand_icon_state = null
	armor_type = /datum/armor/suit_armor

/obj/item/clothing/suit/armor/vest/secjacket // Port from TG Station (DrTuxedo)
	name = "security jacket"
	desc = "A red jacket in red Security colors. It has hi-vis stripes all over it."
	icon = 'modular_zubbers/icons/obj/clothing/suits/jacket.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/jacket.dmi'
	icon_state = "secjacket"
	inhand_icon_state = "armor"
	armor_type = /datum/armor/suit_armor
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/secjacket/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/armor/vest/secjacket/blue // Port from TG Station (DrTuxedo)
	name = "security jacket"
	desc = "A blue jacket in blue Peacekeeper colors. It has hi-vis stripes all over it."
	icon_state = "secjacket_blue"

/obj/item/clothing/suit/armor/vest/intern // Bubberstation Edit
	name = "\improper CentCom head intern vest"
	desc = "A sort of market employee vest colored black with CentCom markings. Definitely barely deserve even this."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "intern_vest"

/obj/item/clothing/suit/armor/vest/centhazard // Bubberstation Edit
	name = "\improper CentCom hazard vest"
	desc = "A dark green utility vest usually worn by Central Command Safety Inspectors, or what most call OSHA."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "centcom_hazard"
	inhand_icon_state = null
	blood_overlay_type = "armor"
	allowed = list(
		/obj/item/fireaxe/metal_h2_axe,
		/obj/item/flashlight,
		/obj/item/radio,
		/obj/item/storage/bag/construction,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/t_scanner,
		/obj/item/gun/ballistic/rifle/boltaction/pipegun,
	)

/obj/item/clothing/suit/hazardvest/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/armor/vest/labcoat // Bubberstation Edit
	name = "\improper CentCom labcoat"
	desc = "A sterile labcoat with green shoulder markings, usually worn by Central Command Medical Officers."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "centcom_labcoat"
	inhand_icon_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	allowed = list(
		/obj/item/analyzer,
		/obj/item/biopsy_tool,
		/obj/item/dnainjector,
		/obj/item/flashlight/pen,
		/obj/item/healthanalyzer,
		/obj/item/paper,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/cup/beaker,
		/obj/item/reagent_containers/cup/bottle,
		/obj/item/reagent_containers/cup/tube,
		/obj/item/reagent_containers/hypospray,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/gun/syringe,
		/obj/item/sensor_device,
		/obj/item/soap,
		/obj/item/stack/medical,
		/obj/item/storage/pill_bottle,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		)
	armor_type = /datum/armor/toggle_labcoat

/obj/item/clothing/suit/armor/vest/capcarapace/centcom
	name = "CentCom carapace"
	desc = "A fireproof armored chestpiece reinforced with ceramic plates and plasteel pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to CentCom's finest, although it does chafe your nipples."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "cent_carapace"

/obj/item/clothing/suit/armor/vest/consultant
	name = "CentCom consultant's vest"
	desc = "An oddly heavy-duty webbing vest with \"Nanotrasen Consultant\" ranking on the front in silver."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "consultantvest"
