/obj/item/clothing/mask/gas/bubber //Saves having to type the icon stuff, means you just type in the state, smiley face emoji heart
	name = "EMERGENCY!!"
	desc = "The next 72 hours are going to be dangerous."
	icon = 'modular_zubbers/icons/obj/clothing/mask/mask.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/mask/mask.dmi'
	icon_state = null

//Sprites from Sojourn Station: https://github.com/sojourn-13/sojourn-station

/obj/item/clothing/mask/gas/bubber/clown
	name = "coloured clown mask"
	desc = "After a painful 48 year delay, the matching non-ginger Clown masks have arrived! Shoes are still in transit."
	clothing_flags = MASKINTERNALS
	icon_state = "redclown"
	dye_color = DYE_CLOWN
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	actions_types = list(/datum/action/item_action/adjust)
	dog_fashion = /datum/dog_fashion/head/clown
	obj_flags = parent_type::obj_flags

/obj/item/clothing/mask/gas/bubber/clown/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/coloured_clown_mask, infinite = TRUE)
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/coloured_clown_mask
	abstract_type = /datum/atom_skin/coloured_clown_mask

/datum/atom_skin/coloured_clown_mask/down_clown
	preview_name = "Down Clown"
	new_icon_state = "blueclown"

/datum/atom_skin/coloured_clown_mask/jumbo
	preview_name = "Jumbo"
	new_icon_state = "greenclown"

/datum/atom_skin/coloured_clown_mask/stepchild
	preview_name = "Stepchild"
	new_icon_state = "redclown"

/datum/atom_skin/coloured_clown_mask/banana_brained
	preview_name = "Banana Brained"
	new_icon_state = "yellowclown"

/datum/atom_skin/coloured_clown_mask/rhubarb_rubber
	preview_name = "Rhubarb Rubber"
	new_icon_state = "purpleclown"

/obj/item/clothing/mask/gas/bubber/clown/proc/on_reskin(datum/source, skin_name)
	SIGNAL_HANDLER
	if(ismob(loc))
		var/mob/clown = loc
		clown.update_worn_mask()
	voice_filter = null // performer masks expect to be talked through

/obj/item/clothing/mask/gas/half_mask
	name = "tacticool neck gaiter"
	desc = "A black techwear mask. Its low-profile design contrasts with the edge. Has a small respirator to be used with internals."
	actions_types = list(/datum/action/item_action/adjust)
	alternate_worn_layer = BODY_FRONT_UNDER_CLOTHES
	icon_state = "half_mask"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	unique_death = 'modular_skyrat/master_files/sound/effects/hacked.ogg'
	voice_filter = null
	use_radio_beeps_tts = FALSE
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/gas/half_mask/ui_action_click(mob/user, action)
	adjust_visor(user)

// Floor Cluwne stuff

//an undroppable mask that changes the user's speech to be unintelligable
/obj/item/clothing/mask/cluwne
	name = "clown wig and mask"
	desc = "A true prankster's facial attire. A clown is incomplete without his wig and mask."
	alternate_screams = list('yogstation/sound/voice/cluwnelaugh1.ogg','yogstation/sound/voice/cluwnelaugh2.ogg','yogstation/sound/voice/cluwnelaugh3.ogg')
	flags_cover = MASKCOVERSEYES
	icon_state = "cluwne"
	item_state = "cluwne"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	flags_1 = MASKINTERNALS
	item_flags = ABSTRACT | DROPDEL
	flags_inv = HIDEEARS | HIDEEYES
	modifies_speech = TRUE

	///world.time when a clune laugh was last played
	var/last_sound = 0
	///cooldown before playing another cluwne laugh
	var/delay = 15
	///if the mask should cluwne you when you put it on
	var/auto_cluwne = TRUE

/obj/item/clothing/mask/cluwne/Initialize(mapload)
	.=..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))

/**
  * Plays one of three cluwne laughs
  */
/obj/item/clothing/mask/cluwne/proc/play_laugh()
	if(world.time > last_sound + delay)
		var/i = rand(1,3)
		switch(i)
			if(1)
				playsound (src, 'yogstation/sound/voice/cluwnelaugh1.ogg', 30, 1)
			if(2)
				playsound (src, 'yogstation/sound/voice/cluwnelaugh2.ogg', 30, 1)
			if(3)
				playsound (src, 'yogstation/sound/voice/cluwnelaugh3.ogg', 30, 1)
		last_sound = world.time

/obj/item/clothing/mask/cluwne/handle_speech(datum/source, list/speech_args) //whenever you speak
	if(!CHECK_BITFIELD(clothing_flags, VOICEBOX_DISABLED))
		if(prob(5)) //the brain isnt fully gone yet...
			speech_args[SPEECH_MESSAGE] = pick("HELP ME!!","PLEASE KILL ME!!","I WANT TO DIE!!", "END MY SUFFERING", "I CANT TAKE THIS ANYMORE!!" ,"SOMEBODY STOP ME!!")
			play_laugh()
		if(prob(3))
			speech_args[SPEECH_MESSAGE] = pick("HOOOOINKKKKKKK!!", "HOINK HOINK HOINK HOINK!!","HOINK HOINK!!","HOOOOOOIIINKKKK!!") //but most of the time they cant speak,
			play_laugh()
		else
			speech_args[SPEECH_MESSAGE] = pick("HEEEENKKKKKK!!", "HONK HONK HONK HONK!!","HONK HONK!!","HOOOOOONKKKK!!") //More sounds,
			play_laugh()

/obj/item/clothing/mask/cluwne/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_MASK)
		play_laugh()
		if(auto_cluwne)
			var/mob/living/carbon/human/H = user
			H.dna.add_mutation(CLUWNEMUT)

/**
  * Togglable cluwne mask that has a small chance to turn the user into a cluwne or create a floor cluwne with the user as a target
  *
  * The logic of the cluwne mask is predetermined in [/obj/item/clothing/mask/yogs/cluwne/happy_cluwne/proc/Initialize] to prevent spamming the equip until you get a floor cluwne
  */
/obj/item/clothing/mask/cluwne/happy_cluwne
	name = "Happy Cluwne Mask"
	desc = "The mask of a poor cluwne that has been scrubbed of its curse by the Nanotrasen supernatural machinations division. Guaranteed to be 99% curse free and 99.9% not haunted."
	item_flags = ABSTRACT
	clothing_flags = VOICEBOX_TOGGLABLE
	auto_cluwne = FALSE

	/// If active, turns the user into a cluwne
	var/does_cluwne = FALSE
	/// If active, creates a floor cluwne with the user as a target
	var/does_floor_cluwne = FALSE

/obj/item/clothing/mask/cluwne/happy_cluwne/Initialize(mapload)
	.=..()
	REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))
	if(prob(1)) //this function pre-determines the logic of the cluwne mask. applying and reapplying the mask does not alter or change anything
		does_cluwne = TRUE
		does_floor_cluwne = FALSE
	else if(prob(0.1))
		does_cluwne = FALSE
		does_floor_cluwne = TRUE

/obj/item/clothing/mask/cluwne/happy_cluwne/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(slot == ITEM_SLOT_MASK)
		if(does_cluwne)
			log_admin("[key_name(H)] was made into a cluwne by [src]")
			message_admins("[key_name(H)] got cluwned by [src]")
			to_chat(H, span_userdanger("The masks straps suddenly tighten to your face and your thoughts are erased by a horrible green light!"))
			H.dropItemToGround(src)
			ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))
			H.cluwneify()
			qdel(src)
		else if(does_floor_cluwne)
			var/turf/T = get_turf(src)
			var/mob/living/simple_animal/hostile/floor_cluwne/S = new(T)
			S.Acquire_Victim(user)
			log_admin("[key_name(user)] summoned a floor cluwne using the [src]")
			message_admins("[key_name(user)] summoned a floor cluwne using the [src]")
			to_chat(H, span_warning("The mask suddenly slips off your face and... slides under the floor?"))
			to_chat(H, "<i>...dneirf uoy ot gnoleb ton seod tahT</i>")
			qdel(src)

// End floor cluwne stuff
