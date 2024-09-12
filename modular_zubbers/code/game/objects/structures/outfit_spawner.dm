
/// lets ghost respawn with specific outfits by clicking on the spawner, admins can configure it by clicking on it as well
/obj/structure/outfit_spawner
	name = "Outfit Spawner"
	desc = "A beacon that allows ghosts to respawn with specific outfits."
	icon = 'icons/obj/machines/beacon.dmi'
	icon_state = "yellowbeacon"
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// Faction to apply to the player when they spawn
	var/spawn_faction = null
	/// specific assoc list of outfits that can be chosen from
	var/list/outfits = list()
	/// specific list of ckeys that are allowed to spawn via this spawner
	var/list/allowed_ckeys = list()

/obj/structure/outfit_spawner/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

/obj/structure/outfit_spawner/examine(mob/user)
	. = ..()
	if(user.client && check_rights_for(user.client, R_ADMIN))
		. += "Click on it as ghost to configure, add the same outfit to remove it."
		. += "VV to change the spawn_faction variable to modify what faction the player spawn with."
		. += "Limitations: You must always re-select all outfits or ckeys each time you configure it!"
		. += "Currently allowed ckeys: [length(allowed_ckeys) ? allowed_ckeys.Join(", ") : "Any"]"
		. += "Currently available outfits: [length(outfits) ? outfits.Join(", ") : "None"]"

/obj/structure/outfit_spawner/attack_ghost(mob/user)
	. = ..()
	if(!user.client || !isobserver(user))
		return
	if(!check_rights_for(user.client, R_ADMIN) && length(allowed_ckeys) && !allowed_ckeys.Find(user.client.ckey))
		to_chat(user, span_warning("You are not allowed to spawn with this spawner."))
		return
	if(!configure(user))
		return
	if(!length(outfits))
		to_chat(user, span_warning("No outfits available, ask a admin to add one."))
		return
	var/chosen_outfit = tgui_input_list(user, "Choose an outfit to spawn with", "Choose loadout", outfits)
	if(!chosen_outfit)
		to_chat(user, span_warning("No outfit chosen, aborting."))
		return
	var/turf/spawn_point = pick(get_adjacent_open_turfs(get_turf(src)))
	var/mob/living/carbon/human/player_mob = new(spawn_point)
	player_mob.equipOutfit(chosen_outfit)
	user.client.prefs.safe_transfer_prefs_to(player_mob, is_antag = TRUE)
	if(spawn_faction)
		player_mob.faction += spawn_faction
	player_mob.ckey = user.client.ckey

/obj/structure/outfit_spawner/proc/configure(mob/user)
	if(!check_rights_for(user.client, R_ADMIN))
		return TRUE
	var/spawn_choice = tgui_alert(user, "Spawn or modify?", "Player or DM?", list("Spawn", "Modify"))
	if(spawn_choice == "Spawn")
		return TRUE
	var/choice = tgui_alert(user, "Modify ckey or outfit list?", "Ckey or outfit list?", list("Ckey", "Outfit"))
	switch(choice)
		if("Ckey")
			var/list/ckey = tgui_input_checkboxes(user, "Select keys to allow or disallow", "Ckey", get_all_ckeys(), 0, 999)
			allowed_ckeys = ckey
		if("Outfit")
			// get all outfits stored on the server
			var/list/master_outfits = list() // keep track of the types and instances of outfits
			var/list/select_outfits = list()
			var/index = 0
			for(var/datum/outfit/outfit as anything in GLOB.custom_outfits)
				if(!outfit.name)
					stack_trace("Outfit has no name, possibly non-instantiated outfit in GLOB.custom_outfits? Type: [outfit?.type ? outfit.type : "empty list entry"]")
					continue
				var/unique_name = master_outfits[outfit.name] ? "[outfit.name]_duplicate_id_[index]" : outfit.name
				select_outfits += unique_name
				master_outfits[unique_name] = outfit
				index++

			for(var/datum/outfit/outfit as anything in subtypesof(/datum/outfit))
				// todo figure out count of duplicates and increment the unique number by that
				// var/exists = select_outfits[initial(outfit.name)]
				var/outfit_name = initial(outfit.name)
				var/is_already_in = master_outfits[outfit_name]
				var/unique_name = is_already_in ? "[outfit_name]_duplicate_id_[index]" : outfit_name
				select_outfits += unique_name
				// subtypesof returns a list of TYPEs, while GLOBAL.custom_outfits is a list of INSTANCES
				// we don't instance it here as we'd need to delete them after, and that'd require us to compare with the custom_outfit list to not delete the original
				master_outfits[unique_name] = outfit
				index++

			var/list/add_outfit = tgui_input_checkboxes(user, "Select outfits to allow in this spawner", "Outfit name", select_outfits, 0, 999) // hilariously tgui_input_checkboxes does not support assoc lists, and neither already checked options
			var/list/result_outfits = list()
			if(!length(add_outfit))
				to_chat(user, span_warning("No outfits chosen, aborting."))
				return FALSE

			for(var/unique_name in add_outfit)
				var/datum/outfit/outfit = master_outfits[unique_name]
				if(ispath(outfit))
					outfit = new outfit
				if(!outfit)
					continue
				result_outfits += outfit

			// assoc key is the type of outfit, value is the name of the outfit
			if(!length(result_outfits))
				to_chat(user, span_warning("Something went wrong, no outfits were added."))
				stack_trace("Invalid result_outfit list generated from master_outfits.")
				return FALSE

			outfits = result_outfits
			to_chat(user, span_notice("Successfully configured outfits."))
	return FALSE


/obj/structure/outfit_spawner/proc/get_all_ckeys()
	. = list()
	for(var/client/client in GLOB.clients)
		. += client.ckey


/obj/structure/outfit_spawner/red
	icon_state = "syndbeacon"
	spawn_faction = "blue"

/obj/structure/outfit_spawner/blue
	icon_state = "bluebeacon"
	spawn_faction = "red"
