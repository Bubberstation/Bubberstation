
/datum/quirk/micro
	name = "Small"
	desc = "For whatever reason, you are slightly smaller than most. You are twenty smaller than others,\
	with the drawback of being easily squashed!"
	icon = FA_ICON_BUG
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN|QUIRK_CHANGES_APPEARANCE
	value = -4
	gain_text = span_danger("You feel a bit smaller.")
	lose_text = span_notice("You feel a bit larger.")
	medical_record_text = "Patient is short and small."
	hardcore_value = 0
	var/squash_damage_ = 14
	var/squash_chance_ = 25
	var/size_reduced = 20

/datum/quirk/micro/smaller
	name = "Microsized"
	desc = "You are thirty percent smaller than others... \
	with the drawback of being easily squashed and it HURTS!!"
	icon = FA_ICON_LOCUST
	squash_damage_ = 20
	squash_chance_ = 40
	size_reduced = 30

/datum/quirk/micro/smallest
	name = "Microscopic"
	desc = "You are fourty percent smaller than others... People really squint their eyes to see you! \
	You are also squished like a bug accidentally ALL the time!"
	icon = FA_ICON_WINDOW_MINIMIZE
	squash_damage_ = 40
	squash_chance_ = 80
	size_reduced = 40

/datum/quirk/micro/post_add()
	var/mob/living/carbon/living_as_carbon = quirk_holder
	if(living_as_carbon.dna.current_body_size != living_as_carbon.dna.features["body_size"])
		living_as_carbon.dna.features["body_size"] = BODY_SIZE_NORMAL - size_reduced
		living_as_carbon.dna.update_body_size()
	living_as_carbon.AddComponent( \
		/datum/component/squashable, \
		squash_chance = squash_chance_, \
		squash_damage = squash_damage_, \
		squash_flags = SQUASHED_ALWAYS_IF_DEAD|SQUASHED_DONT_SQUASH_IN_CONTENTS|SQUASHED_SHOULD_BE_DOWN, \
	)

/datum/quirk/micro/remove()
	qdel(quirk_holder.GetComponent(/datum/component/squashable))



