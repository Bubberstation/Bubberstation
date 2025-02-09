/mob/living/basic/pet/cat/syndicat
	name = "Syndie Cat"
	desc = "OH GOD! RUN!! IT CAN SMELL THE DISK!"
	icon = 'icons/mob/simple/pets.dmi'
	held_lh = 'icons/mob/inhands/pets_held_lh.dmi'
	held_rh = 'icons/mob/inhands/pets_held_rh.dmi'
	icon_state = "syndicat"
	icon_living = "syndicat"
	icon_dead = "syndicat_dead"
	held_state = "syndicat"
	health = 80
	maxHealth = 80
	melee_damage_lower = 20
	melee_damage_upper = 35
	ai_controller = /datum/ai_controller/basic_controller/simple_hostile
	faction = list(FACTION_CAT, ROLE_SYNDICATE)

/mob/living/basic/pet/cat/syndicat/Initialize(mapload)
	. = ..()
	var/obj/item/implant/toinstall = list(/obj/item/implant/weapons_auth, /obj/item/implant/explosive)
	for(var/obj/item/implant/original_implants as anything in toinstall)
		var/obj/item/implant/copied_implant = new original_implants.type
		copied_implant.implant(src, silent = TRUE, force = TRUE)
