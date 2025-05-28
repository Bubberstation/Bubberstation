/obj/machinery/drone_dispenser/Initialize(mapload)
	//So that there are starting drone shells in the beginning of the shift
	if(mapload)
		starting_amount = SHEET_MATERIAL_AMOUNT * MAX_STACK_SIZE
	return ..()

/obj/item/card/id/advanced/simple_bot
	//So that the drones can actually access everywhere and fix it
	trim = /datum/id_trim/centcom

/obj/machinery/door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/sliding_under)

//This is so we log all machinery interactions for drones
/obj/machinery/attack_drone(mob/living/basic/drone/user, list/modifiers)
	. = ..()
	user.log_message("[key_name(user)] interacted with [src] at [AREACOORD(src)]", LOG_GAME)

/datum/language_holder/drone //Allows maintenance drones to understand, but not speak, Common.
	understood_languages = list(
		/datum/language/drone = list(LANGUAGE_ATOM),
		/datum/language/common = list(LANGUAGE_ATOM)
	)
	spoken_languages = list(/datum/language/drone = list(LANGUAGE_ATOM))
	blocked_languages = list()

/mob/living/basic/drone
	//So that drones can do things without worrying about stuff
	shy = FALSE
	//So drones aren't forced to carry around a nodrop toolbox essentially
	default_storage = /obj/item/storage/backpack/drone_bag
	//Redefines Law 1 closer to Goonstation's interpretation, sans the non-interference clause. Loosens the laws to let drones fix areas they're directed to, etc.
	laws = \
	"1. You may not hinder the freedom or actions of other beings, nor undo the results of said actions, unless the other being is another Drone.\n"+\
	"2. You may not harm any being, regardless of intent or circumstance.\n"+\
	"3. Your goals are to actively build, maintain, repair, improve, and provide power to the best of your abilities within the facility that housed your activation."
	// Updates flavortext to match the new expectation.
	flavortext = \
	"\n<big><span class='warning'>DO NOT INTERFERE WITH THE ROUND AS A DRONE OR YOU WILL BE DRONE BANNED</span></big>\n"+\
	"<span class='notice'>Drones are a ghost role that are allowed to fix the station and build things. Interfering with the round as a drone is against the rules.</span>\n"+\
	"<span class='notice'>Actions that constitute interference include, but are not limited to:</span>\n"+\
	"<span class='notice'>     - Interacting with round critical objects (IDs, weapons, contraband, powersinks, bombs, etc.)</span>\n"+\
	"<span class='notice'>     - Significantly interacting with living beings (attacking, healing, intentionally opening doors for them, etc.)</span>\n"+\
	"<span class='notice'>     - Interacting with non-living beings (dragging bodies, looting bodies, etc.)</span>\n"+\
	"<span class='warning'>These rules are at admin discretion and will be heavily enforced.</span>\n"+\
	"<span class='warning'><u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u></span>\n"+\
	"<span class='notice'>Prefix your message with :b to speak in Drone Chat.</span>\n"

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	name = "[initial(name)] [rand(0,9)]-[rand(100,999)]" //So that we can identify drones from each other

/obj/item/storage/backpack/drone_bag
	name = "drone backpack"

/obj/item/storage/backpack/drone_bag/PopulateContents()
	. = ..()
	new /obj/item/crowbar(src)
	new /obj/item/wrench(src)
	new /obj/item/screwdriver(src)
	new /obj/item/weldingtool(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/t_scanner(src)
	new /obj/item/analyzer(src)
	new /obj/item/stack/cable_coil(src)

/obj/effect/mob_spawn/ghost_role/drone/derelict/babylon
	desc = "A shell of a maintenance drone, an expendable robot built to perform station repairs."
	you_are_text = "You are a drone on Babylon Station 13."
	mob_type = /mob/living/basic/drone/babylon

/mob/living/basic/drone/babylon
	name = "derelict drone"
	laws = \
		"1. You may not involve yourself in the matters of another sentient being outside the station that housed your activation, even if such matters conflict with Law Two or Law Three, unless the other being is another Drone.\n\
		2. You may not harm any sentient being, regardless of intent or circumstance.\n\
		3. Your goals are to actively build, maintain, repair, improve, and provide power to the best of your abilities within the facility that housed your activation."
	flavortext = \
		"\n<big><span class='warning'>DO NOT WILLINGLY LEAVE BABYLON STATION 13 (THE DERELICT)</span></big>\n\
		<span class='notice'>Derelict drones are a ghost role that is allowed to roam freely on BS13, with the main goal of repairing and improving it.\n\
		Do not interfere with the round going on outside BS13.\n\
		Actions that constitute interference include, but are not limited to:\
		\n     - Going to the main station in search of materials.\
		\n     - Interacting with non-drone players outside BS13, dead or alive.</span>\n\
		<span class='warning'>These rules are at admin discretion and will be heavily enforced.\n \
		<u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u></span>"
	shy = FALSE

/mob/living/basic/drone/babylon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/stationstuck, PUNISHMENT_GIB, "01000110 01010101 01000011 01001011 00100000 01011001 01001111 01010101<br>WARNING: Dereliction of BS13 detected. Self-destruct activated.")

