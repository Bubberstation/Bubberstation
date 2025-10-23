/// How much brute damage their body regenerates per second while using blood regeneration.
#define BLOOD_REGEN_BRUTE_AMOUNT 2
/// How much burn damage their body regenerates per second while using blood regeneration.
#define BLOOD_REGEN_BURN_AMOUNT 2
/// How much cellular damage their body regenerates per second while using blood regeneration.
#define BLOOD_REGEN_CELLULAR_AMOUNT 1.50
/// How much blood to regen while master of the house is active - net positive of 0.02
#define BLOOD_REGEN_MASTER_OF_THE_HOUSE 0.02
/// The threshold at which you have too much damage to use hemokinetic regen.
#define DAMAGE_LIMIT_HEMOKINETIC_REGEN 50
/// The amount in units of blood that gets consumed per point of damage healed (by hemokinetic regen and master of the house)
#define HEMOKINETIC_REGEN_BLOOD_CONSUMPTION 0.25
/// How much damage per second is healed by hemokinetic regen
#define HEMOKINETIC_REGEN_HEALING 1.8

/datum/status_effect/blood_thirst_satiated
	id = "blood_thirst_satiated"
	duration = 30 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/blood_thirst_satiated
	/// What will the bloodloss_speed_multiplier of the Hemophage be changed by upon receiving this status effect?
	var/bloodloss_speed_multiplier = 0.5


/datum/status_effect/blood_thirst_satiated/on_apply()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return FALSE

	var/obj/item/organ/heart/hemophage/tumor_heart = owner.get_organ_by_type(/obj/item/organ/heart/hemophage)

	if(!tumor_heart)
		return FALSE

	tumor_heart.bloodloss_rate *= bloodloss_speed_multiplier

	return TRUE


/datum/status_effect/blood_thirst_satiated/on_remove()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return

	var/obj/item/organ/heart/hemophage/tumor_heart = owner.get_organ_by_type(/obj/item/organ/heart/hemophage)

	if(!tumor_heart)
		return

	tumor_heart.bloodloss_rate /= bloodloss_speed_multiplier


/datum/movespeed_modifier/hemophage_dormant_state
	id = "hemophage_dormant_state"
	multiplicative_slowdown = 2 // Yeah, they'll be quite significantly slower when in their dormant state.
	blacklisted_movetypes = FLOATING|FLYING


/atom/movable/screen/alert/status_effect/blood_thirst_satiated
	name = "Thirst Satiated"
	desc = "Substitutes and taste-thin imitations keep your pale body standing, but nothing abates eternal thirst and slakes the infection quite like the real thing: Hot blood from a real sentient being."
	icon = 'icons/effects/bleed.dmi'
	icon_state = "bleed10"


/// Heals 1.8 brute + burn per second as long as damage value is DAMAGE_LIMIT_HEMOKINETIC_REGEN or below, consuming 0.2 units of blood per point of damage healed.
/datum/status_effect/hemokinetic_regen
	id = "hemokinetic_regen"
	alert_type = /atom/movable/screen/alert/status_effect/hemokinetic_regen
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
/datum/status_effect/hemokinetic_regen/on_apply()

	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return
	if((owner.getBruteLoss() + carbon_owner.getFireLoss()) >= DAMAGE_LIMIT_HEMOKINETIC_REGEN)
		to_chat(carbon_owner, span_warning("Your body is too damaged to be healed with hemokinesis!"))
		return

	carbon_owner.balloon_alert(carbon_owner, "hemokinetic regen activated!")
	return ..()

/datum/status_effect/hemokinetic_regen/tick(seconds_between_ticks)
	var/mob/living/carbon/C = owner
	if(!istype(C))
		return

	// Let quirks (Sol Weakness) observe this tick
	SEND_SIGNAL(C, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK, seconds_between_ticks, src)

	// ...then do your existing healing math...
	var/amount_healed = 0
	amount_healed += C.adjustBruteLoss(-HEMOKINETIC_REGEN_HEALING * seconds_between_ticks, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
	amount_healed += C.adjustFireLoss(-HEMOKINETIC_REGEN_HEALING * seconds_between_ticks, updating_health = FALSE, required_bodytype = BODYTYPE_ORGANIC)
	if(amount_healed)
		C.blood_volume -= (HEMOKINETIC_REGEN_BLOOD_CONSUMPTION * amount_healed)
		C.updatehealth()

/atom/movable/screen/alert/status_effect/hemokinetic_regen
	name = "Hemokinetic Regen"
	desc = "Our wounds are healing at the expense of blood."
	icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/screen_alert.dmi'
	icon_state = "hemokinetic_regen"


/// Stamina is reduced to 50% and movespeed gains heavy slowdown, but you will regen blood at 0.02u per second. Temporarily re-enables having to breathe.
/datum/status_effect/master_of_the_house
	id = "master_of_the_house"
	alert_type = /atom/movable/screen/alert/status_effect/master_of_the_house
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS


/datum/status_effect/master_of_the_house/on_apply()
	. = ..()
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	carbon_owner.adjustStaminaLoss(carbon_owner.getStaminaLoss() * 0.5, forced = TRUE)
	carbon_owner.max_stamina *= 0.5 // stamina is halved while this is active.
	REMOVE_TRAIT(carbon_owner, TRAIT_NOBREATH, SPECIES_TRAIT)
	REMOVE_TRAIT(carbon_owner, TRAIT_OXYIMMUNE, SPECIES_TRAIT)
	carbon_owner.add_movespeed_modifier(/datum/movespeed_modifier/master_of_the_house)


/datum/status_effect/master_of_the_house/on_remove()
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	carbon_owner.adjustStaminaLoss(carbon_owner.getStaminaLoss() / 0.5, forced = TRUE)
	carbon_owner.max_stamina /= 0.5
	carbon_owner.remove_movespeed_modifier(/datum/movespeed_modifier/master_of_the_house)
	if(carbon_owner.oxyloss) // if they have oxyloss, don't just heal it instantly
		carbon_owner.apply_status_effect(/datum/status_effect/slave_to_the_tumor)
	else
		ADD_TRAIT(carbon_owner, TRAIT_NOBREATH, SPECIES_TRAIT)
		ADD_TRAIT(carbon_owner, TRAIT_OXYIMMUNE, SPECIES_TRAIT)


/datum/status_effect/master_of_the_house/tick(seconds_between_ticks)
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	// Can't regen blood to over the roundstart blood volume
	if(carbon_owner.blood_volume >= BLOOD_VOLUME_ROUNDSTART_HEMOPHAGE)
		return

	carbon_owner.blood_volume += BLOOD_REGEN_MASTER_OF_THE_HOUSE


/datum/movespeed_modifier/master_of_the_house
	blacklisted_movetypes = (FLYING|FLOATING)
	multiplicative_slowdown = 0.75

/atom/movable/screen/alert/status_effect/master_of_the_house
	name = "Master of the House"
	desc = "You are taking back control of your lungs. Breathing once more requires air, but your enriched blood soothes and satiates the hunger within. \
		You are more sluggish than usual as you maintain this state."
	icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/screen_alert.dmi'
	icon_state = "master_of_the_house"


/datum/status_effect/slave_to_the_tumor
	id = "slave_to_the_tumor"
	alert_type = /atom/movable/screen/alert/status_effect/slave_to_the_tumor
	duration = 40 SECONDS
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	/// Snapshot of the mob's oxyloss at the time of getting the status, so we know how much to heal
	var/oxyloss_to_heal


/datum/status_effect/slave_to_the_tumor/on_apply()
	. = ..()
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/carbon_owner = owner
	oxyloss_to_heal = carbon_owner.getOxyLoss()
	to_chat(carbon_owner, "You feel a sense of relief as you embrace the tumor once more...")


/datum/status_effect/slave_to_the_tumor/on_remove()
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/carbon_owner = owner
	ADD_TRAIT(carbon_owner, TRAIT_NOBREATH, SPECIES_TRAIT)
	ADD_TRAIT(carbon_owner, TRAIT_OXYIMMUNE, SPECIES_TRAIT)


// With the tumor back in control, any accrued oxyloss is healed over the course of this status at the cost of blood (0.25u per point of oxyloss healed).
/datum/status_effect/slave_to_the_tumor/tick(seconds_between_ticks)
	var/mob/living/carbon/C = owner
	if(!istype(C))
		return

	// Let quirks observe this tick
	SEND_SIGNAL(C, COMSIG_MOB_HEMO_BLOOD_REGEN_TICK, seconds_between_ticks, src)

	// ...existing oxy heal + blood spend...
	var/amount_healed = C.adjustOxyLoss(round(-oxyloss_to_heal/(initial(duration) / 10) * seconds_between_ticks, 0.01), forced = TRUE)
	if(amount_healed)
		C.blood_volume -= (HEMOKINETIC_REGEN_BLOOD_CONSUMPTION * amount_healed)


/atom/movable/screen/alert/status_effect/slave_to_the_tumor
	name = "Slave to the Tumor"
	desc = "You've given control of your lungs back to the tumor...it is going to take some time to repair the damage."
	icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/screen_alert.dmi'
	icon_state = "slave_to_the_tumor"


#undef BLOOD_REGEN_BRUTE_AMOUNT
#undef BLOOD_REGEN_BURN_AMOUNT
#undef BLOOD_REGEN_CELLULAR_AMOUNT
#undef BLOOD_REGEN_MASTER_OF_THE_HOUSE
#undef DAMAGE_LIMIT_HEMOKINETIC_REGEN
#undef HEMOKINETIC_REGEN_BLOOD_CONSUMPTION
#undef HEMOKINETIC_REGEN_HEALING
