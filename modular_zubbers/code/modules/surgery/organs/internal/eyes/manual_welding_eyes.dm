//Eyes that you can close
/obj/item/organ/eyes/robotic/manuallyshield
	name = "manually shielded robotic eyes"
	desc = "These eyes will protect you from going blind while welding after you manually activate them."
	icon_state = "eyes_cyber_shield"
	flash_protect = FLASH_PROTECTION_NONE
	pupils_name = "manual shields"
	penlight_message = "have toggleable metal eyelids that are blocking all vision when active"
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	var/active = FALSE
	var/toggle_sound = 'sound/vehicles/mecha/mechmove03.ogg'
	var/currently_toggled = FALSE

/obj/item/organ/eyes/robotic/manuallyshield/ui_action_click()
	if(currently_toggled)
		return

	currently_toggled = TRUE

	if(!do_after(owner, 1 SECONDS))
		to_chat(owner, span_notice("You fail to concentrate on the vision shield toggle."))
		currently_toggled = FALSE
		return

	active = !active
	playsound(get_turf(owner), toggle_sound, 25, TRUE)
	currently_toggled = FALSE

	if(active)
		flash_protect = FLASH_PROTECTION_NONE
		tint = INFINITY
		owner.become_blind(FLASHLIGHT_EYES) //im using flashlight_eyes because you cant have flashlight eyes and those at same time, so i dont have to add another source
	else
		flash_protect = FLASH_PROTECTION_NONE
		tint = 0
		owner.cure_blind(FLASHLIGHT_EYES)

/obj/item/organ/eyes/robotic/manuallyshield/on_mob_remove(mob/living/carbon/removingperson)
	. = ..()
	active = FALSE
	tint = 0
	flash_protect = FLASH_PROTECTION_NONE
	removingperson.cure_blind(FLASHLIGHT_EYES)
