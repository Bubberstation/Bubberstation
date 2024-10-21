/obj/item/organ/external/wings/moth
	name = "moth wings"
	desc = "A pair of fuzzy moth wings."
	flight_for_species = list(SPECIES_MOTH)
	///Our associated shadow jaunt spell, for all nightmares
	var/datum/action/cooldown/spell/touch/moth_climb/our_climb
	///Our associated terrorize spell, for antagonist nightmares
	var/datum/action/cooldown/spell/moth_and_dash/our_dash

/obj/item/organ/external/wings/moth/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	if(ismoth(organ_owner))
		our_climb = new(organ_owner)
		our_climb.Grant(organ_owner)

		our_dash = new(organ_owner)
		our_dash.Grant(organ_owner)

/obj/item/organ/external/wings/moth/on_mob_remove(mob/living/carbon/organ_owner)
	. = ..()
	QDEL_NULL(our_climb)
	QDEL_NULL(our_dash)

/datum/action/cooldown/spell/moth_and_dash
	name = "Flap Wings"
	desc = "Forces your wings to propel you forwards, though exhausting."
	button_icon = 'icons/mob/human/species/moth/moth_wings.dmi'
	button_icon_state = "m_moth_wings_gothic_BEHIND"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	antimagic_flags = NONE
	var/jumpdistance = 5 //-1 from to see the actual distance, e.g 4 goes over 3 tiles
	var/jumpspeed = 3
	var/datum/weakref/dash_action_ref
	COOLDOWN_DECLARE(dash_cooldown)

/datum/action/cooldown/spell/moth_and_dash/Trigger(trigger_flags, action, atom/target)
	if (!isliving(owner))
		return

	var/turf/our_turf = get_turf(owner)
	var/datum/gas_mixture/environment = our_turf.return_air()

	if(environment.return_pressure() < (HAZARD_LOW_PRESSURE))
		to_chat(owner, span_warning("There's far too little air for your wings to work against!"))
		return

	if(owner.incapacitated())
		return

	if(!COOLDOWN_FINISHED(src, dash_cooldown))
		to_chat(owner, span_warning("Your wings are extraordinarily tired, give them some rest!"))
		return

	var/atom/dash_target = get_edge_target_turf(owner, owner.dir) //gets the user's direction

	ADD_TRAIT(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)
	if (owner.throw_at(dash_target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE, callback = TRAIT_CALLBACK_REMOVE(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)))
		playsound(owner, 'sound/voice/moth/moth_flutter.ogg', 50, TRUE, TRUE)
		owner.visible_message(span_warning("[usr] propels themselves forwards with a heavy wingbeat!"))
		COOLDOWN_START(src, dash_cooldown, 6 SECONDS)
		var/mob/living/dash_user = owner
		if(istype(dash_user))
			dash_user.adjustStaminaLoss(40) //Given the risk of flying into things and crashing quite violently, you get four of these. Every one slows you down anyway.
	else
		to_chat(owner, span_warning("Something prevents you from dashing forward!"))

/datum/emote/living/mothic_dash
	key = "mdash"
	key_third_person = "mdash"
	cooldown = 6 SECONDS

/datum/emote/living/mothic_dash/run_emote(mob/living/user, params, type_override, intentional)
	if (ishuman(user) && intentional)
		var/datum/action/cooldown/spell/moth_and_dash/dash_action = locate() in user.actions
		if(dash_action)
			dash_action.Trigger()

	return ..()

/datum/action/cooldown/spell/touch/moth_climb
	name = "Lift Wings"
	desc = "Spreads your wings out to facilitate climbing, though this will be extremely tiring."
	button_icon = 'icons/mob/human/species/moth/moth_wings.dmi'
	button_icon_state = "m_moth_wings_monarch_BEHIND"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	antimagic_flags = NONE

	hand_path = /obj/item/climbing_moth_wings
	draw_message = span_notice("You outstretch your wings, ready to climb upwards.")
	drop_message = span_notice("Your wings tuck back behind you.")

/obj/item/climbing_moth_wings
	name = "outstretched wings"
	desc = "Useful for climbing up onto high places, though tiresome."
	icon = 'icons/mob/human/species/moth/moth_wings.dmi'
	icon_state = "m_moth_wings_monarch_BEHIND"
	var/climb_time = 2.5 SECONDS

/obj/item/climbing_moth_wings/examine(mob/user)
	. = ..()
	var/list/look_binds = user.client.prefs.key_bindings["look up"]
	. += span_notice("Firstly, look upwards by holding <b>[english_list(look_binds, nothing_text = "(nothing bound)", and_text = " or ", comma_text = ", or ")]!</b>")
	. += span_notice("Then, click solid ground adjacent to the hole above you.")

/obj/item/climbing_moth_wings/afterattack(turf/open/target, mob/living/user, proximity_flag, click_parameters)
	. = ..()
	if(target.z == user.z)
		return
	if(!istype(target) || isopenspaceturf(target))
		return

	var/turf/user_turf = get_turf(user)
	var/datum/gas_mixture/environment = user_turf.return_air()
	var/turf/above = GET_TURF_ABOVE(user_turf)
	if(target_blocked(target, above))
		return
	if(environment.return_pressure() < (HAZARD_LOW_PRESSURE))
		to_chat(user, span_warning("There's far too little air for your wings to work against!"))
		return
	if(!isopenspaceturf(above) || !above.Adjacent(target)) //are we below a hole, is the target blocked, is the target adjacent to our hole
		user.balloon_alert(user, "blocked!")
		return

	var/away_dir = get_dir(above, target)
	user.visible_message(span_notice("[user] begins pushing themselves upwards with their wings!"), span_notice("Your wings start fluttering violently as you begin going upwards."))
	playsound(target, 'sound/voice/moth/moth_flutter.ogg', 50) //plays twice so people above and below can hear
	playsound(user_turf, 'sound/voice/moth/moth_flutter.ogg', 50)
	var/list/effects = list(new /obj/effect/temp_visual/climbing_hook(target, away_dir), new /obj/effect/temp_visual/climbing_hook(user_turf, away_dir))

	if(do_after(user, climb_time, target))
		user.forceMove(target)
		user.adjustStaminaLoss(100)
		playsound(user_turf, 'sound/voice/moth/moth_flutter.ogg', 50) //a third time for seasoning
	QDEL_LIST(effects)

/obj/item/climbing_moth_wings/proc/target_blocked(turf/target, turf/above)
	if(target.density || above.density)
		return TRUE

	for(var/atom/movable/atom_content as anything in target.contents)
		if(isliving(atom_content))
			continue
		if(HAS_TRAIT(atom_content, TRAIT_CLIMBABLE))
			continue
		if((atom_content.flags_1 & ON_BORDER_1) && atom_content.dir != get_dir(target, above)) //if the border object is facing the hole then it is blocking us, likely
			continue
		if(atom_content.density)
			return TRUE
	return FALSE
