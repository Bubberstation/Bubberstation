/obj/item/borg/apparatus/paper_manipulator
	name = "paperwork manipulation apparatus"
	desc = "An apparatus for carrying, deploying, and manipulating sheets of paper."
	icon_state = "borg_stack_apparatus"
	storable = list(/obj/item/paper)

//Research cyborg apparatus
/obj/item/borg/apparatus/research
	name = "Research manipulation gripper"
	desc = "A simple grasping tool suited to assist in a wide array of research applications."
	icon = 'modular_zubbers/code/modules/borgs/sprites/robot_items.dmi'
	icon_state = "gripper_sci"
	storable = list(
					/obj/item/slime_extract,
					/obj/item/slimepotion,
					/obj/item/disk,
					/obj/item/stock_parts,
					/obj/item/reagent_containers/cup/beaker,
					/obj/item/assembly/prox_sensor,
					/obj/item/healthanalyzer, //To build medibots
					/obj/item/borg_restart_board, //To allow repairs
					/obj/item/borg/upgrade/rename, //Basics not an upgrade
					/obj/item/relic,
					/obj/item/mod,
					/obj/item/reagent_containers/syringe,
					/obj/item/reagent_containers/dropper,
					)

/obj/item/borg/apparatus/research/examine()
	. = ..()
	if(stored)
		. += "The gripper currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")

/obj/item/borg/apparatus/circuit_sci
	name = "Research circuit assembly gripper"
	desc = "A complex grasping tool used for working with circuitry."
	icon = 'modular_zubbers/code/modules/borgs/sprites/robot_items.dmi'
	icon_state = "gripper_circ"
	storable = list(
					/obj/item/circuitboard,
					/obj/item/compact_remote,
					/obj/item/controller,
					/obj/item/multitool/circuit,
					/obj/item/integrated_circuit,
					/obj/item/circuit_component,
					/obj/item/usb_cable,
					)

/obj/item/borg/apparatus/circuit_sci/examine()
	. = ..()
	if(stored)
		. += "The gripper currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")

/obj/item/borg/apparatus/circuit_sci/pre_attack(atom/atom, mob/living/user, params) // copy and paste
	if(istype(atom, /obj/item/ai_module) && !stored) //If an admin wants a borg to upload laws, who am I to stop them? Otherwise, we can hint that it fails
		to_chat(user, span_warning("This circuit board doesn't seem to have standard robot apparatus pin holes. You're unable to pick it up."))
	return ..()

//Illegal gripper to allow research cyborgs when hacked to do further robotics work
/obj/item/borg/apparatus/illegal
	name = "Sketchy looking gripper"
	desc = "A tool used to expanded robotics work"
	icon_state = "connector"
	storable = list(
					/obj/item/mmi,
					/obj/item/assembly/flash, //to build borgs,
					/obj/item/bodypart/arm/left/robot,
					/obj/item/bodypart/arm/right/robot,
					/obj/item/bodypart/leg/left/robot,
					/obj/item/bodypart/leg/right/robot,
					/obj/item/bodypart/chest/robot,
					/obj/item/bodypart/head/robot,
					/obj/item/borg/upgrade/ai, //Shell makeing
					)
/obj/item/borg/apparatus/illegal/examine()
	. = ..()
	if(stored)
		. += "The apparatus currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")

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

/obj/item/borg/apparatus/sheet_manipulator/Initialize()
	. = ..()
	storable += /obj/item/stack/rods
