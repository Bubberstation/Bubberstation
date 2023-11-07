/obj/item/mod/module/dna_lock
	var/obj/item/implant/explosive/macro/macro

/obj/item/implant/explosive/proc/modsuit_explosion()

	playsound(loc, 'sound/items/timer.ogg', 30, FALSE)
	if(!panic_beep_sound)
		sleep(delay * 0.25)
	//total of 8 bomb beeps, and we've already beeped once
	var/bomb_beeps_until_boom = 8
	if(!panic_beep_sound)
		while(bomb_beeps_until_boom > 0)
			//for extra spice
			var/beep_volume = 35
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.25)
			bomb_beeps_until_boom--
			beep_volume += 5
		explode()
	else
		addtimer(CALLBACK(src, PROC_REF(explode)), delay)
		while(delay > 1) //so we dont accidentally enter an infinite sleep
			var/beep_volume = 35
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.2)
			delay -= delay * 0.2
			beep_volume += 5

/obj/item/mod/module/dna_lock/proc/explode(mob/user, mob/owner)
	if(!dna_check(user))
		macro = new/obj/item/implant/explosive/macro(src)
		macro.modsuit_explosion()
		owner.spasm_animation(600)
	else
		to_chat(user, "You feel safe knowing your modsuit did not blow up in your face.")

/obj/item/mod/control/pre_equipped/contractor/doStrip(mob/living/carbon/stripper, mob/owner)
	if(!istype(stripper, /mob/living/carbon))
		return
	var/obj/item/mod/module/dna_lock/dna_lock = locate(/obj/item/mod/module/dna_lock) in modules
	var/alert = tgui_alert(stripper,
		"As you go to pull the modsuit off of [owner], you spot a what appears to be a failsafe. \n If you pull any further, it looks like a fuse for a bomb will be pulled. Continue???",
		"Are you REALLY SURE?",
		list("Yes","No"), 10 SECONDS, TRUE)


	if(alert == "Yes")
		ASYNC
			if(dna_lock.dna)
				dna_lock.explode(user = stripper, owner = owner)
		. = ..()

/obj/item/mod/control/pre_equipped/ninja/doStrip(mob/living/carbon/stripper, mob/owner)
	if(!istype(stripper, /mob/living/carbon))
		return
	var/obj/item/mod/module/dna_lock/reinforced/dna_lock = locate(/obj/item/mod/module/dna_lock/reinforced) in modules
	var/alert = tgui_alert(stripper,
		"As you go to pull the modsuit off of [owner], you spot a what appears to be a failsafe. \n If you pull any further, it looks like a fuse for a bomb will be pulled. Continue???",
		"Are you REALLY SURE?",
		list("Yes","No"), 10 SECONDS, TRUE)


	if(alert == "Yes")
		ASYNC
			if(dna_lock.dna)
				dna_lock.explode(user = stripper, owner = owner)
		. = ..()
