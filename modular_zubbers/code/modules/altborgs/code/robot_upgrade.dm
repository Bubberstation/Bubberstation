/obj/item/borg/upgrade/transform/ntjack
	name = "borg module picker (Centcom)"
	desc = "Allows you to to turn a cyborg into a experimental nanotrasen cyborg."
	icon_state = "cyborg_upgrade3"
	new_model = /obj/item/robot_model/centcom

/obj/item/borg/upgrade/transform/ntjack/action(mob/living/silicon/robot/cyborg, user = usr)
	return ..()
