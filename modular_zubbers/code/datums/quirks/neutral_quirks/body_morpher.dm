// BODY MORPHER QUIRK - Partly ported from SPLURT with some fixes. It's a quirk alternative to the NIF polymorph, for goopy/slime characters
/datum/quirk/body_morpher
	name = "Body Morpher"
	desc = "For one reason or another, you are able to shape your body into different forms, just like a slimeperson can."
	value = 0
	gain_text = span_notice("Your body feels more malleable.")
	lose_text = span_notice("Your body returns to a normal consistency.")
	medical_record_text = "Patient demonstrates ability to perform atypical voluntary plastic deformation."
	mob_trait = TRAIT_BODY_MORPHER
	icon = FA_ICON_PEOPLE_ARROWS
	mail_goodies = list (
		/obj/item/toy/foamblade = 1 // Fake changeling
	)

/datum/action/innate/alter_form/body_morpher
	name = "Alter Form"
	slime_restricted = FALSE
	shapeshift_text = "closes their eyes to focus, their body subtly shifting and contorting."

/datum/quirk/body_morpher/add(client/client_source)
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	// Add quirk ability action datum
	var/datum/action/innate/alter_form/body_morpher/quirk_action = new
	quirk_action.Grant(quirk_mob)

/datum/quirk/body_morpher/remove()
	// Define quirk mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder
	if(QDELETED(quirk_mob))
		return
	// Remove quirk ability action datum
	var/datum/action/innate/alter_form/body_morpher/quirk_action = locate() in quirk_mob.actions
	quirk_action.Remove(quirk_mob)

/datum/action/innate/alter_form/body_morpher/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"Body Colours" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "dna"),
			"Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"Markings" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan"),
			"Character" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "alter_form")
		),
		tooltips = TRUE,
	)
	if(!selected_alteration)
		return
	switch(selected_alteration)
		if("Body Colours")
			alter_colours(alterer)
		if("DNA")
			alter_dna(alterer)
		if("Hair")
			alter_hair(alterer)
		if("Markings")
			alter_markings(alterer)
		if("Character")
			begin_character_alteration(alterer)
