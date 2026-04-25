/datum/species/protean/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ProteanUI", "Protean Interface")
		ui.open()

/datum/species/protean/ui_data(mob/user)
	var/data = list()

	data["metal"] = get_metal()
	data["metal_max"] = max_metal()
	data["low_power"] = owner?.has_status_effect(/datum/status_effect/protean_low_power_mode)
	data["lock"] = species_modsuit?.modlocked
	data["icon"] = species_modsuit?.icon
	data["icon_state"] = species_modsuit?.icon_state
	return data

/datum/species/protean/ui_status(mob/user) // Protean's UI
	if(user == owner)
		return UI_INTERACTIVE
	. = ..()

/datum/species/protean/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("lock")
			owner.lock_suit()
		if("openui")
			species_modsuit.ui_interact(usr)
		if("power")
			owner.low_power()
		if("transform")
			owner.suit_transformation(owner == usr ? FALSE : TRUE) // Others can force the protean to fold.
		if("heal")
			owner.protean_heal()
	return TRUE

/datum/action/protean
	name = "Protean Interface"
	desc = "<b>Left Click</b> Opens the Protean interface.<br><b>Right Click</b> toggles suit transformation."
	button_icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	button_icon_state = "standard-control-sealed"

/datum/action/protean/Trigger(mob/clicker, trigger_flags)
	var/mob/living/carbon/owner = clicker
	var/datum/species/protean/species = owner?.dna.species
	if(!istype(species))
		return FALSE
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		species.owner.suit_transformation()
		return ..()
	species.owner.protean_main_ui()
	return TRUE

/datum/species/protean/proc/get_metal()
	var/obj/item/organ/stomach/protean/refactory = owner?.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(refactory))
		return 0
	return refactory.metal

/datum/species/protean/proc/max_metal()
	var/obj/item/organ/stomach/protean/refactory = owner?.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(refactory))
		return 1
	return refactory.metal_max


