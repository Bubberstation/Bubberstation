#define BEAST_FORM_EXPOSITION_LINK "beast_form_exposition_link"

/datum/status_effect/beast_form
	id = "lycan_beast_form"
	alert_type = null // TODO - maybe add an alert??
	var/datum/species/initial_species

/datum/status_effect/beast_form/on_apply()
	. = ..()
	if (!.)
		return FALSE

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		return FALSE

	var/obj/item/organ/brain/lycan/lycan_brain = human_owner.get_organ_by_type(/obj/item/organ/brain/lycan)
	if (!istype(lycan_brain))
		return FALSE

	initial_species = human_owner.dna.species

	var/datum/species/human/cursekin/current_wolf = human_owner.dna.species
	if(!istype(current_wolf))
		return FALSE

	human_owner.visible_message(span_warning("[human_owner] turns [human_owner.p_their()] head to the sky and howls, rapidly growing and transforming into a horrible beast!"))

	var/client/target_client = human_owner.client
	if (!isnull(target_client))
		var/name = human_owner.real_name
		var/slot = target_client.prefs.read_preference(/datum/preference/numeric/cursekin_char_slot)
		var/transfer = TRUE
		if (isnull(lycan_brain.last_slot))
			lycan_brain.last_slot = target_client.prefs.savefile.get_entry("default_slot")
		target_client.prefs.load_character(slot)
		if (!ispath(target_client.prefs.read_preference(/datum.preference/choiced/species), current_wolf.lycanthropy_species))
			to_chat(human_owner, span_warning("Your selected slot is not a lycan! Defaulting to simply changing your species..."))
			target_client.prefs.load_character(lycan_brain.last_slot)
			human_owner.set_species(current_wolf.lycanthropy_species, TRUE, TRUE, FALSE)
			lycan_brain.last_slot = null // allows for easier switching in later procs
			transfer = FALSE

		if (transfer)
			target_client.prefs.safe_transfer_prefs_to_with_damage(human_owner)
			human_owner.real_name = name
			human_owner.name = name
			SSquirks.OverrideQuirks(human_owner, target_client, spawn_items = FALSE)
			human_owner.dna.update_dna_identity()

			target_client.prefs.load_character(lycan_brain.last_slot)

	ADD_TRAIT(human_owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(human_owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 50)

/datum/status_effect/beast_form/on_remove()
	. = ..()

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		return

	var/obj/item/organ/brain/lycan/lycan_brain = human_owner.get_organ_by_type(/obj/item/organ/brain/lycan)
	if (!istype(lycan_brain))
		return

	human_owner.visible_message(span_warning("[human_owner] shrinks down, their fur receding!"))

	if (lycan_brain.last_slot)
		var/client/target_client = human_owner.client
		if (isnull(target_client))
			human_owner.set_species(initial_species, TRUE, TRUE, FALSE)
		else
			target_client.prefs.load_character(lycan_brain.last_slot)
			target_client.prefs.safe_transfer_prefs_to_with_damage(human_owner)
			SSquirks.OverrideQuirks(human_owner, target_client, spawn_items = FALSE)
			human_owner.dna.update_dna_identity()
	else
		human_owner.set_species(initial_species, TRUE, TRUE, FALSE)

	REMOVE_TRAIT(human_owner, TRAIT_BEAST_FORM, SPECIES_TRAIT)
	playsound(human_owner, 'modular_zubbers/code/modules/customization/species/lycans/transform.ogg', 50)

/datum/status_effect/beast_form/tick(seconds_between_ticks)
	. = ..()

	var/mob/living/carbon/human_owner = owner
	if (!istype(human_owner))
		qdel(src)
		return

	if (human_owner.stat >= HARD_CRIT || human_owner.dna.species.id != SPECIES_LYCAN)
		qdel(src)
		return

/datum/status_effect/beast_form/get_examine_text()
	return span_notice("The NT employee manual has a entry on this species... <a href='byond://?src=[REF(src)];[BEAST_FORM_EXPOSITION_LINK]=1'>Recall what you read?</a>")

/datum/status_effect/beast_form/Topic(href, list/href_list)
	. = ..()

	if (href_list[BEAST_FORM_EXPOSITION_LINK])
		print_exposition(usr)

/datum/status_effect/beast_form/proc/print_exposition(mob/user)
	var/list/render_list = list()

	render_list += "Legends of lycanthropy and animalistic shapeshifters have always existed, but were not confirmed until a century ago when the Cursekin species was \
	officially recognized by most polities across the orion arm. The origin for their curse may vary by Cursekin - some from a god, some from genetics - but each \
	has the ability to transform into a terrifying beast with claws like razors."
	render_list += "<hr>"
	render_list += span_notice("Lycans and related may come in various forms, but each have similarities in how they function.")
	render_list += span_notice("\nLycans possess [EXAMINE_HINT("exceptionally strong claws")], about as strong as a [EXAMINE_HINT("circular saw")] without the armor penetration.")
	render_list += span_notice("\nLycans also have [EXAMINE_HINT("significant damage resistance")] to brute, and to a lesser extent, burn.")
	render_list += span_notice("\nHowever, Lycans [EXAMINE_HINT("cannot wear any clothes")] and cannot have synthetic organs.")
	render_list += span_notice("\nAdditionally, each Lycan possesses a [EXAMINE_HINT("marked weakness to silver")], taking [EXAMINE_HINT("increased damage")] from weapons comprised of it.")
	render_list += span_notice("\nFinally, Lycans [EXAMINE_HINT("cannot use batons")] nor [EXAMINE_HINT("most firearms")] due to the size of their fingers.")
	render_list += span_notice("\nThe Lycan form can be [EXAMINE_HINT("toggled at will")], or [EXAMINE_HINT("forcefully removed")] by [EXAMINE_HINT("knocking them into hard-crit")].")
	render_list += "<hr>"
	render_list += span_warning("While mostly docile, tamed, and relatively weak, it is rumored that some Lycans harbor a [EXAMINE_HINT("exceptionally capable")] form of the curse. Keep an eye out for any of the following:")
	render_list += span_warning("\n	* Extremely powerful claws")
	render_list += span_warning("\n	* Aggressive health regeneration")
	render_list += span_warning("\n	* Immunity to shoves and resistance to pain/stunning")
	render_list += span_warning("\n	* The ability to shrug off any amount of pain and keep sprinting")
	render_list += span_warning("\n	* The ability to smash down airlocks and windows with their claws")
	render_list += span_boldwarning("\nIf you find yourself facing a Lycan with these traits, take these precautions.")
	render_list += span_warning("\n	* Avoid physical weaponry and stamina weapons - their regeneration rapidly heals brute and stamina drain")
	render_list += span_warning("\n	* Use silver weaponry - they deal extra burn damage")
	render_list += span_warning("\n	* Use aerosolized silver - they cannot use internals and will burn on contact with it")
	render_list += span_warning("\n	* Pacify the lycan - they cannot smash windows or airlocks while pacified")

	var/output = jointext(render_list, "")

	to_chat(user, custom_boxed_message("blue_box", output), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)

#undef BEAST_FORM_EXPOSITION_LINK
