#define MAX_HOARD_SIZE 9

/datum/quirk/hoarder
	name = "Hoarder"
	desc = "You have a tendency of gathering trinkets and putting them all together in a big pile"
	icon = FA_ICON_TRASH
	value = 0
	gain_text = span_notice("You feel like amassing a hoard.")
	lose_text = span_warning("You've lost interest in your hoard.")
	medical_record_text = "Patient has a compulsion to collect and hoard items."

/datum/quirk/hoarder/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/datum/action/cooldown/spell/hoard/action = new /datum/action/cooldown/spell/hoard()
	action.Grant(human_holder)

/datum/quirk/hoarder/remove()
	if(QDELETED(quirk_holder))
		return ..()
	var/datum/action/cooldown/spell/hoard/action = locate(/datum/action/cooldown/spell/hoard) in quirk_holder.actions
	action.Remove()

	return ..()

/datum/action/cooldown/spell/hoard
	name = "Expand Hoard"
	desc = "Make the tile you are standing on part of your hoard"

	button_icon = 'icons/obj/devices/tool.dmi'
	button_icon_state = "multitool"
	cooldown_time = 1 SECONDS
	spell_requirements = NONE

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	var/list/hoard_turfs = list()

/datum/action/cooldown/spell/hoard/cast(atom/cast_on)
	.=..()
	var/mob/living/carbon/human/H = owner
	if(!istype(H))
		return FALSE

	var/turf/current_turf = get_turf(H)

	//check if turf is already part of hoard, if so remove it
	if (current_turf in hoard_turfs)
		hoard_turfs -= current_turf
		to_chat(H, span_notice("This turf has been removed from your hoard"))
		return FALSE

	//check if the hoard is already at max size
	if (LAZYLEN(hoard_turfs) >= MAX_HOARD_SIZE)
		to_chat(H, span_warning("Your Hoard can't get any bigger!"))
		return FALSE

	//check if this is the first tile of the hoard
	if (!LAZYLEN(hoard_turfs))
		hoard_turfs += current_turf
		to_chat(H, span_notice("First Turf Added"))
		return


	//check if the new tile is adjacent to the existing hoard
	var/adjacent = FALSE
	for (var/turf/T in hoard_turfs)
		if(get_dist(current_turf, T) == 1)
			adjacent = TRUE
			continue
	if (!adjacent)
		to_chat(H, span_warning("You can only expand your hoard from tiles adjacent to your existing hoard!"))
		return FALSE

	hoard_turfs += current_turf
	to_chat(H, span_notice("Added turf to Hoard"))
	return TRUE


#undef MAX_HOARD_SIZE
