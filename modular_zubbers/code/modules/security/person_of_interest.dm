/// Per-slot weight toward shedding the flag. The jumpsuit, mask and hat carry most of the silhouette.
/// Slot flags are numbers, and a number on the left of a list() entry is a position, not a key, so these are stringified.
#define POI_SLOT_WEIGHTS list(\
	"[ITEM_SLOT_ICLOTHING]" = 4, \
	"[ITEM_SLOT_MASK]" = 3, \
	"[ITEM_SLOT_HEAD]" = 3, \
	"[ITEM_SLOT_OCLOTHING]" = 2, \
	"[ITEM_SLOT_EYES]" = 1, \
	"[ITEM_SLOT_FEET]" = 1, \
	"[ITEM_SLOT_GLOVES]" = 1, \
)
/// Accumulated weight of unobserved changes needed to shed the flag.
#define POI_DISGUISE_THRESHOLD 4
/// Weight of donning or shedding a whole MODsuit, treated as a major silhouette change.
#define POI_MODSUIT_WEIGHT 4
/// How long a corroborated flag survives without a sec-HUD wearer re-observing the target.
#define POI_DECAY_TIME (10 MINUTES)

/datum/component/person_of_interest
	/// Who set the flag, for the examine string.
	var/flagged_by
	/// Snapshot of the worn outfit at flag time. Only used while unidentified.
	var/list/appearance_signature
	/// Name corroborated off a face or a presented ID, if any. Null while unidentified.
	var/corroborated_name
	/// How the name was corroborated: "face" or "id". Face is the stronger anchor.
	var/corroboration_source
	/// Timer that lapses a corroborated flag once surveillance goes cold. Reset whenever a sec-HUD wearer re-observes.
	var/decay_timer
	/// Non-human parents only. The marker image, and the clients currently holding it.
	var/image/beacon
	var/list/client/watchers

/datum/component/person_of_interest/Initialize(flagged_by)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	src.flagged_by = flagged_by
	if(!ishuman(parent))
		// No outfit to shed and no face to read, so the flag holds until security clears it.
		// No wanted HUD slot either, so the marker goes straight into the watchers' clients.
		START_PROCESSING(SSprocessing, src)
		return
	appearance_signature = take_signature()
	try_corroborate()

/datum/component/person_of_interest/Destroy(force)
	STOP_PROCESSING(SSprocessing, src)
	clear_beacons()
	return ..()

/// Shows the marker to sec-HUD wearers in view, so every animal in the game does not need a HUD slot.
/datum/component/person_of_interest/process(seconds_per_tick)
	if(QDELETED(parent))
		return PROCESS_KILL
	var/atom/target = parent
	if(!beacon)
		beacon = image('modular_zubbers/icons/mob/huds/hud.dmi', target, "hudpoi")
		beacon.plane = ABOVE_LIGHTING_PLANE
	var/list/current = list()
	for(var/mob/living/viewer in viewers(target))
		if(viewer == target || !viewer.client)
			continue
		if(IS_UNCONSCIOUS_OR_CRIT(viewer))
			continue
		if(!HAS_TRAIT(viewer, TRAIT_SECURITY_HUD))
			continue
		current += viewer.client
	for(var/client/watcher as anything in watchers)
		if(watcher && !(watcher in current))
			watcher.images -= beacon
	for(var/client/watcher as anything in current)
		watcher.images |= beacon
	watchers = current

/datum/component/person_of_interest/proc/clear_beacons()
	if(!beacon)
		return
	for(var/client/watcher as anything in watchers)
		if(watcher)
			watcher.images -= beacon
	watchers = null
	beacon = null

/datum/component/person_of_interest/RegisterWithParent()
	if(!ishuman(parent))
		return
	RegisterSignal(parent, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_wardrobe_change))
	RegisterSignal(parent, COMSIG_MOB_UNEQUIPPED_ITEM, PROC_REF(on_wardrobe_change))
	RegisterSignals(parent, list(COMSIG_CHANGELING_TRANSFORM, COMSIG_HUMAN_MONKEYIZE), PROC_REF(on_identity_change))
	var/mob/living/carbon/human/target = parent
	target.sec_hud_set_security_status()

/datum/component/person_of_interest/UnregisterFromParent()
	if(!ishuman(parent))
		return
	UnregisterSignal(parent, list(COMSIG_MOB_EQUIPPED_ITEM, COMSIG_MOB_UNEQUIPPED_ITEM, COMSIG_CHANGELING_TRANSFORM, COMSIG_HUMAN_MONKEYIZE))
	var/mob/living/carbon/human/target = parent
	target.sec_hud_set_security_status()

/// Builds the outfit fingerprint. Every MOD part collapses to one token keyed off the control unit, so deploying
/// or retracting a suit does not read as a change of clothes.
/datum/component/person_of_interest/proc/take_signature()
	var/mob/living/carbon/human/target = parent
	var/list/weights = POI_SLOT_WEIGHTS
	var/static/list/mod_parts = typecacheof(list(/obj/item/clothing/head/mod, /obj/item/clothing/suit/mod, /obj/item/clothing/gloves/mod, /obj/item/clothing/shoes/mod, /obj/item/clothing/glasses/mod, /obj/item/clothing/neck/mod))
	var/list/signature = list()
	for(var/slot in weights)
		var/obj/item/worn = target.get_item_by_slot(text2num(slot))
		if(!worn)
			signature[slot] = "empty"
			continue
		signature[slot] = is_type_in_typecache(worn, mod_parts) ? "modsuit" : "[worn.type]"
	var/obj/item/mod/control/worn_suit = target.get_item_by_slot(ITEM_SLOT_BACK)
	signature["modsuit"] = istype(worn_suit) ? "[worn_suit.type]" : "none"
	return signature

/// Anchors the flag to an identity. A readable face is the strong anchor, a presented ID the weak one.
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

/// Refreshes the decay clock. Called whenever a sec-HUD wearer re-observes the target.
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
	if(!("[slot]" in weights) && slot != ITEM_SLOT_ID)
		return
	addtimer(CALLBACK(src, PROC_REF(check_disguise)), 1 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

/// TRUE if any conscious sec-HUD wearer can currently see the target. Changing clothes in front of them does not count.
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
 * A face anchor breaks only on a full identity swap. An ID anchor breaks if the ID changes or is dropped, and upgrades
 * to a face anchor as soon as the face is readable. Neither can be shaken by clothing.
 * An uncorroborated flag is anchored to the outfit and sheds once enough of it changes unobserved. Comparison is always
 * against the first snapshot, so changing back re-anchors.
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
		changed_weight += isnull(text2num(slot)) ? POI_MODSUIT_WEIGHT : weights[slot]
	if(changed_weight < POI_DISGUISE_THRESHOLD)
		return
	target.investigate_log("lost their person of interest flag by changing appearance.", INVESTIGATE_RECORDS)
	qdel(src)

/// Sets the flag. Returns TRUE if it was not already set.
/mob/living/proc/flag_person_of_interest(mob/living/carbon/human/flagger)
	if(GetComponent(/datum/component/person_of_interest))
		return FALSE
	var/flagger_label
	if(warrant_attribution_scrubbed(flagger))
		flagger_label = scrubbed_warrant_attribution()
	else
		var/flagger_rank = flagger.get_assignment(if_no_id = "", if_no_job = "")
		flagger_label = flagger_rank ? "[flagger.get_authentification_name()] ([flagger_rank])" : flagger.get_authentification_name()
	AddComponent(/datum/component/person_of_interest, flagged_by = flagger_label)
	investigate_log("flagged as a person of interest by [key_name(flagger)].", INVESTIGATE_RECORDS)
	return TRUE

/// Clears the flag. Always available to security, so a misunderstanding can be undone.
/mob/living/proc/clear_person_of_interest(mob/living/carbon/human/clearer)
	var/datum/component/person_of_interest/existing = GetComponent(/datum/component/person_of_interest)
	if(!existing)
		return FALSE
	investigate_log("person of interest flag cleared by [key_name(clearer)].", INVESTIGATE_RECORDS)
	qdel(existing)
	return TRUE

/// What to call this thing in a flag notice. A securitron is not an animal.
/mob/living/proc/poi_subject_noun()
	if(isbot(src) || issilicon(src))
		return "robot"
	if(isalien(src))
		return "creature"
	if(isanimal_or_basicmob(src))
		return "animal"
	return "entity"

/// Non-human mobs have no record and no criminal status field, so the flag is the whole interaction.
/// Only sec-HUD wearers see the line.
/mob/living/examine(mob/user)
	. = ..()
	. += poi_examine_lines(user)

/mob/living/proc/poi_examine_lines(mob/user)
	if(ishuman(src) || !ishuman(user) || !HAS_TRAIT(user, TRAIT_SECURITY_HUD))
		return list()
	var/datum/component/person_of_interest/flag = GetComponent(/datum/component/person_of_interest)
	. = list("Person of interest: <a href='byond://?src=[REF(src)];poi=1;examine_time=[world.time]'>\[[flag ? "Flagged" : "Unflagged"]\]</a>")
	if(flag)
		. += span_warning("[capitalize(poi_subject_noun())] flagged as potentially involved in criminal activity.")
		. += span_smallnoticeital("Flagged by [flag.flagged_by].")

/// Sets or clears the flag from the examine link. Same access guards as the human sechud picker.
/mob/living/proc/poi_topic_toggle(mob/user)
	if(ishuman(src) || !ishuman(user))
		return
	var/mob/living/carbon/human/flagger = user
	if(!HAS_TRAIT(flagger, TRAIT_SECURITY_HUD) || !flagger.canUseHUD() || IS_UNCONSCIOUS_OR_CRIT(flagger))
		return
	if(get_warrant_authority(flagger) < WARRANT_AUTH_GUARD)
		to_chat(flagger, span_warning("ERROR: Invalid access."))
		return
	if(GetComponent(/datum/component/person_of_interest))
		clear_person_of_interest(flagger)
		to_chat(flagger, span_notice("Person of interest flag cleared from [src]."))
		return
	flag_person_of_interest(flagger)
	to_chat(flagger, span_notice("Person of interest flag set on [src]."))

// /mob/living/Topic is already taken by another module, and a second definition there would silently shadow it.
/mob/living/basic/Topic(href, href_list)
	. = ..()
	if(href_list["poi"])
		poi_topic_toggle(usr)

/mob/living/simple_animal/Topic(href, href_list)
	. = ..()
	if(href_list["poi"])
		poi_topic_toggle(usr)

#undef POI_DISGUISE_THRESHOLD
#undef POI_MODSUIT_WEIGHT
#undef POI_DECAY_TIME
#undef POI_SLOT_WEIGHTS
