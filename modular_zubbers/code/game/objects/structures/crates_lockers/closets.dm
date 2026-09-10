/obj/structure/closet/examine(mob/user)
	. = ..()
	if(isobserver(user))
		. += span_info("It contains: [english_list(contents)].")

// Funny little closet for Lizard Gas.
/obj/structure/closet/lizardgas
	name = "Lizard Gas closet"
	desc = "Aww that's cute. Now get back to work."
	icon = 'modular_zubbers/icons/obj/storage/closet.dmi'
	icon_state = "lizgas"
	icon_door = "lizgas"

/obj/structure/closet/lizardgas/PopulateContents()
	..()
	var/list/items_inside = list(
		/obj/item/clothing/head/beret/lizardgas = 2,
		/obj/item/clothing/suit/apron/chef/colorable_apron/lizardgas = 2,
		/obj/item/storage/backpack/satchel/lizardgas = 2)
	generate_items_inside(items_inside,src)
