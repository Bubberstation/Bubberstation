/// Maximum an Hemophage will drain, they will drain less if they hit their cap.
#define HEMOPHAGE_DRAIN_AMOUNT 50
/// The multiplier for blood received by Hemophages out of humans with ckeys.
#define BLOOD_DRAIN_MULTIPLIER_CKEY 1.5


/datum/component/organ_corruption/tongue
	corruptable_organ_type = /obj/item/organ/internal/tongue
	corrupted_icon_state = "tongue"
	/// The item action given to the tongue once it was corrupted.
	var/tongue_action_type = /datum/action/cooldown/hemophage/drain_victim


/datum/component/organ_corruption/tongue/corrupt_organ(obj/item/organ/internal/corruption_target)
	. = ..()

	if(!.)
		return

	var/obj/item/organ/internal/tongue/corrupted_tongue = corruption_target
	corrupted_tongue.liked_foodtypes = BLOODY
	corrupted_tongue.disliked_foodtypes = NONE

	var/datum/action/tongue_action = corruption_target.add_item_action(tongue_action_type)

	if(corruption_target.owner)
		tongue_action.Grant(corruption_target.owner)


/datum/action/cooldown/hemophage/drain_victim
	name = "Drain Victim"
	desc = "Leech blood from any carbon victim you are passively grabbing."


/datum/action/cooldown/hemophage/drain_victim/Activate(atom/target)
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/hemophage = owner

	if(!has_valid_target(hemophage))
		return

	// By now, we know that they're pulling a carbon.
	drain_victim(hemophage, hemophage.pulling)


/**
 * Handles the first checks to see if the target is eligible to be drained.
 *
 * Arguments:
 * * hemophage - The person that's trying to drain something or someone else.
 *
 * Returns `TRUE` if the target is eligible to be drained, `FALSE` if not.
 */
/datum/action/cooldown/hemophage/drain_victim/proc/has_valid_target(mob/living/carbon/hemophage)
	if(!hemophage.pulling || !iscarbon(hemophage.pulling) || isalien(hemophage.pulling))
		hemophage.balloon_alert(hemophage, "not pulling any valid target!")
		return FALSE

	var/mob/living/carbon/victim = hemophage.pulling
	if(hemophage.blood_volume >= BLOOD_VOLUME_MAXIMUM)
		hemophage.balloon_alert(hemophage, "already full!")
		return FALSE

	if(victim.stat == DEAD)
		hemophage.balloon_alert(hemophage, "needs a living victim!")
		return FALSE

	if(!victim.blood_volume || (victim.dna && ((HAS_TRAIT(victim, TRAIT_NOBLOOD)) || victim.dna.species.exotic_blood)))
		hemophage.balloon_alert(hemophage, "[victim] doesn't have blood!")
		return FALSE

	if(victim.can_block_magic(MAGIC_RESISTANCE_HOLY, charge_cost = 0))
		victim.show_message(span_warning("[hemophage] tries to bite you, but stops before touching you!"))
		to_chat(hemophage, span_warning("[victim] is blessed! You stop just in time to avoid catching fire."))
		return FALSE

	if(victim.has_reagent(/datum/reagent/consumable/garlic))
		victim.show_message(span_warning("[hemophage] tries to bite you, but recoils in disgust!"))
		to_chat(hemophage, span_warning("[victim] reeks of garlic! You can't bring yourself to drain such tainted blood."))
		return FALSE

	if(ismonkey(victim) && (hemophage.blood_volume >= BLOOD_VOLUME_NORMAL))
		hemophage.balloon_alert(hemophage, "their inferior blood cannot sate you any further!")
		return FALSE

	return TRUE


/**
 * The proc that actually handles draining the victim. Assumes that all the
 * pre-requesite checks were made, and as such will not make any more checks
 * outside of a `do_after` of three seconds.
 *
 * Arguments:
 * * hemophage - The feeder.
 * * victim - The one that's being drained.
 */
/datum/action/cooldown/hemophage/drain_victim/proc/drain_victim(mob/living/carbon/hemophage, mob/living/carbon/victim)
	var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - hemophage.blood_volume //How much capacity we have left to absorb blood
	// We start by checking that the victim is a human and they have a client, so we can give them the
	// beneficial status effect for drinking higher-quality blood.
	var/is_target_human_with_client = istype(victim, /mob/living/carbon/human) && victim.client

	if(ismonkey(victim))
		is_target_human_with_client = FALSE // Sorry, not going to get the status effect from monkeys, even if they have a client in them.

		blood_volume_difference = BLOOD_VOLUME_NORMAL - hemophage.blood_volume

	StartCooldown()

	if(!do_after(hemophage, 3 SECONDS, target = victim))
		hemophage.balloon_alert(hemophage, "stopped feeding")
		return

	var/drained_blood = min(victim.blood_volume, HEMOPHAGE_DRAIN_AMOUNT, blood_volume_difference)
	// if you drained from a human with a client, congrats
	var/drained_multiplier = (is_target_human_with_client ? BLOOD_DRAIN_MULTIPLIER_CKEY : 1)

	victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
	hemophage.blood_volume = clamp(hemophage.blood_volume + (drained_blood * drained_multiplier), 0, BLOOD_VOLUME_MAXIMUM)

	log_combat(hemophage, victim, "drained [drained_blood]u of blood from", addition = " (NEW BLOOD VOLUME: [victim.blood_volume] cL)")
	victim.show_message(span_danger("[hemophage] drains some of your blood!"))
	to_chat(hemophage, span_notice("You drink some blood from [victim]![is_target_human_with_client ? " That tasted particularly good!" : ""]"))

	playsound(hemophage, 'sound/items/drink.ogg', 30, TRUE, -2)

	if(victim.blood_volume <= BLOOD_VOLUME_OKAY)
		to_chat(hemophage, span_warning("That definitely left them looking pale..."))

	if(is_target_human_with_client)
		hemophage.apply_status_effect(/datum/status_effect/blood_thirst_satiated)

	if(!victim.blood_volume || victim.blood_volume < BLOOD_VOLUME_SURVIVE)
		to_chat(hemophage, span_warning("You finish off [victim]'s blood supply."))


#undef HEMOPHAGE_DRAIN_AMOUNT
#undef BLOOD_DRAIN_MULTIPLIER_CKEY
