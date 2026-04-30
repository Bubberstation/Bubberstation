/datum/heretic_knowledge/rifle_ammo
	drafting_cost = 1

/obj/item/gun/ballistic/rifle/lionhunter/examine(mob/user)
	. = ..()

	. += span_notice("A weapon of Mansus-nature, the lionhunter can fire through walls, as well as lock-on to give the projectile tracking and \
	teleport the Acolyte towards their target on impact.")
