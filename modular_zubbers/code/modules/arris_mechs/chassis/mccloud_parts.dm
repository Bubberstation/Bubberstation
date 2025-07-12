/// PARTS ITEMS
/obj/item/mecha_parts/chassis/mccloud
	name = "\improper McCloud chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/mccloud

/obj/item/mecha_parts/part/mccloud_torso
	name = "\improper McCloud torso"
	desc = "A torso part for a McCloud. It's the basis of the cockpit and life-support systems."
	icon_state = "ripley_harness"

/obj/item/mecha_parts/part/mccloud_left_arm
	name = "\improper McCloud left arm"
	desc = "A McCloud left arm. Data and power sockets are compatible with most exosuit tools."
	icon_state = "ripley_l_arm"

/obj/item/mecha_parts/part/mccloud_right_arm
	name = "\improper McCloud right arm"
	desc = "A McCloud right arm. Data and power sockets are compatible with most exosuit tools."
	icon_state = "ripley_r_arm"

/obj/item/mecha_parts/part/mccloud_left_leg
	name = "\improper McCloud left leg"
	desc = "A McCloud left leg. Jet boosters provide assisted movement in biped mode, and become primary means of locomotion in jet mode."
	icon_state = "ripley_l_leg"

/obj/item/mecha_parts/part/mccloud_right_leg
	name = "\improper McCloud right leg"
	desc = "A McCloud right leg. Jet boosters provide assisted movement in biped mode, and become primary means of locomotion in jet mode."
	icon_state = "ripley_r_leg"

/obj/item/mecha_parts/part/mccloud_armor
	gender = PLURAL
	name = "\improper McCloud armor plates"
	desc = "A set of armor plates designed for the McCloud. Thin, but extremely lightweight."
	icon_state = "gygax_armor"

/obj/item/circuitboard/mecha/mccloud/main
	name = "McCloud Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/mccloud/peripherals
	name = "McCloud Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/mccloud/targeting
	name = "McCloud Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/datum/component/construction/unordered/mecha_chassis/mccloud
	result = /datum/component/construction/mecha/mccloud
	steps = list(
		/obj/item/mecha_parts/part/mccloud_torso,
		/obj/item/mecha_parts/part/mccloud_left_arm,
		/obj/item/mecha_parts/part/mccloud_right_arm,
		/obj/item/mecha_parts/part/mccloud_left_leg,
		/obj/item/mecha_parts/part/mccloud_right_leg
	)

/datum/component/construction/mecha/mccloud
	result = /obj/vehicle/sealed/mecha/mccloud
	base_icon = "phazon"

	circuit_control = /obj/item/circuitboard/mecha/mccloud/main
	circuit_periph = /obj/item/circuitboard/mecha/mccloud/peripherals
	circuit_weapon = /obj/item/circuitboard/mecha/mccloud/targeting

	inner_plating=/obj/item/stack/sheet/plasteel
	inner_plating_amount = 5

	outer_plating=/obj/item/mecha_parts/part/mccloud_armor
	outer_plating_amount=1

/datum/component/construction/mecha/mccloud/get_outer_plating_steps()
	return list(
		list(
			"key" = outer_plating,
			"amount" = 1,
			"action" = ITEM_DELETE,
			"back_key" = TOOL_WELDER,
			"desc" = "Internal armor is welded, [initial(outer_plating.name)] can be used as external armor.",
			"forward_message" = "added external armor layer",
			"backward_message" = "cut off internal armor layer"
		),
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "External armor is installed, and can be <b>wrenched</b> into place.",
			"forward_message" = "secured external armor layer",
			"backward_message" = "pried off external armor"
		),
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "External armor is wrenched, and can be <b>welded</b>.",
			"forward_message" = "welded external armor",
			"backward_message" = "unfastened external armor layer"
		),
		list(
			"key" = /obj/item/stack/sheet/glass,
			"amount" = 15,
			"back_key" = TOOL_WELDER,
			"desc" = "External armor is welded, and 15 sheets of <b>glass</b> could be used to build the cockpit windshield.",
			"icon_state" = "phazon26",
			"forward_message" = "constructed windshield",
			"backward_message" = "cut off external armor"
		),
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "Cockpit windshield is installed, and can be <b>wrenched</b> into place.",
			"forward_message" = "secured external armor layer",
			"backward_message" = "pried off external armor"
		),
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "Cockpit windshield is wrenched, and can be <b>welded</b>.",
			"forward_message" = "welded external armor",
			"backward_message" = "unfastened external armor layer"
		)
	)

/obj/structure/closet/secure_closet/mccloud
	name = "mccloud director's locker"
	req_access = list(ACCESS_RD)
	icon_state = "rd"

/obj/structure/closet/secure_closet/mccloud/PopulateContents()
	..()

	new /obj/item/mecha_parts/part/mccloud_torso(src)
	new /obj/item/mecha_parts/part/mccloud_left_arm(src)
	new /obj/item/mecha_parts/part/mccloud_left_leg(src)
	new /obj/item/mecha_parts/part/mccloud_right_arm(src)
	new /obj/item/mecha_parts/part/mccloud_right_leg(src)
	new /obj/item/circuitboard/mecha/mccloud/main(src)
	new /obj/item/circuitboard/mecha/mccloud/peripherals(src)
	new /obj/item/circuitboard/mecha/mccloud/targeting(src)
