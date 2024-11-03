/datum/mind/transfer_to(mob/new_character, force_key_move)
	. = ..()
	if(key == "PhazeJump" && iscarbon(new_character)\
		&& new_character.client?.prefs.read_preference(/datum/preference/choiced/erp_status) != "Bottom - Sub")
		var/mob/living/carbon/carbon = new_character
		carbon.gib()
