#define DIRTY_TILE_CHANCE 1
#define REDIRTY_CHANCE 30

/datum/quirk/dirty
	name = "Dirty"
	desc = "You haven't taken a shower in a loooong time, and as a result, you are caked in an everpresent layer of grime and track it everywhere."
	icon = FA_ICON_TRASH
	value = -2
	//mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = span_danger("You feel dirty!")
	lose_text = span_notice("You're finally clean...")
	medical_record_text = "Patient has atrocious hygene standards."
	hardcore_value = 2
	mail_goodies = list(
		/obj/item/soap
	)
	var/dirty_text
	var/dirt_color

	var/cleaned = FALSE

/datum/quirk/dity/post_add()
	dirty_text = quirk_holder.client.prefs.read_preference(/datum/preference/text/dirty_text)
	dirt_color = quirk_holder.client.prefs.read_preference(/datum/preference/color/dirty_color)

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

/datum/quirk/dirty/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(quirk_holder, COMSIG_ATOM_POST_CLEAN, PROC_REF(on_cleaned))
	RegisterSignal(quirk_holder, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	RegisterSignal(quirk_holder, COMSIG_LIVING_SEARCHED_TRASH_PILE, PROC_REF(searched_trash_pile))

/obj/effect/decal/cleanable/blood/footprints/dirty
	name = "dirty footprints"

/obj/effect/decal/cleanable/blood/footprints/dirty/Initialize(mapload, list/datum/disease/diseases, list/blood_or_dna)
	. = ..()

	fade_into_nothing(5 SECONDS, 3 SECONDS)

/datum/quirk/dirty/proc/searched_trash_pile(atom/signal_source, obj/structure/trash_pile/trash)
	SIGNAL_HANDLER

	if (!cleaned)
		return

	if (!prob(REDIRTY_CHANCE))
		to_chat(quirk_holder, span_warning("You didn't manage to scrounge enough filth to right this wrong. Try again."))

	set_cleaned(FALSE)

/datum/quirk/dirty/proc/on_moved(atom/movable/mover, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	var/turf/new_turf = get_turf(quirk_holder)

	if (prob(DIRTY_TILE_CHANCE))
		new_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/dirt)

	var/obj/effect/decal/cleanable/blood/footprints/dirty/decal = new_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/blood/footprints/dirty)
	if (!isnull(decal))
		decal.color = dirt_color
		decal.update_blood_color()

/datum/quirk/dirty/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (cleaned)
		return
	if(!istype(user))
		return

	examine_list += span_notice(dirty_text)

/datum/quirk/dirty/proc/on_cleaned(datum/component/cleaner/source, mob/living/user)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, TYPE_PROC_REF(/mob, emote), "scream")

	set_cleaned(TRUE)

/datum/quirk/dirty/proc/set_cleaned(new_cleaned)
	if (cleaned && !new_cleaned)
		quirk_holder.visible_message(
			span_warning("[quirk_holder] is once again covered in filth, [quirk_holder.p_their()] hygiene forever accursed."),
			span_notice("Your find yourself lathered in filth once again. A sense of relief washes over you.")
		)
		quirk_holder.clear_mood_event("dirty_quirk_washed")
	else if (!cleaned && new_cleaned)
		quirk_holder.visible_message(
			span_warning("[quirk_holder] squirms and writhes, fighting against the cleansing!"),
			span_userdanger("No! NO! Your filth! It's gone!")
		)
		quirk_holder.add_mood_event("dirty_quirk_washed", /datum/mood_event/dirty_washed)

	cleaned = new_cleaned

/datum/mood_event/dirty_washed
	description = "What is this smell...? Lavender soap? A hint of citrus?! ELDERBERRIES?! DISGUSTING! I need to wash myself in dirt!"
	mood_change = -6

#undef DIRTY_TILE_CHANCE
#undef REDIRTY_CHANCE
