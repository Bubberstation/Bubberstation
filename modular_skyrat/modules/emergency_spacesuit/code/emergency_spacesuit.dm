#define EMERGENCY_SUIT_MIN_TEMP_PROTECT 237
#define EMERGENCY_SUIT_MAX_TEMP_PROTECT 100
#define EMERGENCY_HELMET_MIN_TEMP_PROTECT 2.0
#define EMERGENCY_HELMET_MAX_TEMP_PROTECT 100

// The suit
/obj/item/clothing/suit/space/emergency
	name = "emergency space suit"
	desc = "A fragile looking emergency spacesuit for limited use in space."
	icon_state = "syndicate-orange"
	inhand_icon_state = "syndicate-orange"
	heat_protection = NONE
	min_cold_protection_temperature = EMERGENCY_SUIT_MIN_TEMP_PROTECT
	max_heat_protection_temperature = EMERGENCY_SUIT_MAX_TEMP_PROTECT
	armor_type = /datum/armor/space_emergency
	clothing_flags = STOPSPRESSUREDAMAGE | SNUG_FIT
	actions_types = null
	show_hud = FALSE
	max_integrity = 100
	slowdown = 3
	/// Have we been damaged?
	var/torn = FALSE

/datum/armor/space_emergency
	bio = 20

/obj/item/clothing/suit/space/emergency/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(user_damaged))

/obj/item/clothing/suit/space/emergency/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_APPLY_DAMAGE)

/obj/item/clothing/suit/space/emergency/proc/user_damaged(datum/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER
	if(damage && !torn && prob(50))
		balloon_alert_to_viewers("[src] tears!")
		clothing_flags &= ~STOPSPRESSUREDAMAGE
		torn = TRUE
		playsound(src, 'sound/weapons/slashmiss.ogg', 50, TRUE)
		playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
		update_appearance()


/obj/item/clothing/suit/space/emergency/update_name(updates)
	. = ..()
	if(torn)
		name = "torn [src]"

/obj/item/clothing/suit/space/emergency/examine(mob/user)
	. = ..()
	if(torn)
		. += span_danger("It looks torn and useless!")


// The helmet
/obj/item/clothing/head/helmet/space/emergency
	name = "emergency space helmet"
	desc = "A fragile looking emergency spacesuit helmet for limited use in space."
	icon_state = "syndicate-helm-orange"
	inhand_icon_state = "syndicate-helm-orange"
	heat_protection = NONE
	armor_type = /datum/armor/space_emergency
	flash_protect = 0
	clothing_flags = STOPSPRESSUREDAMAGE | SNUG_FIT
	min_cold_protection_temperature = EMERGENCY_HELMET_MIN_TEMP_PROTECT
	max_heat_protection_temperature = EMERGENCY_HELMET_MAX_TEMP_PROTECT

#undef EMERGENCY_HELMET_MIN_TEMP_PROTECT
#undef EMERGENCY_HELMET_MAX_TEMP_PROTECT
#undef EMERGENCY_SUIT_MIN_TEMP_PROTECT
#undef EMERGENCY_SUIT_MAX_TEMP_PROTECT

// Lil box to hold em in

/obj/item/storage/box/emergency_spacesuit
	name = "emergency space suit case"
	desc =  "A small case containing an emergency space suit and helmet."
	icon = 'modular_skyrat/modules/more_briefcases/icons/briefcases.dmi'
	icon_state = "briefcase_suit"
	illustration = null

/obj/item/storage/box/emergency_spacesuit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_BULKY
	atom_storage.max_slots = 2
	atom_storage.set_holdable(list(
		/obj/item/clothing/head/helmet/space/emergency,
		/obj/item/clothing/suit/space/emergency,
		))

/obj/item/storage/box/emergency_spacesuit/PopulateContents()
	new /obj/item/clothing/head/helmet/space/emergency(src)
	new /obj/item/clothing/suit/space/emergency(src)
