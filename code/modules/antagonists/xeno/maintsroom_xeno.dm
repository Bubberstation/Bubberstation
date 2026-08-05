/datum/team/beno
	name = "Lost Aliens"

/datum/antagonist/beno
	name = "Lost Xenomorph"
	pref_flag = ROLE_ALIEN
	show_in_antagpanel = FALSE
	antagpanel_category = ANTAG_GROUP_XENOS
	show_to_ghosts = TRUE

/datum/antagonist/beno/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/beno/forge_objectives()
	var/datum/objective/maints_benos/objective = new
	objective.owner = owner
	objectives += objective

/datum/objective/maints_benos

/datum/objective/maints_benos/New()
	explanation_text = "Escape your cell and survive. You remember nothing of time before you came here. You've been here for god knows how long-- A decade? A century? This place has changed you. Be it the time, the environment, or the bioscramblers. You are not what you once were."

/obj/effect/mob_spawn/ghost_role/beno
	name = "Comatose Xenomorph"
	desc = "They are in a deep sleep but they seem passive, don't hurt them."
	icon = 'icons/effects/effects.dmi'
	icon_state = "eggs"
	show_flavor = TRUE
	you_are_text = "You are a lost xenomorph."
	flavour_text = "You are a lost xenomorph. You are disconnected from the hive and have been stuck here. Only god knows how long -- a decade or two? A century? This place might have changed you due to the intensity of the anomalies, or you may be the exact same. All you remember is that you were born here."
	important_text = "You should be neutral to the crew. You are not really an antagonist. When you load in you will be presented with two pop-ups to choose your name and description. These will be your xenomorph's name and flavor text/description. Along with this, if you choose any caste, except for the ravager and runner, you will get hands."
	faction = list(ROLE_ALIEN)
	role_ban = ROLE_ALIEN
	prompt_ghost = FALSE
	random_appearance = FALSE
	/// Which antag datum do we grant?
	var/granted_datum = /datum/antagonist/beno
	/// The types of xenomorphs that the spawner can produce, these ones cannot evolve.
	var/list/potentialspawns = list(
		/mob/living/carbon/alien/adult/skyrat/defender/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/drone/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/runner/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom,
	)
	var/new_mob_name = "Dingus"
	var/new_mob_desc = "A normal looking xenomorph"

//try building
/obj/effect/mob_spawn/ghost_role/beno/proc/get_radial_choice(mob/user)
	var/list/beno_list = list()
	var/list/display_benos = list()
	for(var/mob/living/carbon/alien/beno as anything in potentialspawns)
		beno_list[initial(beno.name)] = beno
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(beno.icon), icon_state = initial(beno.icon_state))//like this or would i want to just smack this right on the line above?
		display_benos[initial(beno.name)] = option
		sort_list(display_benos)

	var/chosen_beno = show_radial_menu(user, src, display_benos, radius = 70, require_near = TRUE)
	return beno_list[chosen_beno]

/obj/effect/mob_spawn/ghost_role/beno/pre_ghost_take(mob/dead/observer/user)
	// time 2 call beno_name & beno_desc
	// call it here either after or before <-----------
	var/chosen_beno = length(potentialspawns) > 1 ? get_radial_choice(user) : potentialspawns[1]
	if(isnull(chosen_beno))
		return FALSE
	mob_type = chosen_beno

	new_mob_name = initial(new_mob_name)
	new_mob_name = sanitize_name(tgui_input_text(user, "Set your name.", new_mob_name, max_length = MAX_NAME_LEN))

	new_mob_desc = initial(new_mob_desc)
	new_mob_desc = tgui_input_text(user, "Set your description.", new_mob_desc, max_length = MAX_MESSAGE_LEN)

	return TRUE

/obj/effect/mob_spawn/ghost_role/beno/special(mob/living/spawned_mob, mob/mob_possessor, apply_prefs)
	. = ..()
	spawned_mob.real_name = new_mob_name
	spawned_mob.name = new_mob_name
	var/mob/living/carbon/carbon_mob = spawned_mob
	carbon_mob.desc = new_mob_desc

/mob/living/carbon/alien/adult/skyrat/drone/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/defender/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/runner/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)

/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom/mind_initialize()
	..()
	if(mind.has_antag_datum(/datum/antagonist/xeno))
		mind.remove_antag_datum(/datum/antagonist/xeno)
