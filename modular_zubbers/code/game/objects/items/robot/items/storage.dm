/obj/item/borg/apparatus/paper_manipulator
	name = "paperwork manipulation apparatus"
	desc = "An apparatus for carrying, deploying, and manipulating sheets of paper."
	icon_state = "borg_stack_apparatus"
	storable = list(/obj/item/paper)

//Research cyborg apparatus
/obj/item/borg/apparatus/research
	name = "research manipulation apparatus"
	desc = "A simple grasping tool suited to assist in a wide array of research applications."
	icon = 'modular_zubbers/modules/borgs/sprites/robot_items.dmi'
	icon_state = "gripper_sci"
	storable = list(
					/obj/item/circuitboard,
					/obj/item/slime_extract,
					/obj/item/slimepotion,
					/obj/item/disk,
					/obj/item/mmi,
					/obj/item/stock_parts,
					/obj/item/reagent_containers/cup/beaker,
					/obj/item/assembly/prox_sensor,
					/obj/item/healthanalyzer, //to build medibots
					)
/obj/item/borg/apparatus/research/examine()
	. = ..()
	if(stored)
		. += "The apparatus currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")

/obj/item/borg/apparatus/research/pre_attack(atom/atom, mob/living/user, params) // copy and paste
	if(istype(atom, /obj/item/ai_module) && !stored) //If an admin wants a borg to upload laws, who am I to stop them? Otherwise, we can hint that it fails
		to_chat(user, span_warning("This circuit board doesn't seem to have standard robot apparatus pin holes. You're unable to pick it up."))
	return ..()

/obj/item/borg/apparatus/mech
	name = "Exosuit manipulation apparatus"
	desc = "A large, heavy-duty grasping tool used in construction of mechs."
	icon = 'modular_zubbers/modules/borgs/sprites/robot_items.dmi'
	icon_state = "gripper_mech"
	storable = list(
					/obj/item/mecha_parts/part,
					/obj/item/mecha_parts/mecha_equipment,
					/obj/item/mecha_parts/mecha_tracking
				)
/obj/item/borg/apparatus/mech/examine()
	. = ..()
	if(stored)
		. += "The apparatus currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")

//Illegal gripper to allow cyborgs when hacked to do further robotics work
/obj/item/borg/apparatus/illegal
	name = "research manipulation apparatus"
	desc = "A simple grasping tool suited to assist in a wide array of research applications."
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
					)
/obj/item/borg/apparatus/illegal/examine()
	. = ..()
	if(stored)
		. += "The apparatus currently has [stored] secured."
	. += span_notice(" <i>Alt-click</i> will drop the currently held item. ")
