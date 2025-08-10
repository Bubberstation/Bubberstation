//Plaswood Frames
/obj/structure/table_frame/plaswood
	name = "Plaswood table frame"
	desc = "Four wooden legs with four framing wooden rods for a wooden table. You could easily pass through this."
	icon = 'modular_gs/icons/obj/structures.dmi'
	icon_state = "plaswood_frame"
	framestack = /obj/item/stack/sheet/mineral/plaswood
	framestackamount = 2
	resistance_flags = FLAMMABLE | ACID_PROOF


/*
/obj/structure/table_frame/plaswood/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/stack))
		var/obj/item/stack/material = I
		var/toConstruct // stores the table variant
		if(istype(I, /obj/item/stack/sheet/mineral/plaswood))
			toConstruct = /obj/structure/table/plaswood
		else if(istype(I, /obj/item/stack/tile/carpet))
			toConstruct = /obj/structure/table/plaswood/plaswoodpoker

		if (toConstruct)
			if(material.get_amount() < 1)
				to_chat(user, "<span class='warning'>You need one [material.name] sheet to do this!</span>")
				return
			to_chat(user, "<span class='notice'>You start adding [material] to [src]...</span>")
			if(do_after(user, 20, target = src) && material.use(1))
				make_new_table(toConstruct)
		else
			return ..()
*/

//Mushroom Frames
/obj/structure/table_frame/gmushroom
	name = "mushroom table frame"
	desc = "Four wooden legs with four framing wooden rods for a wooden table. You could easily pass through this."
	icon = 'modular_gs/icons/obj/structures.dmi'
	icon_state = "gmushroom_frame"
	framestack = /obj/item/stack/sheet/mineral/gmushroom
	framestackamount = 2
	resistance_flags = FIRE_PROOF

/*
/obj/structure/table_frame/gmushroom/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/stack))
		var/obj/item/stack/material = I
		var/toConstruct // stores the table variant
		if(istype(I, /obj/item/stack/sheet/mineral/gmushroom))
			toConstruct = /obj/structure/table/gmushroom
		else if(istype(I, /obj/item/stack/tile/carpet))
			toConstruct = /obj/structure/table/gmushroom/gmushroompoker

		if (toConstruct)
			if(material.get_amount() < 1)
				to_chat(user, "<span class='warning'>You need one [material.name] sheet to do this!</span>")
				return
			to_chat(user, "<span class='notice'>You start adding [material] to [src]...</span>")
			if(do_after(user, 20, target = src) && material.use(1))
				make_new_table(toConstruct)
	else
		return ..()
*/


//Shadow Wood Frames
/obj/structure/table_frame/shadoww
	name = "shadow wood frame"
	desc = "Four wooden legs with four framing wooden rods for a wooden table. You could easily pass through this."
	icon = 'modular_gs/icons/obj/structures.dmi'
	icon_state = "shadoww_frame"
	framestack = /obj/item/stack/sheet/mineral/shadoww
	framestackamount = 2
	resistance_flags = FLAMMABLE

/*
/obj/structure/table_frame/shadoww/attackby(obj/item/I, mob/user, params)
	if (istype(I, /obj/item/stack))
		var/obj/item/stack/material = I
		var/toConstruct // stores the table variant
		if(istype(I, /obj/item/stack/sheet/mineral/shadoww))
			toConstruct = /obj/structure/table/shadoww
		else if(istype(I, /obj/item/stack/tile/carpet))
			toConstruct = /obj/structure/table/shadoww/shadowwpoker

		if (toConstruct)
			if(material.get_amount() < 1)
				to_chat(user, "<span class='warning'>You need one [material.name] sheet to do this!</span>")
				return
			to_chat(user, "<span class='notice'>You start adding [material] to [src]...</span>")
			if(do_after(user, 20, target = src) && material.use(1))
				make_new_table(toConstruct)
	else
		return ..()
*/
