//Gives you wizard if you land on 6. Fail, and the dice teleports somewhere else.

/obj/item/dice/d20/teleporting_die_of_fate
	name = "wizardly die of fate"
	desc = "An absurdly magical d20. Land on 20, and get a chance to win a chance to win a prize!"
	var/uses_left = 20
	COOLDOWN_DECLARE(roll_cd) //Prevents exploits

/obj/item/dice/d20/teleporting_die_of_fate/Initialize(mapload)
	. = ..()
	src.add_filter("dice_glow", 2, list("type" = "outline", "color" = "#AC14FF30", "size" = 4))
	src.set_light(5,0.25,"#AC14FF")

/obj/item/dice/d20/teleporting_die_of_fate/examine(mob/user)
	. = ..()
	. += span_notice("It has [uses_left ? uses_left : "no"] uses left!")
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

	uses_left--

	if(roll != 20)
		if(roll == 1) //lol. lmao
			user.emote("scream")
			current_turf.visible_message(span_userdanger("[src] fucking dies!"))
			user.investigate_log("has been killed by a die of fate.", INVESTIGATE_DEATHS)
			user.death()

		uses_left--

		var/turf/desired_turf = get_safe_random_station_turf()
		if(!desired_turf || uses_left <= 0)
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
