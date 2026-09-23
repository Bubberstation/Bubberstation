// Jumpsuit

/obj/item/clothing/under/frontier_colonist
	name = "frontier jumpsuit"
	desc = "A heavy grey jumpsuit with extra padding around the joints. Two massive pockets included. \
		No matter what you do to adjust it, its always just slightly too large."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "jumpsuit"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "jumpsuit"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Boots

/obj/item/clothing/shoes/jackboots/frontier_colonist
	name = "heavy frontier boots"
	desc = "A well built pair of tall boots usually seen on the feet of explorers, first wave colonists, \
		and LARPers across the galaxy."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "boots"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "boots"
	armor_type = /datum/armor/colonist_clothing
	resistance_flags = NONE

/obj/item/clothing/shoes/jackboots/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Jackets

/obj/item/clothing/suit/jacket/frontier_colonist
	name = "frontier trenchcoat"
	desc = "A knee length coat with a water-resistant exterior and relatively comfortable interior. \
		In between? Just enough protective material to stop the odd sharp thing getting through, \
		though don't expect miracles."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "jacket"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "jacket"
	slot_flags = ITEM_SLOT_OCLOTHING
	armor_type = /datum/armor/colonist_clothing
	resistance_flags = NONE
	allowed = null

/obj/item/clothing/suit/jacket/frontier_colonist/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/item/clothing/suit/jacket/frontier_colonist/short
	name = "frontier jacket"
	desc = "A short coat with a water-resistant exterior and relatively comfortable interior. \
		In between? Just enough protective material to stop the odd sharp thing getting through, \
		though don't expect miracles."
	icon_state = "jacket_short"
	worn_icon_state = "jacket_short"

/obj/item/clothing/suit/jacket/frontier_colonist/medical
	name = "frontier medical jacket"
	desc = "A short coat with a water-resistant exterior and relatively comfortable interior. \
		In between? Just enough protective material to stop the odd sharp thing getting through, \
		though don't expect miracles. This one is colored a bright red and covered in white \
		stripes to denote that someone wearing it might be able to provide medical assistance."
	icon_state = "jacket_med"
	worn_icon_state = "jacket_med"

// Flak Jacket

/obj/item/clothing/suit/frontier_colonist_flak
	name = "frontier flak jacket"
	desc = "A simple flak jacket with an exterior of water-resistant material. \
		Jackets like these are often found on first wave colonists that want some armor \
		due to the fact they can be made easily within a colony core type machine."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "flak"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "flak"
	body_parts_covered = CHEST
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	armor_type = /datum/armor/colonist_armor
	resistance_flags = NONE
	allowed = null

/obj/item/clothing/suit/frontier_colonist_flak/Initialize(mapload)
	. = ..()
	allowed += GLOB.colonist_suit_allowed
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Various softcaps

/obj/item/clothing/head/soft/frontier_colonist
	name = "frontier cap"
	desc = "It's a robust baseball hat in a rugged green color."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "cap"
	soft_type = "cap"
	soft_suffix = null
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "cap"

/obj/item/clothing/head/soft/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

/obj/item/clothing/head/soft/frontier_colonist/medic
	name = "frontier medical cap"
	desc = "It's a robust baseball hat in a stylish red color. Has a white diamond to denote that its wearer might be able to provide medical assistance."
	icon_state = "cap_medical"
	soft_type = "cap_medical"
	worn_icon_state = "cap_medical"

// Helmet (Is it a helmet? Questionable? I'm not sure what to call this thing)

/obj/item/clothing/head/frontier_colonist_helmet
	name = "frontier soft helmet"
	desc = "A unusual piece of headwear somewhere between a proper helmet and a normal cap."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "tanker"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "tanker"
	armor_type = /datum/armor/colonist_armor
	resistance_flags = NONE
	flags_inv = 0
	clothing_flags = SNUG_FIT | STACKABLE_HELMET_EXEMPT

/obj/item/clothing/head/frontier_colonist_helmet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Headset

/// How much charge the headset spends pushing one message out with no relay to carry it
#define FRONTIER_RADIO_TRANSMIT_COST (STANDARD_CELL_CHARGE * 0.02)

/obj/item/radio/headset/headset_frontier_colonist
	name = "frontier radio headset"
	desc = "A bulky headset that should hopefully survive exposure to the elements better than station headsets might. \
		Has a battery-powered antenna allowing the headset to work independently of a communications network, \
		and room for a single encryption key."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "radio"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "radio"
	alternate_worn_layer = FACEMASK_LAYER + 0.5
	subspace_transmission = FALSE
	radiosound = 'modular_skyrat/modules/kahraman_equipment/sound/morse_signal.wav'
	radio_sound_volume = 20
	freqlock = RADIO_FREQENCY_LOCKED
	/// Powers the antenna whenever there is no relay to carry our signal
	var/obj/item/stock_parts/power_store/cell = /obj/item/stock_parts/power_store/cell

/obj/item/radio/headset/headset_frontier_colonist/wide
	worn_icon_state = "radio_wide"

/obj/item/radio/headset/headset_frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)
	if(ispath(cell))
		cell = new cell(src)

/obj/item/radio/headset/headset_frontier_colonist/Destroy()
	QDEL_NULL(cell)
	return ..()

/obj/item/radio/headset/headset_frontier_colonist/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == cell)
		cell = null

/obj/item/radio/headset/headset_frontier_colonist/examine(mob/user)
	. = ..()
	if(isnull(cell))
		. += span_warning("Its battery compartment is <b>empty</b>.")
	else
		. += span_notice("Its [cell.name] is charged to <b>[round(cell.percent())]%</b>. Talking with no relay in range drains it.")
	. += span_notice("The battery and key can be removed with a <b>screwdriver</b>.")

// one key, and the frequency lock only guards the dial, not the keyslot
/obj/item/radio/headset/headset_frontier_colonist/install_key(mob/living/user, obj/item/encryptionkey/key)
	if(keyslot)
		loc.balloon_alert(user, "only fits one key!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(key, src))
		loc.balloon_alert(user, "cannot install!")
		return ITEM_INTERACT_BLOCKING
	keyslot = key
	recalculateChannels()
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	loc.balloon_alert(user, "encryption key installed")
	return ITEM_INTERACT_SUCCESS

/obj/item/radio/headset/headset_frontier_colonist/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return ..()
	if(!isnull(cell))
		loc.balloon_alert(user, "already has a battery!")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	cell = tool
	playsound(src, 'sound/machines/click.ogg', 50, TRUE)
	loc.balloon_alert(user, "battery installed")
	return ITEM_INTERACT_SUCCESS

/obj/item/radio/headset/headset_frontier_colonist/screwdriver_act(mob/living/user, obj/item/tool)
	var/removed_anything = length(remove_keys(user)) > 0
	if(!isnull(cell))
		user.put_in_hands(cell)
		removed_anything = TRUE
	if(!removed_anything)
		loc.balloon_alert(user, "nothing to remove!")
		return ITEM_INTERACT_BLOCKING
	tool.play_tool_sound(src, 10)
	loc.balloon_alert(user, "battery and key removed")
	return ITEM_INTERACT_SUCCESS

// only called when no relay picked the message up, so this is the only time we pay for it
/obj/item/radio/headset/headset_frontier_colonist/backup_transmission(datum/signal/subspace/vocal/signal)
	var/turf/our_turf = get_turf(src)
	if(signal.data["done"] && (our_turf?.z in signal.levels))
		return
	if(isnull(cell) || !cell.use(FRONTIER_RADIO_TRANSMIT_COST))
		if(ismob(loc))
			to_chat(loc, span_warning("[src] crackles. There is no relay in range and not enough charge to reach anyone."))
		return
	return ..()

#undef FRONTIER_RADIO_TRANSMIT_COST

// Gloves

/obj/item/clothing/gloves/frontier_colonist
	name = "frontier gloves"
	desc = "A sturdy pair of black gloves that'll keep your precious fingers protected from the outside world. \
		They go a bit higher up the arm than most gloves should, and you aren't quite sure why."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "gloves"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "gloves"
	greyscale_colors = "#3a373e"
	siemens_coefficient = 0.25 // Doesn't insulate you entirely, but makes you a little more resistant
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	clothing_traits = list(TRAIT_QUICK_CARRY)

/obj/item/clothing/gloves/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

// Special mask

/obj/item/clothing/mask/gas/atmos/frontier_colonist
	name = "frontier gas mask"
	desc = "An improved gas mask commonly seen in places where the atmosphere is less than breathable, \
		but otherwise more or less habitable. Its certified to protect against most biological hazards \
		to boot."
	icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing.dmi'
	icon_state = "mask"
	worn_icon = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn.dmi'
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
	worn_icon_digi = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/kahraman_equipment/icons/clothes/clothing_worn_teshari.dmi'
	worn_icon_state = "gas_frontier"
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/gas/atmos/frontier_colonist/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KAHRAMAN)

//// Loadout variant
// suit
/obj/item/clothing/suit/jacket/frontier_colonist/loadout
	armor_type = /datum/armor/none

/obj/item/clothing/suit/jacket/frontier_colonist/loadout/Initialize(mapload)
	. = ..()
	allowed = list()

/obj/item/clothing/suit/jacket/frontier_colonist/short/loadout
	armor_type = /datum/armor/none

/obj/item/clothing/suit/jacket/frontier_colonist/short/loadout/Initialize(mapload)
	. = ..()
	allowed = list()

// Gloves
/obj/item/clothing/gloves/frontier_colonist/loadout
	siemens_coefficient = 0.50

// boots
/obj/item/clothing/shoes/jackboots/frontier_colonist/loadout
	name = "frontier jackboots"
	armor_type = /datum/armor/shoes_jackboots

// mask
/obj/item/clothing/mask/gas/atmos/frontier_colonist/loadout
	armor_type = /datum/armor/mask_gas
	resistance_flags = NONE
	max_filters = 1

