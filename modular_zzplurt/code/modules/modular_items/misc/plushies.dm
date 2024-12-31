/// Saliith Plushie && Pinpointer ///
GLOBAL_DATUM_INIT(saliith_plushie, /obj/item/toy/plush/lizard_plushie/saliith, new)
// Pointer
/obj/item/pinpointer/plushie_saliith
	name = "Saliith plushie pinpointer"
	desc = "A handheld tracking device that locates Saliith's plushie."
	icon = 'modular_zzplurt/icons/obj/device.dmi'
	icon_state = "pinpointer_saliith"

/obj/item/pinpointer/plushie_saliith/scan_for_target()
	target = pick(GLOB.saliith_plushie)

// Plushie
/obj/item/toy/plush/lizard_plushie/saliith
	name = "Saliith plushie"
	desc = "He looks like he needs a friend."
	icon = 'modular_zzplurt/icons/obj/plushes.dmi'
	icon_state = "saliith"
	lefthand_file = 'modular_zzplurt/icons/mob/inhands/misc/plushes_lefthand.dmi'
	righthand_file = 'modular_zzplurt/icons/mob/inhands/misc/plushes_righthand.dmi'
	gender = MALE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	obj_flags = null

/obj/item/toy/plush/lizard_plushie/saliith/Initialize(mapload, set_snowflake_id)
	if(GLOB.saliith_plushie && (GLOB.saliith_plushie != src))
		return INITIALIZE_HINT_QDEL
	SSpoints_of_interest.make_point_of_interest(src)
	. = ..()

	AddComponent(/datum/component/stationloving)
	normal_desc = "[p_they()] look[p_s()] like [p_they()] need[p_s()] a friend."

/obj/item/toy/plush/lizard_plushie/saliith/Destroy()
	SSpoints_of_interest.remove_point_of_interest(src)
	. = ..()

/obj/item/toy/plush/lizard_plushie/saliith/examine(mob/user)
	. = ..()

	if(!stuffed)
		. += span_deadsay("[p_they(TRUE)] [p_are()] dead.")
		return

	if(user.ckey == "sandpoot")
		. += span_deadsay("You feel a sense of familiarity from [p_them()].")
		return

	if((length(user?.mind?.antag_datums) >= 1))
		. += span_warning("[src] gives you a menacing glare! Patting [p_them()] would be a dangerous mistake.")

/obj/item/toy/plush/lizard_plushie/saliith/attack_self(mob/living/carbon/human/user)
	if(!user)
		return ..()

	if(!user.mind)
		return ..()

	if(user.ckey == "sandpoot")
		to_chat(user, span_notice("[p_they()] give[p_s()] you a hesitant gaze, but accept[p_s()] the gesture anyhow."))
		return ..()

	if((length(user?.mind?.antag_datums) >= 1))
		if(user?.mind?.has_antag_datum(/datum/antagonist/changeling))
			to_chat(user, span_notice("[src] senses what you really are, but decides to spare you."))

		else if(user?.mind?.has_antag_datum(/datum/antagonist/brainwashed))
			to_chat(user, span_notice("[src] senses that you're not in control of your actions, and offers [p_their()] sympathy."))
		else
			user.dropItemToGround(src)
			user.visible_message(span_warning("[src] smites [user] with an otherworldly wrath!"), span_boldwarning("You've made a grave mistake."))
			var/turf/turf_target = get_step(get_step(user, NORTH), NORTH)
			turf_target.Beam(user, icon_state="lightning[rand(1,12)]", time = 5)
			user.electrocution_animation(40)
			playsound(get_turf(user), 'sound/effects/magic/lightningbolt.ogg', 50, 1)
			user.adjustFireLoss(120)
			return

	to_chat(user, span_notice("[p_they()] give[p_s()] you a hesitant gaze, but accepts the gesture anyhow."))

	return ..()

/obj/item/toy/plush/lizard_plushie/saliith/attackby(obj/item/item_used, mob/living/user, params)
	if(item_used.get_sharpness())
		visible_message(span_warning("[src] knocks \the [item_used] out of [user]'s hands!"), span_warning("[src] knocks \the [item_used] out of your hands!"))
		user.dropItemToGround(item_used)
		item_used.throw_at(pick(oview(7,get_turf(src))),10,1)
		return

	if(user.ckey == "sandpoot")
		return ..()

	if(istype(item_used, /obj/item/grenade))
		visible_message(span_warning("[src] forces \the [item_used] into [user]'s mouth!"), span_warning("[src] forces \the [item_used] into your mouth!"))
		var/obj/item/grenade/item_grenade = item_used
		item_grenade.forceMove(user)
		item_grenade.arm_grenade(volume = 10)
		return

	return ..()

/obj/item/toy/plush/lizard_plushie/saliith/ex_act(severity, target, origin)
	return

/obj/item/toy/plush/love(obj/item/toy/plush/Kisser, mob/living/user)
	var/plush_saliith = /obj/item/toy/plush/lizard_plushie/saliith

	if(istype(src, plush_saliith) || istype(Kisser, plush_saliith))
		if(user.ckey == "sandpoot")
			return ..()

		user.visible_message(span_warning("[user] tried to force [Kisser] to kiss [src] against their will, and has been yeeted!"), span_warning("You try to force [Kisser] to kiss [src], but get yeeted instead!"))
		say("YEET", spans = list("colossus","yell"))

		playsound(get_turf(src), 'sound/effects/magic/clockwork/invoke_general.ogg', 200, TRUE, 5)

		if(src in user.held_items)
			user.dropItemToGround(src)
		if(Kisser in user.held_items)
			user.dropItemToGround(Kisser)

		var/turf/yeet_target = get_edge_target_turf(user, pick(GLOB.alldirs))
		user.throw_at(yeet_target, 10, 14)
		log_combat(src, user, "plush yeeted")

		return

	return ..()

/// Plushie choise beacon ///
// Box Delivery Code
/obj/item/choice_beacon/box
	name = "choice box (default)"
	desc = "Think really hard about what you want, and then rip it open!"
	icon = 'icons/obj/storage/wrapping.dmi'
	icon_state = "deliverypackage3"

/obj/item/choice_beacon/box/spawn_option(atom/choice, mob/living/M)
	var/choice_text = choice
	if(ispath(choice_text))
		choice_text = initial(choice.name)
	to_chat(M, "<span class='hear'>The box opens, revealing the [choice_text]!</span>")
	playsound(src.loc, 'sound/items/poster/poster_ripped.ogg', 50, 1)
	M.temporarilyRemoveItemFromInventory(src, TRUE)
	M.put_in_hands(new choice)
	qdel(src)

// Standart
/obj/item/choice_beacon/box/plushie
	name = "choice box (plushie)"
	desc = "Using the power of quantum entanglement, this box contains every plush, until the moment it is opened!"
	icon = 'icons/obj/storage/wrapping.dmi'
	icon_state = "deliverypackage3"

/obj/item/choice_beacon/box/plushie/generate_display_names()
	var/static/list/plushie_list = list()
	if(!length(plushie_list))
		var/list/plushies_set_one = subtypesof(/obj/item/toy/plush)
		plushies_set_one = remove_bad_plushies(plushies_set_one)
		for(var/V in plushies_set_one)
			var/atom/A = V
			plushie_list[initial(A.name)] = A
	return plushie_list

/obj/item/choice_beacon/box/plushie/proc/remove_bad_plushies(list/plushies)
	plushies -= list(
		/obj/item/toy/plush/narplush,
		/obj/item/toy/plush/awakenedplushie
		)
	return plushies

// Deluxe
/obj/item/choice_beacon/box/plushie/deluxe
	name = "Deluxe choice box (plushie)"
	desc =  "Using the power of quantum entanglement, this box contains five times every plush, until the moment it is opened!"
	uses = 5

/obj/item/choice_beacon/box/plushie/deluxe/spawn_option(choice, mob/living/M)
	//I don't wanna recode two different procs just for it to do the same as doing this
	if(uses > 1)
		var/obj/item/choice_beacon/box/plushie/deluxe/replace = new
		replace.uses = uses - 1
		M.put_in_hands(replace)
	. = ..()
