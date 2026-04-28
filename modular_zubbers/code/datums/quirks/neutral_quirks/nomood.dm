/datum/quirk/nomood
	name = "No Mood"
	desc = "You don't receive any moodlets, your mood status will be replaced with hunger bar and you will receive slowdown based on how hungry you are."
	icon = FA_ICON_POWER_OFF
	value = 0
	mob_trait = TRAIT_NOMOOD
	gain_text = span_danger("Your mood is way behind the fourth-wall!")
	lose_text = span_notice("Your mood is back to normal...")
	medical_record_text = "Patient is incapable of feeling their own emotions."
	var/previous_modifier = 1

/datum/quirk/nomood/post_add()
	. = ..()
	if(!quirk_holder.mob_mood)
		return
	ADD_TRAIT(quirk_holder, TRAIT_APATHETIC, QUIRK_TRAIT)
	previous_modifier = quirk_holder.mob_mood.mood_modifier
	quirk_holder.mob_mood.mood_modifier = 0 //personalities and anything mood related will just not count
	toggle_mood(hide = TRUE)

/datum/quirk/nomood/remove()
	. = ..()
	if(!quirk_holder.mob_mood)
		return
	REMOVE_TRAIT(quirk_holder, TRAIT_APATHETIC, QUIRK_TRAIT)
	quirk_holder.mob_mood.mood_modifier = previous_modifier
	toggle_mood(hide = FALSE)

/datum/quirk/nomood/proc/toggle_mood(hide)
	//hide the mood
	var/datum/mood/mob_mood = quirk_holder.mob_mood
	var/datum/hud/human/humanhud = quirk_holder.hud_used

	if(isnull(mob_mood) || isnull(humanhud))
		return

	var/atom/movable/screen/mood/mood_icon = mob_mood.mood_screen_object
	var/atom/movable/screen/hunger/hunger_icon = humanhud.hunger

	if(isnull(mood_icon) || isnull(hunger_icon))
		return

	mood_icon.screen_loc = hide ? "EAST-1:-999,CENTER:21" : ui_mood //moves it off the screen so you cant see it
	hunger_icon.screen_loc = hide ? ui_mood : ui_hunger

//slowdown handled the same way it is handled when disable_human_mood is enabled
/obj/item/organ/stomach/handle_hunger(mob/living/carbon/human/human, seconds_per_tick)
	. = ..()
	if(HAS_TRAIT(human, TRAIT_NOMOOD))
		handle_hunger_slowdown(human)
