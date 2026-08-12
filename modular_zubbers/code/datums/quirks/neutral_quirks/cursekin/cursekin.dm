/datum/quirk/cursekin
	name = "Cursekin"
	desc = "You suffer from a terrible curse that enables you to transform into a werebeast! Unfortunately, this precludes you from receiving any synthetic implants or organs."
	gain_text = span_warning("You feel the shine of the distant moon on your skin. And it is aggravating.")
	lose_text = span_notice("The light of Luna fades...")
	medical_record_text = "Patient possesses a curse of striking similarity to the legendary Lycanthropy."
	value = 0
	icon = FA_ICON_PAW
	quirk_flags = QUIRK_HUMAN_ONLY
	mob_trait = TRAIT_LYCAN
	species_blacklist = list(/datum/species/protean, /datum/species/synthetic, /datum/species/lycan)
	var/last_slot
	var/to_human_sfx = 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg'
	var/to_lycan_sfx = 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg'
	var/datum/action/cooldown/spell/beast_form/action

/datum/quirk/cursekin/New()
	. = ..()

	action = new /datum/action/cooldown/spell/beast_form(src)

/datum/quirk_constant_data/cursekin
	associated_typepath = /datum/quirk/cursekin
	customization_options = list(/datum/preference/numeric/cursekin_char_slot)

/datum/quirk/cursekin/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()

	try_getting_slot(client_source)

	new_holder.AddElement(/datum/element/inorganic_rejection)
	action.Grant(new_holder)

/datum/quirk/cursekin/remove()
	. = ..()

	quirk_holder.RemoveElement(/datum/element/inorganic_rejection)
	action.Remove(quirk_holder)

	leave_beast_form()
	last_slot = null

/// A delayed getter for the current slot of the mob. Used because theres no easy way to access the client when a mob is spawend...
/datum/quirk/cursekin/proc/try_getting_slot(client/client_source)
	if (last_slot)
		return

	last_slot = client_source.prefs.savefile.get_entry("default_slot")

/datum/quirk/cursekin/proc/enter_beast_form()
	quirk_holder.apply_status_effect(/datum/status_effect/beast_form)

/datum/quirk/cursekin/proc/leave_beast_form()
	quirk_holder.remove_status_effect(/datum/status_effect/beast_form)

/datum/quirk/cursekin/proc/toggle_beast_form(mob/user)
	set name = "Enter/Leave Lycan Form"
	set desc = "Succumb to the rage and turn into a lycan."
	set category = "Lycan"

	if(!user)
		return
	if(user.has_status_effect(/datum/status_effect/beast_form))
		leave_beast_form()
	else
		if (HAS_TRAIT(user, TRAIT_MANSUS_INHIBITION))
			user.balloon_alert(user, "can't transform while inhibited!")
			return
		enter_beast_form()
