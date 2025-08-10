/*
*	Overwrites all the centcom icons with our own recolored versions; this means little to no mapping/spawning conflicts!
*/

/*
* UNIFORMS
*/
/obj/item/clothing/under/rank/centcom/commander
	desc = "An elegant uniform worn by CentCom's finest, comfortable trousers and gold marking denoting the rank of \"Commander\"."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/centcom/centcom_skirt
	desc = "An elegant uniform worn by CentCom's finest, comfortable skirt and gold marking denoting the rank of \"Commander\"."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/centcom/consultant
	name = "\improper CentCom representative's suit"
	desc = "An elegant uniform worn by CentCom's station officials, comfortable trousers and silver marking denoting the rank of \"Representative\"."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'
	icon_state = "rep"

/obj/item/clothing/under/rank/centcom/consultant/skirt
	name = "\improper CentCom representative's suitskirt"
	desc = "An elegant uniform worn by CentCom's station officials, comfortable skirt and silver marking denoting the rank of \"Representative\"."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'
	icon_state = "rep_skirt"

/obj/item/clothing/under/rank/centcom/official
	desc = "A formal suit worn by CentCom's paper pushers, a generic uniform usually used by Inspectors. The silver belt buckle denotes their rank with ease."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/centcom/official/turtleneck
	name = "\improper CentCom official's turtleneck"
	desc = "A formal suit, with an added comfortable and warm turtleneck worn by CentCom's paper pushers, a generic uniform usually used by Inspectors. The silver belt buckle denotes their rank with ease."
	icon_state = "official_turtleneck"// Sprites by Ebin-Halcyon

/obj/item/clothing/under/rank/centcom/intern
	name = "\improper CentCom intern's uniform"
	desc = "A uniform worn by CentCom's interning employees, with a polo shirt for easy identification of their rank."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/centcom/officer
	name = "\improper CentCom tactical turtleneck"
	desc = "A CentCom uniform worn by Emergency Response Teams, added with black tactical cargo pants. Though, more used as an undersuit for MOD suits."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/centcom/officer_skirt
	name = "\improper CentCom tactical skirtleneck"
	desc = "A CentCom uniform worn by Emergency Response Teams, added with a generic black skirt. Though, more used as an undersuit for MOD suits."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/centcom/officer/replica
	name = "\improper CentCom turtleneck replica"
	desc = "A uniform made from cheap materials, manufactured to resemble what most CentCom officers wear, it has a quite obvious Donk Co. logo on the collar."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'
	icon_state = "fakecent"

/obj/item/clothing/under/rank/centcom/officer_skirt/replica
	name = "\improper CentCom turtleneck skirt replica"
	desc = "A uniform made from cheap materials, manufactured to resemble what most CentCom officers wear, it has a quite obvious Donk Co. logo on the collar."
	icon = 'modular_zubbers/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/centcom.dmi'
	icon_state = "fakecent_skirt"

/*
* SUITS
*/
/obj/item/clothing/suit/armor/centcom_formal
	desc = "A stylish coat given to CentCom Commanders. Perfect for sending ERTs to suicide missions with style!"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/hooded/wintercoat/centcom
	name = "CentCom winter coat"
	desc = "A luxurious winter coat woven in the bright green and gold colours of Central Command. It has a small pin in the shape of the Nanotrasen logo for a zipper."
	icon = 'modular_zubbers/icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/wintercoat.dmi'

/obj/item/clothing/suit/space/officer
	name = "CentCom officer's coat"
	desc = "A luxurious coat with genuine fur along the collar, a exotic suit worn by usually Special Operations Officers of Central Command, it's woven with excellent fabrics, while also housing technology to render the wearer safe from space's vaccum, and freezing temperatures."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'

/obj/item/clothing/suit/armor/vest/officerfake
	name = "CentCom officer's coat"
	desc = "A luxurious coat with synthetic fur along the collar, a exotic suit worn by usually Special Operations Officers of Central Command, it's woven with excellent fabrics. This one lacks the special tech of space protection, which hinders it just as a piece of clothing."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "centcom_coat"

/obj/item/clothing/suit/armor/vest/capcarapace/centcom
	name = "CentCom carapace"
	desc = "A fireproof armored chestpiece reinforced with ceramic plates and plasteel pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to CentCom's finest, although it does chafe your nipples."
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "centcom_vest"

/*
* HATS
*/
/obj/item/clothing/head/hats/centcom_cap
	desc = "A luxurious peaked cap, worn by only CentCom's finest commanders. Inside the lining of the cap, lies two faint initials."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'

/obj/item/clothing/head/hats/consultant_cap
	name = "\improper CentCom representative's cap"
	desc = "A fancy peaked cap, worn by only CentCom's station officials. Inside the lining of the cap, lies two faint initials."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "rep_cap"
	armor_type = /datum/armor/head_nanotrasen_consultant

/obj/item/clothing/head/hats/centhat
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'

/obj/item/clothing/head/hats/intern
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'

/obj/item/clothing/head/beret/centcom_formal
	name = "\improper CentCom formal beret"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "centcom_beret"
	post_init_icon_state = null
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null

/obj/item/clothing/head/hooded/winterhood/centcom
	name = "\improper CentCom winter hood"
	icon = 'modular_zubbers/icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/winterhood.dmi'

/*
* GLOVES
*/
/obj/item/clothing/gloves/captain/centcom
	name = "CentCom gloves"
	desc = "Exotic green gloves, with a nice gold trim, a emerald anti-shock coating, and an integrated thermal barrier. Swanky. Given to CentCom Commanders."
	icon = 'modular_zubbers/icons/obj/clothing/gloves/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/gloves/gloves.dmi'
	icon_state = "centcom"

/*
* MASKS
*/
/obj/item/clothing/mask/gas/atmos/centcom
	name = "\improper CentCom gas mask"
	desc = "Oooh, gold and green. Fancy! This should help as you sit in your office."
	icon = 'modular_zubbers/icons/obj/clothing/mask/mask.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/mask/mask.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION
