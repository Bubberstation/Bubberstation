/// Modular Map Loader doesnt like subfolders
/datum/lazy_template/virtual_domain/ancient_milsim
	name = "Ancient Military Simulator"
	announce_to_ghosts = TRUE
	cost = BITRUNNER_COST_HIGH
	desc = "Recreate the events of the Border War's 'hot' part-long-gone as a Solarian strike team sweeping CIN compounds; sponsored by the SolFed recreation enthusiasts. \
	Multiplayer playthrough and proper preparation highly recommended."
	completion_loot = list(/obj/item/stack/spacecash/c200 = 3) //Sponsored
	difficulty = BITRUNNER_DIFFICULTY_HIGH
	help_text = "The last part of this domain has a chance to be very PvP-centric. It's best if you don't come alone, and smuggle some ability and gear disks."
	forced_outfit = /datum/outfit/solfed_bitrun
	key = "ancient_milsim"
	map_name = "skyrat_ancientmilsim"
	mob_modules = list(/datum/modular_mob_segment/cin_mobs)
	reward_points = BITRUNNER_REWARD_HIGH
	secondary_loot = list(
		/obj/item/stack/spacecash/c100 = 12,
		/obj/item/disk/bitrunning/item/ancient_milsim = 3,
	)
