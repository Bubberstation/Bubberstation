/datum/species/human/vampire
	inherent_biotypes = MOB_VAMPIRIC|MOB_UNDEAD|MOB_HUMANOID

/datum/species/human/vampire/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	to_chat(target, span_warning("Your vampire features have been removed, your nature as a bloodsucker abates the lesser vampirism curse."))
	humanize_organs(target, current_species)

/datum/species/human/vampire/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)

// handled by bane on null rod whip
/datum/species/human/vampire/on_attackby(mob/living/source, obj/item/attacking_item, mob/living/attacker, list/modifiers, list/attack_modifiers)
	. = ..()
	return


/datum/species/human/vampire/get_species_description()
	return list("A classy Vampire! They descend upon Space Station Thirteen Every year to spook the crew! \"Bleeg!!\"",)
