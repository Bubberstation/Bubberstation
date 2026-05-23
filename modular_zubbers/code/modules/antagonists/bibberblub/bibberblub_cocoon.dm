/obj/structure/bibberblub/cocoon
	name = "Slimy Cocoon"
	icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	desc = "There's something alive in there, and sooner or later it's going to find its way out."
	icon_state = "Cocoon"
	max_integrity = 15
	/// Mob spawner handling the actual spawn of the spider
	var/obj/effect/mob_spawn/ghost_role/bibberblub/spawner

/obj/structure/bibberblub/cocoon/Initialize(mapload)
	pixel_x = base_pixel_x + rand(3,-3)
	pixel_y = base_pixel_y + rand(3,-3)
	return ..()

/obj/structure/bibberblub/cocoon/Destroy()
	if(spawner)
		QDEL_NULL(spawner)
	return ..()

/obj/structure/bibberblub/cocoon/attack_ghost(mob/user)
	if(spawner)
		spawner.attack_ghost(user)
	return ..()


/obj/effect/mob_spawn/ghost_role/bibberblub
	name = "Slimy Cocoon"
	prompt_name = "bibberblub"
	desc = "It seems to pulse slightly with an inner life."
	icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	icon_state = "Cocoon"
	move_resist = MOVE_FORCE_NORMAL
	density = FALSE
	show_flavor = FALSE
	you_are_text = "You are a Bibberblub."
	flavour_text = "Steal food and make a mess! You are an awful little pest that the crew wants dead, so act the part. "
	important_text = "Follow your directives at all costs."
	faction = list(FACTION_MAINT_CREATURES)
	role_ban = ROLE_ALIEN
	uses = 4
	mob_type = /mob/living/basic/bibberblub
	///Physical structure housing this spawner
	var/obj/structure/bibberblub/cocoon/cocoon

/obj/effect/mob_spawn/ghost_role/bibberblub/examine(mob/user)
	. = ..()
	. += "It seems to harbor [uses] creatures inside"

/obj/effect/mob_spawn/ghost_role/bibberblub/Initialize(mapload)
	. = ..()
	notify_ghosts(
			"A new Bibberblub cocoon has been created! Pester the Crew!",
			source = src,
			header = "Nuisence!",
			click_interact = TRUE,
			notify_flags = NOTIFY_CATEGORY_NOFLASH,
		)
	cocoon = new (get_turf(loc))
	cocoon.spawner = src
	forceMove(cocoon)

/obj/effect/mob_spawn/ghost_role/bibberblub/Destroy()
	qdel(cocoon)
	cocoon = null
	return ..()

