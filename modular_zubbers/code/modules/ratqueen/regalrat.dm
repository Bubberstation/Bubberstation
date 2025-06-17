// Adds rat fashion system
/mob/living/basic/regal_rat
	/// What kind of fashion are we rocking
	var/datum/rat_fashion/current_look
	/// Press this to change your rat outfit
	var/datum/action/cooldown/rat_fashion/fashion_select
	gender = PLURAL

/mob/living/basic/regal_rat/Initialize(mapload)
	. = ..()
	fashion_select = new(src)
	fashion_select.Grant(src)
	pick_random_look()

/// Randomise how we look on init
/mob/living/basic/regal_rat/proc/pick_random_look()
	var/list/valid_starting_styles = list()
	for (var/datum/rat_fashion/style_path as anything in subtypesof(/datum/rat_fashion))
		if (!initial(style_path.allow_random))
			continue
		valid_starting_styles += new style_path()
	if (!length(valid_starting_styles))
		return
	current_look = pick(valid_starting_styles)
	current_look.apply(src)


/mob/living/basic/regal_rat/revive(full_heal_flags, excess_healing, force_grab_ghost)
	. = ..()
	if(!.)
		return
	current_look.apply(src)

/mob/living/basic/regal_rat/Destroy()
	QDEL_NULL(fashion_select)
	QDEL_NULL(current_look)
	. = ..()

/// Regal rat swallows sludge to transform themselves into a different looking rat
/datum/action/cooldown/rat_fashion
	name = "Rat King's Transformation"
	desc = "Assume your true form, whatever you decide it is at the moment."
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 10 SECONDS
	melee_cooldown_time = 0 SECONDS
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "exit_possession"
	background_icon_state = "bg_clock"
	overlay_icon_state = "bg_clock_border"

/datum/action/cooldown/rat_fashion/Activate(atom/target)
	var/mob/living/basic/regal_rat/rat_owner = owner
	if (!istype(rat_owner))
		owner.balloon_alert(owner, "not a rat!")
		qdel(src)
		return

	var/list/options = list()
	var/list/picks_to_instances = list()
	var/list/rat_styles = subtypesof(/datum/rat_fashion)
	for (var/style_path as anything in rat_styles)
		var/datum/rat_fashion/style = new style_path()
		var/datum/radial_menu_choice/choice = style.get_radial_select()
		options += list("[choice.name]" = choice)
		picks_to_instances[choice.name] = style

	var/pick = show_radial_menu(owner, owner, options, require_near = TRUE)
	if (!pick)
		return

	var/datum/rat_fashion/chosen = picks_to_instances[pick]
	if (rat_owner.current_look.name == chosen.name)
		owner.balloon_alert(owner, "nothing to change!")
		return

	var/turf/origin = get_turf(owner)
	owner.balloon_alert_to_viewers("shudders...")

	if (!do_after(owner, 3 SECONDS, target = origin))
		owner.balloon_alert(owner, "interrupted!")
		return

	rat_owner.current_look = chosen
	rat_owner.current_look.apply(owner)
	var/obj/effect/particle_effect/fluid/smoke/poof = new(origin)
	poof.lifetime = 2 SECONDS
	poof.color = "#5f5940"
	return ..()

/// Decides how regal rats can look
/datum/rat_fashion/
	var/name = ""
	var/allow_random = TRUE
	var/icon = 'modular_zubbers/icons/mob/rat.dmi'
	var/icon_state_living
	var/icon_state_dead

/// Provides radial menu data
/datum/rat_fashion/proc/get_radial_select()
	var/datum/radial_menu_choice/choice = new()
	choice.name = name
	choice.image = image(icon = icon, icon_state = icon_state_living)
	return choice

/// Make yourself look like this
/datum/rat_fashion/proc/apply(mob/living/simple_animal/rat_target)
	rat_target.icon = icon
	rat_target.icon_living = icon_state_living
	rat_target.icon_dead = icon_state_dead
	if(rat_target.stat == DEAD) // How did you use this while dead?
		rat_target.icon_state = icon_state_dead
	else
		rat_target.icon_state = icon_state_living
	rat_target.update_appearance(updates = UPDATE_ICON)

/// Normal
/datum/rat_fashion/default
	name = "regal rat"
	icon = 'icons/mob/simple/animal.dmi'
	icon_state_living = "regalrat"
	icon_state_dead = "regalrat_dead"

/// Old sprite
/datum/rat_fashion/classic
	name = "retro rat"
	allow_random = FALSE
	icon_state_living = "classic"
	icon_state_dead = "classic_dead"

/// Rat queen (thicc rat)

/datum/rat_fashion/rat_queen
	name = "rat queen"
	allow_random = TRUE
	icon_state_living = "ratqueen"
	icon_state_dead = "ratqueen_dead"

/// Rat queen alt (thicc rat but fat)

/datum/rat_fashion/rat_queen_alt
	name = "rat queen alt"
	allow_random = TRUE
	icon_state_living = "ratqueen_fat"
	icon_state_dead = "ratqueen_dead"

/// Ringmaster (thicc rat but clothed)

/datum/rat_fashion/ringmaster
	name = "ringmaster"
	allow_random = FALSE
	icon_state_living = "ringmaster"
	icon_state_dead = "ratqueen_dead"
