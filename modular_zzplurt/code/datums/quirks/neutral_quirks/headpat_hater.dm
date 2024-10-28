// UNIMPLEMENTED QUIRK!
/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, others touching your head won't make you wag your tail should you possess one, and the action may even attract your ire."
	value = 0
	gain_text = span_danger("Others' touches begin to make your blood boil...")
	lose_text = span_notice("Having your head pet doesn't sound so bad right about now...")
	medical_record_text = "Patient cares little with or dislikes being touched."
	mob_trait = TRAIT_DISTANT
	icon = FA_ICON_HAND

// Copy pasted from old code
/*
/datum/quirk/headpat_hater/add()

	var/mob/living/carbon/human/quirk_mob = quirk_holder

	var/datum/action/cooldown/toggle_distant/act_toggle = new
	act_toggle.Grant(quirk_mob)

/datum/quirk/headpat_hater/remove()

	var/mob/living/carbon/human/quirk_mob = quirk_holder

	var/datum/action/cooldown/toggle_distant/act_toggle = locate() in quirk_mob.actions
	if(act_toggle)
		act_toggle.Remove(quirk_mob)
*/
