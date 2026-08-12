/datum/action/cooldown/spell/cosmic_rune/before_cast(atom/cast_on)
	. = ..()

	owner.balloon_alert_to_viewers("invoking rune...")
	if (!do_after(owner, 5 SECONDS, owner, IGNORE_HELD_ITEM))
		return SPELL_CANCEL_CAST

/datum/heretic_knowledge/spell/cosmic_expansion
	required_atoms = list(/obj/item/grenade = 1, /obj/item/stack/sheet/plasmaglass = 5, /obj/item/organ/heart)
	transmute_text = "Transmute a grenade, 5 sheets of plasmaglass, and a heart."
	recharge_amount = 1

/datum/heretic_knowledge/spell/star_blast
	required_atoms = list(/obj/item/organ/eyes = 1, /obj/item/bodypart/arm/left = 5)
	transmute_text = "Transmute a pair of eyes, and a left arm."
	recharge_amount = 1

/datum/heretic_knowledge/spell/cosmic_runes
	required_atoms = list(/obj/item/bodypart/leg/left = 1, /obj/item/bodypart/leg/right = 1)
	transmute_text = "Transmute a set of legs."
	recharge_amount = 1

/datum/heretic_knowledge/spell/star_touch
	required_atoms = list(/obj/item/bodypart/arm/left = 1, /obj/item/bodypart/arm/right = 1)
	transmute_text = "Transmute a set of arms."
	recharge_amount = 1
