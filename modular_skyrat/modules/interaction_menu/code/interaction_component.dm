#define INTERACTION_MENU_SELECTION_RANGE 3

/datum/component/interactable
	/// A hard reference to the parent
	var/mob/living/carbon/human/self = null
	/// A list of interactions that the user can engage in.
	var/list/datum/interaction/interactions
	var/interact_last = 0
	var/interact_next = 0
	///Holds a reference to a relayed body if one exists
	var/obj/body_relay = null
	/// Per-viewer target choices; the owning component remains unchanged.
	var/list/selected_characters = list()

/datum/component/interactable/Initialize(...)
	if(QDELETED(parent))
		qdel(src)
		return

	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	self = parent

	build_interactions_list()

/datum/component/interactable/proc/build_interactions_list()
	interactions = list()
	for(var/iterating_interaction_id in GLOB.interaction_instances)
		var/datum/interaction/interaction = GLOB.interaction_instances[iterating_interaction_id]
		if(interaction.lewd)
			if(!self.client?.prefs?.read_preference(/datum/preference/toggle/erp))
				continue
			if(interaction.sexuality != "" && interaction.sexuality != self.client?.prefs?.read_preference(/datum/preference/choiced/erp_sexuality))
				continue
		interactions.Add(interaction)

/datum/component/interactable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(open_interaction_menu))

/datum/component/interactable/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT)

/datum/component/interactable/Destroy(force, silent)
	self = null
	interactions = null
	selected_characters = null
	return ..()

/datum/component/interactable/proc/open_interaction_menu(datum/source, mob/user)
	if(!ishuman(user))
		return
	build_interactions_list()
	ui_interact(user)

/datum/component/interactable/proc/can_interact(datum/interaction/interaction, mob/living/carbon/human/target)
	if(!interaction.allow_act(target, self))
		return FALSE
	if(interaction.lewd && !target.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE
	if(!interaction.distance_allowed && !target.Adjacent(self))
		if(!body_relay || !target.Adjacent(body_relay))
			return FALSE
	if(interaction.category == INTERACTION_CAT_HIDE)
		return FALSE
	if(self == target && interaction.usage == INTERACTION_OTHER)
		return FALSE
	return TRUE

/// UI Control
/datum/component/interactable/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InteractionPanel")
		ui.open()

/datum/component/interactable/ui_status(mob/user, datum/ui_state/state)
	if(!ishuman(user))
		return UI_CLOSE

	return UI_INTERACTIVE // This UI is always interactive as we handle distance flags via can_interact

/datum/component/interactable/ui_static_data(mob/user)
	var/list/data = list()
	data["arousalLimit"] = AROUSAL_LIMIT
	return data

/// Visible nearby humans with interaction components; selection is revalidated on use.
/datum/component/interactable/proc/get_selectable_characters(mob/user)
	var/list/characters = list()
	if(ishuman(user) && user.GetComponent(/datum/component/interactable))
		characters += user
	for(var/mob/living/carbon/human/person in view(INTERACTION_MENU_SELECTION_RANGE, user))
		if(person == user || QDELETED(person) || !can_see(user, person))
			continue
		if(person.GetComponent(/datum/component/interactable))
			characters += person
	return characters

/datum/component/interactable/ui_close(mob/user)
	selected_characters -= REF(user)
	return ..()

/// Resolve a viewer's choice without sharing selection with other open menus.
/datum/component/interactable/proc/get_selected_component(mob/user)
	var/datum/weakref/selected_ref = selected_characters[REF(user)]
	if(!selected_ref)
		return src
	var/mob/living/carbon/human/selected = selected_ref.resolve()
	if(QDELETED(selected) || !(selected in get_selectable_characters(user)))
		selected_characters -= REF(user)
		return src
	var/datum/component/interactable/selected_component = selected.GetComponent(/datum/component/interactable)
	return selected_component || src

/datum/component/interactable/ui_data(mob/user)
	var/datum/component/interactable/selected_component = get_selected_component(user)
	return selected_component.build_ui_data(user)

/datum/component/interactable/proc/build_ui_data(mob/user)
	var/list/data = list()
	var/list/descriptions = list()
	var/list/categories = list()
	var/list/display_categories = list()
	var/list/colors = list()
	for(var/datum/interaction/interaction in interactions)
		if(!can_interact(interaction, user))
			continue
		if(!categories[interaction.category])
			categories[interaction.category] = list(interaction.name)
		else
			categories[interaction.category] += interaction.name
			var/list/sorted_category = sort_list(categories[interaction.category])
			categories[interaction.category] = sorted_category
		descriptions[interaction.name] = interaction.description
		colors[interaction.name] = interaction.color
	data["descriptions"] = descriptions
	data["colors"] = colors
	for(var/category in categories)
		display_categories += category
	data["categories"] = sort_list(display_categories)
	data["ref_user"] = REF(user)
	data["ref_self"] = REF(self)
	data["self"] = self.name
	data["profile"] = list(
		"name" = self.name,
		"headshot" = interaction_panel_get_headshot(self),
		"details" = interaction_panel_build_anatomy_details(self),
		"tags" = interaction_panel_erp_enabled(user) ? interaction_panel_build_status_tags(self) : list(),
	)
	data["self_data"] = interaction_panel_build_self_data(user)
	data["theme"] = interaction_panel_read_mob_character_pref(user, /datum/preference/choiced/interaction_menu_theme) || "default"
	var/list/characters = list()
	for(var/mob/living/carbon/human/person as anything in get_selectable_characters(user))
		characters += list(list("name" = person.name, "ref" = REF(person)))
	data["characters"] = characters
	if(body_relay)
		if(!can_see(user, self))
			data["self"] = body_relay.name
			// Do not reveal the identity or appearance behind a body relay.
			data["profile"] = list("name" = body_relay.name, "headshot" = "", "details" = list(), "tags" = list())
	data["block_interact"] = interact_next >= world.time
	data["interactions"] = categories
	data["erp_interaction"] = self.client?.prefs?.read_preference(/datum/preference/toggle/erp)

	var/mob/living/carbon/human/human_user = user

	data["isTargetSelf"] = (user == self)

	// user (the one who opened the ui)
	var/user_pleasure = 0
	var/user_arousal = 0
	var/user_pain = 0

	if(user)
		user_pleasure = human_user.pleasure
		user_arousal = human_user.arousal
		user_pain = human_user.pain

		data["pleasure"] = user_pleasure
		data["arousal"] = user_arousal
		data["pain"] = user_pain
		data["yourName"] = human_user.real_name


	// self - the one who the interaction component belongs to, aka who it's opened on (confusing var name yep)
	if(user != self)
		data["theirPleasure"] = self.pleasure
		data["theirArousal"] = self.arousal
		data["theirPain"] = self.pain
		data["theirName"] = self.real_name

	var/list/parts = list()

	if(ishuman(user) && can_lewd_strip(user, self))
		if(self.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			if(self.has_vagina())
				parts += list(generate_strip_entry(ORGAN_SLOT_VAGINA, self, user, self.vagina))
			if(self.has_penis())
				parts += list(generate_strip_entry(ORGAN_SLOT_PENIS, self, user, self.penis))
			if(self.has_anus())
				parts += list(generate_strip_entry(ORGAN_SLOT_ANUS, self, user, self.anus))
			parts += list(generate_strip_entry(ORGAN_SLOT_NIPPLES, self, user, self.nipples))

	data["lewd_slots"] = parts

	return data

/**
 *  Takes the organ slot name, along with a target and source, along with the item on the target that the source can potentially interact with.
 *  If the source can't interact with said slot, or there is no item in the first place, it'll set the icon to null to indicate that TGUI should put a placeholder sprite.
 *
 * Arguments:
 * * name - The name of slot to check and return inside the generated list.
 * * target - The mob that's being interacted with.
 * * source - The mob that's interacting.
 * * item - The item that's currently inside said slot. Can be null.
 */
/datum/component/interactable/proc/generate_strip_entry(name, mob/living/carbon/human/target, mob/living/carbon/human/source, obj/item/clothing/sextoy/item)
	return list(
		"name" = name,
		"img" = (item && can_lewd_strip(source, target, name)) ? icon2base64(icon(item.icon, item.icon_state, SOUTH, 1)) : null
		)

/datum/component/interactable/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!ishuman(usr))
		return

	if(action == "set_selected")
		var/mob/living/carbon/human/selected = locate(params["ref"])
		if(QDELETED(selected) || !(selected in get_selectable_characters(usr)))
			return FALSE
		var/datum/component/interactable/selected_component = selected.GetComponent(/datum/component/interactable)
		if(!selected_component)
			return FALSE
		selected_component.build_interactions_list()
		selected_characters[REF(usr)] = WEAKREF(selected)
		return TRUE

	var/datum/component/interactable/selected_component = get_selected_component(usr)
	// Reject an action from a stale view after the selected character changes or leaves.
	if(params["selfref"] && params["selfref"] != REF(selected_component.self))
		return FALSE
	if(params["userref"] && params["userref"] != REF(usr))
		return FALSE
	return selected_component.handle_ui_action(action, params, usr)

/// Dispatch using the selected component and the authenticated viewer.
/datum/component/interactable/proc/handle_ui_action(action, list/params, mob/living/carbon/human/viewer)
	// Profile actions always act as the authenticated UI user.
	switch(action)
		if("set_theme")
			var/datum/preference/choiced/theme_preference = GLOB.preference_entries[/datum/preference/choiced/interaction_menu_theme]
			if(!(params["theme"] in theme_preference.get_choices()))
				return FALSE
			return interaction_panel_write_mob_character_pref(viewer, /datum/preference/choiced/interaction_menu_theme, params["theme"])
		if("open_examine")
			viewer.run_examinate(body_relay && !can_see(viewer, self) ? body_relay : self)
			return TRUE
		if("set_self_preference")
			interaction_panel_set_self_preference(viewer, params["pref_type"], params["pref_value"])
			return TRUE
		if("set_genital_visibility")
			if(interaction_panel_erp_enabled(viewer))
				interaction_panel_set_genital_visibility(viewer, params["slot"], text2num(params["visibility"]))
			return TRUE
		if("toggle_underwear")
			interaction_panel_toggle_underwear(viewer, params["kind"])
			return TRUE

	if(params["interaction"])
		var/interaction_id = params["interaction"]
		if(GLOB.interaction_instances[interaction_id])
			var/mob/living/carbon/human/user = viewer
			if(!can_interact(GLOB.interaction_instances[interaction_id], user))
				return FALSE
			if(body_relay && !can_see(user, self))
				GLOB.interaction_instances[interaction_id].act(user, self, body_relay)
			else
				GLOB.interaction_instances[interaction_id].act(user, self)
			var/datum/component/interactable/interaction_component = user.GetComponent(/datum/component/interactable)
			interaction_component.interact_last = world.time
			interact_next = interaction_component.interact_last + INTERACTION_COOLDOWN
			interaction_component.interact_next = interact_next
			return TRUE

	if(params["item_slot"])
		// This code should be easy enough to follow... I hope.
		var/item_index = params["item_slot"]
		var/mob/living/carbon/human/source = viewer
		var/mob/living/carbon/human/target = self
		var/obj/item/clothing/sextoy/new_item = source.get_active_held_item()
		var/obj/item/clothing/sextoy/existing_item = target.vars[item_index]

		if(!existing_item && !new_item)
			source.show_message(span_warning("No item to insert or remove!"))
			return

		if(!existing_item && !istype(new_item))
			source.show_message(span_warning("The item you're holding is not a toy!"))
			return

		if(can_lewd_strip(source, target, item_index) && is_toy_compatible(new_item, item_index))
			var/internal = (item_index in list(ORGAN_SLOT_VAGINA, ORGAN_SLOT_ANUS))
			var/insert_or_attach = internal ? "insert" : "attach"
			var/into_or_onto = internal ? "into" : "onto"

			if(existing_item)
				source.visible_message(span_purple("[source.name] starts trying to remove something from [target.name]'s [item_index]."), span_purple("You start to remove [existing_item.name] from [target.name]'s [item_index]."), span_purple("You hear someone trying to remove something from someone nearby."), vision_distance = 1, ignored_mobs = list(target))
			else if (new_item)
				source.visible_message(span_purple("[source.name] starts trying to [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You start to [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You hear someone trying to [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1, ignored_mobs = list(target))
			if (source != target)
				target.show_message(span_warning("[source.name] is trying to [existing_item ? "remove the [existing_item.name] [internal ? "in" : "on"]" : new_item ? "is trying to [insert_or_attach] the [new_item.name] [into_or_onto]" : span_alert("What the fuck, impossible condition? interaction_component.dm!")] your [item_index]!"))
			if(do_after(
				source,
				5 SECONDS,
				target,
				interaction_key = "interaction_[item_index]"
				) && can_lewd_strip(source, target, item_index))

				if(existing_item)
					source.visible_message(span_purple("[source.name] removes [existing_item.name] from [target.name]'s [item_index]."), span_purple("You remove [existing_item.name] from [target.name]'s [item_index]."), span_purple("You hear someone remove something from someone nearby."), vision_distance = 1)
					target.dropItemToGround(existing_item, force = TRUE) // Force is true, cause nodrop shouldn't affect lewd items.
					target.vars[item_index] = null
				else if (new_item)
					source.visible_message(span_purple("[source.name] [internal ? "inserts" : "attaches"] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You [insert_or_attach] the [new_item.name] [into_or_onto] [target.name]'s [item_index]."), span_purple("You hear someone [insert_or_attach] something [into_or_onto] someone nearby."), vision_distance = 1)
					target.vars[item_index] = new_item
					new_item.forceMove(target)
					new_item.lewd_equipped(target, item_index)
				target.update_inv_lewd()

		else
			source.show_message(span_warning("Failed to adjust [target.name]'s toys!"))

		return TRUE

	message_admins("Unhandled interaction '[params["interaction"]]'. Inform coders.")

/// Checks if the target has ERP toys enabled, and can be logially reached by the user.
/datum/component/interactable/proc/can_lewd_strip(mob/living/carbon/human/source, mob/living/carbon/human/target, slot_index)
	if(!target.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return FALSE
	if(!(source.loc == target.loc || source.Adjacent(target)))
		return FALSE
	if(!source.has_arms())
		return FALSE
	if(!slot_index) // This condition is for the UI to decide if the button is shown at all. Slot index should never be null otherwise.
		return TRUE

	switch(slot_index)
		if(ORGAN_SLOT_NIPPLES)
			var/chest_exposed = target.has_breasts(required_state = REQUIRE_GENITAL_EXPOSED)
			if(!chest_exposed)
				chest_exposed = target.is_topless() // for when we don't have breasts

			return chest_exposed

		if(ORGAN_SLOT_PENIS)
			return target.has_penis(required_state = REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_VAGINA)
			return target.has_vagina(required_state = REQUIRE_GENITAL_EXPOSED)
		if(ORGAN_SLOT_ANUS)
			return target.has_anus(required_state = REQUIRE_GENITAL_EXPOSED)

/// Decides if a player should be able to insert or remove an item from a provided lewd slot_index.
/datum/component/interactable/proc/is_toy_compatible(obj/item/clothing/sextoy/item, slot_index)
	if(!item) // Used for UI code, should never be actually null during actual logic code.
		return TRUE

	switch(slot_index)
		if(ORGAN_SLOT_VAGINA)
			return item.lewd_slot_flags & LEWD_SLOT_VAGINA
		if(ORGAN_SLOT_PENIS)
			return item.lewd_slot_flags & LEWD_SLOT_PENIS
		if(ORGAN_SLOT_ANUS)
			return item.lewd_slot_flags & LEWD_SLOT_ANUS
		if(ORGAN_SLOT_NIPPLES)
			return item.lewd_slot_flags & LEWD_SLOT_NIPPLES
		else
			return FALSE

// Shared profile helpers used by the Interaction Menu and Scene Assistant.

/proc/interaction_panel_get_played_character_slot(mob/living/target)
	if(!target)
		return 0
	if(target.rp_panel && target.rp_panel.character_slot)
		return target.rp_panel.character_slot
	var/slot = 0
	if(target.mind?.original_character_slot_index)
		slot = target.mind.original_character_slot_index
	else
		slot = interaction_panel_find_character_slot_by_name(target)
	if(slot && target.rp_panel)
		target.rp_panel.character_slot = slot
	return slot

/proc/interaction_panel_find_character_slot_by_name(mob/living/target)
	var/datum/preferences/prefs = target?.client?.prefs
	if(!prefs?.savefile)
		return 0
	var/mob_name = target.real_name || target.name
	if(!mob_name)
		return 0
	for(var/slot in 1 to prefs.max_save_slots)
		var/list/save_data = prefs.savefile.get_entry("character[slot]")
		if(!islist(save_data))
			continue
		if(save_data["real_name"] == mob_name)
			return slot
	return 0

/proc/interaction_panel_prefs_cache_belongs_to_mob(mob/living/target, datum/preferences/prefs)
	if(!target || !prefs || !prefs.value_cache)
		return FALSE
	var/cached_name = prefs.value_cache[/datum/preference/name/real_name]
	if(!cached_name)
		return FALSE
	return cached_name == (target.real_name || target.name)

/proc/interaction_panel_read_mob_character_pref(mob/living/target, pref_type)
	var/datum/preferences/prefs = target?.client?.prefs
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return null
	if(preference_entry.savefile_identifier != PREFERENCE_CHARACTER)
		return prefs?.read_preference(pref_type)
	var/slot = interaction_panel_get_played_character_slot(target)
	if(slot && prefs?.savefile)
		var/list/save_data = prefs.savefile.get_entry("character[slot]")
		var/value = preference_entry.read(save_data, prefs)
		if(!isnull(value))
			return value
	return interaction_panel_character_pref_fallback(preference_entry, target)

/proc/interaction_panel_character_pref_fallback(datum/preference/preference_entry, mob/living/target)
	if(istype(preference_entry, /datum/preference/color/scene_assistant_name_color))
		return default_scene_assistant_name_color(target?.real_name || target?.name || target?.ckey)
	return preference_entry.create_default_value()

/proc/interaction_panel_write_mob_character_pref(mob/living/target, pref_type, value)
	var/datum/preferences/prefs = target?.client?.prefs
	if(!prefs)
		return FALSE
	var/datum/preference/preference_entry = GLOB.preference_entries[pref_type]
	if(!preference_entry)
		return FALSE
	if(preference_entry.savefile_identifier != PREFERENCE_CHARACTER)
		if(!prefs.write_preference(preference_entry, value))
			return FALSE
		prefs.recently_updated_keys |= preference_entry.type
		prefs.save_preferences()
		return TRUE
	var/slot = interaction_panel_get_played_character_slot(target)
	if(!slot)
		return FALSE
	var/tree_key = "character[slot]"
	var/list/save_data = prefs.savefile.get_entry(tree_key)
	if(isnull(save_data))
		prefs.savefile.set_entry(tree_key, list())
		save_data = prefs.savefile.get_entry(tree_key)
	var/new_value = preference_entry.deserialize(value, prefs)
	if(!preference_entry.write(save_data, new_value, prefs))
		return FALSE
	if(prefs.default_slot == slot && interaction_panel_prefs_cache_belongs_to_mob(target, prefs))
		prefs.value_cache[preference_entry.type] = new_value
	prefs.savefile.save()
	return TRUE

/proc/interaction_panel_erp_enabled(mob/living/target)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	return target?.client?.prefs?.read_preference(/datum/preference/toggle/master_erp_preferences) && target.client.prefs.read_preference(/datum/preference/toggle/erp)

/proc/interaction_panel_get_headshot(mob/living/target)
	if(!target)
		return ""
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		return human_target.dna?.features["headshot"] || ""
	if(target.client?.ckey)
		var/datum/preference/text/headshot/pref = GLOB.preference_entries[/datum/preference/text/headshot]
		if(pref?.stored_link)
			return pref.stored_link[target.client.ckey] || ""
	return ""

/proc/interaction_panel_get_preference_status(choice)
	if(!choice || choice == "No" || choice == "None")
		return "NO"
	if(findtext(choice, "Ask"))
		return "L(OOC)"
	if(findtext(choice, "Check"))
		return "NOTE"
	return "YES"

/proc/interaction_panel_build_anatomy_details(mob/living/target)
	var/list/details = list()
	if(!ishuman(target))
		return details
	var/mob/living/carbon/human/human_target = target
	if(human_target.has_arms(REQUIRE_GENITAL_ANY) > 0)
		details += human_target.is_hands_uncovered() ? "has covered hands" : "has uncovered hands"
	if(human_target.has_feet(REQUIRE_GENITAL_ANY) > 0)
		if(human_target.is_barefoot() && (!human_target.socks || human_target.socks == "Nude" || (human_target.underwear_visibility & UNDERWEAR_HIDE_SOCKS)))
			details += "is barefoot"
		else if(human_target.is_barefoot())
			details += "is wearing socks"
		else
			details += "has feet covered"
	var/obj/item/bodypart/head/head_part = human_target.get_bodypart(BODY_ZONE_HEAD)
	if(head_part)
		var/mouth_covered = (human_target.wear_mask?.flags_inv & HIDEFACE) || (human_target.head?.flags_inv & HIDEFACE)
		details += mouth_covered ? "has a mouth, which is covered" : "has a mouth, which is uncovered"
	details += human_target.is_head_uncovered() ? "has head covered" : "has head uncovered"
	if(human_target.is_topless() && human_target.is_bottomless())
		details += "is naked"
	else if(human_target.is_topless())
		details += "is topless"
	else if(human_target.is_bottomless())
		details += "is bottomless"
	var/static/list/genital_lines = list(
		ORGAN_SLOT_PENIS = "has a penis",
		ORGAN_SLOT_TESTICLES = "has testicles",
		ORGAN_SLOT_VAGINA = "has a vagina",
		ORGAN_SLOT_BREASTS = "has breasts",
		ORGAN_SLOT_ANUS = "has an anus",
	)
	for(var/slot in genital_lines)
		var/obj/item/organ/genital/genital = human_target.get_organ_slot(slot)
		if(istype(genital) && genital.is_exposed())
			details += genital_lines[slot]
	return details

/proc/interaction_panel_build_status_tags(mob/living/target)
	var/list/tags = list()
	if(!target.client?.prefs)
		return tags
	tags += list(list("label" = "ERP", "value" = interaction_panel_get_preference_status(interaction_panel_read_mob_character_pref(target, /datum/preference/choiced/erp_status))))
	tags += list(list("label" = "HYPNOSIS", "value" = interaction_panel_get_preference_status(interaction_panel_read_mob_character_pref(target, /datum/preference/choiced/erp_status_hypno))))
	tags += list(list("label" = "VORE", "value" = interaction_panel_get_preference_status(interaction_panel_read_mob_character_pref(target, /datum/preference/choiced/erp_status_v))))
	tags += list(list("label" = "NON-CON", "value" = interaction_panel_get_preference_status(interaction_panel_read_mob_character_pref(target, /datum/preference/choiced/erp_status_nc))))
	var/mechanics = interaction_panel_read_mob_character_pref(target, /datum/preference/choiced/erp_status_mechanics)
	tags += list(list("label" = "MECHANICS", "value" = (!mechanics || mechanics == "None") ? "NO" : uppertext(mechanics)))
	return tags

/proc/interaction_panel_build_self_data(mob/living/holder)
	var/list/data = list(
		"show_erp" = interaction_panel_erp_enabled(holder),
		"autocum" = FALSE,
		"inactive" = FALSE,
		"prefs" = list(),
		"genitals" = list(),
		"underwear" = list(),
	)
	if(!ishuman(holder))
		return data
	var/mob/living/carbon/human/human_holder = holder
	data["underwear"] = list(
		"underwear" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_UNDIES),
		"bra" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_BRA),
		"undershirt" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_SHIRT),
		"socks" = !!(human_holder.underwear_visibility & UNDERWEAR_HIDE_SOCKS),
	)
	if(!data["show_erp"] || !holder.client?.prefs)
		return data
	data["autocum"] = holder.client.prefs.read_preference(/datum/preference/toggle/erp/autocum)
	var/static/list/pref_map = list(
		"erp_status" = /datum/preference/choiced/erp_status,
		"erp_status_nc" = /datum/preference/choiced/erp_status_nc,
		"erp_status_v" = /datum/preference/choiced/erp_status_v,
		"erp_status_hypno" = /datum/preference/choiced/erp_status_hypno,
		"erp_status_mechanics" = /datum/preference/choiced/erp_status_mechanics,
	)
	var/list/pref_payload = list()
	for(var/key in pref_map)
		var/datum/preference/choiced/pref = GLOB.preference_entries[pref_map[key]]
		pref_payload[key] = list(
			"value" = interaction_panel_read_mob_character_pref(holder, pref_map[key]),
			"options" = pref.get_choices(),
		)
	data["prefs"] = pref_payload
	var/static/list/genital_slots = list(
		ORGAN_SLOT_PENIS = "Penis",
		ORGAN_SLOT_TESTICLES = "Testicles",
		ORGAN_SLOT_VAGINA = "Vagina",
		ORGAN_SLOT_ANUS = "Anus",
		ORGAN_SLOT_BREASTS = "Breasts",
	)
	var/list/genitals = list()
	for(var/slot in genital_slots)
		var/obj/item/organ/genital/genital = human_holder.get_organ_slot(slot)
		if(!istype(genital) || genital.visibility_preference == GENITAL_SKIP_VISIBILITY)
			continue
		genitals += list(list(
			"slot" = slot,
			"name" = genital_slots[slot],
			"visibility" = genital.visibility_preference,
		))
	data["genitals"] = genitals
	return data

/proc/interaction_panel_set_self_preference(mob/living/holder, pref_type, pref_value)
	if(!holder.client?.prefs || !pref_type || isnull(pref_value) || !interaction_panel_erp_enabled(holder))
		return
	var/static/list/pref_map = list(
		"erp_status" = /datum/preference/choiced/erp_status,
		"erp_status_nc" = /datum/preference/choiced/erp_status_nc,
		"erp_status_v" = /datum/preference/choiced/erp_status_v,
		"erp_status_hypno" = /datum/preference/choiced/erp_status_hypno,
		"erp_status_mechanics" = /datum/preference/choiced/erp_status_mechanics,
	)
	var/pref_path = pref_map[pref_type]
	if(!pref_path)
		return
	interaction_panel_write_mob_character_pref(holder, pref_path, pref_value)

/proc/interaction_panel_set_genital_visibility(mob/living/holder, organ_slot, visibility)
	if(!ishuman(holder) || !organ_slot)
		return
	if(!(visibility in list(GENITAL_NEVER_SHOW, GENITAL_HIDDEN_BY_CLOTHES, GENITAL_ALWAYS_SHOW)))
		return
	var/mob/living/carbon/human/human_holder = holder
	var/obj/item/organ/genital/genital = human_holder.get_organ_slot(organ_slot)
	if(!genital)
		return
	genital.visibility_preference = visibility
	human_holder.update_body()
	SEND_SIGNAL(human_holder, COMSIG_HUMAN_TOGGLE_GENITALS)

/proc/interaction_panel_toggle_underwear(mob/living/holder, kind)
	if(!ishuman(holder))
		return
	var/mob/living/carbon/human/human_holder = holder
	switch(kind)
		if("underwear")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_UNDIES
		if("bra")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_BRA
		if("undershirt")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_SHIRT
		if("socks")
			human_holder.underwear_visibility ^= UNDERWEAR_HIDE_SOCKS
		else
			return
	human_holder.update_body()
	SEND_SIGNAL(human_holder, COMSIG_HUMAN_TOGGLE_UNDERWEAR, kind)

#undef INTERACTION_MENU_SELECTION_RANGE
