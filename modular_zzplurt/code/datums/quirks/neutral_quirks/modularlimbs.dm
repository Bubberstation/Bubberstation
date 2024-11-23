#define MODLIMB_TIME_ADJUST 40

/datum/quirk/modularlimbs
	name = "Modular Limbs"
	desc = "You've undergone an experimental ligament hook surgery, allowing your limbs to be attached and detached easily. Unfortunately, this means everyone else can alter your limbs too!"
	value = 0
	gain_text = span_notice("Your limbs feel like they could come off with a bit of effort.")
	lose_text = span_notice("Your limbs feel more firmly attached.")
	medical_record_text = "Patient has undergone an experimental ligament hook surgery."
	mob_trait = TRAIT_MODULAR_LIMBS
	icon = FA_ICON_PUZZLE_PIECE

/datum/quirk/modularlimbs/add(client/client_source)
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Add new quirk verb
	add_verb(quirk_mob,/mob/living/proc/alterlimbs)

	// Add limb modification traits
	quirk_mob.add_traits(list(
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
	), TRAIT_MODULAR_LIMBS)

	// Self-amputation ability from Autotomy genetic
	// Define quirk action
	var/datum/action/cooldown/spell/self_amputation/modularlimbs/quirk_action = new

	// Grant quirk action
	quirk_action.Grant(quirk_holder)

/datum/quirk/modularlimbs/remove()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Remove quirk verb
	remove_verb(quirk_mob,/mob/living/proc/alterlimbs)

	// Remove limb modification traits
	quirk_mob.remove_traits(list(
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
	), TRAIT_MODULAR_LIMBS)

	// Define quirk action
	var/datum/action/cooldown/spell/self_amputation/modularlimbs/quirk_action = new

	// Revoke quirk action
	quirk_action.Remove(quirk_holder)

// Variant of self amputation spell
/datum/action/cooldown/spell/self_amputation/modularlimbs
	// More descriptive text, with warning
	name = "Eject a random limb"
	desc = "Violently eject a random limb from your body. This will hurt."

	// Default ability background
	background_icon = 'icons/mob/actions/backgrounds.dmi'
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	overlay_icon = 'icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = null

// New verb to alter limbs
/mob/living/proc/alterlimbs()
	// Verb definitions
	set name = "Alter Limbs"
	set desc = "Remove or attach a limb!"
	set category = "IC"
	set src in view(usr.client)

	// Define mobs involved
	var/mob/living/carbon/human/mob_initiator = usr
	var/mob/living/carbon/human/mob_target = src

	// Check for self-interacting
	// This causes a runtime error
	if(mob_initiator == mob_target)
		// Alert initiator and return
		to_chat(mob_initiator, span_warning("You cannot alter your own limbs! Ask someone else for help."))
		return

	// Check if initiator is adjacent
	if(!mob_target.Adjacent(mob_initiator))
		// Alert initiator and return
		to_chat(mob_initiator, span_warning("You must be adjacent to [mob_target] to do this!"))
		return

	// Note: Limb attachment is redundant with TRAIT_LIMBATTACHMENT

	// Define item held by initiator
	var/obj/item/held_initiator = mob_initiator.get_active_held_item()
	var/obj/item/bodypart/part_held = held_initiator

	// Check if held item is a body part
	if(part_held)
		// Check if a limb already exists
		if(mob_target.get_bodypart(part_held.body_zone))
			// Alert initiator and return
			to_chat(mob_initiator, span_warning("[mob_target.p_They()] already [mob_target.p_have()] a limb attached there!"))
			return

		// Limb does not already exist!
		// Alert target of interaction attempt
		mob_target.visible_message(span_warning("[mob_initiator] is attempting to attach \the [part_held] onto [mob_target]!"), span_userdanger("[mob_initiator] is attempting to attach \the [part_held] to you!"))

		// Attempt interaction timer
		if(do_after(mob_initiator, MODLIMB_TIME_ADJUST, target = mob_target))
			// Attempt to attach limb
			part_held.try_attach_limb(mob_target)

			// Alert users and return
			mob_target.visible_message(span_warning("[mob_initiator] successfully attaches \the [part_held] onto [mob_target]"), span_warning("[mob_initiator] has successfully attached \the [part_held.name] onto you; you can use that limb again!"))
			return

		// Interaction timer failed
		else
			// Alert users and return
			to_chat(mob_initiator, span_warning("You and [mob_target] must both stand still for you to alter their limbs!"))
			return

	// Initiator is not holding a body part!

	// Check for valid target region
	if(mob_initiator.zone_selected == BODY_ZONE_CHEST || mob_initiator.zone_selected == BODY_ZONE_HEAD)
		// Alert initiator and return
		to_chat(mob_initiator, span_warning("You must target either an arm or a leg!"))
		return
	if(mob_initiator.zone_selected == BODY_ZONE_PRECISE_GROIN || mob_initiator.zone_selected == BODY_ZONE_PRECISE_EYES || mob_initiator.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		// Alert initiator and return
		to_chat(mob_initiator, span_warning("There is no limb here; select an arm or a leg!"))
		return

	// Define target body part
	var/obj/item/bodypart/part_target = mob_target.get_bodypart(mob_initiator.zone_selected)

	// Check if the limb exists to be removed
	if(!part_target)
		// Alert initiator and return
		to_chat(mob_initiator, span_warning("[mob_target.p_They()] [mob_target.p_are()] already missing that limb!"))
		return

	// Check if part is irremovable
	if(part_target.bodypart_flags & BODYPART_UNREMOVABLE)
		// Alert initiator and return
		to_chat(mob_initiator, span_warning("[mob_target.p_Their()] limb is too firmly attached!"))
		return

	// Region is valid and has a limb!

	// Define body part name
	var/part_name = part_target.name

	// Alert users of interaction attempt
	mob_target.visible_message(span_warning("[mob_initiator] is attempting to remove [mob_target]'s [part_name]!"), span_userdanger("[mob_initiator] is attempting to disconnect your [part_name]!"))

	// Attempt interaction timer
	if(do_after(mob_initiator, MODLIMB_TIME_ADJUST, target = mob_target))
		// Define target again
		var/obj/item/bodypart/part_target_check = mob_target.get_bodypart(mob_initiator.zone_selected)

		// Check if redefined target matches
		if(part_target != part_target_check)
			// Alert initiator and return
			to_chat(mob_initiator, span_warning("You cannot target a different limb while already removing one!"))
			return

		// Remove targeted limb
		part_target_check.drop_limb()

		// Play sound effect
		// Taken from admin panel
		playsound(mob_target, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 70)

		// Update target's equipment
		mob_target.update_equipment_speed_mods()

		// Alert users and return
		mob_target.visible_message(span_warning("[mob_initiator] forcefully disconnects [mob_target]'s [part_name]!"), span_userdanger("[mob_initiator] has forcefully disconnected your [part_name]!"))
		return

	// Interaction timer failed
	else
		// Alert users and return
		to_chat(mob_initiator, span_warning("You and [mob_target] must both stand still for you to alter their limbs!"))
		return

#undef MODLIMB_TIME_ADJUST
