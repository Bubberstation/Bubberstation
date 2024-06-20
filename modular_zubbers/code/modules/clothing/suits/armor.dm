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

/obj/item/clothing/suit/armor/centcom_formal
	name = "\improper CentCom formal coat"
	desc = "A fancy, expensive coat worn by CentCom's finest Commanders. Usually only worn in formal events, but that's basically all day for them. It helps you focus when you send an ERT to a suicide mission!"
	icon_state = "centcom_formal"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	inhand_icon_state = "centcom"
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/armor_centcom_formal

/obj/item/clothing/suit/armor/centcom_formal/carapace
	name = "\improper CentCom carapace"
	desc = "A luxurious vest made with plasteel alloyed ceramic plating armor worn normally by CentCom Commanders or Admirals, you get a hint you shouldn't mess with those who wear these."
	icon_state = "centcom_carapace"
	body_parts_covered = CHEST|GROIN
	dog_fashion = null
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/space/officer
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/hooded/wintercoat/centcom
	name = "CentCom winter coat"
	desc = "A luxurious winter coat woven in the bright green and gold colours of Central Command. It has a small pin in the shape of the Nanotrasen logo for a zipper."
	icon_state = "coatcentcom"
	icon = 'modular_zubbers/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/wintercoat.dmi'

/obj/item/clothing/suit/hazardvest/centcom
	name = "CentCom hazard vest"
	desc = "A high-visibility vest used in work zones, this one is slightly padded with some armor to help cope with people who dislike inspections."
	icon_state = "centcom_hazard"
	armor_type = /datum/armor/suit_armor
