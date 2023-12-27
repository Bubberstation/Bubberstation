/obj/effect/mob_spawn/ghost_role
	var/banned_species //functions similarly to restricted_species, but is instead a list of what NOT to allow.
	
/obj/effect/mob_spawn/ghost_role/attack_ghost(mob/dead/observer/user)
	if(banned_species && (user.client?.prefs?.read_preference(/datum/preference/choiced/species) in banned_species))
		tgui_alert(user, "Current species preference incompatible, did you have the wrong character selected?", "Incompatible Species")
		LAZYREMOVE(ckeys_trying_to_spawn, user.ckey)
		return
	. = ..()

//various skyrat roles
/obj/effect/mob_spawn/ghost_role/human/tarkon
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

/obj/effect/mob_spawn/ghost_role/human/ds2
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

/obj/effect/mob_spawn/ghost_role/human/blackmarket
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

/obj/effect/mob_spawn/ghost_role/human/hotel_staff
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

//Charlie station
/obj/effect/mob_spawn/ghost_role/human/oldeng
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)
/obj/effect/mob_spawn/ghost_role/human/oldsci
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)
/obj/effect/mob_spawn/ghost_role/human/oldsec
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)

//various bubber roles
/obj/effect/mob_spawn/ghost_role/human/dauntless
	banned_species = list(/datum/species/human/felinid/primitive, /datum/species/lizard/ashwalker)
