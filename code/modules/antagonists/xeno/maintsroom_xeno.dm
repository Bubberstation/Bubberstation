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
	explanation_text = "Survive, escape your cell, you remember nothing of time before you came here youve been here for god knows how long- a decade? a century? this place has changed you be it the time the environment of the bioscramblers you are not what you once were."

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

/obj/effect/mob_spawn/ghost_role/beno
	name = "Xenomorph in a coma"
	desc = "They are in a deep sleep but they seem passive, dont hurt them."
	icon = 'icons/effects/effects.dmi'
	icon_state = "eggs"
	show_flavor = TRUE
	you_are_text = "You are a lost xenomorph."
	flavour_text = "You are a lost xenomorph, you are disconnected from the hive and you have been stuck here only god knows how long a decade or two? a century? this place might have changed you due to the intensity of the anomalies or you may be the exact same- you dont remember anything before arriving here as you were born here."
	important_text = "You should nuetral to the crew you are not really an antagonist, THE XENOMORPHS INHERIT THE FLAVOR TEXT/NAME/DESC FROM YOUR CURRENTLY SELECTED CHARACTER."
	faction = list(ROLE_ALIEN)
	role_ban = ROLE_ALIEN
	prompt_ghost = FALSE
	random_appearance = FALSE
	/// Prevents spawning from this mob_spawn until TRUE, set by the egg growing
	ready = TRUE
	cluster_type = /obj/structure/spider/eggcluster/benos
	/// Which antag datum do we grant?
	granted_datum = /datum/antagonist/beno
	/// The types of spiders that the spawner can produce
	potentialspawns = list(
		/mob/living/carbon/alien/adult/skyrat/defender/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/drone/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/runner/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom,
	)

/obj/effect/mob_spawn/ghost_role/beno/pre_ghost_take(mob/dead/observer/user)
	var/chosen_spider = length(potentialspawns) > 1 ? get_radial_choice(user) : potentialspawns[1]
	if(isnull(chosen_beno))
		return FALSE
	mob_type = chosen_beno
	return TRUE

/// Pick a spider type from a radial menu
/obj/effect/mob_spawn/ghost_role/beno/proc/get_radial_choice(mob/user)
	var/list/beno_list = list(
		/mob/living/carbon/alien/adult/skyrat/defender/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/drone/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/runner/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom,
	)
	var/list/display_benos = list(
		/mob/living/carbon/alien/adult/skyrat/defender/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/drone/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/praetorian/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/ravager/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/runner/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/sentinel/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/spitter/maintsroom,
		/mob/living/carbon/alien/adult/skyrat/warrior/maintsroom,
	)
	for(var/choice in potentialspawns)
		beno_list[initial(beno.name)] = chosen_beno

		var/datum/radial_menu_choice/option = new

		display_benos[initial(beno.name)] = option
	sort_list(display_benos)
	return beno_list[chosen_beno]

	var/chosen_beno = show_radial_menu(user, egg, display_benos, radius = 38, require_near = TRUE)
	return beno_list[chosen_beno]
