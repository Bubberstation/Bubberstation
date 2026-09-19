/obj/item/stack/medical/wrap
	/// The amount of direct hits our limb can take before we fall off.
	var/integrity = 2
	/// If we are splinting a limb, this is the overlay prefix we will use.
	var/splint_prefix = "splint"
	/// If we are bandaging a limb, this is the overlay prefix we will use.
	var/gauze_prefix = "gauze"
	/// If it is at all possible for us to splint a limb.
	var/can_splint = TRUE

/obj/item/stack/medical/wrap/on_gauze_limb(mob/user, mob/living/patient, obj/item/bodypart/limb)
	. = ..()
	astype(patient, /mob/living/carbon)?.update_bandage_overlays()

/obj/item/stack/medical/wrap/update_wounds(datum/source, obj/item/bodypart/limb)
	. = ..()
	var/mob/living/carbon/previously_gauzed = limb.owner
	if(!QDELETED(previously_gauzed))
		previously_gauzed.update_bandage_overlays()

/**
 * rip_off() called when someone rips it off
 *
 * It will return the bandage if it's considered pristine
 *
 */
/obj/item/stack/medical/wrap/proc/rip_off()
	if (is_pristine())
		. = new src.type(null, 1)

	qdel(src)

/// Returns either [splint_prefix] or [gauze_prefix] depending on if we are splinting or not. Suffixes it with a digitigrade flag if applicable for the limb.
/obj/item/stack/medical/wrap/proc/get_overlay_prefix(obj/item/bodypart/gauzed_bodypart)
	var/splinting = is_splinting(gauzed_bodypart)

	var/prefix
	if (splinting)
		prefix = splint_prefix
	else
		prefix = gauze_prefix

	var/suffix = gauzed_bodypart.body_zone
	if(gauzed_bodypart.bodyshape & BODYSHAPE_DIGITIGRADE)
		suffix += "_digitigrade"

	return "[prefix]_[suffix]"

/// Returns if we can splint, and if any wound on our bodypart gives a splint overlay.
/obj/item/stack/medical/wrap/proc/is_splinting(obj/item/bodypart/gauzed_bodypart)
	SHOULD_BE_PURE(TRUE)

	if (!can_splint)
		return FALSE

	for (var/datum/wound/iterated_wound as anything in gauzed_bodypart.wounds)
		if (iterated_wound.wound_flags & SPLINT_OVERLAY)
			return TRUE

	return FALSE

/**
 * is_pristine() called by rip_off()
 *
 * Used to determine whether the bandage can be re-used and won't qdel itself
 *
 */

/obj/item/stack/medical/wrap/proc/is_pristine()
	return (integrity == initial(integrity))

/**
 * get_hit() called when the bandage gets damaged
 *
 * This proc will subtract integrity and delete the bandage with a to_chat message to whoever was bandaged
 *
 */

/obj/item/stack/medical/wrap/proc/get_hit(obj/item/bodypart/gauzed_bodypart)
	integrity--
	if(integrity <= 0)
		if(gauzed_bodypart.owner)
			to_chat(gauzed_bodypart.owner, span_warning("The [name] on your [gauzed_bodypart.name] tears and falls off!"))
		qdel(src)

/// Returns TRUE if we can generate an overlay, false otherwise.
/obj/item/stack/medical/wrap/proc/has_overlay()
	return (!isnull(gauze_prefix) && !isnull(splint_prefix))

/obj/item/stack/medical/wrap/gauze/improvised
	splint_prefix = "splint_improv"
