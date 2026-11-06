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

/mob/living/silicon/robot/shell/get_status_tab_items()
	. = ..()
	. += "Connected cyborgs: [length(mainframe.connected_robots)]"
	for(var/r in mainframe.connected_robots)
		var/mob/living/silicon/robot/connected_robot = r
		var/robot_status = "Nominal"
		if(connected_robot.shell)
			robot_status = "AI SHELL"
		else if(IS_UNCONSCIOUS_OR_CRIT(connected_robot) || !connected_robot.client)
			robot_status = "OFFLINE"
		else if(!connected_robot.cell || connected_robot.cell.charge <= 0)
			robot_status = "DEPOWERED"
		//Name, Health, Battery, Model, Area, and Status! Everything an AI wants to know about its borgies!
		. += list(list("[connected_robot.name]: ",
			"S.Integrity: [connected_robot.health]% | \
			Cell: [connected_robot.cell ? "[display_energy(connected_robot.cell.charge)]/[display_energy(connected_robot.cell.maxcharge)]" : "Empty"] | \
			Model: [connected_robot.designation] | Loc: [get_area_name(connected_robot, TRUE)] | \
			Status: [robot_status]",
			"src=[REF(src)];track_cyborg=[text_ref(connected_robot)]",
		))
