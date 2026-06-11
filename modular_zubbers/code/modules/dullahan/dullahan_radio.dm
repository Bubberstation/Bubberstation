/obj/item/implant/radio/headset/dullahan
	name = "internal headset implant"
	radio_type = /obj/item/radio/headset/dullahan
	subspace_transmission =  TRUE

/obj/item/radio/headset/dullahan/ui_status(mob/user, datum/ui_state/state)
	if(!user.stat)
		return UI_INTERACTIVE

// Sets things up for the second radio key. This is gross but until someone refactors radio code to be less stupid this will have to do.
/obj/item/implant/radio/headset/dullahan/Initialize(mapload, radio_key_1, radio_key_2)
	if(radio_key_1)
		radio_key = radio_key_1

	. = ..()

	var/obj/item/radio/headset/headset = radio // cast as headset so we can access keyslot2 var

	radio.name = "internal headset"
	icon = 'icons/obj/clothing/headsets.dmi'
	icon_state = "headset"

	if(radio_key_2)
		headset.keyslot2 = new radio_key_2
		headset.recalculateChannels()

/obj/item/radio/headset/dullahan

/datum/outfit/dullahan // empty outfit, we are basically just making use of post_equip() in order to set them up with a headset
	name = "dullahan essentials"

/datum/outfit/dullahan/post_equip(mob/living/carbon/human/user, visuals_only = FALSE)
	. = ..()
	if(visuals_only || isnull(user.mind) || !isdullahan(user))
		return


	var/datum/job/dullahan_job = user.mind.assigned_role
	var/datum/outfit/work_outfit = dullahan_job.outfit
	var/obj/item/radio/headset/work_headset = work_outfit::ears

	if(isnull(work_headset)) // No headset in their work outfit, we probably shouldn't give them one
		return
	var/datum/species/dullahan/dullahan_species = user.dna.species
	var/obj/item/dullahan_relay = dullahan_species.my_head
	var/obj/item/implant/radio/radio_head = locate() in dullahan_relay.loc
	if(radio_head)
		user.ears = radio_head.radio
		return

	// Set up the right encryption keys from their job
	radio_head = new /obj/item/implant/radio/headset/dullahan(user, work_headset::keyslot, work_headset::keyslot2)

	// Implant it and then move it to the head loc
	radio_head.implant(user)
	var/obj/item/radio/headset/radio_item = radio_head.radio
	user.ears = radio_item
	radio_item.grant_headset_languages(user)
	radio_item.set_listening(TRUE)
	radio_head.forceMove(dullahan_relay.loc)
