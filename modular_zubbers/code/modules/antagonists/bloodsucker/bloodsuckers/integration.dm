// Prevents Bloodsuckers from getting affected by blood
/mob/living/carbon/human/handle_blood(seconds_per_tick, times_fired)
	if(mind && IS_BLOODSUCKER(src))
		return FALSE
	return ..()

/datum/reagent/blood/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(exposed_mob)
	if(!bloodsuckerdatum)
		return ..()
	if(!(methods & (INJECT|INGEST)))
		return ..()

	if(bloodsuckerdatum.my_clan && istype(bloodsuckerdatum.my_clan, /datum/bloodsucker_clan/ventrue) && bloodsuckerdatum.GetBloodVolume() >= BLOOD_VOLUME_SAFE)
		return ..()
	if(bloodsuckerdatum.GetRank() >= BLOODSUCKER_HIGH_LEVEL)
		exposed_mob.adjust_disgust(5 SECONDS, DISGUST_LEVEL_GROSS)
		reac_volume = reac_volume * 0.3
	if(bloodsuckerdatum.GetBloodVolume() >= BLOOD_VOLUME_NORMAL)
		return ..()
	bloodsuckerdatum.AdjustBloodVolume(round(reac_volume, 0.1))

/mob/living/carbon/transfer_blood_to(atom/movable/AM, amount, forced)
	. = ..()
	if(!mind)
		return
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!bloodsuckerdatum)
		return
	bloodsuckerdatum.AdjustBloodVolume(-amount)

// Prevents using a Memento Mori
// todo move this to it's own trait
/obj/item/clothing/neck/necklace/memento_mori/memento(mob/living/carbon/human/user)
	if(IS_BLOODSUCKER(user))
		to_chat(user, span_warning("The Memento notices your undead soul, and refuses to react.."))
		return
	return ..()

/mob/living/carbon/human/natural_bodytemperature_stabilization(datum/gas_mixture/environment, seconds_per_tick, times_fired)
	// Return 0 as your natural temperature. Species proc handle_environment() will adjust your temperature based on this.
	if(HAS_TRAIT(src, TRAIT_COLDBLOODED))
		return 0
	return ..()

// Used when analyzing a Bloodsucker, Masquerade will hide brain traumas (Unless you're a Beefman)
/// todo move this to it's own trait or something
/mob/living/carbon/get_traumas()
	if(!mind)
		return ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(src)
	if(bloodsuckerdatum && HAS_TRAIT(src, TRAIT_MASQUERADE))
		return
	return ..()

// Used to keep track of how much Blood we've drank so far
/mob/living/get_status_tab_items()
	. = ..()
	if(!mind)
		return ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum)
		. += ""
		. += "Blood Drank: [bloodsuckerdatum.total_blood_drank]"
		. += "Maximum blood: [bloodsuckerdatum.max_blood_volume]"
		. += "Blood Thickening: [bloodsuckerdatum.blood_level_gain] / [bloodsuckerdatum.get_level_cost()]"
		if(bloodsuckerdatum.frenzied)
			. += "Frenzy exit blood threshold: [bloodsuckerdatum.frenzy_exit_threshold()]"
		else
			. += "Frenzy blood threshold: [bloodsuckerdatum.frenzy_enter_threshold()]"

/datum/outfit/bloodsucker_outfit
	name = "Bloodsucker outfit (Preview only)"
	suit = /obj/item/clothing/suit/costume/dracula

/datum/outfit/bloodsucker_outfit/post_equip(mob/living/carbon/human/enrico, visualsOnly=FALSE)
	enrico.hairstyle = "Undercut"
	enrico.hair_color = "FFF"
	enrico.skin_tone = "african2"
	enrico.eye_color_left = "#663300"
	enrico.eye_color_right = "#663300"

	enrico.update_body(is_creating = TRUE)


/**
 * CARBON INTEGRATION
*
* All overrides of mob/living and mob/living/carbon
*/
/// Brute
/mob/living/proc/getBruteLoss_nonProsthetic()
	return getBruteLoss()

/mob/living/carbon/getBruteLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/chosen_bodypart as anything in bodyparts)
		if(!IS_ORGANIC_LIMB(chosen_bodypart))
			continue
		amount += chosen_bodypart.brute_dam
	return amount

/// Burn
/mob/living/proc/getFireLoss_nonProsthetic()
	return getFireLoss()

/mob/living/carbon/getFireLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/chosen_bodypart as anything in bodyparts)
		if(!IS_ORGANIC_LIMB(chosen_bodypart))
			continue
		amount += chosen_bodypart.burn_dam
	return amount

/mob/living/brain/can_be_revived()
	if(health <= HEALTH_THRESHOLD_DEAD)
		return FALSE
	if(IS_BLOODSUCKER(src))
		return TRUE
	. =..()

// prevents players being trapped in their brain, alive, yet limbless and voiceless
/obj/item/bodypart/head/drop_organs(mob/user, violent_removal)
	var/obj/item/organ/internal/brain/brain = locate(/obj/item/organ/internal/brain) in src
	brain?.brainmob.death()
	. = ..()
