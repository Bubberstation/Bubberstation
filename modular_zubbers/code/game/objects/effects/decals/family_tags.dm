GLOBAL_LIST(gang_tags)

/obj/effect/decal/cleanable/crayon/gang
	name = "Leet Like Jeff K gang tag"
	desc = "Looks like someone's claimed this area for Leet Like Jeff K."
	icon = 'icons/obj/antags/gang/tags.dmi'
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	var/datum/team/gang/my_gang

/obj/effect/decal/cleanable/crayon/gang/Initialize(mapload, main, type, e_name, graf_rot, alt_icon = null)
	. = ..()
	LAZYADD(GLOB.gang_tags, src)

/obj/effect/decal/cleanable/crayon/gang/Destroy()
	LAZYREMOVE(GLOB.gang_tags, src)
	return ..()
