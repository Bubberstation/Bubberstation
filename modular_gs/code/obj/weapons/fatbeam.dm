/obj/item/gun/medbeam/fattening // GS13
	name = "Fatbeam Gun"
	desc = "Apparently used to treat malnourished patients from a safe distance... But we all know what it will truly be used for."
	icon = 'modular_gs/icons/obj/weapons/fatbeam.dmi'
	icon_state = "fatbeam"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/medbeam/fattening/on_beam_tick(var/mob/living/target)
	if(!target?.client?.prefs?.read_preference(/datum/preference/toggle/weight_gain_weapons))
		return

	new /obj/effect/temp_visual/heal(get_turf(target), "#fabb62")
	target.nutrition += 50

