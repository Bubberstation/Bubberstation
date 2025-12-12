/datum/job/assistant/stowaway
	title = "Stowaway"
	description = "Be a stowaway aboard a hazardous research station that is infamous for many reasons."
	faction = FACTION_NONE
	supervisors = "yourself"
	minimal_player_age = 7
	total_positions = 20
	spawn_positions = 20
	exp_requirements = 2400
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_SPECIAL
	config_tag = "STOWAWAY"

	liver_traits = list(TRAIT_MAINTENANCE_METABOLISM)


	job_flags = JOB_NEW_PLAYER_JOINABLE|JOB_REOPEN_ON_ROUNDSTART_LOSS|JOB_ASSIGN_QUIRKS|JOB_CANNOT_OPEN_SLOTS

/datum/job/assistant/stowaway/has_banned_species(datum/preferences/pref)
	//return false cause no species should be banned from this role
	return FALSE

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
	var/turf/T = find_maintenance_spawn(atmos_sensitive = TRUE, require_darkness = FALSE)
	if(!T) // no safe spots... find another method.
		for(var/i in 1 to 16)
			var/turf/picked_safe = get_safe_random_station_turf_equal_weight()
			T = picked_safe
			break
	spawned.forceMove(T)
	spawned.put_in_hands(new /obj/item/storage/toolbox/mechanical)
	spawned.equip_to_slot(new /obj/item/card/cardboard, ITEM_SLOT_ID)

// Fixes for station traits...
/datum/station_trait/wallets/on_job_after_spawn(datum/source, datum/job/job, mob/living/living_mob, mob/M, joined_late)
	if(!(job.job_flags & JOB_EQUIP_RANK))
		return
	. = ..()

/obj/effect/landmark/start/stowaway
	name = "Stowaway"
	icon_state = "Assistant"

// This is purely to satisfy unit tests, stowaway spawn locations are handled in after_spawn()
/datum/area_spawn/stowaway_landmark
	blacklisted_stations = list("Runtime Station", "Minimal Runtime Station", "MultiZ Debug", "Gateway Test")
	amount_to_spawn = 5
	desired_atom = /obj/effect/landmark/start/stowaway
	target_areas = list(/area/station/hallway/secondary/entry, /area/station/terminal/interlink)
