/obj/item/borg/apparatus/paper_manipulator
	name = "paperwork manipulation apparatus"
	desc = "An apparatus for carrying, deploying, and manipulating sheets of paper."
	icon_state = "borg_stack_apparatus"
	storable = list(/obj/item/paper)

/obj/item/borg/apparatus/tank_manipulator
	name = "tank manipulation apparatus"
	desc = "An apparatus for carrying and manipulating handheld tanks."
	icon_state = "borg_beaker_apparatus"
	storable = list(/obj/item/tank)

/obj/item/robot_model/syndicatejack/New(...)
	. = ..()
	basic_modules += /obj/item/borg/apparatus/tank_manipulator

/obj/item/robot_model/ninja_saboteur/New(...)
	. = ..()
	basic_modules += /obj/item/borg/apparatus/tank_manipulator

/obj/item/robot_model/engineering/New(...)
	. = ..()
	basic_modules += /obj/item/borg/apparatus/tank_manipulator

/obj/item/robot_model/saboteur/New(...)
	. = ..()
	basic_modules += /obj/item/borg/apparatus/tank_manipulator
