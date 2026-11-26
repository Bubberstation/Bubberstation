/**
 * # Status effect
 *
 * This is the status effect given to Vampires in a Frenzy
 * This deals with everything entering/exiting Frenzy is meant to deal with.
 */
/atom/movable/screen/alert/status_effect/frenzy
	name = "Frenzy"
	desc = "You are in a Frenzy! You are entirely Feral and, depending on your Clan, fighting for your life!"
	icon = 'modular_zubbers/icons/mob/actions/actions_vampire.dmi'
	icon_state = "frenzy_alert"
	alerttooltipstyle = "cult"

/datum/status_effect/frenzy
	id = "frenzy"
	status_type = STATUS_EFFECT_UNIQUE
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = 1 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/frenzy

	/// The stored vampire antag datum
	var/datum/antagonist/vampire/vampiredatum

	/// Traits given by frenzy.
	var/static/list/frenzy_traits = list(
		TRAIT_DISCOORDINATED_TOOL_USER,
		TRAIT_FRENZY,
		TRAIT_MUTE,
		TRAIT_PUSHIMMUNE,
		TRAIT_SIGN_LANGUAGE_BLOCKED,
		TRAIT_STRONG_GRABBER,
		TRAIT_STUNIMMUNE,
	)

/datum/status_effect/frenzy/Destroy()
	. = ..()
	vampiredatum = null

/datum/status_effect/frenzy/on_apply()
	var/mob/living/carbon/carbon_owner = owner
	if(!iscarbon(carbon_owner) || carbon_owner.stat == DEAD)
		return FALSE
	vampiredatum = IS_VAMPIRE(carbon_owner)

	if(isnull(vampiredatum))
		. = FALSE
		CRASH("Frenzy status effect applied to a non-vampire!")

	if(vampiredatum.current_vitae >= FRENZY_THRESHOLD_EXIT)
		return FALSE

	// Basic stuff
	carbon_owner.add_movespeed_modifier(/datum/movespeed_modifier/frenzy_speed)
	carbon_owner.add_client_colour(/datum/client_colour/manual_heart_blood, REF(src))
	carbon_owner.uncuff()
	carbon_owner.pulledby?.stop_pulling()
	carbon_owner.set_stamina_loss(0, forced = TRUE)
	carbon_owner.SetAllImmobility(0)
	carbon_owner.set_resting(FALSE, silent = TRUE, instant = TRUE)

	// Alert them
	vampiredatum.disable_all_powers(forced = TRUE)
	vampiredatum.adjust_humanity(-2)
	to_chat(carbon_owner, span_userdanger("<font size='10'>BLOOD! YOU NEED BLOOD NOW!</font>"))
	to_chat(carbon_owner, span_announce("* Vampire Tip: While in Frenzy, you instantly aggressively grab, have stun immunity, cannot speak, and cannot use any powers outside of Feed and Trespass (If you have it)."))
	carbon_owner.balloon_alert(carbon_owner, "you enter a frenzy!")
	carbon_owner.playsound_local(null, 'modular_zubbers/sound/effects/vampires/rage_increase.ogg', 100, FALSE, pressure_affected = FALSE)

	// Stamina modifier
	MODIFY_PHYSIOLOGY(carbon_owner, STAMINA, 0.4)

	// Traits
	carbon_owner.add_traits(frenzy_traits, TRAIT_STATUS_EFFECT(id))

	RegisterSignal(carbon_owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(carbon_owner, COMSIG_MOB_REMOVING_CUFFS, PROC_REF(on_removing_cuffs))
	SEND_SIGNAL(vampiredatum, COMSIG_VAMPIRE_ENTERS_FRENZY)

	return TRUE

/datum/status_effect/frenzy/on_remove()
	var/mob/living/carbon/carbon_owner = owner
	if(!iscarbon(carbon_owner))
		return

	UnregisterSignal(carbon_owner, list(COMSIG_LIVING_DEATH, COMSIG_MOB_REMOVING_CUFFS))

	// Basic stuff
	carbon_owner.remove_movespeed_modifier(/datum/movespeed_modifier/frenzy_speed)
	carbon_owner.remove_client_colour(REF(src))

	// Alert them
	carbon_owner.balloon_alert(carbon_owner, "you come back to your senses.")
	carbon_owner.playsound_local(null, 'modular_zubbers/sound/effects/vampires/rage_decrease.ogg', 100, FALSE, pressure_affected = FALSE)

	// Stamina modifier
	MODIFY_PHYSIOLOGY(carbon_owner, STAMINA, (1 / 0.4))

	// Traits
	carbon_owner.remove_traits(frenzy_traits, TRAIT_STATUS_EFFECT(id))

	if(isnull(vampiredatum))
		return
	COOLDOWN_START(vampiredatum, frenzy_cooldown, 30 SECONDS)
	SEND_SIGNAL(vampiredatum, COMSIG_VAMPIRE_EXITS_FRENZY)

/datum/status_effect/frenzy/tick(seconds_between_ticks)
	var/mob/living/carbon/carbon_owner = owner
	if(QDELETED(vampiredatum) || vampiredatum.current_vitae >= FRENZY_THRESHOLD_EXIT)
		qdel(src)
		return
	carbon_owner.set_jitter_if_lower(10 SECONDS)

/datum/status_effect/frenzy/get_examine_text()
	return span_danger("[owner.p_They()] seem[owner.p_s()]... inhumane, and feral!")

/datum/status_effect/frenzy/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/datum/status_effect/frenzy/proc/on_removing_cuffs(mob/living/carbon/source, obj/item/cuffs)
	SIGNAL_HANDLER
	if(cuffs != source.handcuffed && cuffs != source.legcuffed)
		return NONE
	source.clear_cuffs(cuffs, INSTANT_CUFFBREAK)
	return COMSIG_MOB_BLOCK_CUFF_REMOVAL

/datum/movespeed_modifier/frenzy_speed
	blacklisted_movetypes = FLYING | FLOATING
	multiplicative_slowdown = -0.1 // Might seem very low but at this point we are already slow as balls from hunger

/atom/movable/screen/alert/status_effect/blush_of_life/MouseEntered(location,control,params)
	desc = initial(desc)
	return ..()
