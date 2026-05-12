/obj/item/organ/brain/lycan
	name = "lupine brain"
	desc = "A larger than average, albeit slightly smoother brain. The hypothalamus seems larger than normal." // I read in a random medical artical that the hypothalamus controls aggression.
	actions_types = list(/datum/action/cooldown/spell/beast_form)
	var/list/removed_quirks = list()
	var/last_slot

/obj/item/organ/brain/lycan/proc/enter_beast_form()
	var/datum/species/human/cursekin/current_wolf = owner.dna.species
	if(!istype(current_wolf) && HAS_TRAIT_FROM(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT))
		return
	removed_quirks = list()
	for(var/datum/quirk/current_quirks in owner.quirks)
		var/datum/quirk/micro/bad_quirk = locate() in current_quirks
		for(bad_quirk in owner.quirks)
			removed_quirks += bad_quirk.type
			owner.remove_quirk(bad_quirk.type)
	owner.visible_message(span_warning("[owner] grows massive, their body quickly getting covered in fur!"))
	var/client/target_client = owner.client
	if (!isnull(target_client))
		var/name = owner.real_name
		var/slot = target_client.prefs.read_preference(/datum/preference/numeric/cursekin_char_slot)
		var/transfer = TRUE
		last_slot = target_client.prefs.savefile.get_entry("default_slot")
		target_client.prefs.load_character(slot)
		if (!ispath(target_client.prefs.read_preference(/datum.preference/choiced/species), current_wolf.lycanthropy_species))
			to_chat(owner, span_warning("Your selected slot is not a lycan! Defaulting to simply changing your species..."))
			target_client.prefs.load_character(last_slot)
			owner.set_species(current_wolf.lycanthropy_species, TRUE, TRUE, FALSE)
			last_slot = null // allows for easier switching in later procs
			transfer = FALSE

		if (transfer)
			target_client.prefs.safe_transfer_prefs_to_with_damage(owner)
			owner.real_name = name
			owner.name = name
			owner.dna.update_dna_identity()

			target_client.prefs.load_character(last_slot)

	ADD_TRAIT(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 50)

/obj/item/organ/brain/lycan/proc/leave_beast_form()
	var/datum/species/current_wolf = owner.dna.species
	if(isnull(current_wolf) && !HAS_TRAIT_FROM(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT))
		return
	owner.visible_message(span_warning("[owner] shrinks down, their fur receding!"))

	if (last_slot)
		var/client/target_client = owner.client
		if (!isnull(target_client))
			target_client.prefs.load_character(last_slot)
			target_client.prefs.safe_transfer_prefs_to_with_damage(owner)
			owner.dna.update_dna_identity()
	else
		owner.set_species(/datum/species/human/cursekin, TRUE, TRUE, FALSE)
	REMOVE_TRAIT(owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 50)
	if(removed_quirks)
		for(var/typepath in removed_quirks)
			owner.add_quirk(typepath, owner.client, TRUE, FALSE)
		removed_quirks = null

/obj/item/organ/brain/lycan/proc/toggle_beast_form(mob/user)
	set name = "Enter/Leave Lycan Form"
	set desc = "Succumb to the rage and turn into a lycan."
	set category = "Lycan"
	if(!user)
		return
	if(!HAS_TRAIT(user, TRAIT_BEAST_FORM))
		enter_beast_form()
	else if(HAS_TRAIT(user, TRAIT_BEAST_FORM))
		leave_beast_form()

/obj/item/organ/brain/lycan/on_death(seconds_per_tick, times_fired)
	. = ..()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_BEAST_FORM))
		leave_beast_form()
