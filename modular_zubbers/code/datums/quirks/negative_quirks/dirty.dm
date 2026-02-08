#define DIRTY_TILE_CHANCE 0.25
#define REDIRTY_CHANCE 30

/datum/quirk/dirty
	name = "Dirty"
	desc = "You haven't taken a shower in a loooong time, and as a result, you are caked in an everpresent layer of grime and track it everywhere."
	icon = FA_ICON_TRASH_ALT
	value = -2
	mob_trait = TRAIT_DIRTY
	quirk_flags = QUIRK_PROCESSES
	gain_text = span_danger("You feel dirty!")
	lose_text = span_notice("You're finally clean...")
	medical_record_text = "Patient has atrocious hygiene standards."
	hardcore_value = 2
	mail_goodies = list(
		/obj/item/soap
	)
	/// The text displayed on examine, set in preferences.
	var/dirty_text
	/// The hexcolor that all dirt graphics will use.
	var/dirt_color
	/// Next time we're hit, will a bunch of dust fly off us?
	var/cloud_charged = TRUE

	/// Have we been cleaned, thereby disabling our dirt mechanics?
	var/cleaned = FALSE

/datum/quirk_constant_data/dirty
	associated_typepath = /datum/quirk/dirty
	customization_options = list(
		/datum/preference/text/dirty_text,
		/datum/preference/color/dirty_color,
	)

/datum/preference/text/dirty_text
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "dirty_quirk_text"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 100

/datum/preference/text/dirty_text/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/dirty_text/deserialize(input, datum/preferences/preferences)
	return htmlrendertext(input)

/datum/preference/text/dirty_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/text/dirty_text/create_default_value()
	return "They are positively covered in filth, and are tracking it everywhere!"

/datum/preference/color/dirty_color
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "dirty_quirk_color"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/color/dirty_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/color/dirty_color/create_default_value()
	return "#000000"

/datum/quirk/dirty/process(seconds_per_tick)
	if (cleaned)
		return
	for (var/mob/living/iter_mob in get_hearers_in_view(4, quirk_holder))
		if (HAS_TRAIT(iter_mob, TRAIT_DIRTY) || HAS_TRAIT(iter_mob, TRAIT_ANOSMIA))
			continue
		iter_mob.add_mood_event("dirty_smell", /datum/mood_event/dirty_smell)

/datum/quirk/dirty/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignals(quirk_holder, list(COMSIG_ATOM_POST_CLEAN, COMSIG_COMPONENT_CLEAN_ACT), PROC_REF(on_cleaned))
	RegisterSignal(quirk_holder, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	RegisterSignal(quirk_holder, COMSIG_LIVING_SEARCHED_TRASH_PILE, PROC_REF(searched_trash_pile))
	RegisterSignal(quirk_holder, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(on_check_block))

/datum/quirk/dirty/post_add()
	dirty_text = quirk_holder.client.prefs.read_preference(/datum/preference/text/dirty_text)
	dirt_color = quirk_holder.client.prefs.read_preference(/datum/preference/color/dirty_color)

	to_chat(quirk_holder, span_notice("You're dirty! You'll spread dirt when you walk, and can add a mood debuff to people around you. \
	Being cleaned will remove your filth - rummage through a trash pile to get it back."))

	return ..()

/datum/quirk/dirty/proc/searched_trash_pile(atom/signal_source, obj/structure/trash_pile/trash)
	SIGNAL_HANDLER

	if (!cloud_charged)
		to_chat(quirk_holder, span_notice("You find yourself covered in a thick layer of grime - a solid impact might knock it off in a cloud."))
		cloud_charged = TRUE

	if (!cleaned)
		return

	if (!prob(REDIRTY_CHANCE))
		to_chat(quirk_holder, span_warning("You didn't manage to scrounge enough filth to right this wrong. Try again."))
		return

	set_cleaned(FALSE)

/obj/effect/decal/cleanable/blood/footprints/dirty
	name = "dirty footprints"
	desc = "Footprints caked in grime. They smell awful."
	dried = TRUE
	bloodiness = 0

/datum/quirk/dirty/proc/on_moved(atom/movable/mover, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	if (cleaned)
		return
	if (quirk_holder.body_position == LYING_DOWN || (quirk_holder.movement_type & MOVETYPES_NOT_TOUCHING_GROUND))
		return

	var/turf/new_turf = get_turf(quirk_holder)

	if (prob(DIRTY_TILE_CHANCE))
		quirk_holder.balloon_alert_to_viewers("spreads dirt...")
		new_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/dirt)

	var/mob/living/carbon/human/human_holder = quirk_holder
	if (!istype(human_holder))
		return

	if (!isnull(human_holder.shoes))
		return

	var/obj/effect/decal/cleanable/blood/footprints/dirty/old_loc_prints = locate() in new_turf

	if (old_loc_prints)
		return

	var/obj/effect/decal/cleanable/blood/footprints/dirty/new_loc_prints = new /obj/effect/decal/cleanable/blood/footprints/dirty(new_turf, null, null)

	// Find any leg of our human and add that to the footprint, instead of the default which is to just add the human type
	for(var/obj/item/bodypart/leg/affecting in human_holder.bodyparts)
		if(!affecting.bodypart_disabled)
			LAZYSET(new_loc_prints.species_types, affecting.limb_id, TRUE)

	new_loc_prints.color = dirt_color
	new_loc_prints.entered_dirs |= quirk_holder.dir
	new_loc_prints.exited_dirs |= quirk_holder.dir
	new_loc_prints.update_appearance()

	new_loc_prints.fade_into_nothing()

/datum/effect_system/fluid_spread/smoke/dirty
	var/color

/datum/effect_system/fluid_spread/smoke/dirty/start(log)
	var/start_loc = holder ? get_turf(holder) : src.location
	var/obj/effect/particle_effect/fluid/smoke/smoke = new /obj/effect/particle_effect/fluid/smoke(start_loc, new /datum/fluid_group(amount))
	smoke.add_atom_colour(color, FIXED_COLOUR_PRIORITY)
	smoke.spread() // Making the smoke spread immediately.

/datum/quirk/dirty/proc/on_check_block(atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	SIGNAL_HANDLER

	if (!cloud_charged || cleaned)
		return
	quirk_holder.visible_message(
		span_warning("The impact knocks a cloud of grime and dust off [quirk_holder]!"),
		span_notice("The impact knocks a cloud of grime and dust off you!")
	)

	var/datum/effect_system/fluid_spread/smoke/dirty/smoke = new /datum/effect_system/fluid_spread/smoke/dirty()
	smoke.color = dirt_color
	smoke.set_up(0, holder = quirk_holder, location = get_turf(quirk_holder))
	smoke.start()

	cloud_charged = FALSE

/datum/quirk/dirty/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (cleaned)
		return
	if(!istype(user))
		return

	examine_list += span_warning(dirty_text)

/// Setter proc for [cleaned]. Handles messages and other reactions.
/datum/quirk/dirty/proc/on_cleaned(datum/source)
	SIGNAL_HANDLER

	if (!cleaned)
		INVOKE_ASYNC(quirk_holder, TYPE_PROC_REF(/mob, emote), "scream")

	set_cleaned(TRUE)

/datum/quirk/dirty/proc/set_cleaned(new_cleaned)

	if (cleaned && !new_cleaned)
		quirk_holder.visible_message(
			span_warning("[quirk_holder] is once again covered in filth, [quirk_holder.p_their()] hygiene forever accursed."),
			span_notice("Your find yourself lathered in filth once again. A sense of relief washes over you.")
		)
		quirk_holder.clear_mood_event("dirty_quirk_washed")
		ADD_TRAIT(quirk_holder, TRAIT_DIRTY, QUIRK_TRAIT)
	else if (!cleaned && new_cleaned)
		quirk_holder.visible_message(
			span_warning("[quirk_holder] squirms and writhes, fighting against the cleansing!"),
			span_userdanger("No! NO! Your filth! It's gone!")
		)
		quirk_holder.add_mood_event("dirty_quirk_washed", /datum/mood_event/dirty_washed)
		REMOVE_TRAIT(quirk_holder, TRAIT_DIRTY, QUIRK_TRAIT)

	cleaned = new_cleaned

/datum/mood_event/dirty_smell
	description = "Something... or someone... smells rotten around here..."
	mood_change = -2
	timeout = 25 SECONDS

/datum/mood_event/dirty_smell/add_effects(...)
	. = ..()

	to_chat(owner, span_warning("You catch the distinct scent of someone who hasn't showered in years. Disgusting."))

/datum/mood_event/dirty_washed
	description = "What is this smell...? Lavender soap? A hint of citrus?! ELDERBERRIES?! DISGUSTING! I need to wash myself in dirt!"
	mood_change = -6

#undef DIRTY_TILE_CHANCE
#undef REDIRTY_CHANCE
