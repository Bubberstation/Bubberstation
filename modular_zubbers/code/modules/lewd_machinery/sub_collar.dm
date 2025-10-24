/obj/item/clothing/neck/sub_collar
	name = "training collar"
	desc = "A shiny black collar embedded with a micro-chip that allows the user to be trained quickly."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_black"
	kink_collar = TRUE
	// The person training the collar-wearer
	var/owner
	// the person wearing the collar
	var/mob/living/carbon/pet
	// if the person wearing the collar has the well-trained quirk
	var/has_well_trained

// shows a list of all people in the user's sight- including themselves, and allows the user to choose an owner
/obj/item/clothing/neck/sub_collar/attack_self(mob/user, modifiers)
	. = ..()
	if(!owner)
		var/list/in_view = get_hearers_in_view(world.view, user)
		in_view -= GLOB.dead_mob_list
		//in_view.Remove(user) - you can select yourself to "prep" the collar

		for(var/mob/mob in in_view) // filters out the AI eye and clientless mobs
			if(istype(mob, /mob/eye/camera/ai))
				continue
			if(mob.client)
				continue
			in_view.Remove(mob)

		owner = tgui_input_list(user, "Pick an owner", "Owner Selection", in_view)
		if(!owner)
			return FALSE
	else if(tgui_alert(user, "[owner] is your current owner, would you like to replace [owner]?", "Owner Replacement", list("Yes", "No")) == "Yes")
		owner = null
	return FALSE

// if the collar has an owner, view them on examine
/obj/item/clothing/neck/sub_collar/examine(mob/user)
	. = ..()
	if(!owner)
		return .
	. += span_purple("[owner]'s name is etched in the collar.")
	return .

// on equipping the collar, adds the effects of it
/obj/item/clothing/neck/sub_collar/equipped(mob/user, slot)
	. = ..()
	pet = user
	if(!(slot & ITEM_SLOT_NECK))
		return
	if(!(iscarbon(pet) && pet.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy)))
		return
	has_well_trained = pet.has_quirk(/datum/quirk/well_trained)
	if(has_well_trained) // removes well-trained as youre owned by one person
		pet.remove_quirk(/datum/quirk/well_trained)
	var/mob/living/carbon/target = owner
	if(owner && !(pet.name == target.name))
		RegisterSignal(pet, COMSIG_MOB_EXAMINING, PROC_REF(on_owner_examine))
		RegisterSignal(owner, COMSIG_MOB_EMOTE, PROC_REF(on_owner_snap))

// on removing the collar, removes the effects of it
/obj/item/clothing/neck/sub_collar/dropped(mob/user)
	. = ..()
	pet = user
	if(!(pet.wear_neck == src))
		return
	if(has_well_trained)
		pet.add_quirk(/datum/quirk/well_trained)
	if(owner)
		UnregisterSignal(pet, COMSIG_MOB_EXAMINING)
		UnregisterSignal(owner, COMSIG_MOB_EMOTE)
	pet = null
	has_well_trained = null

/obj/item/clothing/neck/sub_collar/proc/on_owner_examine(atom/source, mob/living/target, list/examine_list)
	SIGNAL_HANDLER

	if(!istype(target))
		return
	if(target.stat == DEAD)
		return
	examine_list += span_purple("You can't look at <b>[target]</b> for long before flustering away")

	if(TIMER_COOLDOWN_FINISHED(target, DOMINANT_COOLDOWN_EXAMINE))
		to_chat(target, span_purple("<b>[source]</b> tries to look at you but immediately looks away with a red face..."))
		TIMER_COOLDOWN_START(target, DOMINANT_COOLDOWN_EXAMINE, 15 SECONDS)
		INVOKE_ASYNC(pet, TYPE_PROC_REF(/mob, emote), "blush")
		pet.dir = turn(get_dir(pet, target), pick(-90, 90))


/obj/item/clothing/neck/sub_collar/proc/on_owner_snap(atom/source, datum/emote/emote_args)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(handle_owner_snap), source, emote_args)

/obj/item/clothing/neck/sub_collar/proc/handle_owner_snap(atom/source, datum/emote/emote_args)

	. = FALSE
	var mob/living/target = owner
	var/list/emote_list = list("snap", "snap2", "snap3")
	if(locate(emote_args.key) in emote_list)
		return
	if(!TIMER_COOLDOWN_FINISHED(target, DOMINANT_COOLDOWN_SNAP))
		return
	if(pet in hearers(world.view / 2, owner))
		if(pet.stat == DEAD)
			return
		var/good_x = "pet"
		switch(pet.gender)
			if(MALE)
				good_x = "boy"
			if(FEMALE)
				good_x = "girl"

		switch(emote_args.key)
			if("snap")
				pet.dir = get_dir(pet, owner)
				pet.emote("me", 1, "faces towards <b>[owner]</b> at attention!", TRUE)
				to_chat(pet, span_purple("<b>[owner]</b>'s snap shoots down your spine and puts you at attention"))

			if("snap2")
				pet.dir = get_dir(pet, owner)
				pet.Immobilize(0.3 SECONDS)
				pet.emote("me",1,"hunches down in response to <b>[owner]'s</b> snapping.", TRUE)
				to_chat(pet, span_purple("You hunch down and freeze in place in response to <b>[owner]</b> snapping their fingers"))

			if("snap3")
				pet.KnockToFloor(knockdown_amt = 0.1 SECONDS)
				step(pet, get_dir(pet, owner))
				pet.emote("me",1,"falls to the floor and crawls closer to <b>[owner]</b>, following their command.",TRUE)
				pet.do_jitter_animation(0.1 SECONDS)
				to_chat(pet, span_purple("You throw yourself on the floor like a pathetic beast and crawl towards <b>[owner]</b> like a good, submissive [good_x]."))

		. = TRUE

	if(.)
		TIMER_COOLDOWN_START(target, DOMINANT_COOLDOWN_SNAP, 10 SECONDS)
