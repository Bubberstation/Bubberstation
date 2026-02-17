/*
	// HATS
*/

// OFFICER

/obj/item/clothing/head/helmet/sec
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "security_helmet"
	base_icon_state = "security_helmet"
	worn_icon_muzzled = null
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/mask/bandana/sec
	name = "red bandana"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "security_bandana"
	post_init_icon_state = "security_bandana"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_inhand_left = /datum/greyscale_config/bandana/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/bandana/inhands_right
	greyscale_colors = "#c41521"
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/head/beret/sec/viro
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "security_beret"
	post_init_icon_state = "security_beret"
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_colors = null
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/head/soft/sec
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "secsoft"
	soft_type = "sec"

/obj/item/clothing/head/security_beanie
	name = "security beanie"
	desc = "A robust beanie with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "security_beanie"
	armor_type = /datum/armor/cosmetic_sec
	hair_mask = /datum/hair_mask/standard_hat_low

// WARDEN

/obj/item/clothing/head/hats/warden/viro // too many subtypes, who would've guessed?
	name = "\proper the Warden's service cap"
	desc = "It's a special armored hat issued to the Warden of Nanotrasen Corporate Security. Protects the head from impacts."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "warden_cap"
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/hats/warden/viro/alt
	icon_state = "warden_cap_red"

/obj/item/clothing/head/hats/warden/drill/viro
	name = "\proper the Warden's campaign cover"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "wardendrill"
	hair_mask = /datum/hair_mask/standard_hat_low

/obj/item/clothing/head/hats/warden/viro/beret // not greyscaled so its easier to do this then make it a subtype of regular berets
	name = "\proper the Warden's beret"
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon_state = "warden_beret"

/obj/item/clothing/head/soft/sec/warden
	name = "\proper the Warden's cap"
	desc = "An armoured grey baseball cap, attached on front is the Warden's insignia, a deep-red patch emblazoned with a jailcell, with words around stating '/WARDEN CORRECTIONALS  -  NANOTRASEN CORPORATE SECURITY'/"
	icon_state = "wardensoft"
	soft_type = "warden"
	armor_type = /datum/armor/hats_warden

// HOS

/obj/item/clothing/head/hats/hos/cap
	name = "\proper the Head of Security's service cap"
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "hoscap"
	hair_mask = /datum/hair_mask/standard_hat_low

/obj/item/clothing/head/hats/hos/cap/beret // so jank
	name = "\proper the Head of Security's beret"
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "hos_beret"
	hair_mask = /datum/hair_mask/standard_hat_middle

/obj/item/clothing/head/helmet/sec/hos
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "hos_helmet"
	base_icon_state = "hos_helmet"
	armor_type = /datum/armor/hats_hos

/obj/item/clothing/head/soft/sec/hos
	name = "\proper the Head of Security's cap"
	desc = "An armoured black baseball cap, attached on front are embroided yellow letters stating '/HEAD OF SECURITY'/"
	icon_state = "hossoft"
	soft_type = "hos"
	armor_type = /datum/armor/hats_hos

/obj/item/clothing/head/hats/hos/cap/cowboy
	name = "\proper the Head of Security's cowboy hat"
	desc = "An armoured cattleman's hat, emblazoned with the Head of Security's insignia attached to a red band that goes around the hat."
	icon = 'modular_zubbers/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/hats.dmi'
	icon_state = "hos_cowboy"
	hair_mask = /datum/hair_mask/standard_hat_middle

/*
	// UNIFORMS
*/

// OFFICER

/obj/item/clothing/under/rank/security/officer/viro // theres too many subtypes so we just snowflake
	name = "security uniform"
	desc = "Standard-issue Security department uniform, given to members of Nanotrasen Corporate Security."
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "security_uniform"
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/security/officer/viro/skirt
	name = "security jumpskirt"
	desc = "A padded jumpskirt made out of wind-resistant, slightly water-repellent materials for Nanotrasen Corporate Security."
	icon_state = "security_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/officer/viro/jumpsuit
	name = "security jumpsuit"
	desc = "The previous standard-issue attire for officers, technically antiquated but still popular with utilitarian officers."
	icon_state = "security_jumpsuit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/security/officer/formal
	name = "security officer formals"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "security_formals"
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/security/officer/formal/skirt
	name = "security officer's formal skirt"
	icon_state = "security_formals_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/officer/viro/lowcut
	name = "security summer uniform"
	desc = "An alternative to the standard Security uniform, with an <i>incredibly</i> low-cut collar and cut sleeves."
	icon_state = "security_lowcut"

/obj/item/clothing/under/rank/security/officer/viro/bodysuit
	name = "security bodysuit"
	desc = "Designed out of synthetic leather that automatically seals around the user to reduce overheating and snagging issues that arise while inside a MODsuit. \
			While the bodysuit was only designed to be used while inside of and operating a MODsuit, the bodysuit found a niche with certain... eccentric officers."
	icon_state = "security_bodysuit"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_FULL
	strip_delay = 80

/obj/item/clothing/under/rank/security/officer/viro/bodysuit/equipped(mob/living/affected_mob, slot) // stolen from the lustwish catsuit lol
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	if(src == affected_human.w_uniform)
		if(affected_mob.gender == FEMALE)
			icon_state = "security_bodysuit_female"
		else
			icon_state = "security_bodysuit_male"

		affected_mob.update_worn_undersuit()

// WARDEN

/obj/item/clothing/under/rank/security/warden
	name = "\proper the Warden's uniform"
	desc = "Standard-issue Security department uniform, given to the Warden of Nanotrasen Corporate Security."
	icon_state = "warden_uniform"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/security/warden/skirt
	name = "\proper the Warden's jumpskirt"
	desc = "A padded jumpskirt made out of wind-resistant, slightly water-repellent materials for the Warden of Nanotrasen Corporate Security."
	icon_state = "warden_skirt"
	female_sprite_flags = NO_FEMALE_UNIFORM
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/rank/security/warden/grey
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/warden/formal
	name = "\proper the Warden's formals"
	icon_state = "wardenblueclothes"

/obj/item/clothing/under/rank/security/warden/formal/skirt
	name = "\proper the Warden's formal skirt"
	icon_state = "wardenblueclothes_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE


// HOS

/obj/item/clothing/under/rank/security/head_of_security
	name = "\proper the Head of Security's uniform"
	desc = "Standard-issue Security department uniform, given to the Head of Security of Nanotrasen Corporate Security."
	icon_state = "hos_uniform"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/security/head_of_security/skirt
	name = "\proper the Head of Security's jumpskirt"
	desc = "A padded jumpskirt made out of wind-resistant, slightly water-repellent materials for the Head of Security for Nanotrasen Corporate Security."
	icon_state = "hos_skirt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/head_of_security/grey
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/head_of_security/alt
	name = "\proper the Head of Security's turtleneck"
	icon_state = "hosalt"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	name = "\proper the Head of Security's skirtleneck"
	icon_state = "hosalt_skirt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/rank/security/head_of_security/parade
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/head_of_security/formal
	name = "\proper the Head of Security's formals"
	icon_state = "hosblueclothes"

/obj/item/clothing/under/rank/security/head_of_security/formal/skirt
	name = "\proper the Head of Security's formal skirt"
	icon_state = "hosblueclothes_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/*
	// ARMORS
*/

/obj/item/clothing/suit/armor/vest/alt/sec/viro // too many subtypes
	name = "security plate carrier"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "sec_platecarrier"

/obj/item/clothing/suit/armor/vest/alt/sec/viro/heavyvest
	name = "security heavy vest"
	desc = "An alternate armour vest for Security employees, featuring more coverage at the cost of weight."
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	icon_state = "sec_heavyvest"

/obj/item/clothing/suit/armor/vest/alt/sec/viro/leatherjacket
	name = "security leather jacket"
	desc = "Made out of synthetic leather materials, this jacket is designed for formal events, but is applicable for general use with it's ceramic-woven leather."
	icon_state = "sec_leatherjacket"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

/obj/item/clothing/suit/armor/vest/alt/sec/viro/softshell
	name = "security softshell"
	desc = "A windproof, rainproof, insulation jacket made for Security — with an internal sweater sewn into the collar of the suit, the sweater keeps the wearer insulated while allowing the jacket to be unzipped."
	icon_state = "sec_softshell"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// WARDEN

/obj/item/clothing/suit/armor/vest/warden
	name = "\proper the Warden's jacket"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	desc = "A grey armored jacket with red shoulder designations and '/Warden/' stitched into one of the chest pockets."
	icon_state = "warden_alt"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/warden/alt
	name = "\proper the Warden's armoured jacket"
	desc = "A grey jacket with silver rank pips and body armor strapped on top."
	icon_state = "warden_jacket"

/obj/item/clothing/suit/armor/vest/warden/alt/winter
	name = "\proper the Warden's winter jacket"
	desc = "A modification of the Warden's standard armoured jacket, made out of synthetic cotton woven with ceramic, and lined with faux-fur. For the cozy Warden."
	icon_state = "warden_winterjacket"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

// HOS

/obj/item/clothing/suit/armor/hos
	name = "\proper the Head of Security's leather greatcoat"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hos_greatcoat"
	worn_icon_digi = null

/obj/item/clothing/suit/armor/hos/trenchcoat
	name = "\proper the Head of Security's leather trenchcoat"
	icon_state = "hos_leathercoat"

/obj/item/clothing/suit/armor/hos/overcoat
	name = "\proper the Head of Security's overcoat"
	icon_state = "hos_overcoat"

/obj/item/clothing/suit/armor/hos/trenchcoat/winter
	name = "\proper the Head of Security's winter trenchcoat"
	icon_state = "hos_wintercoat"

/obj/item/clothing/suit/armor/hos/vest
	name = "\proper the Head of Security's plate carrier"
	desc = "Specially issued plate carrier for Security command staff. On the front is an embroided patch, that in big yellow letters says: \"HEAD OF SECURITY\""
	icon_state = "hos_platecarrier"
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN

/obj/item/clothing/suit/armor/hos/hos_formal // so annoying
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'

/*
	// GLOVES
*/

/obj/item/clothing/gloves/color/black/security
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	icon_state = "sec_gloves"

/obj/item/clothing/gloves/color/black/security/blu
	icon_state = "sec_gloves"

/obj/item/clothing/gloves/tackler/security	//Can't just overwrite tackler, as there's a ton of subtypes that we'd then need to account for. This is easier. MUCH easier.
	icon = 'modular_zubbers/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	icon_state = "sec_gloves"

/obj/item/clothing/gloves/kaza_ruk/sec
	worn_icon = 'modular_zubbers/icons/mob/clothing/hands.dmi'
	icon_state = "fightgloves"

/*
	// BELTS
*/

/obj/item/storage/belt/security
	icon = 'modular_zubbers/icons/obj/clothing/belt.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	icon_state = "security"
	content_overlays = FALSE
	alternate_worn_layer = LOW_NECK_LAYER  // so it goes under things like the HOS' trenchcoats

/obj/item/storage/belt/security/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_belt)

/datum/atom_skin/security_belt
	abstract_type = /datum/atom_skin/security_belt

/datum/atom_skin/security_belt/red
	preview_name = "Red Variant"
	new_icon_state = "security"

/datum/atom_skin/security_belt/black // why doesn't this work ????
	preview_name = "Black Variant"
	new_icon_state = "security_black"

/obj/item/storage/belt/security/webbing
	icon = 'modular_zubbers/icons/obj/clothing/belt.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	icon_state = "security_webbing"
	worn_icon_state = "security_webbing"
	alternate_worn_layer = BELT_LAYER


/*
	// SHOES
*/

/obj/item/clothing/shoes/jackboots/sec
	name = "security boots"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	icon_state = "jackboots_sec"

/obj/item/clothing/shoes/jackboots/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_jackboots, infinite = TRUE)

/datum/atom_skin/security_jackboots
	abstract_type = /datum/atom_skin/security_jackboots

/datum/atom_skin/security_jackboots/bloused
	preview_name = "Bloused"
	new_icon_state = "jackboots_sec"

/datum/atom_skin/security_jackboots/unbloused
	preview_name = "Unbloused"
	new_icon_state = "jackboots_sec_unbloused"

/*
	// MASK
*/

/obj/item/clothing/mask/gas/sechailer
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/mask.dmi'
	worn_icon_muzzled = 'modular_zubbers/icons/mob/clothing/head/mask_muzzled.dmi'

/obj/item/clothing/mask/gas/sechailer/swat
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDEEYES | HIDEEARS | HIDESNOUT

/obj/item/clothing/mask/gas/sechailer/swat/spacepol
	icon = 'icons/obj/clothing/masks.dmi'
	worn_icon = 'icons/mob/clothing/mask.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'

/*
	// NECK
*/

// HOS

/obj/item/clothing/neck/cloak/hos  // still ugly but i tried
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'

/*
	// BACKPACKS
*/

/obj/item/storage/backpack/security
	worn_icon = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi'
	icon_state = "backpack-security"

/obj/item/storage/backpack/satchel/sec
	worn_icon = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi'
	icon_state = "satchel-security"

/obj/item/storage/backpack/duffelbag/sec
	worn_icon = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi'
	icon_state = "duffel-security"

/obj/item/storage/backpack/messenger/sec
	icon = 'icons/obj/storage/backpack.dmi' // yeah i dont know either
	worn_icon = 'modular_zubbers/icons/mob/clothing/back/backpack.dmi'
	icon_state = "messenger_security"


	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi' // fucking kill me
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'


/*
	// EYES
*/

/obj/item/clothing/glasses/hud/security/sunglasses
	icon = 'modular_zubbers/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/security/sunglasses/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_sunglasses)

/datum/atom_skin/security_sunglasses
	abstract_type = /datum/atom_skin/security_sunglasses

/datum/atom_skin/security_sunglasses/red
	preview_name = "Red Variant"
	new_icon_state = "sunhudsec"

/datum/atom_skin/security_sunglasses/black
	preview_name = "Black Variant"
	new_icon_state = "sunhudsec_blk"

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'

/*
	// PRISONER (why is this here ?)
*/

/obj/item/clothing/under/rank/prisoner/protcust
	name = "protective custody prisoner jumpsuit"
	desc = "A mustard coloured prison jumpsuit, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/protcust"
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/skirt/protcust
	name = "protective custody prisoner jumpskirt"
	desc = "A mustard coloured prison jumpskirt, often worn by former Security members, informants and former CentCom employees. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/protcust"
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/lowsec
	name = "low security prisoner jumpsuit"
	desc = "A pale, almost creamy prison jumpsuit, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/lowsec"
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/skirt/lowsec
	name = "low security prisoner jumpskirt"
	desc = "A pale, almost creamy prison jumpskirt, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/lowsec"
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/highsec
	name = "high risk prisoner jumpsuit"
	desc = "A bright red prison jumpsuit, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/highsec"
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/skirt/highsec
	name = "high risk prisoner jumpskirt"
	desc = "A bright red prison jumpskirt, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/highsec"
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/supermax
	name = "supermax prisoner jumpsuit"
	desc = "A dark crimson red prison jumpsuit, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/supermax"
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/skirt/supermax
	name = "supermax prisoner jumpskirt"
	desc = "A dark crimson red prison jumpskirt, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/supermax"
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/classic
	name = "classic prisoner jumpsuit"
	desc = "A black and white striped jumpsuit, like something out of a movie."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/costume.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/costume_digi.dmi'
	icon_state = "prisonerclassic"
	post_init_icon_state = null
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/prisoner/syndicate
	name = "syndicate prisoner jumpsuit"
	desc = "A crimson red jumpsuit worn by syndicate captives. Its sensors have been shorted out."
	icon_state = "/obj/item/clothing/under/rank/prisoner/syndicate"
	greyscale_colors = "#992300"
	has_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/skirt/syndicate
	name = "syndicate prisoner jumpskirt"
	desc = "A crimson red jumpskirt worn by syndicate captives. Its sensors have been shorted out."
	icon_state = "/obj/item/clothing/under/rank/prisoner/skirt/syndicate"
	greyscale_colors = "#992300"
	has_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/syndicate/station
	name = "syndicate prisoner jumpsuit"
	desc = "A dark blood red prison jumpsuit, for the known Syndicate captives, valuable targets to CentCom and interrogation. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "/obj/item/clothing/under/rank/prisoner/syndicate/station"
	greyscale_colors = "#5c0000ff"

/*
	// DETECTIVE
*/

/obj/item/clothing/under/rank/security/detective/cowboy
	name = "blonde cowboy uniform"
	desc = "A blue shirt and dark jeans, with a pair of spurred cowboy boots to boot."
	icon = 'modular_skyrat/master_files/icons/donator/obj/clothing/uniform.dmi'	//Donator item-ish? See the /armorless one below it
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/donator/mob/clothing/uniform_digi.dmi'
	icon_state = "cowboy_uniform"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/cowboy/armorless //Donator variant, just uses the sprite.
	armor_type = /datum/armor/clothing_under

/obj/item/clothing/under/rank/security/detective/runner
	name = "runner sweater"
	desc = "<i>\"You look lonely.\"</i>"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "runner"
	can_adjust = FALSE

/*
	// ANTIQUATED
*/

//Not technically an override but oh well
/obj/item/clothing/neck/security_cape
	name = "security cape"
	desc = "A fashionable cape worn by security officers."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cape_black"
	inhand_icon_state = "" //no unique inhands
	///Decides the shoulder it lays on, false = RIGHT, TRUE = LEFT
	var/swapped = FALSE

/obj/item/clothing/neck/security_cape/armplate  // wanted to kill this item but stuff relies on it so i cant
	name = "security gauntlet"
	desc = "A fashionable full-arm gauntlet worn by security officers. The gauntlet itself is made of plastic, and provides no protection, but it looks cool as hell."
	icon_state = "armplate_black"


/*
	// ANTIQUATED GLASSES
*/

/obj/item/clothing/glasses/hud/eyepatch/sec
	name = "security eyepatch HUD"
	desc = "Lost your eye beating an innocent clown? Thankfully your corporate overlords have made something to make up for this. May not do well against flashes."
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red
	icon = 'modular_zubbers/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/eyes.dmi'

/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold
	name = "sec blindfold HUD"
	desc = "a fake blindfold with a security HUD inside, helps you look like blind justice. This won't provide the same protection that you'd get from sunglasses."
	icon_state =  "secfold"
	base_icon_state =  "secfold"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
