/obj/item/disk/bitrunning/prefs
	name = "DeForest biological simulation disk"
	desc = "A disk containing the biological simulation data necessary to load custom characters into bitrunning domains."

	w_class = WEIGHT_CLASS_SMALL

	var/datum/preferences/loaded_preference

	var/include_loadout = FALSE

/obj/item/disk/bitrunning/prefs/examine(mob/user)
	. = ..()
	if(!isnull(loaded_preference))
		var/name = loaded_preference.read_preference(/datum/preference/name/real_name)
		. += "It currently has the character [name] loaded, with loadouts [(include_loadout ? "enabled" : "disabled")]"
		. += span_notice("Ctrl-Click to change loadout loading")

/obj/item/disk/bitrunning/prefs/item_ctrl_click(mob/user)
	include_loadout = !include_loadout // We just switch this around. Elegant!
	balloon_alert(user, include_loadout ? "Loadout enabled" : "Loadout disabled")

/obj/item/disk/bitrunning/prefs/attack_self(mob/user, modifiers)
	. = ..()

	var/list/prefdata_names = user.client.prefs?.create_character_profiles()
	if(isnull(prefdata_names))
		return

	var/response = tgui_alert(user, message = "Change selected prefs?", title = "Prefchange", buttons = list("Yes", "No"))
	if(isnull(response) || response == "No")
		return
	var/choice = tgui_input_list(user, message = "Select a character",  title = "Character selection", items = prefdata_names)
	if(isnull(choice) || !user.is_holding(src))
		return

	loaded_preference = new(user.client)
	loaded_preference.load_character(prefdata_names.Find(choice))

	balloon_alert(user, "character set")
	to_chat(user, span_notice("Character set to [choice] sucessfully!"))

/datum/outfit/job/bitrunner
	r_pocket = /obj/item/disk/bitrunning/prefs

/datum/orderable_item/bitrunning_tech/pref_item
	cost_per_order = 500
	purchase_path = /obj/item/disk/bitrunning/prefs
	desc = "This disk contains a program that lets you load in custom characters."

// Bitrunning martial arts. Instead of being given a book, you just start with them already known in the domain.

/obj/item/disk/bitrunning/martialarts
	name = "bitrunning program: martial arts"
	desc = "Now, we're supposed to start with these operation programs first, but that's major boring shit. Let's do something a little more fun. How about combat training?"
	var/datum/martial_art/granted_martial_art

	var/list/datum/martial_art/selectable_martial_arts = list(
		/datum/martial_art/boxing/hunter,
		/datum/martial_art/boxing/evil,
		/datum/martial_art/cqc,
	)

/obj/item/disk/bitrunning/martialarts/load_onto_avatar(mob/living/carbon/human/neo, mob/living/carbon/human/avatar, domain_flags)
	if(isnull(granted_martial_art))
		return BITRUNNER_GEAR_LOAD_FAILED

	if(locate(granted_martial_art) in avatar.martial_arts)
		return BITRUNNER_GEAR_LOAD_FAILED

	var/datum/martial_art/martial_art = new granted_martial_art(avatar)
	if(!martial_art.teach(avatar))
		qdel(martial_art)
		return BITRUNNER_GEAR_LOAD_FAILED
	return NONE

/obj/item/disk/bitrunning/martialarts/attack_self(mob/user, modifiers)
	if(choice_made)
		return

	var/list/names = list()
	for(var/datum/martial_art/martial_art_type as anything in selectable_martial_arts)
		names += initial(martial_art_type.name)

	var/choice = tgui_input_list(user, message = "Select a martial art", title = "Bitrunning Program", items = names)
	if(isnull(choice) || !user.is_holding(src))
		return

	for(var/datum/martial_art/martial_art_type as anything in selectable_martial_arts)
		if(initial(martial_art_type.name) == choice)
			granted_martial_art = martial_art_type

	if(isnull(granted_martial_art))
		return

	balloon_alert(user, "selected")
	playsound(user, 'sound/items/click.ogg', 50, TRUE)
	choice_made = choice


/datum/orderable_item/bitrunning_tech/martialarts
	cost_per_order = 1250
	purchase_path = /obj/item/disk/bitrunning/martialarts
	desc = "This disk contains a program that lets you load a martial art of your choosing in the simulation."
