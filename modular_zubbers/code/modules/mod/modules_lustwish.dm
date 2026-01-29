/obj/item/mod/construction/plating/lustwish
	icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	icon_state = "lustwish-plating"
	theme = /datum/mod_theme/lustwish

/obj/item/mod/module/hypno_visor
	name = "\improper MOD hypnotic visor module"
	desc = "A module inserted into the visor of a suit in which commands can be processed."
	icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	icon_state = "module_hypno"
	complexity = 0
	idle_power_cost = 0
	incompatible_modules = list(/obj/item/mod/module/hypno_visor)
	required_slots = list(ITEM_SLOT_HEAD)
	overlay_icon_file = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'

	module_type = MODULE_PASSIVE //These three are changed when the control wire is snipped
	overlay_state_active = null
	overlay_state_inactive = "module_hypno_overlay"

	var/hypno_message = "Obey"
		///Does the visor overlay show on the character sprite when installed? Only eligible with certain skins.
	var/visor_effect = TRUE

/obj/item/mod/module/hypno_visor/examine(mob/user)
	. = ..()
	. += span_info("It's currently programmed with the following directive: \"[hypno_message]\" Use it in-hand to rewrite it.")
	. += span_info("Its visor will [visor_effect ? "" : "<b>not</b>"] display an external hypnotic effect. Use a screwdriver to toggle.")
	. += span_info("Its control wire is currently [(module_type == MODULE_TOGGLE) ? \
						"<b>intact,</b> allowing for on-the-fly configuration via the MOD UI." \
						: \
						"<b>snipped,</b> forcing the module to be always-on when the helmet is activated."] \
					Use wirecutters to toggle.")

/obj/item/mod/module/hypno_visor/attack_self(mob/user)
	. = ..()
	var/message_input = tgui_input_text(user, "Change the hypnotic phrase.", default = hypno_message, max_length = MAX_MESSAGE_LEN)
	if(message_input)
		hypno_message = message_input
	else
		hypno_message = "Obey"

/obj/item/mod/module/hypno_visor/screwdriver_act(mob/living/user, obj/item/tool)
	visor_effect = !visor_effect
	to_chat(user, span_notice("You turn the visor display of [src] [visor_effect ? "on" : "off"]."))
	return TRUE

/obj/item/mod/module/hypno_visor/wirecutter_act(mob/living/user, obj/item/tool)
	if(module_type == MODULE_TOGGLE) // If it's not toggle, make it so. If it is, make it passive.
		module_type = MODULE_PASSIVE
		overlay_state_active = null
		overlay_state_inactive = "module_hypno_overlay"
	else
		module_type = MODULE_TOGGLE
		overlay_state_active = "module_hypno_overlay"
		overlay_state_inactive = null

	to_chat(user, span_notice("You [(module_type == MODULE_TOGGLE) ? "mend" : "snip"] the control wire on [src]."))
	return TRUE

/obj/item/mod/module/hypno_visor/on_install()
	. = ..()
	if(mod.skin != "lustwish" && visor_effect == TRUE)
		overlay_state_inactive = null // Visual thing. Removes the overlay if it's not a part of the lustwish suit.
		overlay_state_active = null
		visor_effect = FALSE
		balloon_alert(usr, "visor effect unavailable for this plating!")

/obj/item/mod/module/hypno_visor/on_uninstall(deleting = FALSE)
	. = ..()
	overlay_state_inactive = initial(overlay_state_inactive) //This part only matters for visor/passive
	overlay_state_active = initial(overlay_state_active) //This part only matters for visor/toggleable

/obj/item/mod/module/hypno_visor/proc/apply_hypnosis()
	if(!(mod.wearer.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis) && mod.wearer.client.prefs.read_preference(/datum/preference/toggle/erp/sex_toy)))
		return to_chat(mod.wearer, span_warning("Mind resilient to hypnotic effects: Shutting down"))
	if(hypno_message == "" || isnull(hypno_message))
		hypno_message = "Obey"
	mod.wearer.gain_trauma(new /datum/brain_trauma/very_special/induced_hypnosis(hypno_message), TRAUMA_RESILIENCE_MAGIC)

/obj/item/mod/module/hypno_visor/Destroy()
	if(!mod)
		return ..()
	if(module_type == ((module_type == MODULE_PASSIVE && part_activated) || (module_type == MODULE_TOGGLE && active)) && mod.wearer)
		mod.wearer.cure_trauma_type(/datum/brain_trauma/very_special/induced_hypnosis, TRAUMA_RESILIENCE_MAGIC)
	return ..()

/obj/item/mod/module/hypno_visor/on_part_activation()
	if(module_type == MODULE_PASSIVE)
		apply_hypnosis()

/obj/item/mod/module/hypno_visor/on_part_deactivation(deleting = FALSE)
	if(module_type == MODULE_PASSIVE)
		mod.wearer.cure_trauma_type(/datum/brain_trauma/very_special/induced_hypnosis, TRAUMA_RESILIENCE_MAGIC)

/obj/item/mod/module/hypno_visor/on_activation(mob/activator)
	if(module_type == MODULE_TOGGLE)
		apply_hypnosis()

/obj/item/mod/module/hypno_visor/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	if(module_type == MODULE_TOGGLE)
		mod.wearer.cure_trauma_type(/datum/brain_trauma/very_special/induced_hypnosis, TRAUMA_RESILIENCE_MAGIC)

/obj/item/mod/module/hypno_visor/get_configuration()
	. = ..()
	if(module_type == MODULE_TOGGLE)
		.["hypno_message"] = add_ui_configuration("Hypnotic Message", "button", "list")
		.["visor_effect"] = add_ui_configuration("Visor Effect", "bool", visor_effect)

/obj/item/mod/module/hypno_visor/configure_edit(key, value)
	switch(key)
		if("hypno_message")
			hypno_message = tgui_input_text(usr, "Change the hypnotic phrase.", default = hypno_message, max_length = MAX_MESSAGE_LEN)
			if(active)
				balloon_alert(usr, "restart to finalize changes")
		if("visor_effect")
			if(mod.skin != "lustwish")
				return balloon_alert(usr, "visor effect unavailable for this plating!")
			visor_effect = text2num(value)
			overlay_state_active = visor_effect ? "module_hypno_overlay" : null
			if(active)
				balloon_alert(usr, "restart to finalize changes")


/datum/storage/pockets/small/remote_module
	max_slots = 1

/datum/storage/pockets/small/remote_module/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(can_hold_list = list(/obj/item/remote_controller))

/obj/item/mod/module/remote_control
	name = "modsuit remote module"
	desc = "A module, once inserted, will allow anyone with its linked remote to control all functionality of the suit."
	icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	icon_state = "module_remote"
	module_type = MODULE_PASSIVE
	complexity = 0
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0
	incompatible_modules = list(/obj/item/mod/module/remote_control)
	required_slots = list(ITEM_SLOT_OCLOTHING)
	overlay_state_inactive = "module_remote_overlay"
	overlay_icon_file = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'

/obj/item/mod/module/remote_control/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/remote_module)
	var/obj/item/remote_controller/remote = new /obj/item/remote_controller()
	remote.module = src
	remote.forceMove(src)

/obj/item/mod/module/remote_control/can_install(obj/item/mod/control/mod)
	if(locate(/obj/item/remote_controller) in contents)
		balloon_alert(usr, "remove remote from storage")
		return FALSE
	return TRUE

/obj/item/mod/module/remote_control/attack_self(mob/user)
	. = ..()
	atom_storage?.open_storage(user)

/obj/item/remote_controller
	name = "modsuit remote"
	desc = "A remote that allows control of a modsuit once its paired module is inserted."
	icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	icon_state = "remote_item"
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/mod/module/remote_control/module

/obj/item/remote_controller/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MODsuitremote")
		ui.open()

/obj/item/remote_controller/ui_data(mob/user)
	var/list/data = list()
	data["linked_suit"] = !!module?.mod
	data["wearer"] = !!module.mod?.wearer
	data["erp_pref_check"] = module.mod?.wearer?.client?.prefs.read_preference(/datum/preference/toggle/erp/sex_toy)
	if(module.mod)
		data += module.mod.ui_data()
	return data

/obj/item/remote_controller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("emote")
			module.mod.wearer.emote("me", 1, params["emote"], TRUE)

/obj/item/remote_controller/proc/forced_emote(emoter, user)

/obj/item/remote_controller/Initialize(mapload, module_init)
	. = ..()
	src.module = module_init

/obj/item/remote_controller/ui_static_data(mob/user)
	return module?.mod?.ui_static_data()

/obj/item/remote_controller/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	return module?.mod?.ui_act(action, params, ui, state)

/obj/item/remote_controller/Destroy(force)
	module = null
	return ..()

