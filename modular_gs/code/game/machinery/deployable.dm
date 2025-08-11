#define SINGLE "single"
#define VERTICAL "vertical"
#define HORIZONTAL "horizontal"

#define METAL 1
#define WOOD 2
#define SAND 3

/obj/structure/barricade/shadoww //GS13 wood barricades
	name = "Shadow barricade"
	desc = "This space is blocked off by a shadow wood barricade."
	icon = 'modular_gs/icons/obj/structures.dmi'
	icon_state = "shadowwbarricade"
	max_integrity = 50
	bar_material = WOOD
	var/drop_amount = 3

/*
/obj/structure/barricade/shadoww/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/stack/sheet/mineral/shadoww))
		var/obj/item/stack/sheet/mineral/shadoww/W = I
		if(W.amount < 5)
			to_chat(user, "<span class='warning'>You need at least five shadown planks to make a wall!</span>")
			return
		else
			to_chat(user, "<span class='notice'>You start adding [I] to [src]...</span>")
			if(do_after(user, 50, target=src))
				W.use(5)
				new /turf/closed/wall/mineral/shadoww/nonmetal(get_turf(src))
				qdel(src)
				return
	return ..()
*/

/obj/structure/barricade/shadoww/make_debris()
	new /obj/item/stack/sheet/mineral/shadoww(get_turf(src), drop_amount)


/obj/structure/barricade/plaswood
	name = "Plaswood barricade"
	desc = "This space is blocked off by a plaswood barricade."
	icon = 'modular_gs/icons/obj/structures.dmi'
	icon_state = "plaswoodwbarricade"
	max_integrity = 180
	bar_material = WOOD
	var/drop_amount = 3

/*
/obj/structure/barricade/plaswood/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/stack/sheet/mineral/plaswood))
		var/obj/item/stack/sheet/mineral/plaswood/W = I
		if(W.amount < 5)
			to_chat(user, "<span class='warning'>You need at least five plaswood planks to make a wall!</span>")
			return
		else
			to_chat(user, "<span class='notice'>You start adding [I] to [src]...</span>")
			if(do_after(user, 50, target=src))
				W.use(5)
				new /turf/closed/wall/mineral/plaswood/nonmetal(get_turf(src))
				qdel(src)
				return
	return ..()
*/

/obj/structure/barricade/plaswood/make_debris()
	new /obj/item/stack/sheet/mineral/plaswood(get_turf(src), drop_amount)


/obj/structure/barricade/gmushroom
	name = "Mushroom barricade"
	desc = "This space is blocked off by a mushroom barricade."
	icon = 'modular_gs/icons/obj/structures.dmi'
	icon_state = "gmushroombarricade"
	max_integrity = 50
	bar_material = WOOD
	var/drop_amount = 3

/*
/obj/structure/barricade/gmushroom/attackby(obj/item/I, mob/user)
	if(istype(I,/obj/item/stack/sheet/mineral/gmushroom))
		var/obj/item/stack/sheet/mineral/gmushroom/W = I
		if(W.amount < 5)
			to_chat(user, "<span class='warning'>You need at least five mushroom planks to make a wall!</span>")
			return
		else
			to_chat(user, "<span class='notice'>You start adding [I] to [src]...</span>")
			if(do_after(user, 50, target=src))
				W.use(5)
				new /turf/closed/wall/mineral/gmushroom/nonmetal(get_turf(src))
				qdel(src)
				return
	return ..()
*/

/obj/structure/barricade/gmushroom/make_debris()
	new /obj/item/stack/sheet/mineral/gmushroom(get_turf(src), drop_amount)

//GS13 wood barricades
