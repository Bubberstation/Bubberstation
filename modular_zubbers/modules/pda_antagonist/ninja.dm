/datum/dynamic_ruleset/midround/from_living/ninja
	name = "Crew Ninja"
	offer_name = "Spider Clan Recruit"
	midround_ruleset_style = MIDROUND_RULESET_STYLE_LIGHT
	antag_datum = /datum/antagonist/ninja/crew
	antag_flag = ROLE_NINJA
	antag_flag_override = ROLE_NINJA
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
		ROLE_POSITRONIC_BRAIN,
	)
	required_candidates = 1
	weight = 35
	cost = 5
	requirements = list(3,3,3,3,3,3,3,3,3,3)
	repeatable = TRUE

/datum/dynamic_ruleset/midround/from_living/ninja/trim_candidates()
	..()
	candidates = living_players
	for(var/mob/living/player in candidates)
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			candidates -= player
		else if(is_centcom_level(player.z))
			candidates -= player // We don't autotator people in CentCom
		else if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			candidates -= player // We don't autotator people with roles already

/datum/dynamic_ruleset/midround/from_living/ninja/follow_up_on_job_offers(list/tracked_messengers, mob/living/M)
	for(var/datum/computer_file/program/messenger/i in tracked_messengers)
		if(i.recruiter_call == "ACCEPT")
			assigned += M
			candidates -= M
			var/datum/antagonist/ninja/crew/crew = new
			M.mind.add_antag_datum(crew)
			message_admins("[ADMIN_LOOKUPFLW(M)] was selected by the [name] ruleset and has been made into a midround ninja.")
			log_dynamic("[key_name(M)] was selected by the [name] ruleset and has been made into a midround ninja.")
			. = TRUE

/datum/antagonist/ninja/crew/

/datum/antagonist/ninja/crew/equip_space_ninja(mob/living/carbon/human/ninja = owner.current)
	var/obj/item/beacon = new /obj/item/summon_beacon/ninja
	var/success = ninja.put_in_hands(beacon)
	to_chat(ninja, span_notice("A summoning beacon appears [success ? "in you hands" : "on the floor before you!"]"))
	return TRUE

/obj/item/storage/box/ninja/PopulateContents()
	new/obj/item/clothing/under/syndicate/ninja(src)
	new/obj/item/clothing/glasses/night(src)
	new/obj/item/clothing/mask/gas/ninja(src)
	new/obj/item/radio/headset(src)
	new/obj/item/clothing/shoes/jackboots(src)
	new/obj/item/grenade/c4/ninja(src)
	new/obj/item/energy_katana(src)
	new/obj/item/mod/control/pre_equipped/ninja(src)

/obj/item/summon_beacon/ninja
	selectable_atoms = list(/obj/item/storage/box/ninja)
