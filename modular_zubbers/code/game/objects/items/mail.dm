/obj/item/paper/fluff/junkmail_generic
	icon = 'modular_zubbers/icons/obj/service/advertisements.dmi'
	var/static/list/random_icon_states = list(
		"pinkpage", "honk", "sunmag", null,
		"paper"
	)

/obj/item/paper/fluff/junkmail_generic/Initialize(mapload)
	. = ..()
	icon_state = pick(random_icon_states)
