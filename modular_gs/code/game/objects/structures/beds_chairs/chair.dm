//Shadow
/obj/structure/chair/shadoww
	name = "shadow wood chair"
	desc = "Fashionable dark."
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "shadoww_chair"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstacktype = /obj/item/stack/sheet/mineral/shadoww
	buildstackamount = 3
	item_chair = /obj/item/chair/shadoww

//Plaswood
/obj/structure/chair/plaswood
	name = "plaswood chair"
	desc = "Hard but confortable to sit."
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "plaswood_chair"
	resistance_flags = FLAMMABLE | ACID_PROOF
	max_integrity = 90
	buildstacktype = /obj/item/stack/sheet/mineral/plaswood
	buildstackamount = 3
	item_chair = /obj/item/chair/plaswood

//Mushroom
/obj/structure/chair/gmushroom
	name = "mushroom chair"
	desc = "You don't need to worry about losing your seat in case of fire!"
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "gmushroom_chair"
	resistance_flags = FIRE_PROOF
	max_integrity = 70
	buildstacktype = /obj/item/stack/sheet/mineral/gmushroom
	buildstackamount = 3
	item_chair = /obj/item/chair/gmushroom

//Toppled chairs
/obj/item/chair/shadoww
	name = "shadow wood chair"
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "shadoww_chair_toppled"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	hitsound = 'sound/items/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/shadoww

/obj/item/chair/plaswood
	name = "plaswood chair"
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "plaswood_chair_toppled"
	resistance_flags = FLAMMABLE | ACID_PROOF
	max_integrity = 90
	hitsound = 'sound/items/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/plaswood

/obj/item/chair/gmushroom
	name = "mushroom chair"
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "gmushroom_chair_toppled"
	resistance_flags = FIRE_PROOF
	max_integrity = 70
	hitsound = 'sound/items/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/gmushroom
