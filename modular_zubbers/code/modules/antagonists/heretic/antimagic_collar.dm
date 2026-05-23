/obj/item/clothing/neck/antimagic_collar
	name = "\improper irreality collar"
	desc = "A cumbersome collar of antimagic nature, capable of reaching into - and cutting off - a thread of mansus wherever it may be."
	icon = 'modular_zubbers/icons/obj/clothing/neck/neck.dmi'
	icon_state = "antimagic_collar"
	worn_icon = 'modular_zubbers/icons/mob/clothing/neck/neck.dmi'
	worn_icon_state = "antimagic_collar"
	inhand_icon_state = "reverse_bear_trap"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	clothing_flags = INEDIBLE_CLOTHING|DANGEROUS_OBJECT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.25,
	)

	armor_type = /datum/armor/antimagic_collar
	equip_delay_self = 6 SECONDS
	equip_delay_other = 8 SECONDS
	repairable_by = /obj/item/stack/sheet/bluespace_crystal

	speech_span = SPAN_ROBOT

	max_integrity = 30
	integrity_failure = 0.5

	clothing_traits = list(TRAIT_MANSUS_INHIBITION)

	var/obj/item/radio/headset/radio

	var/set_id = "UNSET"
	var/locked = FALSE
	var/broken = FALSE

	var/static/list/emp_heavy_results = list(
		"zap" = 50,
		"burn" = 50,
		"unlock" = 20,
	)

/datum/armor/antimagic_collar
	acid = 50
	fire = 20
	bomb = 50

/obj/item/clothing/neck/antimagic_collar/Destroy()
	. = ..()

	QDEL_NULL(radio)

/obj/item/clothing/neck/antimagic_collar/Initialize(mapload)
	. = ..()

	radio = new /obj/item/radio/headset/headset_sec(src)
	ADD_TRAIT(src, TRAIT_NO_STRIP, REF(src))

/obj/item/clothing/neck/antimagic_collar/attack_self(mob/user, modifiers)
	var/new_id = tgui_input_text(user, "Input the new ID.", "ID input", timeout = 20 SECONDS, max_length = 100)

	if (!new_id)
		balloon_alert(user, "invalid id!")
		return FALSE

	set_id = new_id
	balloon_alert(user, "id set to [set_id]")
	return TRUE

/obj/item/clothing/neck/antimagic_collar/examine(mob/user)
	. = ..()

	. += span_boldnotice("Prevents the use of most Acolyte spells and all Acolyte rituals while attached to a neck.")
	. += span_boldnotice("Use while in-hand to set the ID. Its current id is [set_id].")
	. += span_notice("Capable of being disabled by acid and fire, or unlocked with a strong EMP.")
	. += span_warning("Will announce to the security channel if unlocked with a key! Though, if comms were jammed...")
	. += "" // hr
	. += span_notice("It seems to be [locked ? "locked" : "unlocked"].")
	if (broken)
		. += span_boldwarning("Its broken, and currently nonfunctional!")
	else
		var/hp_left = get_integrity() - (max_integrity * integrity_failure)
		. += span_notice("It has [EXAMINE_HINT("[hp_left]")] integrity left til it breaks.")

/obj/item/clothing/neck/antimagic_collar/equipped(mob/living/user, slot)
	. = ..()

	if (slot == ITEM_SLOT_NECK)
		if (IS_HERETIC(user) && !broken)
			to_chat(loc, span_userdanger("You feel your connection to the Mansus weaken and eventually fade!"))
		if (!locked)
			toggle_lock(TRUE)
			visible_message(span_warning("[src] automatically locks!"))

/obj/item/clothing/neck/antimagic_collar/atom_break(damage_flag)
	. = ..()

	name = "[name] (BROKEN!)"
	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50)
	broken = TRUE
	if (isliving(loc))
		var/mob/living/wearer = loc
		do_sparks(3)
		say("Inhibition failure detected! Please check collar for signs of damage!")
		if (IS_HERETIC(wearer))
			to_chat(wearer, span_boldnotice("As [src] sputters and sparks, you feel your powers return..."))

	detach_clothing_traits(TRAIT_MANSUS_INHIBITION)
	REMOVE_TRAIT(src, TRAIT_NO_STRIP, REF(src))
	// still locked, though

/obj/item/clothing/neck/antimagic_collar/emp_act(severity)
	. = ..()

	var/mob/living/wearer
	if (isliving(loc))
		wearer = loc

	switch (severity)
		if (EMP_LIGHT)
			return
		if (EMP_HEAVY)
			var/outcome = pick_weight(emp_heavy_results)
			switch (outcome)
				if ("zap")
					to_chat(loc, span_userdanger("[src] malfunctions, debilitating you with a terrible shock!"))
					wearer?.electrocute_act(25, src, 1, SHOCK_ILLUSION|SHOCK_SUPPRESS_MESSAGE|SHOCK_NOGLOVES|SHOCK_KNOCKDOWN) // illusion so it doesnt do damage
				if ("burn")
					to_chat(loc, span_userdanger("[src] malfunctions, overheating and burning your neck!"))
					wearer?.apply_damage(25, BURN, BODY_ZONE_HEAD) // yes it can wound
				if ("unlock")
					if (!locked)
						return
					to_chat(loc, span_userdanger("[src] malfunctions, unlocking when it REALLY shouldn't!"))
					toggle_lock(FALSE)

/obj/item/clothing/neck/antimagic_collar/repair(mob/user)
	. = ..()

	broken = FALSE
	name = initial(src.name)

	if (TRAIT_MANSUS_INHIBITION in clothing_traits)
		return

	attach_clothing_traits(TRAIT_MANSUS_INHIBITION)
	ADD_TRAIT(src, TRAIT_NO_STRIP, REF(src))

	if (isliving(loc))
		var/mob/living/wearer = loc

		playsound(src, 'sound/machines/ping.ogg', 50)
		say("Inhibition function restored!")

		if (IS_HERETIC(wearer))
			to_chat(wearer, span_userdanger("As [src] returns to function, you feel your powers fade!"))

/obj/item/clothing/neck/antimagic_collar/proc/toggle_lock(new_status, mob/living/user, obj/item/key/collar/antimagic/key)
	if (locked == new_status)
		return

	locked = new_status
	balloon_alert_to_viewers("[locked ? "locked!" : "unlocked!"]")
	if (!isnull(key) && !locked)
		radio.talk_into(src, "Antimagic collar [set_id] unlocked using a key.", RADIO_CHANNEL_SECURITY, list(speech_span))
	if (user)
		to_chat(user, span_warning("You [locked ? "lock" : "unlock"] the collar."))

/obj/item/clothing/neck/antimagic_collar/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_lock))

/obj/item/clothing/neck/antimagic_collar/proc/try_lock(atom/source, mob/user, obj/item/attacking_item, params)
	if(istype(attacking_item, /obj/item/key/collar/antimagic))
		toggle_lock(!locked, user, attacking_item)
	return TRUE

/obj/item/clothing/neck/antimagic_collar/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && locked)
		to_chat(user, span_warning("The collar is locked! You'll need unlock the collar before you can take it off! Alternatively, you could try destroying it..."))
		return
	..()

/obj/item/key/collar/antimagic
	name = "antimagic collar key"
	desc = "The only kind of key that will open an antimagic collar. Hard to come across organically."

/obj/item/key/collar/antimagic/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	var/obj/item/clothing/neck/antimagic_collar/collar = target_mob.get_item_by_slot(ITEM_SLOT_NECK)
	if (!istype(collar))
		user.balloon_alert(user, "no collar!")
		return FALSE

	collar.toggle_lock(!collar.locked, user, src)

	return TRUE

/obj/item/storage/box/antimagic
	name = "antimagic collar box"
	desc = "Contains a pair of anti-Acolyte collars, as well as a key to unlock them with."
	icon_state = "secbox"
	illustration = "heart_black"

/obj/item/storage/box/antimagic/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/clothing/neck/antimagic_collar(src)
	new /obj/item/key/collar/antimagic(src)

/datum/supply_pack/security/antimagic_collar
	name = "Antimagic Collars"
	desc = "Contains a pair of Anti-Acolyte collars, as well as a key to unlock them with."
	cost = CARGO_CRATE_VALUE * 5
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/storage/box/antimagic = 1)
	crate_name = "antimagic collar crate"
