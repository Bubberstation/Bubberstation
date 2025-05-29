/obj/item/borg/upgrade/feeding_arm
	name = "food gripper module"
	desc = "An extra module that allows cyborgs to grab food and drinks, and feed them to people."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/feeding_arm/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/gripper/food/S = new(R.module)
		R.module.basic_modules += S
		R.module.add_module(S, FALSE, TRUE)

/obj/item/borg/upgrade/feeding_arm/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		var/obj/item/gripper/food/S = locate() in R.module
		R.module.remove_module(S, TRUE)

/obj/item/gripper/food
	name = "food gripper"
	desc = "A simple grasping tool for interacting with various food and drink related items."
	item_flags = NOBLUDGEON

	can_hold = list(
		/obj/item/reagent_containers,
	)
