
//the list of possible things people can make if they have maxed forging skill
#define COMSIG_SMITHING_QUENCH "smithing_done"
#define COMSIG_SMITHING_PASSIVE_COOLED "smithing_passive_cooled"

#define DOAFTER_SMITHING_FORGE "smithing_forging_doafter"
#define DOAFTER_SMITHING_ANVIL "smithing_anvil_doafter"
#define DOAFTER_SMITHING_WATER_BASIN "smithing_waterbasin_doafter"
#define DOAFTER_SMITHING_TABLE "smithing_table_doafter"

#define DOAFTER_REVOLVER_HAMMER_COCK "smithing_revolver_hammer_cock_doafter"

/// smithing hits are advanced by "quality points" depending on various factors. What's the lowest that the quality points given can be?
#define MINIMUM_SMITHING_QUALITY_POINTS

#define FORGING_WEAPON_REFORGING_MAX_QUALITY 30
#define FORGING_WEAPON_REFORGING_AVERAGE_WAIT 1 SECONDS
#define FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS 15
#define FORGING_WEAPON_REFORGING_MAX_BAD_HITS 6

#define FORGING_CLOTHING_REFORGING_MAX_QUALITY 30
#define FORGING_CLOTHING_REFORGING_AVERAGE_WAIT 1 SECONDS
#define FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS 15
#define FORGING_CLOTHING_REFORGING_MAX_BAD_HITS 6

#define USER_CAN_REAGENT_IMBUE(user) (HAS_TRAIT(user, TRAIT_KNOW_ADVANCED_SMITHING) || user.mind.get_skill_level(/datum/skill/smithing) >= SKILL_LEVEL_MASTER)
#define USER_CAN_SEE_SMITHING_INFO(user) (user.mind.get_skill_level(/datum/skill/smithing) >= SKILL_LEVEL_JOURNEYMAN)
/// Minimum and maximum force multiplier if a weapon contains incomplete parts
#define MIN_INCOMPLETE_FORGING_SCALING_PENALTY 0.1
#define MAX_INCOMPLETE_FORGING_SCALING_PENALTY 0.5
/// The maximum force that can be given to a weapon via perfect hits
#define MAX_PERFECT_FORCE_BONUS 3
/// maximum force that can be given to a reagent staff via perfect hits
#define MAX_PERFECT_STAFF_INTEG_BONUS 20
///amount of chems that can be stored into the result
#define MAX_PRE_IMBUE_STORAGE 60
///amount of chems that the result reads as
#define DEFAULT_IMBUE_STORAGE 10
#define REAGENT_CLOTHING_INJECT_AMOUNT 0.5
#define REAGENT_WEAPON_INJECT_AMOUNT 4
#define REAGENT_STAFF_INJECT_AMOUNT 10
#define MAX_OIL_AP_AMOUNT 10
#define PERFECT_ACCESSORY_DURABILITY_BONUS 50
#define PERFECT_HANDCUFFS_UNLOCK_SPEED_BONUS 2 SECONDS

#define MAX_QUENCH_HEAT 600
#define HEAT_GIVEN_FROM_QUENCHING_METAL 300
#define MIN_VOLUME_TO_QUENCH 300
#define SMITHING_BASIN_HEATLOSS_COEFFICIENT 0.7

#define FORGE_EFFECT_FORCE "forge_effect_force"
#define FORGE_EFFECT_ARMORPEN "forge_effect_armorpen"
#define FORGE_EFFECT_ARMOR "forge_effect_armor"
#define FORGE_EFFECT_DURABILITY "forge_effect_durability"
#define FORGE_EFFECT_BLOCKCHANCE "forge_effect_block"
#define FORGE_EFFECT_REAGENT_INJECT "forge_effect_reagent_inject"
#define FORGE_EFFECT_TOOLSPEED "forge_effect_toolspeed"

///helper function - given two ratios, a forge effect, an item, and a maximal value, it gives a new modifier and resets the old modifier to the item
/proc/give_added_modifying_effect_to_item(forge_effect, old_modifier, new_modifier, obj/item/item, max_effect)
	switch(forge_effect)
		if(FORGE_EFFECT_ARMOR)
			var/datum/armor/indexed_armor
			if(ispath(max_effect))
				indexed_armor = get_armor_by_type(max_effect)
			else
				indexed_armor = max_effect

			///WHY does the tgstation implementation have 0-multipler return the source armor? and not return armor/none?
			var/datum/armor/new_armor_modifier
			if(new_modifier == 0)
				new_armor_modifier = new /datum/armor/none
			else
				new_armor_modifier = indexed_armor.generate_new_with_multipliers(list(ARMOR_ALL = new_modifier))
			var/datum/armor/previous_armor_modifier
			if(old_modifier == 0)
				previous_armor_modifier = new /datum/armor/none
			else
				previous_armor_modifier = indexed_armor.generate_new_with_modifiers(list(ARMOR_ALL = new_modifier))

			var/datum/armor/newarmor = item.get_armor()
			newarmor = newarmor.add_other_armor(new_armor_modifier)
			newarmor = newarmor.subtract_other_armor(previous_armor_modifier)
			item.set_armor(newarmor)
		if(FORGE_EFFECT_ARMORPEN)
			var/new_armorpen_modifier = new_modifier * max_effect
			var/previous_armorpen_modifier = old_modifier * max_effect
			item.armour_penetration += new_armorpen_modifier - previous_armorpen_modifier
		if(FORGE_EFFECT_BLOCKCHANCE)
			var/new_blockchance_modifier = new_modifier * max_effect
			var/previous_blockchance_modifier = old_modifier * max_effect
			item.block_chance += new_blockchance_modifier - previous_blockchance_modifier
		if(FORGE_EFFECT_DURABILITY)
			var/new_durability_modifier = new_modifier * max_effect
			var/previous_durability_modifier = old_modifier * max_effect
			item.modify_max_integrity(item.max_integrity + new_durability_modifier - previous_durability_modifier)
		if(FORGE_EFFECT_FORCE)
			var/new_force_modifier = new_modifier * max_effect
			var/previous_force_modifier = old_modifier * max_effect
			item.force += new_force_modifier - previous_force_modifier
		if(FORGE_EFFECT_TOOLSPEED)
			var/new_toolspeed_modifier = new_modifier * max_effect
			var/previous_toolspeed_modifier = old_modifier * max_effect
			item.toolspeed += new_toolspeed_modifier - previous_toolspeed_modifier
		if(FORGE_EFFECT_REAGENT_INJECT)
			var/datum/component/reagent_imbued/reagent_component = item.GetComponent(/datum/component/reagent_imbued/)
			if(isnull(reagent_component))
				stack_trace("Reagent inject amount was increased via forging for an item that does not have reagent imbuing!")

			var/new_inject_modifier = new_modifier * max_effect
			var/previous_inject_modifier = old_modifier * max_effect
			reagent_component.inject_amount += new_inject_modifier - previous_inject_modifier
		else
			stack_trace("Tried to modify [item] with an invalid effect [forge_effect]!")

/proc/blacksmithing_change_material_integrity(obj/item/my_item, datum/material/material, amount, multiplier, removing = FALSE)
	var/base_modifier = material.get_property(MATERIAL_INTEGRITY)
	if(isnull(base_modifier))
		return

	var/integrity_mod = GET_MATERIAL_MODIFIER(base_modifier, multiplier)
	var/integrity_change = removing ? floor(my_item.max_integrity / integrity_mod) : ceil(my_item.max_integrity * integrity_mod)
	my_item.modify_max_integrity(integrity_change)

	var/list/armor_mods = material.get_armor_modifiers(multiplier)

	//with blacksmithing everything has to be addition based
	var/datum/armor/new_armor = get_armor_by_type(my_item.get_initial_armor_type())
	new_armor = new_armor.generate_new_with_multipliers(armor_mods)
	new_armor = new_armor.subtract_other_armor(my_item.get_initial_armor_type())
	new_armor = new_armor.generate_new_with_multipliers(list(ARMOR_ALL = 0.3)) //reduce effect because existing armor mults can be too much

	// Invert if we're removing our material
	if(!removing)
		new_armor = my_item.get_armor().add_other_armor(new_armor)
	else
		new_armor = my_item.get_armor().subtract_other_armor(new_armor)
	my_item.set_armor(new_armor)

/proc/blacksmithing_change_material_strength(obj/item/my_item, datum/material/material, mat_amount, multiplier, remove = FALSE)
	var/density = material.get_property(MATERIAL_DENSITY)
	var/hardness = material.get_property(MATERIAL_HARDNESS)
	var/flexibility = material.get_property(MATERIAL_FLEXIBILITY)
	if(isnull(density) || isnull(hardness) || isnull(flexibility))
		return

	// Item force calculation depends on its initial (assumed to be main) sharpness
	// Transforming component doesn't work with materials at all and will need a refactor to change that, so we don't care about it here.

	var/force_mod = 1
	var/throwforce_mod = 1

	switch (my_item.sharpness)
		if (NONE)
			// Blunt items are really hurt by all the flexing
			force_mod = (1 + (density - 4) * 0.1) / (1 + flexibility * 0.1)
			throwforce_mod = 1 + (density - 4) * 0.1 - flexibility * 0.1

		if (SHARP_EDGED)
			// Sharp items don't care about density and need high hardness to get a real bonus, but can tolerate (and benefit from) some flex
			force_mod = 1 + (hardness - 4) * 0.1
			throwforce_mod = 1 + (hardness - 4) * 0.1

			// Peaks out at 20% at flexibility of 1, drops off up to -80% at 10
			if (flexibility < 2)
				force_mod *= 1 + (1 - abs(1 - flexibility)) * 0.2
				throwforce_mod += (1 - abs(1 - flexibility)) * 0.2
			else
				force_mod *= 1 - (flexibility - 2) * 0.1
				throwforce_mod -= (flexibility - 2) * 0.1

		if (SHARP_POINTY)
			// Pointy items care about both density and hardness
			force_mod = 1 + MATERIAL_PROPERTY_DIVERGENCE(density, 4, 6) * 0.05 + (hardness - 4) * 0.1
			throwforce_mod = 1 + MATERIAL_PROPERTY_DIVERGENCE(density, 4, 6) * 0.05 * 0.05 + (hardness - 4) * 0.1
			// But are not affected by flexibility until higher values, although they don't benefit from it either
			if (flexibility > 4)
				force_mod *= (1 - (flexibility - 4) * 0.2)
				throwforce_mod -= (flexibility - 4) * 0.2

	// Just for sanity in case something breaks
	force_mod = clamp(force_mod, MATERIAL_MIN_FORCE_MULTIPLIER, MATERIAL_MAX_FORCE_MULTIPLIER)
	throwforce_mod = clamp(throwforce_mod, MATERIAL_MIN_FORCE_MULTIPLIER, MATERIAL_MAX_FORCE_MULTIPLIER)

	// change the forcemod to an added factor instead of a whole multiplier, then reduce the sum effect of the force mod because they currently go too fuggin hard
	force_mod = round((force_mod - 1) / 3.5, 0.01)
	throwforce_mod = round((throwforce_mod - 1) / 3.5, 0.01)
	if (!remove)
		my_item.force += initial(my_item.force) * GET_MATERIAL_MODIFIER(force_mod, multiplier)
		my_item.throwforce += initial(my_item.force) * GET_MATERIAL_MODIFIER(throwforce_mod, multiplier)
	else
		my_item.force -= initial(my_item.force) * GET_MATERIAL_MODIFIER(force_mod, multiplier)
		my_item.throwforce -= initial(my_item.force) * GET_MATERIAL_MODIFIER(throwforce_mod, multiplier)

/proc/get_material_quality_points_mult(datum/material/item_material)
	//material properties affect forging; high thermal conductivity and flexibility are a bonus while high density and hardness take away
	var/density = item_material.get_property(MATERIAL_DENSITY)
	var/hardness = item_material.get_property(MATERIAL_HARDNESS)
	var/flexibility = item_material.get_property(MATERIAL_FLEXIBILITY)
	var/thermal = item_material.get_property(MATERIAL_THERMAL)

	if(isnull(density) || isnull(hardness) || isnull(flexibility) || isnull(thermal))
		return 1
	else
		return ((flexibility * 3) + thermal) / (density + hardness)

///urgh tg needs a get_armor_initial proc, working around protected/private vars is really annoying here
/atom/proc/get_initial_armor_type()
	RETURN_TYPE(/datum/armor)
	return initial(armor_type)
