/datum/species/protean/on_species_gain(mob/living/carbon/human/target)
	. = ..()
	var/datum/action/innate/alter_form/protean/alter_action = new
	alter_action.Grant(target)

/datum/species/protean/on_species_loss(mob/living/carbon/human/target)
	. = ..()
	var/datum/action/innate/alter_form/protean/alter_action = locate() in target.actions
	alter_action?.Remove(target)

/datum/action/innate/alter_form/protean
	name = "Alter Form"
	slime_restricted = FALSE
	shapeshift_text = "'s nanites begin to move around their body and shift, as their orchestrator whirrs."

/datum/action/innate/alter_form/protean/change_form(mob/living/carbon/human/alterer)
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
