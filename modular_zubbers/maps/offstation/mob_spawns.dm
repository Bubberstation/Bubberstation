/obj/effect/mob_spawn/ghost_role
	/// List of species which cannot be chosen to spawn with. Mutually exclusive with restricted species.
	var/banned_species
/obj/effect/mob_spawn/ghost_role/human
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

/obj/effect/mob_spawn/ghost_role/attack_ghost(mob/dead/observer/user)
	if(!restricted_species && banned_species && (user.client?.prefs?.read_preference(/datum/preference/choiced/species) in banned_species))
		tgui_alert(user, "Current species preference incompatible, did you have the wrong character selected?", "Incompatible Species")
		LAZYREMOVE(ckeys_trying_to_spawn, user.ckey)
		return
	. = ..()

//why are the demihumans called "catgirl" anyways? what about catboys?
//null just in case blanking doesnt work
/obj/effect/mob_spawn/ghost_role/human/ash_walker
	banned_species = null
/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl
	banned_species = null
//For the record, I knew making it default to denying would lead to this oversight. Fiksed. Icecats and ashliz can spawn on cafe now.
/obj/effect/mob_spawn/ghost_role/human/ghostcafe
	banned_species = null
