//Gives you wizard if you land on 6. Fail, and the dice teleports somewhere else.



/obj/item/dice/d20/teleporting_die_of_fate
	name = "wizardly die of fate"
	desc = "An absurdly magical d20. Land on 20, and get a chance to win a chance to win a prize!"
	microwave_riggable = FALSE //lol. lmao
	COOLDOWN_DECLARE(roll_cd) //Prevents exploits
	var/smite_rng_seed = 1
	var/do_teleport = TRUE

/obj/item/dice/d20/teleporting_die_of_fate/cursed //Always rolls 1. Careful with this, as this is a reliable way to summon a smite.
	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 1

/obj/item/dice/d20/teleporting_die_of_fate/blessed //Always rolls 20. This is basically single use since it just makes you wizard and deletes itself.
	rigged = DICE_TOTALLY_RIGGED
	rigged_value = 20

/obj/item/dice/d20/teleporting_die_of_fate/Initialize(mapload)
	. = ..()
	src.add_filter("dice_glow", 2, list("type" = "outline", "color" = "#AC14FF30", "size" = 4))
	src.set_light(5,0.25,"#AC14FF")
	smite_rng_seed = rand(1,11) //The only reason I do this is for testing :^). It does have some benefit to not having the same 2 effects occur in a row.

/obj/item/dice/d20/teleporting_die_of_fate/examine(mob/user)
	. = ..()
	. += span_notice("Roll a 20, and you might become magical...")
	. += span_warning("Roll a 1, and you will end up in medical!")

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

		if(do_teleport)
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

	if(!target.client)
		//Cheater.
		target.gib(DROP_ALL_REMAINS)
		return

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
	// /datum/smite/bloodless, way too loud.
	// /datum/smite/boneless, way too loud

	switch(smite_rng_seed % 9)
		if(0)
			var/datum/smite/bad_luck/bad_luck_smite = new
			bad_luck_smite.silent = FALSE
			bad_luck_smite.incidents = 7 //7 years bad luck (7 instances)
			chosen_smite = bad_luck_smite
		if(1)
			var/datum/smite/berforate/perforate_smite = new
			perforate_smite.hatred = "A little" //Actually unironically has a chance to gib.
			chosen_smite = perforate_smite
		if(2)
			chosen_smite = new /datum/smite/brain_damage
		if(3)
			var/datum/smite/curse_of_babel/babel_smite = new
			babel_smite.duration = 5 MINUTES
			chosen_smite = babel_smite
		if(4)
			chosen_smite = new /datum/smite/fireball
		if(5)
			chosen_smite = new /datum/smite/lightning
		if(6)
			chosen_smite = new /datum/smite/ocky_icky
		if(7)
			var/datum/smite/rod/rod_smite = new
			rod_smite.force_looping = FALSE
			chosen_smite = rod_smite
		if(8)
			var/datum/smite/supply_pod_quick/supply_pod_smite = new
			supply_pod_smite.target_path = /obj/item/toy/plush/lizard_plushie
			chosen_smite = supply_pod_smite

	smite_rng_seed++

	chosen_smite.effect(target.client,target) //Client is needed here so it is logged properly.
