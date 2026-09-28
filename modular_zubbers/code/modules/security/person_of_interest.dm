/// Per-slot weight toward shedding the flag. Jumpsuit, mask and hat dominate the silhouette; the rest is noise.
#define POI_SLOT_WEIGHTS list(\
	ITEM_SLOT_ICLOTHING = 4, \
	ITEM_SLOT_MASK = 3, \
	ITEM_SLOT_HEAD = 3, \
	ITEM_SLOT_OCLOTHING = 2, \
	ITEM_SLOT_EYES = 1, \
	ITEM_SLOT_FEET = 1, \
	ITEM_SLOT_GLOVES = 1, \
)
/// Accumulated weight of unobserved changes needed to shed the flag.
#define POI_DISGUISE_THRESHOLD 4
/// Weight of donning or shedding a whole MODsuit, treated as a major silhouette change.
#define POI_MODSUIT_WEIGHT 4
/// How long a corroborated flag survives without a sec-HUD wearer re-observing the target before it goes cold. Deliberately long for a first pass.
#define POI_DECAY_TIME (10 MINUTES)

/datum/component/person_of_interest
	/// Who last raised the flag, for the examine string.
	var/flagged_by
	/// Snapshot of the worn outfit at flag time. Only used while unidentified.
	var/list/appearance_signature
	/// Name corroborated off a face or a presented ID, if any. Null while unidentified.
	var/corroborated_name
	/// How the name was corroborated: "face" or "id". Face is the stronger anchor.
	var/corroboration_source
	/// Timer that lapses a corroborated flag once surveillance goes cold. Reset whenever a sec-HUD wearer re-observes.
	var/decay_timer

/datum/component/person_of_interest/Initialize(flagged_by)
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	src.flagged_by = flagged_by
	appearance_signature = take_signature()
	try_corroborate()

/datum/component/person_of_interest/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_wardrobe_change))
	RegisterSignal(parent, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(on_wardrobe_change))
	RegisterSignal(parent, list(COMSIG_CHANGELING_TRANSFORM, COMSIG_HUMAN_MONKEYIZE), PROC_REF(on_identity_change))
	var/mob/living/carbon/human/target = parent
	target.sec_hud_set_security_status()

/datum/component/person_of_interest/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM, COMSIG_CHANGELING_TRANSFORM, COMSIG_HUMAN_MONKEYIZE))
	var/mob/living/carbon/human/target = parent
	target.sec_hud_set_security_status()

/// Builds the current outfit fingerprint across the weighted slots. A deployed MODsuit is one outfit, not six garments,
/// so every MOD part collapses to a single token keyed off the control unit: deploying or retracting is not a disguise.
/datum/component/person_of_interest/proc/take_signature()
	var/mob/living/carbon/human/target = parent
	var/list/weights = POI_SLOT_WEIGHTS
	var/static/list/mod_parts = typecacheof(list(/obj/item/clothing/head/mod, /obj/item/clothing/suit/mod, /obj/item/clothing/gloves/mod, /obj/item/clothing/shoes/mod, /obj/item/clothing/glasses/mod, /obj/item/clothing/neck/mod))
	var/list/signature = list()
	for(var/slot in weights)
		var/obj/item/worn = target.get_item_by_slot(slot)
		if(!worn)
			signature["[slot]"] = "empty"
			continue
		signature["[slot]"] = is_type_in_typecache(worn, mod_parts) ? "modsuit" : "[worn.type]"
	var/obj/item/mod/control/worn_suit = target.get_item_by_slot(ITEM_SLOT_BACK)
	signature["modsuit"] = istype(worn_suit) ? "[worn_suit.type]" : "none"
	return signature

/// Anchors the flag to an identity. A readable face is the strong anchor; failing that, any ID the target presents is a
/// weaker one, since a person with no record who wears an ID has volunteered a handle to hold them by.
/datum/component/person_of_interest/proc/try_corroborate()
	if(corroborated_name)
		return TRUE
	var/mob/living/carbon/human/target = parent
	if(!target.is_face_obscured())
		var/face_name = target.get_face_name("")
		if(face_name && face_name != "")
			corroborated_name = face_name
			corroboration_source = "face"
			mark_seen()
			return TRUE
	var/id_name = target.get_id_name("")
	if(id_name && id_name != "")
		corroborated_name = id_name
		corroboration_source = "id"
		mark_seen()
		return TRUE
	return FALSE

/// Refreshes the decay clock. A corroborated flag stays warm while security keeps eyes on the target and goes cold once they slip away.
/datum/component/person_of_interest/proc/mark_seen()
	if(!corroborated_name)
		return
	decay_timer = addtimer(CALLBACK(src, PROC_REF(go_cold)), POI_DECAY_TIME, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE)

/// Surveillance lost the target for long enough. The flag lapses.
/datum/component/person_of_interest/proc/go_cold()
	var/mob/living/carbon/human/target = parent
	target.investigate_log("lost their person of interest flag as surveillance went cold.", INVESTIGATE_RECORDS)
	qdel(src)

/datum/component/person_of_interest/proc/on_wardrobe_change(datum/source, obj/item/thing, slot)
	SIGNAL_HANDLER
	var/list/weights = POI_SLOT_WEIGHTS
	// The ID slot carries no disguise weight, but presenting or ditching an ID can make or break an ID-based anchor.
	if(!(slot in weights) && slot != ITEM_SLOT_ID)
		return
	addtimer(CALLBACK(src, PROC_REF(check_disguise)), 1 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

/// TRUE if any conscious sec-HUD wearer currently has eyes on the target. Changing your outfit in front of the watch does not fool it.
/datum/component/person_of_interest/proc/is_being_watched()
	var/mob/living/carbon/human/target = parent
	for(var/mob/living/viewer in viewers(target))
		if(viewer == target)
			continue
		if(IS_UNCONSCIOUS_OR_CRIT(viewer))
			continue
		if(HAS_TRAIT(viewer, TRAIT_SECURITY_HUD))
			return TRUE
	return FALSE

/// A changeling transform or monkeyize can swap the whole identity. Re-check once it has settled.
/datum/component/person_of_interest/proc/on_identity_change(datum/source)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(check_disguise)), 2 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

/**
 * Decides whether the flag should lapse.
 * A corroborated flag is anchored to an identity security captured. A face anchor breaks only if the target becomes
 * someone else entirely (changeling transform, full identity swap). An ID anchor breaks if the presented ID changes or
 * is dropped, but upgrades to a face anchor the moment the face is readable. Clothing cannot shake either.
 * An unidentified flag is anchored to the outfit security saw. It sheds only when the target has, while unobserved,
 * changed enough of that outfit by weight. Reverting to the original outfit re-anchors, since the comparison is always
 * against the first snapshot: a disguise you take off in private was never a disguise.
 */
/datum/component/person_of_interest/proc/check_disguise()
	var/mob/living/carbon/human/target = parent
	if(corroborated_name)
		switch(corroboration_source)
			if("face")
				if(target.is_face_obscured())
					return
				if(target.get_face_name("") == corroborated_name)
					return
				target.investigate_log("lost their person of interest flag by assuming a new identity.", INVESTIGATE_RECORDS)
				qdel(src)
				return
			if("id")
				if(!target.is_face_obscured())
					var/face_name = target.get_face_name("")
					if(face_name && face_name != "")
						corroborated_name = face_name
						corroboration_source = "face"
						return
				if(target.get_id_name("") == corroborated_name)
					return
				target.investigate_log("lost their person of interest flag by ditching their presented identification.", INVESTIGATE_RECORDS)
				qdel(src)
				return
	try_corroborate()
	if(corroborated_name)
		return
	if(is_being_watched())
		return
	var/list/current = take_signature()
	var/list/weights = POI_SLOT_WEIGHTS
	var/changed_weight = 0
	for(var/slot in appearance_signature)
		if(current[slot] == appearance_signature[slot])
			continue
		var/slot_num = text2num(slot)
		changed_weight += isnull(slot_num) ? POI_MODSUIT_WEIGHT : weights[slot_num]
	if(changed_weight < POI_DISGUISE_THRESHOLD)
		return
	target.investigate_log("lost their person of interest flag by changing appearance.", INVESTIGATE_RECORDS)
	qdel(src)

/// Raises the flag. Returns TRUE if it was not already up.
/mob/living/carbon/human/proc/flag_person_of_interest(mob/living/carbon/human/flagger)
	if(GetComponent(/datum/component/person_of_interest))
		return FALSE
	var/flagger_rank = flagger.get_assignment(if_no_id = "", if_no_job = "")
	var/flagger_label = flagger_rank ? "[flagger.get_authentification_name()] ([flagger_rank])" : flagger.get_authentification_name()
	AddComponent(/datum/component/person_of_interest, flagged_by = flagger_label)
	investigate_log("flagged as a person of interest by [key_name(flagger)].", INVESTIGATE_RECORDS)
	return TRUE

/// Clears the flag. Always available to security, so a misunderstanding can be undone.
/mob/living/carbon/human/proc/clear_person_of_interest(mob/living/carbon/human/clearer)
	var/datum/component/person_of_interest/existing = GetComponent(/datum/component/person_of_interest)
	if(!existing)
		return FALSE
	investigate_log("person of interest flag cleared by [key_name(clearer)].", INVESTIGATE_RECORDS)
	qdel(existing)
	return TRUE

#undef POI_DISGUISE_THRESHOLD
#undef POI_MODSUIT_WEIGHT
#undef POI_DECAY_TIME
#undef POI_SLOT_WEIGHTS
