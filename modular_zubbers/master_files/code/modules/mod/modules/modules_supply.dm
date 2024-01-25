/obj/item/mod/module/ash_accretion
	/// Is this ash accretion module providing its perks? Separate from active, because I don't know how it would interact with everything else as it's a passive module.
	var/protection_enabled = FALSE

/obj/item/mod/module/ash_accretion/on_suit_activation()
	. = ..()
	protection_enabled = TRUE
	RegisterSignals(mod, list(COMSIG_MOD_DEPLOYED, COMSIG_MOD_RETRACTED), PROC_REF(on_mod_toggle))

/obj/item/mod/module/ash_accretion/on_suit_deactivation(deleting)
	. = ..()
	protection_enabled = FALSE
	UnregisterSignal(mod, list(COMSIG_MOD_DEPLOYED, COMSIG_MOD_RETRACTED))

/obj/item/mod/module/ash_accretion/proc/on_mod_toggle()

	if((mod.wearer.head == mod.helmet) && (mod.wearer.wear_suit == mod.chestplate) && (mod.wearer.gloves == mod.gauntlets) && (mod.wearer.shoes == mod.boots) && mod.active)
		// suit is on and fully deployed, give them their proofing
		mod.wearer.add_traits(list(TRAIT_ASHSTORM_IMMUNE, TRAIT_SNOWSTORM_IMMUNE), MOD_TRAIT)
		RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
		balloon_alert(mod.wearer, "ash accretion enabled")
		protection_enabled = TRUE
		return
	// if their suit is not fully deployed, take their proofing away
	if(!protection_enabled)
		return
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	mod.wearer.remove_traits(list(TRAIT_ASHSTORM_IMMUNE, TRAIT_SNOWSTORM_IMMUNE), MOD_TRAIT)
	balloon_alert(mod.wearer, "ash accretion disabled!")
	protection_enabled = FALSE
	if(!traveled_tiles)
		return
	var/list/parts = mod.mod_parts + mod
	var/datum/armor/to_remove = get_armor_by_type(armor_mod)
	for(var/obj/item/part as anything in parts)
		part.set_armor(part.get_armor().subtract_other_armor(to_remove.generate_new_with_multipliers(list(ARMOR_ALL = traveled_tiles))))
	if(traveled_tiles == max_traveled_tiles)
		mod.slowdown += speed_added
		mod.wearer.update_equipment_speed_mods()
	traveled_tiles = 0
