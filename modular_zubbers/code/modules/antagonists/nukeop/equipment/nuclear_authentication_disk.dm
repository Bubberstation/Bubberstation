#define UNSECURED_DISK_COMMAND_PAY_PENALTY 0.5
#define GRACE_PERIOD 35 MINUTES

GLOBAL_VAR_INIT(did_sleepy_disk_announcement, FALSE)

/obj/item/disk/nuclear/unsecured_process(last_move)
	//If there is no assigned captain, then don't run the event.
	if(!SSjob || !SSjob.assigned_captain)
		return

	/// How comfy is our disk?
	var/disk_comfort_level = 0

	//Go through and check for items that make disk comfy
	for(var/obj/comfort_item in loc)
		if(istype(comfort_item, /obj/item/bedsheet) || istype(comfort_item, /obj/structure/bed))
			disk_comfort_level++
	var/comfy = disk_comfort_level >= 2

	if(last_move < world.time - GRACE_PERIOD)
		if (comfy)
			if (GLOB.did_sleepy_disk_announcement)
				return
			priority_announce(
				"Attention [GLOB.station_name]. It has come to our attention that your nuclear authentication disk has been stationary for... wait - did you \
				tuck it into bed and... awww. Awwwww. You know what? We'll let it slide just this time. Sleep tight, disky.",
				"Central Command Asset Protection",
				'modular_skyrat/modules/alerts/sound/alerts/alert1.ogg',
				has_important_message = TRUE
			)
			GLOB.did_sleepy_disk_announcement = TRUE
		else
			reprimand_command()

/obj/item/disk/nuclear/proc/reprimand_command()
	priority_announce(
		"Attention [GLOB.station_name]. It has come to our attention that your nuclear authentication disk has been stationary for an egregious period of time. \
		There is no excuse. Your command staff will have their pay docked and employment reviewed. Failure to secure the disk in good time will result \
		in further consequences.",
		"Central Command Asset Protection",
		'modular_skyrat/modules/alerts/sound/alerts/alert1.ogg',
		has_important_message = TRUE
	)

	for (var/datum/bank_account/iter_account as anything in assoc_to_values(SSeconomy.bank_accounts_by_id))
		var/datum/job/our_job = iter_account.account_job
		if (isnull(our_job))
			continue

		if (!(our_job::title in SSjob.chain_of_command))
			continue

		iter_account.payday_modifier *= UNSECURED_DISK_COMMAND_PAY_PENALTY
	// i hate getcomponent but couldnt figure out a better way to reset the time without throwing the disk around (not guaranteed to work)
	var/datum/component/keep_me_secure/our_component = GetComponent(/datum/component/keep_me_secure)
	our_component.last_move = world.time

/obj/item/disk/nuclear/secured_process(last_move)

	//If there is no assigned captain, then don't run the event.
	if(!SSjob || !SSjob.assigned_captain)
		return

	. = ..()

#undef UNSECURED_DISK_COMMAND_PAY_PENALTY
#undef GRACE_PERIOD
