/*
*	GUN CASE LIDS
*
*	Any gun case whose icon has an "-open" frame shows it while somebody has the case open,
*	and shuts again when the last person stops looking inside.
*	A case with no open frame is left alone, so a new case joins in just by having the sprite.
*/

/obj/item/storage/toolbox/guncase
	/// Are we showing the open lid right now
	var/opened = FALSE
	/// Does our icon have an open frame to swap to. Checked once on init.
	var/has_open_sprite = FALSE

/obj/item/storage/toolbox/guncase/Initialize(mapload)
	. = ..()
	has_open_sprite = ("[initial(icon_state)]-open" in icon_states(icon))

/obj/item/storage/toolbox/guncase/update_icon_state()
	. = ..()
	if(!has_open_sprite)
		return
	if(opened)
		icon_state = "[initial(icon_state)]-open"
	else
		icon_state = initial(icon_state)

// Called by our storage when the first person opens us and when the last one leaves.
// Returns TRUE if the lid actually moved, so our storage knows whether to make a noise about it.
/obj/item/storage/toolbox/guncase/proc/set_lid_open(new_lid_state)
	if(!has_open_sprite || opened == new_lid_state)
		return FALSE
	opened = new_lid_state
	update_appearance(UPDATE_ICON_STATE)
	return TRUE

/datum/storage/toolbox/guncase
	/// How many mobs have us open right now. The lid only shuts when the last one leaves.
	var/lid_viewers = 0
	/// Played when the lid drops shut behind the last person to look inside.
	var/close_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	var/close_sound_vary = TRUE

/datum/storage/toolbox/guncase/show_contents(mob/to_show)
	. = ..()
	if(!. || isobserver(to_show))
		return
	lid_viewers++
	set_lid(TRUE)

/datum/storage/toolbox/guncase/hide_contents(mob/to_hide)
	var/was_viewing = (to_hide.active_storage == src) && !isobserver(to_hide)
	. = ..()
	if(!was_viewing)
		return
	lid_viewers = max(lid_viewers - 1, 0)
	if(lid_viewers)
		return
	// opening already has its own sound, so the lid only needs one on the way back down
	if(set_lid(FALSE) && !silent)
		playsound(parent, close_sound, 50, close_sound_vary, -5)

// TRUE if the lid actually moved.
/datum/storage/toolbox/guncase/proc/set_lid(new_lid_state)
	var/obj/item/storage/toolbox/guncase/case = parent
	if(!istype(case))
		return FALSE
	return case.set_lid_open(new_lid_state)
