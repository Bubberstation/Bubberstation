/obj/item/mod/module/dna_lock/reinforced
	var/obj/item/implant/explosive/macro // Not really a macrobomb :P

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
#define PULL_SUIT "Pull it off"
#define IGNORE_SUIT "Don't pull it off"
#define DUMP_CONTENTS "Dump the storage box"
/obj/item/mod/module/dna_lock/reinforced/proc/explode(mob/user, mob/owner)
	if(!dna_check(user))
		macro = new/obj/item/implant/explosive/macro(src)
		macro.modsuit_explosion()
		owner.spasm_animation(600)
	else
		to_chat(user, "You feel safe knowing your modsuit did not blow up in your face.")

/obj/item/mod/control/pre_equipped/contractor/doStrip(mob/living/carbon/stripper, mob/owner)
	if(!istype(stripper, /mob/living/carbon))
		return
	var/obj/item/mod/module/dna_lock/reinforced/dna_lock = locate(/obj/item/mod/module/dna_lock/reinforced) in modules
	var/alert
	if(dna_lock)
		alert = tgui_alert(stripper,
			"As you go to pull the modsuit off of [owner], you spot a what appears to be a failsafe. \n If you pull any further, it looks like a fuse for a bomb will be pulled. Continue???",
			"Are you REALLY SURE?",
			list(PULL_SUIT, IGNORE_SUIT, DUMP_CONTENTS), 10 SECONDS, TRUE)


	if(alert == PULL_SUIT)
		ASYNC
			if(dna_lock.dna)
				dna_lock.explode(user = stripper, owner = owner)
		. = ..()
	if(alert == DUMP_CONTENTS)
		dump_modsuit_toss_contents()

/obj/item/mod/control/pre_equipped/ninja/doStrip(mob/living/carbon/stripper, mob/owner)
	if(!istype(stripper, /mob/living/carbon))
		return
	var/obj/item/mod/module/dna_lock/reinforced/dna_lock = locate(/obj/item/mod/module/dna_lock/reinforced) in modules
	var/alert
	if(dna_lock)
		alert = tgui_alert(stripper,
			"As you go to pull the modsuit off of [owner], you spot a what appears to be a failsafe. \n If you pull any further, it looks like a fuse for a bomb will be pulled. Continue???",
			"Are you REALLY SURE?",
			list(PULL_SUIT, IGNORE_SUIT, DUMP_CONTENTS), 10 SECONDS, TRUE)


	if(alert == PULL_SUIT)
		ASYNC
			if(dna_lock.dna)
				dna_lock.explode(user = stripper, owner = owner)
		. = ..()
	if(alert == DUMP_CONTENTS)
		dump_modsuit_toss_contents()

/obj/item/mod/control
	COOLDOWN_DECLARE(trash_cooldown)
	COOLDOWN_DECLARE(funny_sound_cooldown)

/obj/item/mod/control/proc/dump_modsuit_toss_contents()
	if(QDELETED(src)) //Check if valid.
		return FALSE
	var/turf/T
	var/obj/item/mod/module/storage/storage = locate() in contents
	if(!storage)
		playsound(src, 'sound/effects/quack.ogg')
		return FALSE
	// Code Thanks to BurgerBB
	if(COOLDOWN_FINISHED(src, trash_cooldown))
		COOLDOWN_START(src, trash_cooldown, 0.2 SECONDS*0.5 + rand()*0.2 SECONDS) // x0.5 to x1.5
		if(!T)
			T = get_turf(src)
		var/atom/movable/item = pick(storage.contents)
		if(item)
			var/turf/throw_at = get_ranged_target_turf_direct(src, usr, 7, rand(-60,60))
			if(item.safe_throw_at(throw_at, rand(2,4), rand(1,3), usr, spin = TRUE))
				playsound(T, 'sound/weapons/punchmiss.ogg', 10)

	if(COOLDOWN_FINISHED(src,funny_sound_cooldown))
		COOLDOWN_START(src, funny_sound_cooldown, 0.1 SECONDS*0.5 + rand()*0.1 SECONDS) // x0.5 to x1.5
		if(!T)
			T = get_turf(src)
		playsound(T,'sound/effects/jingle.ogg' , 25)

	return TRUE
