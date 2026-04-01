/datum/action/item_action/adjust/papermask
	name = "Adjust paper mask"
	desc = "LMB: Change mask face. RMB: Adjust mask."

/datum/action/item_action/adjust/papermask/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/obj/item/clothing/mask/paper/paper_mask = target
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		paper_mask.adjust_mask(usr)
	else
		paper_mask.check_pen(usr)

/obj/item/clothing/mask/paper
	name = "paper mask"
	desc = "It's true. Once you wear a mask for so long, you forget about who you are. Wonder if that happens with shitty paper ones."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "mask_paper"
	clothing_flags = MASKINTERNALS
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	interaction_flags_click = NEED_DEXTERITY
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/adjust/papermask)
	custom_materials = list(/datum/material/paper = SHEET_MATERIAL_AMOUNT * 1.25)

	/// Whether or not the mask is currently being layered over (or under!) hair. FALSE/null means the mask is layered over the hair (this is how it starts off).
	var/wear_hair_over
	/// Whether or not the strap is currently hidden or visible
	var/strap_hidden

/obj/item/clothing/mask/paper/Initialize(mapload)
	. = ..()
	if(wear_hair_over)
		alternate_worn_layer = BACK_LAYER
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/paper_mask, infinite = TRUE)
	RegisterSignal(src, COMSIG_CLICK_ALT, PROC_REF(check_pen))
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/paper_mask
	abstract_type = /datum/atom_skin/paper_mask

/datum/atom_skin/paper_mask/blank
	preview_name = "Blank"
	new_icon_state = "mask_paper"

/datum/atom_skin/paper_mask/neutral
	preview_name = "Neutral"
	new_icon_state = "mask_neutral"

/datum/atom_skin/paper_mask/eye
	preview_name = "Eye"
	new_icon_state = "mask_eye"

/datum/atom_skin/paper_mask/sleepy
	preview_name = "Sleep"
	new_icon_state = "mask_sleep"

/datum/atom_skin/paper_mask/heart
	preview_name = "Heart"
	new_icon_state = "mask_heart"

/datum/atom_skin/paper_mask/core
	preview_name = "Core"
	new_icon_state = "mask_core"

/datum/atom_skin/paper_mask/plus
	preview_name = "Plus"
	new_icon_state = "mask_plus"

/datum/atom_skin/paper_mask/square
	preview_name = "Square"
	new_icon_state = "mask_square"

/datum/atom_skin/paper_mask/bullseye
	preview_name = "Bullseye"
	new_icon_state = "mask_bullseye"

/datum/atom_skin/paper_mask/vertical
	preview_name = "Vertical"
	new_icon_state = "mask_vertical"

/datum/atom_skin/paper_mask/horizontal
	preview_name = "Horizontal"
	new_icon_state = "mask_horizontal"

/datum/atom_skin/paper_mask/x
	preview_name = "X"
	new_icon_state = "mask_x"

/datum/atom_skin/paper_mask/bug
	preview_name = "Bug"
	new_icon_state = "mask_bug"

/datum/atom_skin/paper_mask/double
	preview_name = "Double"
	new_icon_state = "mask_double"

/datum/atom_skin/paper_mask/mark
	preview_name = "Mark"
	new_icon_state = "mask_mark"

/datum/atom_skin/paper_mask/line
	preview_name = "Line"
	new_icon_state = "mask_line"

/datum/atom_skin/paper_mask/minus
	preview_name = "Minus"
	new_icon_state = "mask_minus"

/datum/atom_skin/paper_mask/four
	preview_name = "Four"
	new_icon_state = "mask_four"

/datum/atom_skin/paper_mask/diamond
	preview_name = "Diamond"
	new_icon_state = "mask_diamond"

/datum/atom_skin/paper_mask/cat
	preview_name = "Cat"
	new_icon_state = "mask_cat"

/datum/atom_skin/paper_mask/big_eye
	preview_name = "Big Eye"
	new_icon_state = "mask_bigeye"

/datum/atom_skin/paper_mask/good
	preview_name = "Good"
	new_icon_state = "mask_good"

/datum/atom_skin/paper_mask/bad
	preview_name = "Bad"
	new_icon_state = "mask_bad"

/datum/atom_skin/paper_mask/happy
	preview_name = "Happy"
	new_icon_state = "mask_happy"

/datum/atom_skin/paper_mask/sad
	preview_name = "Sad"
	new_icon_state = "mask_sad"

/obj/item/clothing/mask/paper/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!strap_hidden)
		. += mutable_appearance(icon_file, "mask_paper_strap")

/obj/item/clothing/mask/paper/click_alt_secondary(mob/user)
		adjust_mask(user)

/obj/item/clothing/mask/paper/item_ctrl_click(mob/user)
	. = ..()
	if(.)
		return
	if(user.can_perform_action(src, NEED_DEXTERITY))
		adjust_strap(user)

/obj/item/clothing/mask/paper/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Change Mask Face"
	context[SCREENTIP_CONTEXT_ALT_RMB] = "Adjust Mask"
	context[SCREENTIP_CONTEXT_CTRL_LMB] = "Hide/Show Strap"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/mask/paper/proc/check_pen(datum/source, mob/user)
	SIGNAL_HANDLER
	if(!user.is_holding_item_of_type(/obj/item/pen))
		balloon_alert(user, "must be holding a pen!")
		return CLICK_ACTION_BLOCKING
	return NONE

/obj/item/clothing/mask/paper/proc/on_reskin(datum/source, skin_name)
	SIGNAL_HANDLER
	var/mob/living/carbon/carbon_user
	if(ismob(loc) && iscarbon(loc))
		carbon_user = loc
	if(carbon_user && carbon_user.wear_mask == src)
		carbon_user.update_worn_mask()

/obj/item/clothing/mask/paper/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated)
		var/is_worn = user.wear_mask == src
		wear_hair_over = !wear_hair_over
		if(wear_hair_over)
			alternate_worn_layer = BACK_LAYER
			to_chat(user, "You [is_worn ? "" : "will "]sweep your hair over the mask.")
		else
			alternate_worn_layer = initial(alternate_worn_layer)
			to_chat(user, "You [is_worn ? "" : "will "]sweep your hair under the mask.")

		user.update_worn_mask()

/obj/item/clothing/mask/paper/proc/adjust_strap(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated)
		var/is_worn = user.wear_mask == src
		strap_hidden = !strap_hidden
		to_chat(user, "You [is_worn ? "" : "will "][strap_hidden ? "hide" : "show"] the mask strap.")

		user.update_worn_mask()

// Because alternate_worn_layer can potentially get reset on unequipping the mask (ex: for 'Top' snouts), let's make sure we don't lose it our settings
/obj/item/clothing/mask/paper/dropped(mob/living/carbon/human/user)
	var/prev_alternate_worn_layer = alternate_worn_layer
	. = ..()
	alternate_worn_layer = prev_alternate_worn_layer
