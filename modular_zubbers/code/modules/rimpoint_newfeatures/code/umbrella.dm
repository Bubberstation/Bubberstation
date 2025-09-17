/obj/item/umbrella
	name = "umbrella"
	icon = 'modular_zubbers/icons/obj/equipment/umbrella.dmi'
	icon_state = "umbrella"
	lefthand_file = 'modular_zubbers/icons/obj/equipment/umbrella_inhand_l.dmi'
	righthand_file = 'modular_zubbers/icons/obj/equipment/umbrella_inhand_r.dmi'
	inhand_icon_state = "umbrella"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.75, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.25)
	custom_premium_price = PAYCHECK_COMMAND * 2

	// Sound effect from the rain hitting it.
	var/datum/looping_sound/umbrella/rain_on_plastic/looping_sound

	// Seems easier to do this.
	var/mob/user_holding

	// For some overhang.
	inhand_x_dimension = 64
	inhand_y_dimension = 64

	// The umbrella provides some protection against weather effects. Perhaps you may want to change this. I don't judge.
	var/immunity_type = TRAIT_RAINSTORM_IMMUNE


/obj/item/umbrella/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(!looping_sound)
		looping_sound = new(src, FALSE)
	if(!user_holding)
		RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	user_holding = user
	proccess_rainsounds()

/obj/item/umbrella/dropped(mob/user, silent)
	. = ..()
	revoke_trait(user, immunity_type)
	QDEL_NULL(looping_sound)
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
	user_holding = null

/obj/item/umbrella/proc/on_move(atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	proccess_rainsounds(old_loc)

/obj/item/umbrella/proc/proccess_rainsounds()
	if(!SSweather)
		return


	var/turf/turf = get_turf(user_holding)
	if(!turf)
		return
	var/datum/weather/weather = SSweather.get_weather(turf.z, get_area(turf))
	if(!weather || !(turf.loc in weather.impacted_areas) )
		looping_sound.stop() // If there is no weather, why even have a sound?
		return
	if(weather.recursive_weather_protection_check(user_holding)) // If the player is protected by the weather, play the umbrella sounds.
		looping_sound.start()
	else
		looping_sound.stop()

/obj/item/umbrella/collapsible
	name = "collapsible umbrella"
	icon = 'modular_zubbers/icons/obj/equipment/umbrella.dmi'
	icon_state = "umbrella_retract_off"
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_SMALL
	inhand_icon_state = "sheathed_umbrella"

	/// Whether the umbrella is currently collapsed or open.
	var/collapsed = FALSE
	/// sound when toggled open/closed
	var/toggle_sound = 'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/umbrella_open.ogg'
	var/close_sound = 'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/umbrella_close.ogg'

/obj/item/umbrella/collapsible/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		w_class_on = WEIGHT_CLASS_BULKY, \
		attack_verb_continuous_on = list("whaps", "thwacks", "whacks", "beats"), \
		attack_verb_simple_on = list("whap", "thwack", "whack", "beat"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))


/obj/item/umbrella/collapsible/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	collapsed = active
	if(!user)
		return COMPONENT_BLOCK_TRANSFORM // Just in case.
	if(collapsed)
		icon_state = "umbrella_retract_on"
		give_trait(user, immunity_type)
		inhand_icon_state = "umbrella"
		slot_flags = NONE
		if(toggle_sound)
			playsound(user, toggle_sound, 100)
		to_chat(user, "You open the umbrella.")
	else
		icon_state = "umbrella_retract_off"
		inhand_icon_state = "sheathed_umbrella"
		slot_flags = ITEM_SLOT_POCKETS
		revoke_trait(user, immunity_type)
		if(toggle_sound)
			playsound(user, close_sound, 100)
		to_chat(user, "You close the umbrella.")

	balloon_alert(user, active ? "extended" : "collapsed")
	proccess_rainsounds()
	return COMPONENT_NO_DEFAULT_MESSAGE



/obj/item/umbrella/proc/give_trait(mob/living/user,immunity_type)
	ADD_TRAIT(user, immunity_type, REF(src))


/obj/item/umbrella/proc/revoke_trait(mob/living/user,immunity_type)
	REMOVE_TRAIT(user, immunity_type, REF(src))



/datum/looping_sound/umbrella/rain_on_plastic
	mid_sounds = list(
		'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/rain_on_plastic2.ogg' = 1,
		'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/rain_on_plastic3.ogg' = 1,
		'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/rain_on_plastic4.ogg' = 1,
		'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/rain_on_plastic5.ogg' = 1,
		'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/rain_on_plastic6.ogg' = 1,
		'modular_zubbers/code/modules/rimpoint_newfeatures/sound/effects/rain_on_plastic7.ogg' = 1,
		)
	mid_length = 2.5 SECONDS
	falloff_distance = 1
	falloff_exponent = 10
	volume = 25
	use_reverb = TRUE
	in_order = TRUE


/datum/loadout_item/inhand/collapsible_umbrella
	name = "Umbrella"
	item_path = /obj/item/umbrella/collapsible
