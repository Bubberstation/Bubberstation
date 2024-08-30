/obj/item/implant/disrobe
	name = "rapid disrobe implant"
	icon = 'icons/obj/clothing/uniforms.dmi'
	icon_state = "grey"

	// Custom action for extra customization
	actions_types = list(/datum/action/item_action/disrobe)

// Implant flavor text
/obj/item/implant/disrobe_ultra/get_data()
	// Define text variable
	var/dat = {"
		<b>Implant Specifications:</b><BR>
		<b>Name:</b> Rapid Disrobe Implant<BR>
		<b>Important Notes:</b> Nanotransen requires employees to follow workplace safety standards, including protective clothing.<BR>
		<HR>
		<b>Implant Details:</b><BR>
		<b>Function:</b> Lines the subject's epidermis with high power static charge nodes, allowing the rapid removal of worn clothing.<BR>
		<b>Special Features:</b> Will not cause drunkenness in most subjects.<BR>
		<b>Integrity:</b> Implant will last so long as it is inside the host.
		"}

	// Return text
	return dat

// Only allow use on "human" targets
/obj/item/implant/disrobe/can_be_implanted_in(mob/living/target)
	if(!ishuman(target))
		return FALSE
	. = ..()

// Runs on toggling the implant
/obj/item/implant/disrobe/activate()
	. = ..()

	// Define target
	var/mob/living/carbon/target_user = imp_in

	// Perform LPD effect
	target_user.clothing_burst(TRUE)

/*
 * Action datums
*/

// Action for rapid wardrobe removal
/datum/action/item_action/disrobe
	name = "Rapid Disrobe"
	desc = "Instantly eject all covering clothing from your body."
	button_icon = 'modular_zzplurt/icons/mob/actions/misc_actions.dmi'
	button_icon_state = "no_uniform"
	background_icon_state = "bg_tech"

/*
 * Implant items
*/

// Implanter item
/obj/item/implanter/disrobe
	name = "implanter (rapid disrobe)"
	imp_type = /obj/item/implant/disrobe

// Implant case item
/obj/item/implantcase/disrobe
	name = "implant case - 'rapid disrobe'"
	desc = "A glass case containing a rapid disrobe implant."
	imp_type = /obj/item/implant/disrobe
