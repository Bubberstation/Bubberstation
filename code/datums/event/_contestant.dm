/**
 * The contestant represents one player in an arena or event.
 */
/datum/contestant
	var/name
	var/ckey
	var/rounds_participated = 0
	var/datum/event_team/current_team
	var/flagged_for_elimination = FALSE
	var/eliminated = FALSE
	var/flagged_on_death = FALSE
	var/frozen = FALSE
	var/godmode = FALSE
	var/datum/atom_hud/antag/our_team_hud

/datum/contestant/New(new_ckey)
	ckey = new_ckey
	name = ckey

	if(!get_mob_by_ckey(ckey))
		return

/datum/contestant/Destroy(force, ...)
	if(current_team)
		current_team.remove_member(src)
	..()

/datum/contestant/proc/dump_info()
	if(!ckey)
		return
	return "CONTESTANT LINE| Ckey: [ckey] | Eliminated: [eliminated] | Flagged for Elimination: [flagged_for_elimination] | Rounds Participated: [rounds_participated] | Team: [current_team]"

/datum/contestant/proc/get_mob()
	if(!ckey)
		return
	return get_mob_by_ckey(ckey)

/datum/contestant/proc/set_flag_on_death(new_mode)
	if(flagged_on_death == new_mode)
		return

	flagged_on_death = new_mode
	var/mob/living/our_boy = get_mob()
	if(!istype(our_boy))
		return

	if(flagged_on_death)
		RegisterSignal(our_boy, COMSIG_LIVING_DEATH, .proc/on_flagged_death)
	else
		UnregisterSignal(our_boy, COMSIG_LIVING_DEATH)

/datum/contestant/proc/set_frozen(mob/user, new_mode)
	if(frozen == new_mode)
		return

	frozen = new_mode
	if(user)
		message_admins("[key_name_admin(user)] has [new_mode ? 'FROZEN' : 'UNFROZEN'] [src]!")
		log_game("[key_name_admin(user)] has [new_mode ? 'FROZEN' : 'UNFROZEN'] [src]!")

	var/mob/living/our_boy = get_mob()
	if(!istype(our_boy))
		return

	if(frozen)
		ADD_TRAIT(our_boy, TRAIT_IMMOBILIZED, TRAIT_EVENT)
	else
		REMOVE_TRAIT(our_boy, TRAIT_IMMOBILIZED, TRAIT_EVENT)

/datum/contestant/proc/set_godmode(mob/user, new_mode)
	if(godmode == new_mode)
		return

	godmode = new_mode

	if(user)
		message_admins("[key_name_admin(user)] has [new_mode ? 'GODMODED' : 'UNGODMODED'] [src]!")
		log_game("[key_name_admin(user)] has [new_mode ? 'GODMODED' : 'UNGODMODED'] [src]!")

	var/mob/living/our_boy = get_mob()
	if(!istype(our_boy))
		return

	if(godmode)
		ADD_TRAIT(our_boy, TRAIT_GODMODE, TRAIT_EVENT)
	else
		REMOVE_TRAIT(our_boy, TRAIT_GODMODE, TRAIT_EVENT)

/datum/contestant/proc/spawn_this_contestant(obj/machinery/arena_spawn/spawnpoint)
	if(!istype(spawnpoint))
		CRASH("[src] cannot be spawned, no spawnpoint provided!")

	if(LAZYFIND(GLOB.global_roster.live_contestants, src))
		message_admins("[src] is already spawned??")

	var/mob/oldbody = get_mob()
	var/mob/living/carbon/human/M = new/mob/living/carbon/human(get_turf(spawnpoint))

	if(oldbody?.client && istype(oldbody.client.prefs))
		oldbody.client.prefs.CopyTo(M)

	if(!(M.dna?.species in list(/datum/species/human, /datum/species/moth, /datum/species/lizard, /datum/species/human/felinid)))
		M.set_species(/datum/species/human)

	M.equipOutfit(/datum/outfit/job/assistant)
	ADD_TRAIT(M, TRAIT_BYPASS_MEASURES, "arena_member")

	if(M.ears)
		var/obj/item/radio/R = M.ears
		switch(spawnpoint.color)
			if("red")
				R.set_frequency(FREQ_CTF_RED)
			if("green")
				R.set_frequency(FREQ_CTF_GREEN)
			if("blue")
				R.set_frequency(FREQ_CTF_BLUE)

	M.key = ckey
	M.forceMove(get_turf(spawnpoint))
	LAZYADD(GLOB.global_roster.live_contestants, src)
	on_spawn()
	return TRUE

/datum/contestant/proc/on_spawn()
	var/mob/living/our_boy = get_mob()
	if(!istype(our_boy))
		return

	if(frozen)
		ADD_TRAIT(our_boy, TRAIT_IMMOBILIZED, TRAIT_EVENT)
	if(godmode)
		ADD_TRAIT(our_boy, TRAIT_GODMODE, TRAIT_EVENT)

	if(!current_team || current_team.battle_royale)
		return

	if(!our_boy.mind)
		our_boy.mind_initialize()

	update_antag_hud()

/datum/contestant/proc/update_antag_hud()
	var/datum/roster/the_roster = GLOB.global_roster
	var/team_slot = the_roster.get_team_slot(current_team)
	var/mob/living/our_boy = get_mob()
	if(!istype(our_boy))
		return

	if(!team_slot)
		our_team_hud?.remove_from_hud(our_boy)
		return

	var/datum/atom_hud/antag/new_team_hud = the_roster.get_team_antag_hud(current_team)
	if(our_team_hud && our_team_hud != new_team_hud)
		our_team_hud.leave_hud(our_boy)
	our_team_hud = new_team_hud
	if(!our_team_hud)
		return
	our_team_hud.join_hud(our_boy)
	set_antag_hud(our_boy,"arena",the_roster.team_hud_index[team_slot])

/datum/contestant/proc/despawn()
	LAZYREMOVE(GLOB.global_roster.live_contestants, src)

/datum/contestant/proc/on_flagged_death(datum/source)
	SIGNAL_HANDLER
	flagged_for_elimination = TRUE
	set_flag_on_death(FALSE)
