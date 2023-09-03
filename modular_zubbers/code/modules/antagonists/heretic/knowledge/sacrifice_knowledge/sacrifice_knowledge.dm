#define SACRIFICE_SLEEP_DURATION 20 SECONDS

/datum/heretic_knowledge/hunt_and_sacrifice/proc/begin_sacrifice(mob/living/carbon/human/sac_target)

	. = FALSE

	var/datum/antagonist/heretic/our_heretic = heretic_mind?.has_antag_datum(/datum/antagonist/heretic)
	if(!our_heretic)
		CRASH("[type] - begin_sacrifice was called, and no heretic [heretic_mind ? "antag datum":"mind"] could be found!")

	var/turf/safe_station_turf = get_safe_random_station_turf_light(/area/station/service/chapel)

	if(!safe_station_turf) //Can't find a good chapel spot. Just throw them on the station hallways.
		safe_station_turf = get_safe_random_station_turf_light(/area/station/hallway)

	if(!safe_station_turf) //Find a safe lit chapel spot. Just find a normal one, I guess.
		safe_station_turf = get_safe_random_station_turf(/area/station/service/chapel)

	if(!safe_station_turf) //Just throw them on the station hallways, I guess!
		safe_station_turf = get_safe_random_station_turf(/area/station/hallway)

	if(!safe_station_turf) //Okay. Something is clearly wrong.
		var/obj/effect/landmark/observer_start/backup_loc = locate(/obj/effect/landmark/observer_start) in GLOB.landmarks_list
		safe_station_turf = get_turf(backup_loc)

	var/obj/item/organ/internal/heart/sac_heart = sac_target.get_organ_slot(ORGAN_SLOT_HEART)
	if(!sac_heart)
		to_chat(heretic_mind.current, span_red("Egads! They don't have a heart to sacrifice!?"))
		return
	else
		heretic_mind.current.visible_message(span_danger("[heretic_mind.current] pulls [sac_heart] out of [sac_target]!"), span_danger("You pull [sac_heart] out of [sac_target]!"))
		heretic_mind.current.put_in_hands(sac_heart)
		sac_heart.Remove(sac_target)
		ADD_TRAIT(sac_target, TRAIT_STABLEHEART, MAGIC_TRAIT)
		sac_target.spawn_gibs()

	sac_target.apply_necropolis_curse(CURSE_BLINDING | CURSE_GRASPING)
	sac_target.visible_message(span_danger("[sac_target] begins to shudder violenty as dark tendrils begin to drag them into thin air!"))
	sac_target.set_handcuffed(new /obj/item/restraints/handcuffs/energy/cult(sac_target))
	sac_target.update_handcuffed()
	sac_target.do_jitter_animation()

	log_combat(heretic_mind.current, sac_target, "sacrificed")

	addtimer(CALLBACK(sac_target, TYPE_PROC_REF(/mob/living/carbon, do_jitter_animation)), SACRIFICE_SLEEP_DURATION * (1/3))
	addtimer(CALLBACK(sac_target, TYPE_PROC_REF(/mob/living/carbon, do_jitter_animation)), SACRIFICE_SLEEP_DURATION * (2/3))

	if(sac_target.AdjustUnconscious(SACRIFICE_SLEEP_DURATION))
		to_chat(sac_target, span_hypnophrase("Your mind feels torn apart as you fall into a shallow slumber..."))
	else
		to_chat(sac_target, span_hypnophrase("Your mind begins to tear apart as you watch dark tendrils envelop you."))

	sac_target.AdjustParalyzed(SACRIFICE_SLEEP_DURATION * 1.2)
	sac_target.AdjustImmobilized(SACRIFICE_SLEEP_DURATION * 1.2)

	addtimer(CALLBACK(src, PROC_REF(after_target_sleeps), sac_target, safe_station_turf), SACRIFICE_SLEEP_DURATION) // Wake up!

	return TRUE


/datum/heretic_knowledge/hunt_and_sacrifice/proc/after_target_sleeps(mob/living/carbon/human/sac_target, turf/destination)

	if(QDELETED(sac_target))
		return

	sac_target.remove_status_effect(/datum/status_effect/necropolis_curse)
	sac_target.adjust_stutter(40 SECONDS)

	// Send 'em to the destination. If it fucks up, just keep them dead.
	if(!destination || !do_teleport(sac_target, destination, asoundin = 'sound/magic/repulse.ogg', asoundout = 'sound/magic/blind.ogg', no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC, forced = TRUE))
		return

	if(heretic_mind?.current)
		var/composed_return_message = ""
		composed_return_message += span_notice("Your victim, [sac_target], was returned to a safe place - ")
		if(sac_target.stat == DEAD)
			composed_return_message += span_red("dead. ")
		else
			composed_return_message += span_green("alive. ")

		composed_return_message += span_notice("You hear a whisper... ")
		composed_return_message += span_hypnophrase(get_area_name(destination, TRUE))
		to_chat(heretic_mind.current, composed_return_message)

	var/obj/effect/visible_heretic_influence/illusion = new(destination)
	illusion.name = "\improper weakened rift in reality"
	illusion.desc = "A rift wide enough for something... or someone... to come through."
	illusion.color = COLOR_DARK_RED

	sac_target.gain_trauma(/datum/brain_trauma/magic/stalker,TRAUMA_RESILIENCE_SURGERY)

	sac_target.adjustOxyLoss(-100, FALSE)
	if(!sac_target.heal_and_revive(60, span_danger("[sac_target]'s body begins to shake with an unholy force as they return from death!")))
		return

	return TRUE

#undef SACRIFICE_SLEEP_DURATION