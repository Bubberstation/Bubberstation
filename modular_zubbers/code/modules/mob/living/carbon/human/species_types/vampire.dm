/datum/species/vampire
	inherent_biotypes = MOB_VAMPIRIC|MOB_UNDEAD|MOB_HUMANOID

/datum/species/vampire/on_bloodsucker_gain(mob/living/carbon/human/target, datum/species/current_species)
	to_chat(target, span_warning("Your vampire features have been removed, your nature as a bloodsucker abates the lesser vampirism curse."))
	humanize_organs(target, current_species)

/datum/species/vampire/on_bloodsucker_loss(mob/living/carbon/human/target)
	normalize_organs(target)

// handled by bane on null rod whip
/datum/species/vampire/damage_weakness(datum/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	return


/datum/species/vampire/get_species_description()
	return list("A classy Vampire! They descend upon Space Station Thirteen Every year to spook the crew! \"Bleeg!!\"",)
