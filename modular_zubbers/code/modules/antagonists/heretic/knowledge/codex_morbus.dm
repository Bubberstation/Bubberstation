/obj/item/codex_cicatrix/morbus/Initialize(mapload)
	. = ..()

	if (check_holidays(APRIL_FOOLS) || prob(1))
		name = "Codex Morbius"
		desc = "It's morbin' time."

/datum/status_effect/heretic_curse/on_apply()
	. = ..()

	if (!.)
		return

	if (the_curser)
		to_chat(owner, span_boldwarning("You feel your blood roil. Someone, somewhere, has used a tincture of your blood to cast a curse on you...!"))

/datum/heretic_knowledge/curse/transmutation
	duration = 5 MINUTES // infinit efor no fucking reason in tgcode oml

/datum/heretic_knowledge/curse/corrosion
	duration = 1.5 MINUTES

/obj/item/codex_cicatrix/morbus/examine(mob/user)
	. = ..()

	. += span_notice("The Codex Morbus can drain influences and draw runes even faster. Additionally, if the user has blood in their offhand, \
	they can [EXAMINE_HINT("right-click")] a rune to cast a [EXAMINE_HINT("curse")] on the owner's blood. The duration is extended if the curser has an item \
	with the target's fingerprints.")
