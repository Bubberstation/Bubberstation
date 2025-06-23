/mob/living/carbon/proc/protean_ui()
	set name = "Open Suit UI"
	set desc = "Opens your suit UI"
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		return
	species.species_modsuit.ui_interact(src)

/mob/living/carbon/proc/protean_heal()
	set name = "Heal Organs and Limbs"
	set desc = "Heals your replacable organs and limbs with 6 metal."
	set category = "Protean"

	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return

	var/datum/species/protean/species = dna.species
	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	if(incapacitated && loc != suit)
		balloon_alert(src, "incapacitated!")
		return

	brain.replace_limbs()

/mob/living/carbon/proc/lock_suit()
	set name = "Lock Suit"
	set desc = "Locks your suit on someone"
	set category = "Protean"

	var/datum/species/protean/species = dna.species

	if(!istype(species))
		return

	var/obj/item/mod/control/pre_equipped/protean/suit = species.species_modsuit
	species.species_modsuit.toggle_lock()
	to_chat(src, span_notice("You [suit.modlocked ? "<b>lock</b>" : "<b>unlock</b>"] the suit [isprotean(suit.wearer) || loc == suit ? "" : "onto [suit.wearer]"]"))
	playsound(src, 'sound/machines/click.ogg', 25)

/mob/living/carbon/proc/suit_transformation()
	set name = "Toggle Suit Transformation"
	set desc = "Either leave or enter your suit."
	set category = "Protean"
	var/obj/item/organ/brain/protean/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	if(!istype(brain))
		return
	var/datum/species/protean/species = dna.species
	if(loc == species.species_modsuit)
		brain.leave_modsuit()
	else if(isturf(loc))
		if(!incapacitated)
			brain.go_into_suit()
		else
			balloon_alert(src, "incapacitated!")

/mob/living/carbon/proc/low_power()
	set name = "Toggle Low Power Mode"
	set desc = "Toggle whether you are running on low power mode."
	set category = "Protean"

	var/datum/species/protean/species = dna.species
	if(!istype(species))
		return
	var/obj/item/organ/stomach/protean/stomach = get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach))
		to_chat(src, span_warning("You are missing a stomach and can't turn on low power mode"))
		return
	if(loc == species.species_modsuit)
		to_chat(src, span_notice("You can't toggle low power when in a suit form!"))
		return
	if(!do_after(src, 2.5 SECONDS)) // Long enough to where our stomach can process inbetween activations
		src.loc.balloon_alert(src, "toggle interrupted")
		return
	if(has_status_effect(/datum/status_effect/protean_low_power_mode))
		stomach.metabolism_modifier *= 16
		remove_status_effect(/datum/status_effect/protean_low_power_mode)
	else
		if(species.species_modsuit.active)
			species.species_modsuit.toggle_activate(usr, TRUE)
		stomach.metabolism_modifier /= 16
		apply_status_effect(/datum/status_effect/protean_low_power_mode)

