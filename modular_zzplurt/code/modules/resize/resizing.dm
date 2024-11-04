//handle the big steppy, except nice
/mob/living/proc/handle_micro_bump_helping(mob/living/target)
	if(ishuman(src))
		var/mob/living/carbon/human/user = src

		if(target.pulledby == user)
			return FALSE

		//Micro is on a table.
		var/turf/steppyspot = target.loc
		for(var/thing in steppyspot.contents)
			if(istype(thing, /obj/structure/table))
				return TRUE

		//Both small.
		if(get_size(user) <= RESIZE_A_TINYMICRO && get_size(target) <= RESIZE_A_TINYMICRO)
			now_pushing = 0
			user.forceMove(target.loc)
			return TRUE

		//Doing messages
		if(COMPARE_SIZES(user, target) >= 2) //if the initiator is twice the size of the micro
			now_pushing = 0
			user.forceMove(target.loc)

			//Smaller person being stepped on
			if(iscarbon(src))
				if(istype(user) && user.dna.features["taur"] == "Naga" || user.dna.features["taur"] == "Tentacle")
					target.visible_message(span_notice("[src] carefully slithers around [target]."), span_notice("[src]'s huge tail slithers besides you."))
				else
					target.visible_message(span_notice("[src] carefully steps over [target]."), span_notice("[src] steps over you carefully."))
				return TRUE

		//Smaller person stepping under a larger person
		if(COMPARE_SIZES(target, user) >= 2)
			user.forceMove(target.loc)
			now_pushing = 0
			micro_step_under(target)
			return TRUE

//Stepping on disarm intent -- TO DO, OPTIMIZE ALL OF THIS SHIT
/mob/living/proc/handle_micro_bump_other(mob/living/target)
	ASSERT(isliving(target))
	if(ishuman(src))
		var/mob/living/carbon/human/user = src

		if(target.pulledby == user)
			return FALSE

	//If on a table, don't
		var/turf/steppyspot = target.loc
		for(var/thing in steppyspot.contents)
			if(istype(thing, /obj/structure/table))
				return TRUE

	//Both small
		if(get_size(user) <= RESIZE_A_TINYMICRO && get_size(target) <= RESIZE_A_TINYMICRO)
			now_pushing = 0
			user.forceMove(target.loc)
			return TRUE

		if(COMPARE_SIZES(user, target) >= 2)
			log_combat(user, target, "stepped on", addition="[resolve_intent_name(user.combat_mode)] trample")
			if((user.mobility_flags & MOBILITY_MOVE) && !user.buckled)
				switch(resolve_intent_name(user.combat_mode))
					if("disarm")
						now_pushing = 0
						user.forceMove(target.loc)
						user.sizediffStamLoss(target)
						user.add_movespeed_modifier(/datum/movespeed_modifier/stomp, TRUE) //Full stop
						addtimer(CALLBACK(user, TYPE_PROC_REF(/mob, remove_movespeed_modifier), MOVESPEED_ID_STOMP, TRUE), 3) //0.3 seconds
						if(iscarbon(user))
							if(istype(user) && user.dna.features["taur"] == "Naga" || user.dna.features["taur"] == "Tentacle")
								target.visible_message(span_danger("[src] carefully rolls their tail over [target]!"), span_danger("[src]'s huge tail rolls over you!"))
							else
								target.visible_message(span_danger("[src] carefully steps on [target]!"), span_danger("[src] steps onto you with force!"))
							return TRUE

					if("harm")
						now_pushing = 0
						user.forceMove(target.loc)
						user.sizediffStamLoss(target)
						user.sizediffBruteloss(target)
						playsound(loc, 'sound/misc/splort.ogg', 50, 1)
						user.add_movespeed_modifier(/datum/movespeed_modifier/stomp, TRUE)
						addtimer(CALLBACK(user, TYPE_PROC_REF(/mob, remove_movespeed_modifier), MOVESPEED_ID_STOMP, TRUE), 1 SECONDS) //1 second
						//user.Stun(20)
						if(iscarbon(user))
							if(istype(user) && (user.dna.features["taur"] == "Naga" || user.dna.features["taur"] == "Tentacle"))
								target.visible_message(span_danger("[src] mows down [target] under their tail!"), span_userdanger("[src] plows their tail over you mercilessly!"))
							else
								target.visible_message(span_danger("[src] slams their foot down on [target], crushing them!"), span_userdanger("[src] crushes you under their foot!"))
							return TRUE

					if("grab")
						now_pushing = 0
						user.forceMove(target.loc)
						user.sizediffStamLoss(target)
						user.sizediffStun(target)
						user.add_movespeed_modifier(/datum/movespeed_modifier/stomp, TRUE)
						addtimer(CALLBACK(user, TYPE_PROC_REF(/mob, remove_movespeed_modifier), MOVESPEED_ID_STOMP, TRUE), 7)//About 3/4th a second
						if(iscarbon(user))
							var/feetCover = (user.wear_suit && (user.wear_suit.body_parts_covered & FEET)) || (user.w_uniform && (user.w_uniform.body_parts_covered & FEET) || (user.shoes && (user.shoes.body_parts_covered & FEET)))
							if(feetCover)
								if(user?.dna?.features["taur"] == "Naga" || user?.dna?.features["taur"] == "Tentacle")
									target.visible_message(span_danger("[src] pins [target] under their tail!"), span_danger("[src] pins you beneath their tail!"))
								else
									target.visible_message(span_danger("[src] pins [target] helplessly underfoot!"), span_danger("[src] pins you underfoot!"))
								return TRUE
							else
								if(user?.dna?.features["taur"] == "Naga" || user?.dna?.features["taur"] == "Tentacle")
									target.visible_message(span_danger("[user] snatches up [target] underneath their tail!"), span_userdanger("[src]'s tail winds around you and snatches you in its coils!"))
									//target.mob_pickup_micro_feet(user)
									SEND_SIGNAL(target, COMSIG_MICRO_PICKUP_FEET, user)
								else
									target.visible_message(span_danger("[user] stomps down on [target], curling their toes and picking them up!"), span_userdanger("[src]'s toes pin you down and curl around you, picking you up!"))
									//target.mob_pickup_micro_feet(user)
									SEND_SIGNAL(target, COMSIG_MICRO_PICKUP_FEET, user)
								return TRUE

		if(COMPARE_SIZES(target, user) >= 2)
			user.forceMove(target.loc)
			now_pushing = 0
			micro_step_under(target)
			return TRUE

/mob/living/proc/macro_step_around(mob/living/target)
	if(ishuman(src))
		var/mob/living/carbon/human/validmob = src
		if(validmob?.dna?.features["taur"] == "Naga" || validmob?.dna?.features["taur"] == "Tentacle")
			visible_message(span_notice("[validmob] carefully slithers around [target]."), span_notice("You carefully slither around [target]."))
		else
			visible_message(span_notice("[validmob] carefully steps around [target]."), span_notice("You carefully steps around [target]."))

//smaller person stepping under another person... TO DO, fix and allow special interactions with naga legs to be seen
/mob/living/proc/micro_step_under(mob/living/target)
	if(ishuman(src))
		var/mob/living/carbon/human/validmob = src
		if(validmob?.dna?.features["taur"] == "Naga" || validmob?.dna?.features["taur"] == "Tentacle")
			visible_message(span_notice("[validmob] bounds over [validmob]'s tail."), span_notice("You jump over [target]'s thick tail."))
		else
			visible_message(span_notice("[validmob] runs between [validmob]'s legs."), span_notice("You run between [target]'s legs."))

//Proc for scaling stamina damage on size difference
/mob/living/carbon/proc/sizediffStamLoss(mob/living/carbon/target)
	var/S = COMPARE_SIZES(src, target) * 25 //macro divided by micro, times 25
	target.Knockdown(S) //final result in stamina knockdown

//Proc for scaling stuns on size difference (for grab intent)
/mob/living/carbon/proc/sizediffStun(mob/living/carbon/target)
	var/T = COMPARE_SIZES(src, target) * 2 //Macro divided by micro, times 2
	target.Stun(T)

//Proc for scaling brute damage on size difference
/mob/living/carbon/proc/sizediffBruteloss(mob/living/carbon/target)
	var/B = COMPARE_SIZES(src, target) * 3 //macro divided by micro, times 3
	target.adjustBruteLoss(B) //final result in brute loss

//Proc for instantly grabbing valid size difference. Code optimizations soon(TM)
/*
/mob/living/proc/sizeinteractioncheck(mob/living/target)
	if(abs(get_effective_size()/target.get_effective_size())>=2.0 && get_effective_size()>target.get_effective_size())
		return FALSE
	else
		return TRUE
*/
//Clothes coming off at different sizes, and health/speed/stam changes as well
