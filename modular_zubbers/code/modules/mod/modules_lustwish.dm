/obj/item/mod/construction/plating/lustwish
	icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	icon_state = "lustwish-plating"
	theme = /datum/mod_theme/lustwish

/obj/item/mod/module/hypno_visor
	name = "hypnosis module"
	desc = "A module inserted into the visor of a suit in which commands can be processed. Use on self to set directives."
	icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	icon_state = "module_hypno"
	module_type = MODULE_PASSIVE
	complexity = 0
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0
	incompatible_modules = list(/obj/item/mod/module/hypno_visor)
	required_slots = list(ITEM_SLOT_HEAD)
	overlay_state_inactive = "module_hypno_overlay"
	overlay_icon_file = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	var/hypno_message

/obj/item/mod/module/hypno_visor/Destroy()
	if(!mod)
		return ..()
	if(mod.wearer && part_activated)
		mod.wearer.cure_trauma_type(/datum/brain_trauma/very_special/induced_hypnosis, TRAUMA_RESILIENCE_MAGIC)
	return ..()

/obj/item/mod/module/hypno_visor/attack_self(mob/user)
	. = ..()
	hypno_message = tgui_input_text(user, "Change the hypnotic phrase.", max_length = MAX_MESSAGE_LEN)

/obj/item/mod/module/hypno_visor/on_part_activation()
	if(!(mod.wearer.client?.prefs?.read_preference(/datum/preference/toggle/erp/hypnosis) && mod.wearer.client.prefs.read_preference(/datum/preference/toggle/erp/sex_toy)))
		return to_chat(mod.wearer, span_warning("Mind resilient to hypnotic effects: Shutting down"))
	if(hypno_message == "" || isnull(hypno_message))
		hypno_message = "Obey"
	mod.wearer.gain_trauma(new /datum/brain_trauma/very_special/induced_hypnosis(hypno_message), TRAUMA_RESILIENCE_MAGIC)

/obj/item/mod/module/hypno_visor/on_part_deactivation(deleting = FALSE)
	mod.wearer.cure_trauma_type(/datum/brain_trauma/very_special/induced_hypnosis, TRAUMA_RESILIENCE_MAGIC)

/obj/item/mod/module/hypno_visor/on_install()
	. = ..()
	if(mod.skin != "lustwish")
		overlay_state_inactive = null // Visual thing. Removes the overlay if it's not a part of the lustwish suit.

/obj/item/mod/module/hypno_visor/on_uninstall(deleting = FALSE)
	. = ..()
	if(isnull(overlay_state_inactive))
		overlay_state_inactive = initial(overlay_state_inactive)

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

