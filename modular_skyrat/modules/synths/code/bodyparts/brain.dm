/obj/item/organ/brain/synth
	name = "compact positronic brain"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	organ_flags = ORGAN_ROBOTIC | ORGAN_SYNTHETIC_FROM_SPECIES
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"
	/// The last time (in ticks) a message about brain damage was sent. Don't touch.
	var/last_message_time = 0
	organ_traits = list(TRAIT_SILICON_EMOTES_ALLOWED)
	var/mmi_type = /obj/item/mmi/posibrain
	var/obj/item/mmi/stored_mmi

/obj/item/organ/brain/synth/Initialize(mapload, obj/item/mmi/M)
	. = ..()
	if(M && istype(M))
		stored_mmi = M
		M.forceMove(src)
	else
		stored_mmi = new mmi_type(src)

/obj/item/organ/brain/synth/Destroy()
	QDEL_NULL(stored_mmi)
	return ..()

/obj/item/organ/brain/synth/Insert(mob/living/carbon/receiver, special = FALSE, movement_flags)
	if(special)
		return ..()
	if(!stored_mmi)
		qdel(src)
		return
	brainmob = stored_mmi.brainmob
	return ..()

/obj/item/organ/brain/synth/Remove(mob/living/carbon/organ_owner, special = FALSE, movement_flags)
	if(special)
		return ..()
	if(!stored_mmi)
		. = ..()
		qdel(src)
		return

	stored_mmi.forceMove(get_turf(owner)) // so we can get the turf of the owner
	..()
	stored_mmi = null
	qdel(src)


/obj/item/organ/brain/synth/transfer_identity(mob/living/L)
	..(stored_mmi.brainmob)
	// brainmob.loc = null
	// brainmob.forceMove(stored_mmi) //moves the brainmob to the stored mmi
	// stored_mmi.set_brainmob(brainmob) //sets the mmi's brainmob to the current one
	// brainmob.container = stored_mmi
	// stored_mmi.brain = L // for the mmi icon
	// stored_mmi.name = "[initial(name)] ([L.real_name])"
	// brainmob.set_stat(CONSCIOUS) //mmis are conscious
	// brainmob.remove_from_dead_mob_list()
	// brainmob.add_to_alive_mob_list() //mmis are technically alive I guess?
	// stored_mmi.update_appearance() //update it because the brain is alive now
	// brainmob.reset_perspective() //resets perspective to the mmi
	// brainmob = null //clears the brainmob var so it doesn't get deleted when the holder is destroyed

/obj/item/organ/brain/synth/on_mob_insert(mob/living/carbon/brain_owner, special, movement_flags = NO_ID_TRANSFER)
	. = ..()

	if(brain_owner.stat != DEAD || !ishuman(brain_owner))
		return

	var/mob/living/carbon/human/user_human = brain_owner
	if(HAS_TRAIT(user_human, TRAIT_REVIVES_BY_HEALING) && user_human.health > SYNTH_BRAIN_WAKE_THRESHOLD)
		user_human.revive(FALSE)

/obj/item/organ/brain/synth/emp_act(severity) // EMP act against the posi, keep the cap far below the organ health
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
		switch(severity)
			if(EMP_HEAVY)
				to_chat(owner, span_warning("01001001 00100111 01101101 00100000 01100110 01110101 01100011 01101011 01100101 01100100 00101110"))
				apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)
			if(EMP_LIGHT)
				to_chat(owner, span_warning("Alert: Electromagnetic damage taken in central processing unit. Error Code: 401-YT"))
				apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, SYNTH_EMP_BRAIN_DAMAGE_MAXIMUM, required_organ_flag = ORGAN_ROBOTIC)

/obj/item/organ/brain/synth/apply_organ_damage(damage_amount, maximum = maxHealth, required_organ_flag = NONE)
	. = ..()

	if(owner && damage > 0 && (world.time - last_message_time) > SYNTH_BRAIN_DAMAGE_MESSAGE_INTERVAL)
		last_message_time = world.time

		if(damage > BRAIN_DAMAGE_SEVERE)
			to_chat(owner, span_warning("Alre: re oumtnin ilir tocorr:pa ni ne:cnrrpiioruloomatt cessingode: P1_1-H"))
			return

		if(damage > BRAIN_DAMAGE_MILD)
			to_chat(owner, span_warning("Alert: Minor corruption in central processing unit. Error Code: 001-HP"))

/obj/item/organ/brain/synth/circuit
	name = "compact AI circuit"
	desc = "A compact and extremely complex circuit, It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/alt_silicon_brains.dmi'
	icon_state = "circuit-occupied"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	mmi_type = /obj/item/mmi/posibrain/circuit

/obj/item/organ/brain/synth/mmi
	name = "compact man-machine interface"
	desc = "A compact man-machine interface, It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "mmi-ipc"
	mmi_type = /obj/item/mmi
