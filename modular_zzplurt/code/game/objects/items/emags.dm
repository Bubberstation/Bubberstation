#define BLOODMAG_USE_COST (BLOOD_VOLUME_NORMAL * 0.10) // 10% of standard blood
#define BLOODMAG_USE_COST_FAKE (BLOOD_VOLUME_NORMAL * 0.01) // 1% of standard blood
#define BLOODMAG_CD_TIME 3 SECONDS

//
// Bloodfledge exclusive emag
//
/obj/item/card/emag/bloodfledge
	name = "hemorrhagic sanguinizer"
	desc = "A card with a blood seal attached to some circuitry. Requires special training to use properly."
	icon = 'modular_zzplurt/icons/obj/card.dmi'
	icon_state = "bloodmag"
	// List of allowed types - Unused!
	//var/type_whitelist

	// Can this actually emag things?
	var/unlocked = FALSE

	// Cooldown between uses
	COOLDOWN_DECLARE(bloodmag_cooldown)

// On creation
// Unused feature: type whitelist
/*
/obj/item/card/emag/bloodfledge/Initialize(mapload)
	. = ..()

	// List of object types this emag can affect
	type_whitelist = list(
		typesof(/obj/machinery/chem_dispenser), // Unlocks more reagents
		typesof(/obj/structure/bodycontainer/morgue), // Changes status light
	)
*/

// Emag the bloodmag
/obj/item/card/emag/bloodfledge/emag_act(mob/user, obj/item/card/emag/emag_card)
	// Check if valid
	if(isnull(user) || !istype(emag_card))
		return FALSE

	// Check if already unlocked
	if(unlocked)
		// Alert user and return
		balloon_alert(user, "already upgraded!")
		return FALSE

	// Unlock full functionality
	unlocked = TRUE

	// Alert user
	balloon_alert(user, "sanguinizer upgraded!")

// Examine text
/obj/item/card/emag/bloodfledge/examine(mob/user)
	. = ..()

	// Check for bloodfledge
	if(HAS_TRAIT(user, TRAIT_BLOODFLEDGE))
		// Check if unlocked
		if(unlocked)
			// Add unlocked text
			. += span_notice("It's been switched to hemorrhagic sequencing mode.")

		// Item is not unlocked
		else
			// Add fake usage text
			. += span_notice("You know exactly how to sanguinize things with this!")

// Can use check
/obj/item/card/emag/bloodfledge/can_emag(atom/target, mob/user)
	. = ..()

	// Check parent return
	if(!.)
		return FALSE

	// Check for bloodfledge
	if(!HAS_TRAIT(user, TRAIT_BLOODFLEDGE))
		// Warn user and return
		to_chat(user, span_warning("You can't figure out what to do with [src]. Maybe you should ask someone more qualified."))
		return FALSE

	// Check for bloodless
	if(HAS_TRAIT(user, TRAIT_NOBLOOD))
		// Warn user and return
		to_chat(user, span_warning("Your body is incapable of utilizing [src]!"))
		return FALSE

	// Check cooldown
	if(!COOLDOWN_FINISHED(src, bloodmag_cooldown))
		// Warn user and return
		balloon_alert(user, "still recharging!")
		return FALSE

	// Check for unlocked state
	if(!unlocked)
		// Give false alerts
		user.visible_message(span_danger("[user] sanguinizes [target] with [user.p_their()] [src]! Never before has [target] been more sanguine!"), span_warning("You sanguinize [target]! Never before has [target] been more sanguine!"))
		balloon_alert(user, "target sanguinized!")

		// Start cooldown to prevent spam
		COOLDOWN_START(src, bloodmag_cooldown, BLOODMAG_CD_TIME)

		// Apply color named "Sanguine"
		//target.add_atom_colour("#6D0C0D", WASHABLE_COLOUR_PRIORITY)

		// Define carbon holder
		var/mob/living/carbon/item_mob = user

		// Check if holder exists
		if(item_mob)
			// Cause user to bleed
			item_mob.bleed(BLOODMAG_USE_COST_FAKE)

			// Apply blood to the target
			target.add_mob_blood(item_mob)

		// Return failure
		return FALSE

	// Allow use
	return TRUE

	// Unused feature: type whitelist
	/*
	// Check for compatible object type
	for (var/list/subtypelist in type_whitelist)
		if (target.type in subtypelist)
			return TRUE

	// Interaction is not valid
	// Warn user and return
	balloon_alert(user, "incompatible target!")
	return FALSE
	*/

// Trigger on using
/obj/item/card/emag/bloodfledge/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()

	// Check if successful
	if(. != ITEM_INTERACT_SUCCESS)
		// Do nothing
		return

	// Start cooldown
	COOLDOWN_START(src, bloodmag_cooldown, BLOODMAG_CD_TIME)

	// Define carbon holder
	var/mob/living/carbon/item_mob = user

	// Check if holder exists
	if(item_mob)
		// Cause target to bleed
		item_mob.bleed(BLOODMAG_USE_COST)

		// Apply blood to the target
		interacting_with.add_mob_blood(item_mob)

		// Warn user
		to_chat(user, span_boldwarning("You can feel [src] draining your life force."))

// Suicide action
/obj/item/card/emag/bloodfledge/suicide_act(mob/living/carbon/user)
	// Alert in chat
	user.visible_message(span_suicide("[user] hacks themselves with [src], unlocking ultra gore mode!"))

	// Gib the user
	user.gib(DROP_ALL_REMAINS)

	// Check if unlocked
	if(unlocked)
		// Explode
		explosion(src, light_impact_range = 1, explosion_cause = src)

		// Delete item
		qdel(src)

	// Return success
	return MANUAL_SUICIDE

#undef BLOODMAG_USE_COST
#undef BLOODMAG_USE_COST_FAKE
#undef BLOODMAG_CD_TIME
