/mob/living/basic/heretic_summon/maid_in_the_mirror/examine(mob/user)
	. = ..()

	. += span_notice("Immune to lasers, but weak to melee and ballistics. Takes damage from being examined.")
	. += span_notice("Inflicts void chill on attack - a stacking debuff that lowers temperature but can be exploited to heal.")
	. += span_notice("Has x-ray vision.")
	. += span_notice("Can jaunt when in proximity to glass.")
