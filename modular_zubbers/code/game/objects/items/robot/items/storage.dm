/obj/item/borg/apparatus/paper_manipulator
	name = "paperwork manipulation apparatus"
	desc = "An apparatus for carrying, deploying, and manipulating sheets of paper."
	icon_state = "borg_stack_apparatus"
	storable = list(/obj/item/paper)

//Research cyborg apparatus
/obj/item/borg/apparatus/research
	name = "Research manipulation gripper"
	desc = "A simple grasping tool suited to assist in a wide array of research applications."
	icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/robot_items.dmi'
	icon_state = "gripper_sci"
	storable = list(
					/obj/item/slime_extract,
					/obj/item/slimepotion,
					/obj/item/disk/data,
					/obj/item/disk/design_disk,
					/obj/item/disk/tech_disk,
					/obj/item/computer_disk,//ordinance
					/obj/item/stock_parts,
					/obj/item/reagent_containers/cup/beaker,
					/obj/item/healthanalyzer, //To build medibots
					/obj/item/borg_restart_board, //To allow repairs
					/obj/item/borg/upgrade/rename, //Basics not an upgrade
					/obj/item/relic,
					/obj/item/mod,
					/obj/item/reagent_containers/syringe,
					/obj/item/reagent_containers/dropper,
					/obj/item/food/monkeycube,
					)

/obj/item/borg/apparatus/research/examine()
	. = ..()
	if(stored)
		. += "The gripper currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")

//To build funny little gadgets

/obj/item/borg/apparatus/circuit_sci
	name = "Research circuit assembly gripper"
	desc = "A complex grasping tool used for working with circuitry."
	icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/robot_items.dmi'
	icon_state = "gripper_circ"
	storable = list(
					/obj/item/circuitboard,
					/obj/item/compact_remote,
					/obj/item/controller,
					/obj/item/multitool/circuit,
					/obj/item/integrated_circuit,
					/obj/item/circuit_component,
					/obj/item/usb_cable,
					/obj/item/assembly/signaler,
					/obj/item/healthanalyzer, //To build medibots
					/obj/item/assembly/prox_sensor,
					/obj/item/electronics,
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
					/obj/item/assembly, //unrestricted assembly building
					/obj/item/bodypart/arm/left/robot,
					/obj/item/bodypart/arm/right/robot,
					/obj/item/bodypart/leg/left/robot,
					/obj/item/bodypart/leg/right/robot,
					/obj/item/bodypart/chest/robot,
					/obj/item/bodypart/head/robot,
					/obj/item/borg/upgrade/ai, //Shell making
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

/obj/item/borg/apparatus/tank_manipulator/update_overlays()
	. = ..()
	var/mutable_appearance/arm = mutable_appearance(icon = icon, icon_state = "borg_beaker_apparatus")
	if(stored)
		stored.pixel_x = 0
		stored.pixel_y = 0
		var/mutable_appearance/stored_copy = new /mutable_appearance(stored)
		stored_copy.layer = FLOAT_LAYER
		stored_copy.plane = FLOAT_PLANE
		. += stored_copy
	else
		arm.pixel_y = arm.pixel_y - 5
	. += arm

/obj/item/robot_model/syndicatejack/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/robot_model/ninja_saboteur/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/robot_model/engineering/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/robot_model/saboteur/Initialize(mapload)
	basic_modules += list(
		/obj/item/borg/apparatus/tank_manipulator,
		/obj/item/borg/apparatus/engineering,
	)
	. = ..()

/obj/item/borg/apparatus/sheet_manipulator/Initialize()
	. = ..()
	storable += /obj/item/stack/rods

//Engineering cyborg apparatus
/obj/item/borg/apparatus/engineering
	name = "Engineering manipulation gripper"
	desc = "A simple grasping tool for interacting with various engineering related items, such as circuits, gas tanks, conveyer belts and more."
	icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/robot_items.dmi'
	icon_state = "gripper"
	storable = list(
					/obj/item/vending_refill,
					/obj/item/stack/tile,
					/obj/item/light,
					/obj/item/stack/conveyor,
					/obj/item/conveyor_switch_construct,
					/obj/item/wallframe,
					/obj/item/tank,
					)

/obj/item/borg/apparatus/mining/examine()
	. = ..()
	if(stored)
		. += "The gripper currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")
