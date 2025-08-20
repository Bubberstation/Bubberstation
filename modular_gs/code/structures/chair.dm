/obj/structure/chair/foldingchair
	name = "folding chair"
	desc = "A collapsible folding chair."
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "chair_fold"
	color = "#ffffff"
	item_chair = ""

/obj/structure/chair/mountchair
	name = "mounted chair"
	desc = "A chair mounted to the floor, this aint going anywhere!"
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "mounted_chair"
	color = "#ffffff"
	item_chair = ""

/obj/structure/chair/sofachair
	name = "sofa chair"
	desc = "A leather sofa chair."
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "sofachair"
	color = "#ffffff"
	item_chair = ""

/obj/structure/chair/sofachair/GetArmrest()
	return mutable_appearance('modular_gs/icons/obj/chairs.dmi', "sofachair_armrest")

/obj/structure/chair/sofachair/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/chair/sofachair/post_buckle_mob(mob/living/M)
	. = ..()
	update_armrest()

/obj/structure/chair/sofachair/update_armrest()
	if(has_buckled_mobs())
		add_overlay(armrest)
	else
		cut_overlay(armrest)

/obj/structure/chair/sofachair/post_unbuckle_mob()
	. = ..()
	update_armrest()

/obj/structure/chair/sofachair/Initialize()

	armrest = GetArmrest()
	armrest.layer = ABOVE_MOB_LAYER
	return ..()

/* uhoh - we are going to have to port over items from hyper.
/obj/structure/rack/shelf
	name = "shelving"
	desc = "Some nice metal shelves."
	icon = 'hyperstation/icons/obj/objects.dmi'
	icon_state = "shelf"
*/

/obj/structure/chair/beanbag
	name = "beanbag chair"
	desc = "A comfy beanbag chair. Almost as soft as your fat ass."
	icon = 'modular_gs/icons/obj/chairs.dmi'
	icon_state = "beanbag"
	color = "#ffffff"
	anchored = FALSE
	buildstacktype = /obj/item/stack/sheet/cloth
	buildstackamount = 5
	item_chair = null

/obj/structure/chair/beanbag/gato
	name = "GATO beanbag chair"
	desc = "A comfy beanbag chair. This one seems to a super duper cutesy GATO mascot."
	icon_state = "beanbag_gato"


//beanbag chair colors
/obj/structure/chair/beanbag/red
	color = "#8b2e2e"

/obj/structure/chair/beanbag/blue
	color = "#345bbc"

/obj/structure/chair/beanbag/green
	color = "#76da4b"

/obj/structure/chair/beanbag/purple
	color = "#a83acf"

/obj/structure/chair/beanbag/black
	color = "#404040"
