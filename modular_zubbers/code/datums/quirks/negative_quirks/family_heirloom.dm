/// Typecache of types that cannot be marked as heirlooms.
GLOBAL_LIST_INIT(invalid_heirloom_types, typecacheof(list(
	/obj/item/card/id,
	/obj/item/disk/nuclear,
)))

/datum/quirk/item_quirk/family_heirloom
	/// The temporary mark action we give to users who have opted out of random items.
	var/datum/action/mark_family_heirloom/mark_action

/datum/quirk/item_quirk/family_heirloom/Destroy()
	. = ..()

	QDEL_NULL(mark_action)

/datum/quirk_constant_data/family_heirloom
	associated_typepath = /datum/quirk/item_quirk/family_heirloom
	customization_options = list(/datum/preference/toggle/random_heirloom)

/datum/preference/toggle/random_heirloom
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "random_heirloom_toggle"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	default_value = TRUE

/datum/preference/toggle/random_heirloom/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/action/mark_family_heirloom
	name = "Mark Held Item As Heirloom"
	desc = "Use to mark your held item as your family heirloom. Does not work on existing heirlooms."

/datum/action/mark_family_heirloom/Trigger(mob/clicker, trigger_flags)
	. = ..()

	if (!.)
		return FALSE

	if (!isliving(owner))
		return FALSE
	var/mob/living/living_owner = owner

	var/datum/quirk/item_quirk/family_heirloom/quirk = locate() in living_owner.quirks
	if (isnull(quirk))
		stack_trace("someone has the family heirloom action without the trait... wack. [owner]")
		owner.balloon_alert(owner, "no quirk!")
		return FALSE

	var/obj/item/held_item = living_owner.get_active_held_item()

	if (isnull(held_item))
		living_owner.balloon_alert(living_owner, "no held item!")
		return FALSE

	if (GLOB.invalid_heirloom_types[held_item.type])
		living_owner.balloon_alert(living_owner, "invalid item type!")
		return FALSE

	if (held_item.GetComponent(/datum/component/heirloom))
		living_owner.balloon_alert(living_owner, "already a heirloom!")
		return FALSE

	// valid heirloom

	var/new_name = tgui_input_text(
		clicker,
		"Enter the new name of [held_item]. (Leave blank for default name)",
		"New name",
		max_length = 50,
		timeout = 60 SECONDS
	)

	var/new_desc = tgui_input_text(
		clicker,
		"Enter the new description of this [held_item]. (Leave blank for default desc)",
		"New desc",
		max_length = 256,
		multiline = TRUE,
		timeout = 60 SECONDS,
	)

	var/list/names = splittext(living_owner.real_name, " ")
	var/family_name = names[names.len]

	if (new_name)
		held_item.name = "[new_name] ([held_item.name])"
		ADD_TRAIT(held_item, TRAIT_WAS_RENAMED, REF(quirk))
		held_item.AddElement(/datum/element/examined_when_worn)
		SEND_SIGNAL(held_item, COMSIG_NAME_CHANGED)
	if (new_desc)
		held_item.desc = "[new_desc]"

	held_item.AddComponent(/datum/component/heirloom, living_owner.mind, family_name)
	living_owner.add_mob_memory(/datum/memory/key/quirk_heirloom, protagonist = living_owner, heirloom_name = initial(held_item.name))

	owner.balloon_alert(owner, "heirloom set")
	quirk.heirloom = WEAKREF(held_item)
	quirk.mark_action = null
	qdel(src)
