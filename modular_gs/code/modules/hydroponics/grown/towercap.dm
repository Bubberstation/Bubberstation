//extra chopped wood logs
/obj/item/grown/log/gmushroom
	seed = null
	name = "mushroom log"
	desc = "Looks like candy! Do not eat it."
	icon = 'modular_gs/icons/obj/hydroponics/harvest.dmi'
	icon_state = "mushroom_log"
	plank_type = /obj/item/stack/sheet/mineral/gmushroom
	plank_name = "mushroom planks"

/obj/item/grown/log/gmushroom/CheckAccepted(obj/item/I)
	return FALSE

/obj/item/grown/log/shadowtree
	seed = null
	name = "shadow log"
	desc = "A piece of dark log."
	icon = 'modular_gs/icons/obj/hydroponics/harvest.dmi'
	icon_state = "shadow_log"
	plank_type = /obj/item/stack/sheet/mineral/shadoww
	plank_name = "shadow planks"

/obj/item/grown/log/gmushroom/CheckAccepted(obj/item/I)
	return FALSE

/obj/item/grown/log/plasmatree
	seed = null
	name = "plasma tree log"
	desc = "A heavy piece log."
	icon = 'modular_gs/icons/obj/hydroponics/harvest.dmi'
	icon_state = "plasmatree_log"
	plank_type = /obj/item/stack/sheet/mineral/plaswood
	plank_name = "plaswood planks"

/obj/item/grown/log/plasmatree/CheckAccepted(obj/item/I)
	return FALSE
