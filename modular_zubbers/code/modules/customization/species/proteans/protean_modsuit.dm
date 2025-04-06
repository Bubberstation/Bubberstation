/obj/item/mod/control/pre_equipped/protean
	name = "hardsuit rig"
	desc = "The hardsuit rig unit of a Protean, allowing them to retract into it, or to deploy a suit that protects against various environments."
	theme = /datum/mod_theme // Standard theme. TODO: Can be changed with standard mod armors

	applied_core = /obj/item/mod/core/protean
	applied_cell = null // Goes off stomach

	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF // funny nanite
	/// Whether or not the wearer can undeploy parts.
	var/modlocked = FALSE
	var/obj/item/mod/control/stored_modsuit
	var/datum/mod_theme/stored_theme

	// Antag proteans can brainwash their wearers.
	var/brainwash = FALSE
	var/brainwash_message = "You are an extension of your suit's objectives. You will listen to them"

/datum/mod_theme/protean
	name = "Protean"

/obj/item/mod/control/pre_equipped/protean/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "protean")
	AddElement(/datum/element/strippable/protean, GLOB.strippable_human_items, TYPE_PROC_REF(/mob/living/carbon/human/, should_strip))

/obj/item/mod/control/pre_equipped/protean/Destroy()
	if(stored_modsuit)
		QDEL_NULL(stored_modsuit)
		QDEL_NULL(stored_theme)
	return ..()

/obj/item/mod/control/pre_equipped/protean/wrench_act(mob/living/user, obj/item/wrench)
	return FALSE // Can't remove the core.

/obj/item/mod/control/pre_equipped/protean/emag_act(mob/user, obj/item/card/emag/emag_card)
	return FALSE // Nope

/obj/item/mod/control/pre_equipped/protean/canStrip(mob/who)
	return TRUE

/obj/item/mod/control/pre_equipped/protean/doStrip(mob/stripper, mob/owner) // Custom stripping code.
	if(!isprotean(wearer)) // Strip it normally
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean") // Your ass is coming off.
		return ..()
	var/obj/item/mod/module/storage/inventory = locate() in src.modules
	if(!isnull(inventory))
		src.atom_storage.remove_all()
		to_chat(stripper, span_notice("You empty out all the items from the Protean's internal storage module!"))
		stripper.balloon_alert(stripper, "emptied storage")
		return TRUE

	to_chat(stripper, span_warning("This suit seems to be a part of them. You can't remove it!"))
	stripper.balloon_alert(stripper, "can't strip a protean's suit!")
	return ..()

/obj/item/mod/control/pre_equipped/protean/proc/drop_suit()
	if(wearer)
		wearer.dropItemToGround(src, TRUE, TRUE)
	else
		forceMove(get_turf(loc))

/// Proteans can lock themselves on people.
/obj/item/mod/control/pre_equipped/protean/proc/toggle_lock()
	if(modlocked)
		REMOVE_TRAIT(src, TRAIT_NODROP, "protean")
	modlocked = !modlocked

/obj/item/mod/control/pre_equipped/protean/equipped(mob/user, slot, initial)
	. = ..()

	if(isprotean(wearer))
		return
	if(slot == ITEM_SLOT_BACK)
		RegisterSignal(wearer, COMSIG_OOC_ESCAPE, PROC_REF(ooc_escape))
		if(modlocked)
			ADD_TRAIT(src, TRAIT_NODROP, "protean")
			to_chat(wearer, span_warning("The suit does not seem to be able to come off..."))
	else
		UnregisterSignal(wearer, COMSIG_OOC_ESCAPE)

/obj/item/mod/control/pre_equipped/protean/choose_deploy(mob/user)
	if(!isprotean(user) && modlocked && active)
		balloon_alert(user, "it refuses to listen")
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/toggle_activate(mob/user, force_deactivate)
	if(!force_deactivate && modlocked && !isprotean(user) && active)
		balloon_alert(user, "it doesn't turn off")
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/quick_deploy(mob/user)
	if(!isprotean(user) && modlocked && active)
		balloon_alert(user, "it won't undeploy")
		return FALSE
	return ..()

/obj/item/mod/control/pre_equipped/protean/retract(mob/user, obj/item/part, instant)
	if(!isprotean(user) && modlocked && active)
		balloon_alert(user, "that button is unresponsive")
		return FALSE
	return ..()

/// Protean Revivial

/obj/item/mod/control/pre_equipped/protean/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = core
	var/obj/item/organ/brain/protean/brain = protean_core?.linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_core.linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)

	if(brain?.dead && open && istype(tool, /obj/item/organ/stomach/protean) && do_after(user, 10 SECONDS) && !refactory)
		var/obj/item/organ/stomach = tool
		stomach.Insert(protean_core.linked_species.owner, TRUE, DELETE_IF_REPLACED)
		balloon_alert(user, "inserted!")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		brain.revive_timer()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/mod/control))
		to_chat(user, span_notice("The suit begins to slowly absorb [tool]!"))
		if(!do_after(user, 4 SECONDS)) // Bump this time to 20 seconds
			return
		assimilate_modsuit(user, tool)
		return ITEM_INTERACT_SUCCESS

/obj/item/mod/control/pre_equipped/protean/proc/assimilate_modsuit(mob/user, modsuit, forced)
	var/obj/item/mod/control/to_assimilate = modsuit

	if(stored_modsuit)
		to_chat(user, span_warning("Can't absorb two modsuits!"))
		return
	if(!user.transferItemToLoc(to_assimilate, src, forced))
		balloon_alert(wearer, "stuck!")
		return
	stored_modsuit = to_assimilate
	stored_theme = theme // Store the old theme in cache
	theme = to_assimilate.theme // Set new theme
	complexity_max = to_assimilate.complexity_max // Inheret complexity
	skin = to_assimilate.skin // Inheret skin
	theme.set_up_parts(src, skin) // Put everything together
	name = to_assimilate.name
	for(var/obj/item/mod/module/module in to_assimilate.modules) // Insert every module
		if(install(module, user, TRUE))
			continue
		uninstall(module) // Drop it if failed
	update_static_data_for_all_viewers()

/obj/item/mod/control/pre_equipped/protean/proc/unassimilate_modsuit(mob/living/user)
	if(active)
		balloon_alert(user, "deactivate modsuit")
		return
	if(!(user.has_active_hand()))
		balloon_alert(user, "need active hand")
		return
	to_chat(user, span_notice("You begin to pry the assimilated modsuit away."))
	if(!do_after(user, 4 SECONDS)) // Bump this time to 30 seconds
		return
	complexity_max = initial(complexity_max)
	for(var/obj/item/mod/module in modules) // Transfer back every module
		if(stored_modsuit.install(module, user, TRUE))
			continue
		uninstall(module)


	theme = stored_theme
	stored_theme = null
	skin = initial(skin)
	theme.set_up_parts(src, skin)
	name = initial(name)
	if(user.can_put_in_hand(stored_modsuit, user.active_hand_index))
		user.put_in_hand(stored_modsuit, user.active_hand_index)
		stored_modsuit = null
	update_static_data_for_all_viewers()

/obj/item/mod/control/pre_equipped/protean/verb/remove_modsuit()
	set name = "Remove Assimilated Modsuit"

	unassimilate_modsuit(usr)

/obj/item/mod/control/pre_equipped/protean/examine(mob/user)
	. = ..()
	var/obj/item/mod/core/protean/protean_core = core
	var/obj/item/organ/brain/protean/brain = protean_core?.linked_species.owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	var/obj/item/organ/stomach/protean/refactory = protean_core.linked_species.owner.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!isnull(brain) || istype(brain))
		. += span_notice("<b>Control Shift Click</b> to open Protean strip menu.")
		if(brain.dead)
			if(!open)
				. += isnull(refactory) ? span_warning("This Protean requires critical repairs! <b>Screwdriver them open</b>") : span_notice("<b>Repairing systems...</b>")
			else
				. += isnull(refactory) ? span_warning("<b>Insert a new refactory</b>") : span_notice("<b>Refactory Installed! Repairing systems...</b>")

/obj/item/mod/control/pre_equipped/protean/proc/ooc_escape(mob/living/carbon/user)
	SIGNAL_HANDLER

	if(isprotean(wearer))
		return
	drop_suit()

/**
 * Protean stripping while they're in the suit.
 * Yeah I guess stripping is an element. Carry on, citizen.
 */
/datum/element/strippable/protean

/datum/element/strippable/protean/Attach(datum/target, list/items, should_strip_proc_path)
	. = ..()
	RegisterSignal(target, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(click_control_shit))

/datum/element/strippable/protean/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_CLICK_CTRL_SHIFT)

/datum/element/strippable/protean/proc/click_control_shit(datum/source, mob/user)
	SIGNAL_HANDLER

	var/obj/item/mod/control/pre_equipped/protean/suit = source
	if(!istype(suit))
		return
	var/obj/item/mod/core/protean/core = suit.core
	var/datum/species/protean/species = core.linked_species
	if(species.owner == user)
		return
	if(suit.wearer == source)
		return
	if (!isnull(should_strip_proc_path) && !call(species.owner, should_strip_proc_path)(user))
		return
	suit.balloon_alert_to_viewers("stripping")
	ASYNC
		if(!do_after(user, 3 SECONDS))
			return
		var/datum/strip_menu/protean/strip_menu = LAZYACCESS(strip_menus, species.owner)

		if (isnull(strip_menu))
			strip_menu = new(species.owner, src)
			LAZYSET(strip_menus, species.owner, strip_menu)
		strip_menu.ui_interact(user)

/datum/strip_menu/protean

/datum/strip_menu/protean/ui_status(mob/user, datum/ui_state/state) // Needs to pass a viewcheck.
	return min(
		ui_status_only_living(user, owner),
		ui_status_user_has_free_hands(user, owner),
		ui_status_user_is_adjacent(user, owner, allow_tk = FALSE, viewcheck = FALSE),
		HAS_TRAIT(user, TRAIT_CAN_STRIP) ? UI_INTERACTIVE : UI_UPDATE,
		max(
			ui_status_user_is_conscious_and_lying_down(user),
			ui_status_user_is_abled(user, owner),
		),
	)
