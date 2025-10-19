/// The message displayed in the hemophage's chat when they enter their dormant state.
#define DORMANT_STATE_START_MESSAGE "You feel your tumor's pulse slowing down, as it enters a dormant state. You suddenly feel incredibly weak and vulnerable to everything, and exercise has become even more difficult, as only your most vital bodily functions remain."
/// The message displayed in the hemophage's chat when they leave their dormant state.
#define DORMANT_STATE_END_MESSAGE "You feel a rush through your veins, as you can tell your tumor is pulsating at a regular pace once again. You no longer feel incredibly vulnerable, and exercise isn't as difficult anymore."


/datum/action/cooldown/hemophage
	cooldown_time = 3 SECONDS
	button_icon_state = null
	background_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/actions_hemophage.dmi'
	background_icon_state = "bg_hemophage"
	/// Whether the hemophage action is useable when dormant, by default they are not.
	var/useable_dormant


/datum/action/cooldown/hemophage/New(Target)
	. = ..()

	if(target && isnull(button_icon_state))
		AddComponent(/datum/component/action_item_overlay, target)

/// Called when the tumor goes dormant on all hemophage actions
/datum/action/cooldown/hemophage/proc/go_dormant()
	if(!useable_dormant)
		disable()


/// Called when the tumor wakes from its dormant state on all hemophage actions
/datum/action/cooldown/hemophage/proc/wake_up()
	if(!useable_dormant)
		enable()

/datum/action/cooldown/hemophage/toggle_dormant_state
	name = "Enter Dormant State"
	desc = "Causes the tumor inside of you to enter a dormant state, causing it to need just a minimum amount of blood to survive. \
		However, as the tumor living in your body is the only thing keeping you still alive, rendering it latent cuts both it and you to just the essential functions to keep standing. \
		It will no longer mend your body even in the darkness nor allow you to taste anything, and the lack of blood pumping through you will have you the weakest you've ever felt; and \
		leave you hardly able to run. It is not on a switch, and it will take some time for it to awaken."
	cooldown_time = 2 MINUTES
	useable_dormant = TRUE

/datum/action/cooldown/hemophage/toggle_dormant_state/Activate(atom/action_target)
	if(!owner || !ishuman(owner) || !target)
		return

	var/obj/item/organ/heart/hemophage/tumor = target
	if(!tumor || !istype(tumor)) // This shouldn't happen, but you can never be too careful.
		return

	owner.balloon_alert(owner, "[tumor.is_dormant ? "leaving" : "entering"] dormant state")

	if(!do_after(owner, 3 SECONDS))
		owner.balloon_alert(owner, "cancelled state change")
		return

	to_chat(owner, span_notice("[tumor.is_dormant ? DORMANT_STATE_END_MESSAGE : DORMANT_STATE_START_MESSAGE]"))

	StartCooldown()

	tumor.toggle_dormant_state()
	tumor.toggle_dormant_tumor_vulnerabilities(owner)

	if(tumor.is_dormant)
		name = "Exit Dormant State"
		desc = "Causes the pitch-black mass living inside of you to awaken, allowing your circulation to return and blood to pump freely once again. It fills your legs to let you run again, \
			and longs for the darkness as it did before. You start to feel strength rather than the weakness you felt before. However, the tumor giving you life is not on a switch, and it will take \
			some time to subdue it again."
	else
		name = initial(name)
		desc = initial(desc)

/datum/action/cooldown/hemophage/hemokinetic_regen
	name = "Hemokinetic Regeneration"
	desc = "While active, you will use hemokinesis and blood from your reserves to heal minor wounds as they occur."
	cooldown_time = 2 SECONDS
	background_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/actions_hemophage.dmi'
	background_icon_state = "bg_hemophage"
	button_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/actions_hemophage.dmi'
	button_icon_state = "hemokinetic_regen"


/datum/action/cooldown/hemophage/hemokinetic_regen/Activate(atom/action_target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return

	if(living_owner.blood_volume <= MINIMUM_VOLUME_FOR_REGEN)
		living_owner.balloon_alert(living_owner, "blood level too low!")
		return

	if(living_owner.has_status_effect(/datum/status_effect/hemokinetic_regen))
		living_owner.remove_status_effect(/datum/status_effect/hemokinetic_regen)
		living_owner.balloon_alert(living_owner, "hemokinetic regen deactivated!")
	else
		living_owner.apply_status_effect(/datum/status_effect/hemokinetic_regen)

	return ..()


/datum/action/cooldown/hemophage/hemokinetic_regen/go_dormant()
	. = ..()
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return

	living_owner.remove_status_effect(/datum/status_effect/hemokinetic_regen)


// Fully clots one wound per use at the cost of 50u of blood
/datum/action/cooldown/hemophage/hemokinetic_clot
	name = "Hemokinetic Clot"
	desc = "Clot an active wound for 50 blood units at a time. This is a temporary fix, as the wound will return upon the next instance of damage to that affected limb."
	cooldown_time = 10 SECONDS
	background_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/actions_hemophage.dmi'
	background_icon_state = "bg_hemophage"
	button_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/actions_hemophage.dmi'
	button_icon_state = "hemokinetic_clot"
	/// List of wounds that we can readd if the mob takes damage
	var/list/previous_wounds = list()


/datum/action/cooldown/hemophage/hemokinetic_clot/Activate(atom/action_target)
	var/mob/living/carbon/carbon_owner = owner
	if(!istype(carbon_owner))
		return

	if(carbon_owner.blood_volume <= MINIMUM_VOLUME_FOR_REGEN)
		carbon_owner.balloon_alert(carbon_owner, "blood level too low!")
		return

	// Fully clot one wound per use, priotizing the most oozy one.
	var/datum/wound/chosen_wound
	for(var/datum/wound/iter_wound as anything in carbon_owner.all_wounds)
		if(!(iter_wound.limb.bodytype & BODYTYPE_ORGANIC)) // no healing for robotic limbs
			continue
		if(iter_wound.blood_flow && (iter_wound.blood_flow > chosen_wound?.blood_flow))
			chosen_wound = iter_wound

	if(chosen_wound) // This one has the greatest blood flow, so heal it--first taking a snapshot of it so we can restore it later if the limb takes damage. The snapshot is a quadruplet list of data about the wound.
		if(!previous_wounds[chosen_wound.limb.name])
			previous_wounds[chosen_wound.limb.name] = list()
		previous_wounds[chosen_wound.limb.name] += list(list(
			chosen_wound.type,
			chosen_wound.wound_source,
			WEAKREF(chosen_wound.limb),
			chosen_wound.blood_flow
		))
		RegisterSignal(carbon_owner, COMSIG_CARBON_LIMB_DAMAGED, PROC_REF(on_limb_damaged), override = TRUE)
		chosen_wound.adjust_blood_flow(-WOUND_MAX_BLOODFLOW)
		to_chat(carbon_owner, span_good("You use hemokinesis to clot the [chosen_wound]."))
		carbon_owner.blood_volume -= 50
		return ..()

	carbon_owner.balloon_alert(carbon_owner, "no clottable wounds!")


/// Called when the limb takes damage, the previous wounds return as they were before they got clotted.
/datum/action/cooldown/hemophage/hemokinetic_clot/proc/on_limb_damaged(mob/living/our_mob, limb, brute, burn)
	SIGNAL_HANDLER

	if((brute + burn) <= 0) // nothing to do
		return

	// Wounds are really complicated in that they are constantly 'downgrading' or 'upgrading' themselves, which involves copying aspects of the old wound into a new datum, deleting the old one
	// We are going to just keep a 'copy' of the old wound around in a list and reapply it, adjusting the blood flow to what it was before. To accomplish this we can just use a simple quadruplet list which stores a 'snapshot' of the wound data.
	// In the quadruplet we have the wound's type, the wound_source, a weakref to the limb (so we don't cause hard dels), and the previous blood flow value. That should be all we need to put the wound back basically the same as it was before we 'healed' it.
	// Pray that TG doesn't severely refactor things there.
	for (var/limb_name in previous_wounds)
		var/list_entry = previous_wounds[limb_name]
		for(var/quadruplet in list_entry)
			// the datum typepath of the wound so we know which type to recreate
			var/wound_type = quadruplet[1]
			// the the wound source string so we can retain that as well
			var/wound_source = quadruplet[2]
			// which limb was the wound on? put it back there if we can
			var/datum/weakref/limb_ref = quadruplet[3]
			var/obj/item/bodypart/iter_limb = limb_ref?.resolve()
			if (iter_limb == limb)
				var/previous_blood_flow = quadruplet[4]
				var/datum/wound/iter_wound = new wound_type
				iter_wound.wound_source = wound_source
				if(iter_wound.apply_wound(iter_limb))
					iter_wound.adjust_blood_flow(previous_blood_flow)
				list_entry -= list(quadruplet)
				if(!length(list_entry))
					previous_wounds -= limb_name
				to_chat(our_mob, span_warning("The [iter_wound] comes unclotted upon taking damage!"))

	UnregisterSignal(our_mob, COMSIG_CARBON_LIMB_DAMAGED)


/datum/action/cooldown/hemophage/master_of_the_house
	name = "Master of the House"
	desc = "While active, wrest control of your lungs from the tumor. Breathing once more requires air, but your enriched blood soothes and satiates the hunger within. \
		Stamina is reduced to 50% and movespeed is slowed, but you will slowly regenerate blood."
	cooldown_time = 2 SECONDS
	background_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/actions_hemophage.dmi'
	background_icon_state = "bg_hemophage"
	button_icon = 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/species/hemophage/icons/actions_hemophage.dmi'
	button_icon_state = "master_of_the_house"


/datum/action/cooldown/hemophage/master_of_the_house/Activate(atom/action_target)
	var/mob/living/living_owner = owner
	if(!istype(living_owner))
		return

	if(living_owner.has_status_effect(/datum/status_effect/slave_to_the_tumor))
		to_chat(living_owner, "You are still recovering...")
		return

	if(living_owner.has_status_effect(/datum/status_effect/master_of_the_house))
		living_owner.remove_status_effect(/datum/status_effect/master_of_the_house)
		to_chat(living_owner, "You release control of your lungs back to the tumor...")
	else
		living_owner.apply_status_effect(/datum/status_effect/master_of_the_house)
		to_chat(living_owner, "You begin to wrest control of your lungs from the tumor. You can't keep this up forever, can you?")

	return ..()


/datum/action/cooldown/hemophage/master_of_the_house/go_dormant()
	. = ..()
	var/mob/living/living_owner = owner
	if(living_owner)
		living_owner.remove_status_effect(/datum/status_effect/master_of_the_house)

#undef DORMANT_STATE_START_MESSAGE
#undef DORMANT_STATE_END_MESSAGE
