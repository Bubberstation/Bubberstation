/obj/structure/prop/ship_wreck
	name = "Wreck"
	desc = "The shattered remains of a spacecraft, its hull torn apart by some catastrophic event."
	icon = 'modular_zvents/icons/structures/props/tgmc/urbanrandomprops.dmi'
	icon_state = "ship_wreck_nofire"
	base_icon_state = "ship_wreck_nofire"

	var/burning_time = 10 MINUTES
	var/heat_power = 5 KILO JOULES
	var/target_temperature = T0C + 40
	light_range = 3
	light_color = COLOR_FIRE_LIGHT_RED

	pixel_x = -16
	pixel_y = -16

/obj/structure/prop/ship_wreck/Initialize(mapload)
	. = ..()
	if(burning_time <= 0)
		return
	icon_state = "ship_wreck"
	AddComponent(/datum/component/heat_source, \
	_heat_output = 3, \
	_heat_power = heat_power, \
	_range = 1, \
	_target_temperature = target_temperature)
	addtimer(CALLBACK(src, PROC_REF(stop_fire)), burning_time)


/obj/structure/prop/ship_wreck/proc/stop_fire()
	icon_state = "ship_wreck_nofire"
	light_range = 0
	heat_power = 0
	update_light()
	qdel(GetComponent(/datum/component/heat_source))



/obj/structure/prop/stalagmite
	name = "Stalagmite"
	desc = "A jagged rock formation rising from the cave floor, shaped by eons of dripping minerals."
	icon = 'modular_zvents/icons/structures/props/tgmc/urban/deco.dmi'
	icon_state = "stalagmite"
	base_icon_state = "stalagmite"


/obj/structure/prop/stalagmite/style_1
	icon_state = "stalagmite1"

/obj/structure/prop/stalagmite/style_2
	icon_state = "stalagmite2"

/obj/structure/prop/stalagmite/style_3
	icon_state = "stalagmite3"

/obj/structure/prop/stalagmite/style_4
	icon_state = "stalagmite4"

/obj/structure/prop/stalagmite/style_5
	icon_state = "stalagmite5"

/obj/structure/prop/stalagmite/style_random/Initialize(mapload)
	. = ..()
	icon_state = "stalagmite[rand(1, 5)]"


/obj/structure/bonfire/start_burning()
	. = ..()
	AddComponent(/datum/component/heat_source, \
	_heat_output = 3, \
	_heat_power = (5 KILO JOULES), \
	_range = 3, \
	_target_temperature = (T0C + 45))

/obj/structure/bonfire/extinguish()
	. = ..()
	qdel(GetComponent(/datum/component/heat_source))


/obj/item/flashlight/flare/ignition(mob/user)
	. = ..()
	if(!.)
		return
	AddComponent(/datum/component/heat_source, \
	_heat_output = 1, \
	_heat_power = (2 JOULES), \
	_range = 1, \
	_target_temperature = (T0C + 38))

/obj/item/flashlight/flare/turn_off()
	. = ..()
	qdel(GetComponent(/datum/component/heat_source))
