/datum/heretic_knowledge/limited_amount/hardcore

	name = "Hardcore"
	desc = "Allows you to transmute a sheet of titanium, a liver, and an orb of divination into a permanent 55 point health gain. \
	However, when you die, every single item on your person is sent to the void. Researching this prevents \"Six Portal Body Problem\" from being researched. \
	Once the ritual is performed, this cannot be reversed!"

	required_atoms = list(
		/obj/item/stack/ore/titanium = 1,
		/obj/item/organ/internal/liver = 1,
		/obj/item/heretic_currency/divination = 1
	)

	cost = 3
	depth = 8
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "portal"

	limit = 1

	banned_knowledge = list(/datum/heretic_knowledge/limited_amount/portal_protection)

	var/max_health_to_add = 55

/datum/heretic_knowledge/limited_amount/hardcore/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)

	. = ..()

	user.maxHealth += max_health_to_add
	user.health += max_health_to_add

	RegisterSignal(user, COMSIG_LIVING_DEATH, PROC_REF(on_heretic_death))


/datum/heretic_knowledge/limited_amount/hardcore/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	. = ..()
	UnregisterSignal(user, COMSIG_LIVING_DEATH)

/datum/heretic_knowledge/limited_amount/hardcore/proc/on_heretic_death(mob/living/carbon/human/user, gibbed)

	SIGNAL_HANDLER

	if(!ishuman(user))
		return

	if(user.stat != DEAD) //Uhhhhhh
		return

	if(gibbed) //You're fucked lol.
		return

	//Stolen from die of fate code.
	for(var/obj/item/non_implant in user)
		if(istype(non_implant, /obj/item/implant))
			continue
		qdel(non_implant)

	user.visible_message(
		span_userdanger("Everything [user] was holding and wearing disappears!"),
		span_userdanger("Everything you were holding and wearing disappears!")
	)
