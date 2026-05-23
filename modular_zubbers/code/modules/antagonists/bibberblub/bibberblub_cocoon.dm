/obj/effect/mob_spawn/ghost_role/bibberblub
	name = "Slimy Cocoon"
	prompt_name = "bibberblub"
	desc = "It seems to pulse slightly with an inner life."
	icon = 'icons/effects/effects.dmi'
	icon_state = "eggs"
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
