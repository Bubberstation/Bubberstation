/datum/action/innate/pai/shell/holo_leashed
	name = "Toggle Leash"
	button_icon_state = "template"
	background_icon_state = "bg_tech"
	overlay_icon_state = "bg_tech_border"

/datum/action/innate/pai/shell/Holo_leashed/Trigger(trigger_flags)
	if(!pai_owner.holoform)
		if(pai_owner.holo_leash)
			pai_owner.balloon_alert(src, "Emitters set to Move")
			pai_owner.holo_leash = FALSE
		else
			pai_owner.balloon_alert(src, "Emitters set to Project")
			pai_owner.holo_leash = TRUE
	else
		pai_owner.balloon_alert(src, "You cannot reconfigure your emitters while they are active!")
