
/turf/closed/indestructible
	/// The material this wall should look like.
	var/obj/item/stack/sheet_type = /obj/item/stack/sheet/plasteel

/turf/closed/indestructible/Initialize(mapload)
	if(sheet_type && !custom_wall)
		set_materials(sheet_type)
	. = ..()

/turf/closed/indestructible/wood
	sheet_type = /obj/item/stack/sheet/mineral/wood

/turf/closed/indestructible/weeb
	custom_wall = TRUE

/turf/closed/indestructible/syndicate
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium

/turf/closed/indestructible/stone
	sheet_type = /obj/item/stack/sheet/mineral/stone

/turf/closed/indestructible/splashscreen
	custom_wall = TRUE

/turf/closed/indestructible/sandstone
	sheet_type = /obj/item/stack/sheet/mineral/sandstone

/turf/closed/indestructible/rock
	custom_wall = TRUE

/turf/closed/indestructible/riveted

/turf/closed/indestructible/riveted/boss
	custom_wall = TRUE

/turf/closed/indestructible/riveted/hierophant
	custom_wall = TRUE

/turf/closed/indestructible/reinforced

/turf/closed/indestructible/paper
	custom_wall = TRUE

/turf/closed/indestructible/opshuttle
	custom_wall = TRUE

/turf/closed/indestructible/opsglass
	custom_wall = TRUE

/turf/closed/indestructible/oldshuttle
	custom_wall = TRUE

/turf/closed/indestructible/necropolis
	custom_wall = TRUE

/turf/closed/indestructible/meat
	custom_wall = TRUE

/turf/closed/indestructible/iron
	sheet_type = /obj/item/stack/sheet/iron

/turf/closed/indestructible/hotelwall

/turf/closed/indestructible/hoteldoor
	custom_wall = TRUE

/turf/closed/indestructible/grille // Who the fuck would use this?
	custom_wall = TRUE

/turf/closed/indestructible/fakeglass
	custom_wall = TRUE

/turf/closed/indestructible/fakedoor
	custom_wall = TRUE

/turf/closed/indestructible/cult
	sheet_type = /obj/item/stack/sheet/runed_metal

/turf/closed/indestructible/binary
	custom_wall = TRUE

/turf/closed/indestructible/baseturfs_ded
	custom_wall = TRUE

/turf/closed/indestructible/alien
	sheet_type = /obj/item/stack/sheet/mineral/abductor

/turf/closed/indestructible/abductor // Oh fuck this subtype is awful
	custom_wall = TRUE
