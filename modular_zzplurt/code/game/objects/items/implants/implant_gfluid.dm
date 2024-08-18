/* Commented until we have the genital fluid options
/obj/item/implant/genital_fluid
	name = "genital fluid implant"
	icon = 'modular_splurt/icons/obj/implants.dmi'
	icon_state = "genital_fluid"
	var/use_blacklist = TRUE

	// Custom action for extra customization
	actions_types = list(/datum/action/item_action/genital_fluid_infuse)

// Implant flavor text
/obj/item/implant/genital_fluid/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Nanotrasen Genital Fluid Inducer Implant<BR>
				<b>Important Notes:</b> It will only works in genitals that have the natural function of producing fluids.<BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Allows the user to induce their genitals into producing a specific reagent.<BR>
				<b>Special Features:</b> Will prevent harmful liquids from being accepted as a genital fluid replace.<BR>
				<b>Integrity:</b> Implant will last so long as the implant is inside the host and they possess genitals capable of fluid production."}
	return dat

// Only allow use on "human" targets
/obj/item/implant/genital_fluid/can_be_implanted_in(mob/living/target)
	if(!ishuman(target))
		return FALSE
	. = ..()

// Runs on toggling the implant
/obj/item/implant/genital_fluid/activate()
	. = ..()

	// Set list of possible genitals
	var/list/obj/item/organ/genital/genitals_list

	// Set list of possible fluids
	var/list/datum/reagent/fluid_list = list()

	// Set owner
	var/mob/living/carbon/human/genital_owner = imp_in

	// List their genitals if they have any at all
	for(var/obj/item/organ/genital/genital_checked in genital_owner.internal_organs)
		if(istype(genital_checked) && (genital_checked.genital_flags & GENITAL_FUID_PRODUCTION))
			// Add genitals to the list
			LAZYADD(genitals_list, genital_checked)

	// List their current reagents if they're valid
	for(var/datum/reagent/genital_reagent in genital_owner.reagents.reagent_list)
		if((find_reagent_object_from_type(genital_reagent.type)) && ((genital_reagent.type in allowed_gfluid_paths()) || !use_blacklist))
			// Add valid reagents to the list
			LAZYADD(fluid_list, find_reagent_object_from_type(genital_reagent.type))

	// List any reagents they may be holding in their hands
	if(genital_owner.available_rosie_palms(TRUE, /obj/item/reagent_containers))
		for(var/obj/item/reagent_containers/container in genital_owner.held_items)
			if(container.is_open_container() || istype(container, /obj/item/reagent_containers/food/snacks))
				for(var/datum/reagent/genital_reagent in container.reagents.reagent_list)
					if((find_reagent_object_from_type(genital_reagent.type)) && ((genital_reagent.type in allowed_gfluid_paths()) || !use_blacklist))
						// Add valid reagents to the list
						LAZYADD(fluid_list, find_reagent_object_from_type(genital_reagent.type))

	// Return if genitals list is void/null
	if(!genitals_list)
		// Play an error sound
		SEND_SOUND(genital_owner, 'sound/machines/terminal_error.ogg')

		// Alert the user in chat
		to_chat(genital_owner, span_notice("ERROR: No compatible genitals detected."))

		// Escape
		return

	// Prompt user for which genital to use
	var/obj/item/organ/genital/genital_input = tgui_input_list(genital_owner, "Pick a genital", "Genital Fluid Infuser", genitals_list)
	if(!genital_input)
		// No selection was made
		return

	// Update list of possible fluids
	fluid_list = list(find_reagent_object_from_type(genital_input.get_default_fluid())) + fluid_list

	// Prompt user to select a new fluid
	var/datum/reagent/reagent_selection = tgui_input_list(genital_owner, "Choose your new reagent", "Genital Fluid Infuser", fluid_list)
	if(!reagent_selection)
		// No selection was made
		return

	// Set new fluid
	genital_input.fluid_id = reagent_selection.type

	// Play the reagent processing sound effect
	SEND_SOUND(genital_owner, 'sound/effects/bubbles.ogg')

	// Display flavor text
	to_chat(genital_owner, span_notice("You feel the fluids inside your [genital_input.name] bubble and swirl..."))

	// Send admin notice
	message_admins("[ADMIN_LOOKUPFLW(genital_owner)] changed the fluid of [genital_owner.p_their()] [genital_input.name] to [reagent_selection].")

// Unlock with an emag
/obj/item/implant/genital_fluid/emag_act()
	. = ..()
	name = "hacked genital fluid implant"
	use_blacklist = FALSE
	obj_flags |= EMAGGED

/*
 * Action datum
*/

// Action for updating genital fluids
/datum/action/item_action/genital_fluid_infuse
	name = "Infuse Genital Fluids"
	desc = "Activate an integrated reagent receptor device to modify your genital contents."
	icon_icon = 'modular_splurt/icons/obj/implants.dmi'
	button_icon_state = "genital_fluid"
	background_icon_state = "bg_tech"

	// Restrict non-synthesizable reagents?
	var/use_blacklist = TRUE

/*
 * Implant items
*/

// Implanter item
/obj/item/implanter/genital_fluid
	name = "implanter (genital fluid)"
	imp_type = /obj/item/implant/genital_fluid

// Implanter item, emagged
/obj/item/implanter/genital_fluid/hacked
	name = "implanter (genital fluid (hacked))"

/obj/item/implanter/genital_fluid/hacked/New()
	. = ..()
	if(istype(imp, /obj/item/implant/genital_fluid))
		var/obj/item/implant/genital_fluid/I = imp
		I.emag_act()

// Implant case item
/obj/item/implantcase/genital_fluid
	name = "implant case - 'Genital Fluid'"
	desc = "A glass case containing a Genital Fluid Infuser implant."
	imp_type = /obj/item/implant/genital_fluid

// Implant case item, emagged
/obj/item/implantcase/genital_fluid/hacked
	name = "implant case - 'Genital Fluid (Hacked)'"

/obj/item/implantcase/genital_fluid/hacked/New()
	. = ..()
	if(istype(imp, /obj/item/implant/genital_fluid))
		var/obj/item/implant/genital_fluid/I = imp
		I.emag_act()
*/
