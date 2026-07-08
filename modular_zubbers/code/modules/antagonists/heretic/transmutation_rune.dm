/obj/effect/heretic_rune/add_fingerprint(...)
	return

/obj/effect/heretic_rune/add_fingerprint_list(...)
	return

/obj/effect/heretic_rune/wash(clean_types)
	. = ..()

	if (. || clean_types & CLEAN_SCRUB)
		qdel(src)

/obj/effect/heretic_rune/examine(mob/user)
	. = ..()

	. += span_notice("This rune can be created by any acolyte at any time with their [EXAMINE_HINT("mansus grasp")], and is how they perform \
	[EXAMINE_HINT("rituals")], the backbone of their gameplay.")
	if (IS_HERETIC(user))
		. += span_notice("[EXAMINE_HINT("Drop items")] on the rune to use them as an ingredient in a ritual.")
	. += span_notice("Remove with [EXAMINE_HINT("soap")], or an [EXAMINE_HINT("antimagic item")].")
