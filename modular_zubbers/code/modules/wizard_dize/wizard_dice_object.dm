//Gives you wizard if you land on 6. Fail, and the dice teleports somewhere else.

/obj/item/dice/d20/teleporting_die_of_fate
	name = "wizardly die of fate"
	desc = "An absurdly magical d20. Land on 20, and get a chance to win a chance to win a prize!"
	microwave_riggable = FALSE //lol. lmao
	COOLDOWN_DECLARE(roll_cd) //Prevents exploits
	var/forced_smite_number = 0 //For debugging.

/obj/item/dice/d20/teleporting_die_of_fate/cursed //Always rolls 1
	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 1

/obj/item/dice/d20/teleporting_die_of_fate/blessed //Always rolls 20
	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 20

/obj/item/dice/d20/teleporting_die_of_fate/Initialize(mapload)
	. = ..()
	src.add_filter("dice_glow", 2, list("type" = "outline", "color" = "#AC14FF30", "size" = 4))
	src.set_light(5,0.25,"#AC14FF")

/obj/item/dice/d20/teleporting_die_of_fate/examine(mob/user)
	. = ..()
	. += span_notice("Roll a 20, and you might become magical...")
	. += span_warning("Roll a 1, and you will end up in medical! (See: Fucking dead)")

/obj/item/dice/d20/teleporting_die_of_fate/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user) || !user.mind || IS_WIZARD(user))
		to_chat(user, span_warning("You feel the magic of the dice is restricted to ordinary humans! You should leave it alone."))
		user.dropItemToGround(src)


/obj/item/dice/d20/teleporting_die_of_fate/diceroll(mob/user, in_hand=FALSE)

	if(!COOLDOWN_FINISHED(src, roll_cd))
		to_chat(user, span_warning("Hold on, [src] isn't caught up with your last roll!"))
		return

	. = ..()

	if(!ishuman(user) || !user.mind || IS_WIZARD(user))
		to_chat(user, span_warning("You feel the magic of the dice is restricted to ordinary humans!"))
		return

	var/turf/current_turf = get_turf(src)
	current_turf.visible_message(span_userdanger("[src] flares briefly."))

	addtimer(CALLBACK(src, PROC_REF(effect), user, .), 1 SECONDS)
	COOLDOWN_START(src, roll_cd, 2.5 SECONDS)

/obj/item/dice/d20/teleporting_die_of_fate/proc/effect(mob/living/carbon/human/user,roll)

	var/turf/current_turf = get_turf(src)

	new/obj/effect/temp_visual/emp/pulse(current_turf) //Does not cause an EMP :^)
	playsound(current_turf,'sound/magic/magic_missile.ogg',50,8,FALSE)

	if(roll != 20)
		if(roll == 1) //lol. lmao
			user.emote("scream")
			user.investigate_log("has been smited by a wizardly die of fate.", INVESTIGATE_DEATHS)
			apply_random_smite(user)

		var/turf/desired_turf = get_safe_random_station_turf()
		if(!desired_turf) //This should never happen, but you never know.
			current_turf.visible_message(span_userdanger("[src] is erased from reality! Darn!"))
			qdel(src)
			return

		current_turf.visible_message(span_warning("[src] phases out to another location!"))

		//Teleport!
		src.forceMove(desired_turf)

		new/obj/effect/temp_visual/emp/pulse(desired_turf) //Does not cause an EMP :^)
		playsound(desired_turf,'sound/magic/magic_missile.ogg',50,8,FALSE)

		notify_ghosts(
			"[src] has teleported to [desired_turf.loc]!",
			source = src
		)

		return

	current_turf.visible_message(span_userdanger("Magic flows out of [src] and into [user]!"))
	user.mind.make_wizard()

	qdel(src)


/obj/item/dice/d20/teleporting_die_of_fate/proc/apply_random_smite(var/mob/living/target)

	var/datum/smite/chosen_smite

	//Unused smites and reasons:
	// /datum/smite/bsa, can gib
	// /datum/smite/dock_pay, not coded properly
	// /datum/smite/fake_bwoink, too minor
	// /datum/smite/fat, too minor
	// /datum/smite/ghost_control, too permanent
	// /datum/smite/gib, hmmmm
	// /datum/smite/custom_imaginary_friend, requires ghost polling
	// /datum/smite/immerse, too permanent
	// /datum/smite/knot_shoes, too minor
	// /datum/smite/nugget, too serious
	// /datum/smite/petrify, too permanent
	// /datum/smite/puzzgrid, too permanent. have you seen the puzzle-solving IQ of bubberstation players????
	// /datum/smite/puzzle, see above
	// /datum/smite/scarify, too minor
	// /datum/smite/supply_pod, /datum/smite/supply_pod_quick is better

	switch(forced_smite_number ? forced_smite_number : rand(1,11))
		if(1)
			var/datum/smite/bad_luck/bad_luck_smite = new
			bad_luck_smite.silent = FALSE
			bad_luck_smite.incidents = 7 //7 years bad luck (7 instances)
			chosen_smite = bad_luck_smite
		if(2)
			var/datum/smite/berforate/perforate_smite = new
			perforate_smite.hatred = "A lot"
			chosen_smite = perforate_smite
		if(3)
			chosen_smite = new /datum/smite/bloodless
		if(4)
			chosen_smite = new /datum/smite/boneless
		if(5)
			chosen_smite = new /datum/smite/brain_damage
		if(6)
			var/datum/smite/curse_of_babel/babel_smite = new
			babel_smite.duration = 5 MINUTES
			chosen_smite = babel_smite
		if(7)
			chosen_smite = new /datum/smite/fireball
		if(8)
			chosen_smite = new /datum/smite/lightning
		if(9)
			chosen_smite = new /datum/smite/ocky_icky
		if(10)
			var/datum/smite/rod/rod_smite = new
			rod_smite.force_looping = FALSE
			chosen_smite = rod_smite
		if(11)
			var/datum/smite/supply_pod_quick = new
			target_path = /obj/item/toy/plush/lizard_plushie
			chosen_smite = supply_pod_quick

	chosen_smite.effect(null,target)
