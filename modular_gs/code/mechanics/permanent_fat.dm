/mob/living/carbon
	var/savekey
	var/ckeyslot

/mob/living/carbon/proc/perma_fat_save()
	var/key = savekey
	if(!key || !client)
		return FALSE
	var/filename = "preferences.sav"
	var/path = "data/player_saves/[key[1]]/[key]/[filename]"

	var/savefile/S = new /savefile(path)
	if(!path)
		return FALSE

	if(ckeyslot)
		var/slot = ckeyslot
		S.cd = "/character[slot]"

		var/persi
		S["weight_gain_persistent"] >> persi
		if(persi)
			WRITE_FILE(S["starting_weight"]			, fatness_real)
			client.prefs.starting_weight = fatness_real
			to_chat(src, span_notice("Your starting weight has been updated!"))
		var/perma
		S["weight_gain_permanent"] >> perma
		if(S["weight_gain_permanent"])
			WRITE_FILE(S["permanent_fat"]			, fatness_perma)
			client.prefs.permanent_fat = fatness_perma
			to_chat(src, span_notice("Your permanent fat has been updated!"))

/mob/living/carbon/proc/queue_perma_save()
	to_chat(src,"Your permanence options are being saved, please wait." )
	addtimer(CALLBACK(src, PROC_REF(perma_fat_save), TRUE, silent), 3 SECONDS, TIMER_STOPPABLE)

/datum/controller/subsystem/ticker/declare_completion()
	. = ..()
	for(var/mob/m in GLOB.player_list)
		if(iscarbon(m))
			var/mob/living/carbon/C = m
			if(C)
				C.queue_perma_save()

/obj/machinery/cryopod/despawn_occupant()
	var/mob/living/mob_occupant = occupant
	if(iscarbon(mob_occupant))
		var/mob/living/carbon/C = mob_occupant
		if(C)
			C.perma_fat_save(C)
	. = ..()

/*
/datum/preferences/proc/perma_fat_save(character)
	if(iscarbon(character))
		var/mob/living/carbon/C = character
		if(!C.client.prefs.weight_gain_permanent && !C.client.prefs.weight_gain_persistent)
			return FALSE
		if(!path)
			return FALSE
			if(world.time < savecharcooldown)
				if(istype(parent))
					to_chat(parent, "<span class='warning'>You're attempting to save your character a little too fast. Wait half a second, then try again.</span>")

				return FALSE

		savecharcooldown = world.time + PREF_SAVELOAD_COOLDOWN
		var/savefile/S = new /savefile(path)
		if(!S)
			return FALSE
		S.cd = "/character[default_slot]"

		if(C.client.prefs.weight_gain_persistent)
			WRITE_FILE(S["starting_weight"]			, C.fatness_real)
		if(C.client.prefs.weight_gain_permanent)
			WRITE_FILE(S["permanent_fat"]			, C.fatness_perma)
*/
