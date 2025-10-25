#define MAX_HOARD_SIZE 9

#define HOARD_BAD 200
#define HOARD_OKAY 400
#define HOARD_GOOD 800
#define HOARD_FULL 1000

/datum/quirk/hoarder
	name = "Hoarder"
	desc = "You have a habit of gathering trinkets and putting them all together in a big pile"
	icon = FA_ICON_TRASH
	value = 0
	gain_text = span_notice("You feel like amassing a hoard.")
	lose_text = span_warning("You've lost interest in your hoard.")
	medical_record_text = "Patient has a compulsion to collect and hoard items."

	var/list/hoard_turfs = list()
	var/list/hoard_images = list()
	var/hoard_visible = TRUE
	var/hoard_process_interval = 30 SECONDS
	var/hoard_grace_period = 10 MINUTES

/datum/quirk/hoarder/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/spell/hoard/expand_hoard = new /datum/action/cooldown/spell/hoard()
	expand_hoard.Grant(human_holder)
	expand_hoard.hoard_quirk = src
	var/datum/action/cooldown/spell/toggle_hoard/toggle_hoard = new /datum/action/cooldown/spell/toggle_hoard()
	toggle_hoard.Grant(human_holder)
	toggle_hoard.hoard_quirk = src
	addtimer(CALLBACK(src, PROC_REF(first_hoard_check)), hoard_grace_period)

/datum/quirk/hoarder/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/spell/hoard/expand_hoard = locate(/datum/action/cooldown/spell/hoard) in quirk_holder.actions
	expand_hoard.Remove()
	var/datum/action/cooldown/spell/toggle_hoard/toggle_hoard = locate(/datum/action/cooldown/spell/hoard) in quirk_holder.actions
	toggle_hoard.Remove()

	// clean up overlays if any
	if(quirk_holder?.client && hoard_images)
		for(var/image/I in hoard_images)
			if(I && quirk_holder.client)
				quirk_holder.client.images -= I
				qdel(I)
		hoard_images = list()

	return ..()


// === Hoard Calculation Below ===
/datum/quirk/hoarder/proc/first_hoard_check()
	update_hoard_mood()
	addtimer(CALLBACK(src, PROC_REF(update_hoard_mood)), hoard_process_interval, TIMER_LOOP)

/datum/quirk/hoarder/proc/update_hoard_mood()
	var/mob/living/carbon/human/H = quirk_holder
	if(!H)
		return
	var/value = get_total_hoard_value()
	if (value == 0)
		H.add_mood_event("hoard_value", /datum/mood_event/hoard_none)
		return
	if (value < HOARD_BAD)
		H.add_mood_event("hoard_value", /datum/mood_event/hoard_sparse)
		return
	if (value < HOARD_OKAY)
		H.add_mood_event("hoard_value", /datum/mood_event/hoard_meager)
		return
	if (value < HOARD_GOOD)
		H.add_mood_event("hoard_value", /datum/mood_event/hoard_acceptable)
		return
	if (value < HOARD_FULL)
		H.add_mood_event("hoard_value", /datum/mood_event/hoard_plentiful)
		return
	H.add_mood_event("hoard_value", /datum/mood_event/hoard_overflowing)
	return

/datum/quirk/hoarder/proc/get_total_hoard_value()
	if (!hoard_turfs)
		return 0
	var/final_value = 0
	for (var/turf/T in hoard_turfs)
		var/list/obj/item/hoard_items = T.contents
		for(var/obj/item/trinket in hoard_items)
			final_value += trinket.hoard_value
	return final_value


// === Hoard Expansion code below ===

/datum/action/cooldown/spell/hoard
	name = "Expand Hoard"
	desc = "Make the tile you are standing on part of your hoard"

	button_icon = 'icons/obj/devices/tool.dmi'
	button_icon_state = "multitool"
	cooldown_time = 0 SECONDS
	spell_requirements = NONE

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	var/datum/quirk/hoarder/hoard_quirk = null

/datum/action/cooldown/spell/hoard/cast(atom/cast_on)
	.=..()
	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return FALSE
	if(!hoard_quirk)
		return FALSE

	var/turf/current_turf = get_turf(H)

	//check if turf is already part of hoard, if so remove it
	if (current_turf in hoard_quirk.hoard_turfs)
		hoard_quirk.hoard_turfs -= current_turf
		var/datum/action/cooldown/spell/toggle_hoard/toggle_hoard = locate(/datum/action/cooldown/spell/toggle_hoard) in owner.actions
		toggle_hoard.remove_turf(H, current_turf)
		to_chat(H, span_notice("This turf has been removed from your hoard"))
		return FALSE

	//check if the hoard is already at max size
	if (LAZYLEN(hoard_quirk.hoard_turfs) >= MAX_HOARD_SIZE)
		to_chat(H, span_warning("Your Hoard can't get any bigger!"))
		return FALSE

	//check if this is the first tile of the hoard
	if (!LAZYLEN(hoard_quirk.hoard_turfs))
		var/datum/action/cooldown/spell/toggle_hoard/toggle_hoard = locate(/datum/action/cooldown/spell/toggle_hoard) in owner.actions
		toggle_hoard.add_turf(H, current_turf)
		to_chat(H, span_notice("First Turf Added"))
		return TRUE


	//check if the new tile is adjacent to the existing hoard
	var/adjacent = FALSE
	for (var/turf/T in hoard_quirk.hoard_turfs)
		if(get_dist(current_turf, T) == 1)
			adjacent = TRUE
			break
	if (!adjacent)
		to_chat(H, span_warning("You can only expand your hoard from tiles adjacent to your existing hoard!"))
		return FALSE

	var/datum/action/cooldown/spell/toggle_hoard/toggle_hoard = locate(/datum/action/cooldown/spell/toggle_hoard) in owner.actions
	toggle_hoard.add_turf(H, current_turf)
	to_chat(H, span_notice("Added turf to Hoard"))
	return TRUE



// === Hoard Rendering Code below ===
/datum/action/cooldown/spell/toggle_hoard
	name = "Toggle Hoard Visibility"
	desc = "Toggles the visibility of your hoard tiles"

	button_icon = 'icons/obj/tiles.dmi'
	button_icon_state = "tile"
	cooldown_time = 1 SECONDS
	spell_requirements = NONE
	var/datum/quirk/hoarder/hoard_quirk = null

/datum/action/cooldown/spell/toggle_hoard/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return FALSE

	hoard_quirk.hoard_visible = !hoard_quirk.hoard_visible

	if(!hoard_quirk.hoard_visible)
		_hide_hoard_overlay(H)
		to_chat(H, span_notice("Hoard overlays hidden."))
		return TRUE

	_show_hoard_overlay(H)
	to_chat(H, span_notice("Hoard overlays visible."))
	return TRUE

/datum/action/cooldown/spell/toggle_hoard/proc/_show_hoard_overlay(mob/living/carbon/human/H)

	if(!H?.client)
		return
	if(!hoard_quirk.hoard_turfs)
		return

	_hide_hoard_overlay(H)

	var/icon_path = 'icons/effects/effects.dmi'
	var/icon_state = "target_tile"
	for(var/turf/T in hoard_quirk.hoard_turfs)
		var/image/I = image(icon_path, T, icon_state, HIGH_TURF_LAYER)
		if (!I)
			continue
		I.alpha = 100
		I.color = "#ffaa00"
		I.plane = RENDER_PLANE_GAME
		H.client.images += I
		hoard_quirk.hoard_images += I


/datum/action/cooldown/spell/toggle_hoard/proc/_hide_hoard_overlay(mob/living/carbon/human/H)
	if(!H?.client)
		return
	if(!hoard_quirk.hoard_images)
		return

	for(var/image/I in hoard_quirk.hoard_images)
		H.client.images -= I
		qdel(I)
	hoard_quirk.hoard_images = list()

/datum/action/cooldown/spell/toggle_hoard/proc/add_turf(mob/living/carbon/human/H, turf/new_tile)
	if(!hoard_quirk.hoard_turfs) hoard_quirk.hoard_turfs = list()
	hoard_quirk.hoard_turfs += new_tile

	if(!hoard_quirk.hoard_visible)
		return
	if(!H?.client)
		return

	var/icon_path = 'icons/effects/effects.dmi'
	var/icon_state = "target_tile"
	var/image/I = image(icon_path, new_tile, icon_state, HIGH_TURF_LAYER)
	if (I)
		I.alpha = 100
		I.color = "#ffaa00"
		I.plane = RENDER_PLANE_GAME
		H.client.images += I
		hoard_quirk.hoard_images += I


/datum/action/cooldown/spell/toggle_hoard/proc/remove_turf(mob/living/carbon/human/H, turf/removed_tile)
	if(hoard_quirk.hoard_turfs && (removed_tile in hoard_quirk.hoard_turfs))
		hoard_quirk.hoard_turfs -= removed_tile

	if(!hoard_quirk.hoard_visible || !H?.client || !hoard_quirk.hoard_images)
		return

	for(var/image/I in hoard_quirk.hoard_images)
		if (I && I.loc == removed_tile)
			H.client.images -= I
			hoard_quirk.hoard_images -= I
			qdel(I)
			break


#undef MAX_HOARD_SIZE
#undef HOARD_BAD
#undef HOARD_OKAY
#undef HOARD_GOOD
#undef HOARD_FULL
