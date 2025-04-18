/datum/job/assistant/stowaway
	title = "Stowaway"
	description = "Be a stowaway crewmember."
	faction = FACTION_NONE
	supervisors = "Yourself."
	minimal_player_age = 7
	exp_requirements = 2400
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_SPECIAL

	liver_traits = list(TRAIT_MAINTENANCE_METABOLISM)


	job_flags = JOB_NEW_PLAYER_JOINABLE|JOB_REOPEN_ON_ROUNDSTART_LOSS|JOB_ASSIGN_QUIRKS|JOB_CANNOT_OPEN_SLOTS

/datum/job/assistant/stowaway/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	for(var/obj/item/card/id/to_del in spawned.contents)
		spawned.dropItemToGround(to_del, force = TRUE)
		qdel(to_del)
	for(var/obj/item/modular_computer/pda/to_del in spawned.contents)
		spawned.dropItemToGround(to_del, force = TRUE)
		qdel(to_del)

	var/mob/living/carbon/human/human_holder = spawned
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[human_holder.account_id]"]
	account?.Destroy()
	var/turf/T
	if(LAZYLEN(GLOB.blobstart))
		var/list/blobstarts = shuffle(GLOB.blobstart)
		for(var/_T in blobstarts)
			T = _T
			break
	else // no blob starts so look for an alternate
		for(var/i in 1 to 16)
			var/turf/picked_safe = get_safe_random_station_turf_equal_weight()
			T = picked_safe
			break
	spawned.forceMove(T)
	spawned.put_in_hands(new /obj/item/storage/toolbox/mechanical)
