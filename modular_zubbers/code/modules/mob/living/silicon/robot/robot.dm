//Ported from NOVA.
//if a Cyborg clicks a hat, they try to put it on
/obj/item/clothing/head/attack_robot_secondary(mob/living/silicon/robot/user, list/modifiers)
	. = ..()
	if(. != SECONDARY_ATTACK_CALL_NORMAL)
		return

	if(!Adjacent(user))
		return

	balloon_alert(user, "picking up hat...")
	if(!do_after(user, 3 SECONDS, src))
		return
	if(QDELETED(src) || !Adjacent(user) || user.incapacitated)
		return
	user.place_on_head(src)
	balloon_alert(user, "picked up hat")

// if a borg right clicks themself, they try to drop their hat
/mob/living/silicon/robot/attack_robot_secondary(mob/user, list/modifiers)
	. = ..()
	if(. != SECONDARY_ATTACK_CALL_NORMAL)
		return

	if(user != src || isnull(hat))
		return

	balloon_alert(user, "dropping hat...")
	if(!do_after(user, 3 SECONDS, src))
		return
	if(QDELETED(src) || !Adjacent(user) || user.incapacitated || isnull(hat))
		return
	hat.forceMove(get_turf(src))
	hat = null
	update_icons()
	balloon_alert(user, "dropped hat")
