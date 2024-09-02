/datum/heretic_knowledge/limited_amount/portal_protection

	name = "Six Portal Body Problem"
	desc = "Allows you to transmute a defibrillator, a map, six hearts, amd six bluespace crystals into the ability to revive and heal all your external damage on death. \
	This only works up to 6 times, and each death gives you a moderate amount of brain damage. \
	Completing the ritual will also reduce your maximum health by 45 as a consequence. \
	The place in which you revive will be the place where you complete the transmutation ritual. Researching this prevents \"Hardcore\" from being researched.\
	Once the ritual is performed, this cannot be reversed!"

	required_atoms = list(
		/obj/item/heretic_map = 1,
		/obj/item/defibrillator = 1,
		/obj/item/organ/internal/heart = 6,
		/obj/item/stack/ore/bluespace_crystal = 6,
	)

	result_atoms = list(
		/obj/item/paper/fluff/good_advice //We need a result here so the limit feature actually works.
	)

	cost = 6
	depth = 8
	route = PATH_SIDE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "portal"

	banned_knowledge = list(/datum/heretic_knowledge/limited_amount/hardcore)

	var/portals_left = 6

	var/max_health_to_take = 45

	var/turf/research_location

	limit = 1

/datum/heretic_knowledge/limited_amount/portal_protection/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	user.maxHealth -= 45
	user.health = min(user.health, user.maxHealth)

	research_location = loc.type

	RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(on_heretic_death))

	to_chat(user,span_velvet("Your body is now imbued with the power of revival. You have [portals_left] [portals_left == 1 ? "revive" :"revives"] left."))



/datum/heretic_knowledge/limited_amount/portal_protection/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_DEATH)



/datum/heretic_knowledge/limited_amount/portal_protection/proc/on_heretic_death(mob/living/user, gibbed)

	SIGNAL_HANDLER

	if(!isliving(user))
		return

	if(user.stat != DEAD) //Uhhhhhh
		return

	if(gibbed || portals_left <= 0) //You're fucked lol.
		return

	portals_left--

	user.visible_message(
		span_userdanger("As [user] takes their last breath, they disappear!"),
		span_userdanger("As you take your last breath, you feel yourself disappearing!")
	)

	if(research_location) //Safety
		do_teleport(
			user,
			research_location,
			no_effects = TRUE,
			channel = TELEPORT_CHANNEL_MAGIC,
			asoundin = 'sound/magic/cosmic_energy.ogg',
			asoundout = 'sound/magic/cosmic_energy.ogg',
		)

	user.revive(
		HEAL_ALL & ~(HEAL_ORGANS|HEAL_REFRESH_ORGANS),
		excess_healing = 100,
		force_grab_ghost  = TRUE
	)

	var/damage_to_deal = round(BRAIN_DAMAGE_DEATH/6,1)
	user.adjustOrganLoss(ORGAN_SLOT_BRAIN,damage_to_deal)

	to_chat(user,span_velvet("You feel your soul getting slammed back into your broken body while it is carried away to safety... you have [portals_left] [portals_left == 1 ? "revive" :"revives"] left!"))

