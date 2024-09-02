
/// lets ghost respawn with specific outfits by clicking on the spawner, admins can configure it by clicking on it as well
/obj/structure/outfit_spawner
	name = "Outfit Spawner"
	icon = 'icons/obj/machines/beacon.dmi'
	icon_state = "yellowbeacon"
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
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
		. += "Alt click to configure, add the same outfit to remove it."
		. += "Currently allowed ckeys: [length(allowed_ckeys) ? allowed_ckeys.Join(", ") : "None"]"
		. += "Currently available outfits: [length(outfits) ? outfits.Join(", ") : "None"]"

/obj/structure/outfit_spawner/attack_ghost(mob/user)
	. = ..()
	if(!user.client || !isobserver(user))
		return
	if(!check_rights_for(user.client, R_ADMIN) && !allowed_ckeys.Find(user.client.ckey))
		return
	if(!configure(user) || !length(outfits))
		return
	var/list/outfit_names = list()
	for(var/datum/outfit/outfit as anything in outfits)
		outfit_names += initial(outfit.name)
	var/chosen_outfit = tgui_input_list(user, "Choose an outfit to spawn with", outfit_names)
	if(!chosen_outfit)
		return
	var/datum/outfit/outfit_instance = outfits.Find(chosen_outfit)
	var/turf/spawn_point = pick(get_adjacent_open_turfs(get_turf(src)))
	var/mob/living/carbon/human/player_mob = new(spawn_point)
	player_mob.equipOutfit(outfit_instance)
	user.client.prefs.safe_transfer_prefs_to(player_mob, is_antag = TRUE)

/obj/structure/outfit_spawner/proc/configure(mob/user)
	if(!user.client || !check_rights_for(user.client, R_ADMIN))
		return FALSE
	var/spawn_choice = tgui_alert(user, "Spawn or modify?", "DM or Player?", list("Spawn", "Modify"))
	if(spawn_choice == "Spawn")
		return FALSE
	var/choice = tgui_alert(user, "Modify ckey or outfit list?", "Ckey or outfit list?", list("Ckey", "outfit"))
	switch(choice)
		if("ckey")
			var/ckey = tgui_input_checkboxes(user, "Select keys to allow or disallow", "Ckey", GLOB.player_list)
			if(allowed_ckeys.Find(ckey))
				allowed_ckeys -= ckey
				. += "Removed ckey [ckey] from allowed list."
			else
				allowed_ckeys += ckey
				. += "Added ckey [ckey] to allowed list."
		if("outfit")
			// get all outfits stored on the server
			var/datum/outfit/add_outfit = tgui_input_list(user, "Enter the name of the outfit to add", "Outfit name", GLOB.custom_outfits)
			for(var/datum/outfit/outfit as anything in outfits)
				if(outfit == add_outfit)
					to_chat(user, span_notice("Outfit [outfit.name] already exists in the list of outfits, removing."))
					outfits -= outfit
					break
			outfits += add_outfit
			to_chat(user, span_notice("Outfit [initial(add_outfit.name)] added to the list of outfits."))

	return TRUE
