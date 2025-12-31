/obj/item/clothing/neck/tie/disco
	name = "horrific necktie"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "eldritch_tie"
	desc = "The necktie is adorned with a garish pattern. It's disturbingly vivid. Somehow you feel as if it would be wrong to ever take it off. It's your friend now. You will betray it if you change it for some boring scarf."

/obj/item/clothing/neck/mantle
	name = "mantle"
	desc = "A decorative drape over the shoulders. This one has a simple, dry color."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "mantle"

/obj/item/clothing/neck/mantle/regal
	name = "regal mantle"
	desc = "A colorful felt mantle. You feel posh just holding this thing."
	icon_state = "regal-mantle"

/obj/item/clothing/neck/mantle/qm
	name = "\proper the quartermaster's mantle"
	desc = "A snug and comfortable looking shoulder covering garment, it has an air of rebellion and independence. Or annoyance and delusions, your call."
	icon_state = "qmmantle"

/obj/item/clothing/neck/mantle/hopmantle
	name = "\proper the head of personnel's mantle"
	desc = "A decorative draping of blue and red over your shoulders, signifying your stamping prowess."
	icon_state = "hopmantle"

/obj/item/clothing/neck/mantle/cmomantle
	name = "\proper the chief medical officer's mantle"
	desc = "A light blue shoulder draping for THE medical professional. Contrasts well with blood."
	icon_state = "cmomantle"

/obj/item/clothing/neck/mantle/rdmantle
	name = "\proper the research director's mantle"
	desc = "A terribly comfortable shoulder draping for the discerning scientist of fashion."
	icon_state = "rdmantle"

/obj/item/clothing/neck/mantle/cemantle
	name = "\proper the chief engineer's mantle"
	desc = "A bright white and yellow striped mantle. Do not wear around active machinery."
	icon_state = "cemantle"

/obj/item/clothing/neck/mantle/hosmantle
	name = "\proper the head of security's mantle"
	desc = "A plated mantle that one might wrap around the upper torso. The 'scales' of the garment signify the members of security and how you're carrying them on your shoulders."
	icon_state = "hosmantle"

/obj/item/clothing/neck/mantle/hosmantle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/hos_mantle)

/datum/atom_skin/hos_mantle
	abstract_type = /datum/atom_skin/hos_mantle

/datum/atom_skin/hos_mantle/red
	preview_name = "Red Variant"
	new_icon_state = "hosmantle"

/datum/atom_skin/hos_mantle/blue
	preview_name = "Blue Variant"
	new_icon_state = "hosmantle_blue"

/obj/item/clothing/neck/mantle/bsmantle
	name = "\proper the blueshield's mantle"
	desc = "A plated mantle with command colors. Suitable for the one assigned to making sure they're still breathing."
	icon_state = "bsmantle"

/obj/item/clothing/neck/mantle/capmantle
	name = "\proper the captain's mantle"
	desc = "A formal mantle to drape around the shoulders. Others stand on the shoulders of giants. You're the giant they stand on."
	icon_state = "capmantle"

/obj/item/clothing/neck/mantle/recolorable
	name = "mantle"
	desc = "A simple drape over the shoulders."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/mantle/recolorable"
	post_init_icon_state = "mantle"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/neck/neck.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/neck/neck_teshari.dmi'
	greyscale_colors = "#ffffff"
	greyscale_config = /datum/greyscale_config/mantle
	greyscale_config_worn = /datum/greyscale_config/mantle/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/mantle/worn/teshari
	greyscale_config_worn_better_vox = /datum/greyscale_config/mantle/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/mantle/worn/oldvox
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/neck/face_scarf
	name = "face scarf"
	desc = "A warm looking scarf that you can easily put around your face."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/face_scarf"
	post_init_icon_state = "face_scarf"
	greyscale_config = /datum/greyscale_config/face_scarf
	greyscale_config_worn = /datum/greyscale_config/face_scarf/worn
	greyscale_config_worn_muzzled = /datum/greyscale_config/face_scarf/worn/muzzled
	greyscale_colors = "#a52424"
	flags_1 = IS_PLAYER_COLORABLE_1
	flags_inv = HIDEFACIALHAIR | HIDESNOUT
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/neck/face_scarf/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, toggle_noun = "scarf")

/obj/item/clothing/neck/face_scarf/click_alt(mob/user) //Make sure that toggling actually hides the snout so that it doesn't clip
	if(icon_state != "face_scarf_t")
		flags_inv = HIDEFACIALHAIR | HIDESNOUT
	else
		flags_inv = HIDEFACIALHAIR
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/neck/maid_neck_cover
	name = "maid neck cover"
	desc = "A neckpiece for a maid costume, it smells faintly of disappointment."
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/maid_neck_cover"
	post_init_icon_state = "maid_neck_cover"
	greyscale_config = /datum/greyscale_config/bubber_maid_neck_cover
	greyscale_config_worn = /datum/greyscale_config/bubber_maid_neck_cover/worn
	greyscale_colors = "#7b9ab5#edf9ff"
	flags_1 = IS_PLAYER_COLORABLE_1
