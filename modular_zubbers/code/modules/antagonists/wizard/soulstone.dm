/obj/item/soulstone/proc/capture_ghost(mob/living/carbon/victim, user)
	var/mob/chosen_one = SSpolling.poll_ghosts_for_target(
		check_jobban = ROLE_CULTIST,
		poll_time = 20 SECONDS,
		checked_target = src,
		ignore_category = POLL_IGNORE_SHADE,
		alert_pic = /mob/living/basic/shade,
		jump_target = src,
		role_name_text = "a shade",
		chat_text_border_icon = /mob/living/basic/shade,
	)
	on_poll_concluded(user, victim, chosen_one)
	return TRUE //it'll probably get someone ;)
