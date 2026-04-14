/datum/action/cooldown/spell/jaunt/space_crawl/before_cast(atom/cast_on)
	. = ..()

	if (!is_jaunting(owner))
		owner.balloon_alert_to_viewers("phasing out...")
		if (!do_after(owner, 2 SECONDS, owner, IGNORE_HELD_ITEM|IGNORE_SLOWDOWNS|IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE))
			return SPELL_CANCEL_CAST
