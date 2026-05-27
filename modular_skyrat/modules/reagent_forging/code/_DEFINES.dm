
//the list of possible things people can make if they have maxed forging skill
#define COMSIG_SMITHING_QUENCH "smithing_done"
#define COMSIG_SMITHING_PASSIVE_COOLED "smithing_passive_cooled"

#define DOAFTER_SMITHING_FORGE "smithing_forging_doafter"
#define DOAFTER_SMITHING_ANVIL "smithing_anvil_doafter"
#define DOAFTER_SMITHING_WATER_BASIN "smithing_waterbasin_doafter"

#define DOAFTER_REVOLVER_HAMMER_COCK "smithing_revolver_hammer_cock_doafter"

#define FORGING_WEAPON_REFORGING_MAX_QUALITY 16
#define FORGING_WEAPON_REFORGING_AVERAGE_WAIT 2 SECONDS
#define FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS 10
#define FORGING_WEAPON_REFORGING_MAX_BAD_HITS 6

#define FORGING_CLOTHING_REFORGING_MAX_QUALITY 16
#define FORGING_CLOTHING_REFORGING_AVERAGE_WAIT 2 SECONDS
#define FORGING_CLOTHING_REFORGING_MAX_PERFECT_HITS 10
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

///helper function - given two ratios, a forge effect, an item, and a maximal value, it gives a new modifier and resets the old modifier to the item
/proc/give_added_modifying_effect_to_item(forge_effect, old_modifier, new_modifier, obj/item/item, max_effect)
	switch(forge_effect)
		if(FORGE_EFFECT_ARMOR)
			var/datum/armor/indexed_armor = get_armor_by_type(max_effect)
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
			item.max_integrity += new_durability_modifier - previous_durability_modifier
		if(FORGE_EFFECT_FORCE)
			var/new_force_modifier = new_modifier * max_effect
			var/previous_force_modifier = old_modifier * max_effect
			item.force += new_force_modifier - previous_force_modifier
		if(FORGE_EFFECT_REAGENT_INJECT)
			var/datum/component/reagent_imbued/reagent_component = item.GetComponent(/datum/component/reagent_imbued/)
			if(isnull(reagent_component))
				stack_trace("Reagent inject amount was increased via forging for an item that does not have reagent imbuing!")

			var/new_inject_modifier = new_modifier * max_effect
			var/previous_inject_modifier = old_modifier * max_effect
			reagent_component.inject_amount += new_inject_modifier - previous_inject_modifier
		else
			stack_trace("Tried to modify [item] with an invalid effect [forge_effect]!")
