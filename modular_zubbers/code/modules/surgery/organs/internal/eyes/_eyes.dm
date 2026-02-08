/obj/item/organ/eyes/shadekin
	name = "shadekin eyes"
	desc = "These eyes are massive, and feel warm to the touch. The shadekin that's missing these is probably feeling very queasy."
	eye_icon = 'modular_zubbers/icons/mob/human/human_face.dmi'
	eye_icon_state = "shadekin_eyes"
	icon_state = "eyes_moth"	//i'm too lazy to give them their own sprite
	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	iris_overlay = null
	lighting_cutoff = LIGHTING_CUTOFF_MEDIUM

/obj/item/organ/eyes/vulpkanin
	name = "vulpkanin eyes"
	desc = "These eyes seem adept at seeing in low light environments, not that the vulpkanin missing them can see anything right now."

	flash_protect = FLASH_PROTECTION_SENSITIVE
	blink_animation = FALSE
	iris_overlay = null
	lighting_cutoff = LIGHTING_CUTOFF_LOW

/obj/item/organ/eyes/robotic/multitool_act(mob/living/user, obj/item/tool)
	. = ..()
	// Choose left and right eye color
	to_chat(user, span_notice("Changing Eye Color: Pressing 'Cancel' or closing out the window will return the eye's current color."))
	eye_color_left = tgui_color_picker(user, "Pick a new color", "Left Eye Color", eye_color_left)
	eye_color_right = tgui_color_picker(user, "Pick a new color", "Right Eye Color", eye_color_right)
