/obj/item/mod/construction/plating/lustwish
	icon = 'modular_zubbers/icons/mob/clothing/modsuit/mod_modules.dmi'
	icon_state = "lustwish-plating"
	theme = /datum/mod_theme/lustwish

/obj/item/mod/module/hypno_visor
	name = "Hypnosis Module"
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
