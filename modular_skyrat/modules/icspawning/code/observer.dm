// SKYRAT MODULE IC-SPAWNING https://github.com/Skyrat-SS13/Skyrat-tg/pull/104

/mob/dead/observer/CtrlClickOn(mob/target)
	quickicspawn(target, src)

/mob/dead/observer/proc/quickicspawn(mob/target, mob/user)
	if(!isobserver(target) || !check_rights(R_SPAWN))
		return

	/// Whether to spawn in with sparks or in a pod
	var/teleport_option
	/// Teleportation options
	var/list/teleport_options = list("Bluespace", "Pod", "Cancel")
	/// What style of pod to use, if the option was chosen
	var/pod_style
	/// Assoc list of pod UI names to style datums, static so it's only built once
	var/static/list/pod_styles
	/// Whether to spawn in as your current character or a random one
	var/character_option
	/// Character options
	var/list/character_options = list("Selected Character", "Random Character", "Cancel")
	/// Which outfit to use
	var/outfit_option
	/// Initial list of outfits
	var/list/outfit_options = list(
		"Bluespace Tech" = /datum/outfit/admin/bst,
		"Naked" = /datum/outfit,
		"Show All" = "Show All",
	)
	/// Whether to grant the return spell
	var/give_return
	/// Whether to spawn with quirks and/or loadout
	var/give_quirks_loadout
	/// Quirk/loadout options
	var/list/quirk_loadout_options = list("Quirks Only", "Loadout Only", "Quirks & Loadout", "None")

	teleport_option = tgui_alert(user, "How would you like to be spawned in?", "IC Quick Spawn", teleport_options)
	if(!teleport_option || teleport_option == teleport_options[3])
		return

	if(teleport_option == teleport_options[2])
		if(!pod_styles)
			pod_styles = list()
			for(var/datum/pod_style/style as anything in typesof(/datum/pod_style))
				pod_styles[style::ui_name] = style

		pod_style = tgui_input_list(user, "Which style of pod?", "IC Quick Spawn", pod_styles)
		pod_style = pod_styles[pod_style]
		if(!pod_style)
			return

	character_option = tgui_alert(user, "Which character to spawn as?", "IC Quick Spawn", character_options)
	if(!character_option || character_option == character_options[3])
		return

	outfit_option = tgui_input_list(user, "Which outfit to use?", "IC Quick Spawn", outfit_options)
	if(outfit_option == outfit_options[3])
		outfit_option = user.client.robust_dress_shop_skyrat()
	else
		outfit_option = outfit_options[outfit_option]
	if(!outfit_option)
		return

	// The give return option is only relevant if the user is spawning in someone else
	if(target != user)
		give_return = tgui_alert(user, "Do you want to give them the power to return? Not recommended for non-admins.", "IC Quick Spawn", list("No", "Yes"))
		if(!give_return)
			return

	if(character_option == character_options[1])
		give_quirks_loadout = tgui_input_list(user, "Include quirks/loadout?", "IC Quick Spawn", quirk_loadout_options)
		if(!give_quirks_loadout)
			return

	var/turf/current_turf = get_turf(target)
	var/mob/living/carbon/human/new_player = new(current_turf)
	if(character_option == character_options[1])
		new_player.name = target.name
		new_player.real_name = target.real_name
		target.client?.prefs.safe_transfer_prefs_to(new_player)
		new_player.dna.update_dna_identity()

	if(give_quirks_loadout == quirk_loadout_options[1])
		SSquirks.AssignQuirks(new_player, target.client)
		new_player.equipOutfit(outfit_option)
	else if(give_quirks_loadout == quirk_loadout_options[2])
		new_player.equip_outfit_and_loadout(outfit_option, target.client?.prefs)
	else if(give_quirks_loadout == quirk_loadout_options[3])
		SSquirks.AssignQuirks(new_player, target.client)
		new_player.equip_outfit_and_loadout(outfit_option, target.client?.prefs)
	else if(give_quirks_loadout == quirk_loadout_options[4] || !give_quirks_loadout) // null case matches if they chose random character
		new_player.equipOutfit(outfit_option)

	if(target.mind)
		target.mind.transfer_to(new_player, TRUE)
	else
		new_player.key = target.key
	qdel(target)

	if(give_return != "No")
		var/datum/action/cooldown/spell/return_back/return_spell = new
		return_spell.Grant(new_player)

	if(teleport_option == teleport_options[1])
		new_player.forceMove(current_turf)
		playsound(new_player, 'sound/effects/magic/Disable_Tech.ogg', 100, FALSE)
		var/datum/effect_system/spark_spread/quantum/sparks = new
		sparks.set_up(10, 1, new_player)
		sparks.attach(get_turf(new_player))
		sparks.start()
	else if(teleport_option == teleport_options[2])
		var/obj/structure/closet/supplypod/podspawn/empty_pod = new(null, pod_style)
		new_player.forceMove(empty_pod)
		new /obj/effect/pod_landingzone(current_turf, empty_pod)

/client/proc/robust_dress_shop_skyrat()
	var/list/baseoutfits = list("Custom","As Job...", "As Plasmaman...")
	var/list/outfits = list()
	var/list/paths = subtypesof(/datum/outfit) - typesof(/datum/outfit/job) - typesof(/datum/outfit/plasmaman)

	for(var/path in paths)
		// Get the datum from the path so we can grab its name.
		var/datum/outfit/path_as_outfit = path
		outfits[initial(path_as_outfit.name)] = path

	var/dresscode = tgui_input_list(src, "Select outfit", "Robust quick dress shop", baseoutfits + sort_list(outfits))

	if (isnull(dresscode))
		return

	if (outfits[dresscode])
		dresscode = outfits[dresscode]

	if (dresscode == "As Job...")
		var/list/job_paths = subtypesof(/datum/outfit/job)
		var/list/job_outfits = list()
		for(var/path in job_paths)
			var/datum/outfit/O = path
			job_outfits[initial(O.name)] = path

		dresscode = input("Select job equipment", "Robust quick dress shop") as null|anything in sort_list(job_outfits)
		dresscode = job_outfits[dresscode]
		if(isnull(dresscode))
			return

	if (dresscode == "As Plasmaman...")
		var/list/plasmaman_paths = typesof(/datum/outfit/plasmaman)
		var/list/plasmaman_outfits = list()
		for(var/path in plasmaman_paths)
			var/datum/outfit/O = path
			plasmaman_outfits[initial(O.name)] = path

		dresscode = input("Select plasmeme equipment", "Robust quick dress shop") as null|anything in sort_list(plasmaman_outfits)
		dresscode = plasmaman_outfits[dresscode]
		if(isnull(dresscode))
			return

	if (dresscode == "Custom")
		var/list/custom_names = list()
		for(var/datum/outfit/req_outfit in GLOB.custom_outfits)
			custom_names[req_outfit.name] = req_outfit
		var/selected_name = input("Select outfit", "Robust quick dress shop") as null|anything in sort_list(custom_names)
		dresscode = custom_names[selected_name]
		if(isnull(dresscode))
			return

	return dresscode
