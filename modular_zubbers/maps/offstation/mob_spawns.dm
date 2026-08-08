/obj/effect/mob_spawn/ghost_role
	/// List of species which cannot be chosen to spawn with. Mutually exclusive with restricted species.
	var/banned_species
/obj/effect/mob_spawn/ghost_role/human
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

//why are the demihumans called "catgirl" anyways? what about catboys?
//null just in case blanking doesnt work
/obj/effect/mob_spawn/ghost_role/human/ash_walker
	banned_species = null
/obj/effect/mob_spawn/ghost_role/human/primitive_catgirl
	banned_species = null
//For the record, I knew making it default to denying would lead to this oversight. Fiksed. Icecats and ashliz can spawn on cafe now.
/obj/effect/mob_spawn/ghost_role/human/ghostcafe
	banned_species = null
