/obj/item/storage/fancy/treat_box
	name = "treat box"
	desc = "A cardboard box used for holding dog treats."
	icon = 'modular_zubbers/icons/obj/food/containers.dmi'
	icon_state = "treatbox"
	spawn_type = /obj/item/food/snacks/dogtreat
	spawn_count = 6
	contents_tag = "dog treats"

/obj/item/storage/fancy/treat_box/Initialize(mapload)
	. = ..()
	atom_storage.set_holdable(list(/obj/item/food/snacks/dogtreat))
