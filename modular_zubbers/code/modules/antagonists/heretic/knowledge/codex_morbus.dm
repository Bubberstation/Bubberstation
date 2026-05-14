/obj/item/codex_cicatrix/morbus/Initialize(mapload)
	. = ..()

	if (check_holidays(APRIL_FOOLS) || prob(1))
		name = "Codex Morbius"
		desc = "It's morbin' time."

/datum/heretic_knowledge/curse/curse(mob/living/carbon/human/chosen_mob, obj/item/codex_cicatrix/morbus/cursing_book)
	. = ..()

	chosen_mob.balloon_alert_to_viewers("CURSED!")
	to_chat(chosen_mob, span_boldwarning("You've been cursed by an Acolyte using a tincture of your blood! It will fade with time..."))

/datum/heretic_knowledge/curse/transmutation
	duration = 5 MINUTES // infinit efor no fucking reason in tgcode oml

/datum/heretic_knowledge/curse/corrosion
	duration = 20 SECONDS

/obj/item/codex_cicatrix/morbus/examine(mob/user)
	. = ..()

	. += span_notice("The Codex Morbus can drain influences and draw runes even faster. Additionally, if the user has blood in their offhand, \
	they can [EXAMINE_HINT("right-click")] a rune to cast a [EXAMINE_HINT("curse")] on the owner's blood. The duration is extended if the curser has an item \
	with the target's fingerprints.")
