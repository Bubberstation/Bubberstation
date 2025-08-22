//Setup the deathrattle group

GLOBAL_VAR_INIT(security_deathrattle,create_security_deathrattle())

GLOBAL_VAR_INIT(allow_security_deathrattle,TRUE)

/proc/create_security_deathrattle()
	return new /datum/deathrattle_group("nanotrasen security group")

//Create the implant.
/obj/item/implant/deathrattle/security
	name = "deathrattle implant (security)"

/obj/item/implant/deathrattle/security/Initialize(mapload)
	. = ..()
	var/datum/deathrattle_group/metaclique = GLOB.security_deathrattle
	if(metaclique) //Safety
		metaclique.register(src)

//Create an implant case with it.
/obj/item/implantcase/deathrattle/security
	name = "implant case - 'Deathrattle (Security)'"
	imp_type = /obj/item/implant/deathrattle/security

//Create an implanter with it.
/obj/item/implanter/security_deathrattle
	name = "implanter (security deathrattle)"
	imp_type = /obj/item/implant/deathrattle/security

//Create a lockbox containing them.
/obj/item/storage/lockbox/security_deathrattle
	name = "lockbox of security deathrattle implants"
	req_access = list(ACCESS_SECURITY)

/obj/item/storage/lockbox/security_deathrattle/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/implantcase/deathrattle/security(src)
	new /obj/item/implanter/security_deathrattle(src)

//Add supply pack to cargo.

/datum/supply_pack/security/deathrattle_implants
	name = "Security Deathrattle Implants"
	desc = "Demoralize your fellow officers by telling them the exact moment you die! Comes with a lockbox of 4 security deathrattle implants."
	cost = CARGO_CRATE_VALUE * 4
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/lockbox/security_deathrattle = 1)
	crate_name = "deathrattle implant crate"
	special = TRUE
	special_enabled = FALSE

//Disable deathrattles if security already has them
/datum/station_trait/deathrattle_department/security/New(...)
	. = ..()
	GLOB.allow_security_deathrattle = FALSE
	var/datum/supply_pack/security/deathrattle_implants/implant_order = SSshuttle.supply_packs[/datum/supply_pack/security/deathrattle_implants]
	implant_order.special_enabled = FALSE

/datum/station_trait/deathrattle_all/New(...)
	. = ..()
	GLOB.allow_security_deathrattle = FALSE
	var/datum/supply_pack/security/deathrattle_implants/implant_order = SSshuttle.supply_packs[/datum/supply_pack/security/deathrattle_implants]
	implant_order.special_enabled = FALSE


// Add the event to trigger it.

/datum/round_event_control/security_deathrattle_implants
	name = "Security Deathrattle Implants"
	typepath = /datum/round_event/security_deathrattle_implants
	weight = 20
	category = EVENT_CATEGORY_BUREAUCRATIC
	description = "Allows security to purchase deathrattle implants."
	max_occurrences = 1

/datum/round_event_control/security_deathrattle_implants/can_spawn_event(players_amt, allow_magic = FALSE)

	. = ..()

	if(!.)
		return

	return GLOB.allow_security_deathrattle && (SSsecurity_level.get_current_level_as_number() >= SEC_LEVEL_AMBER)

/datum/round_event/security_deathrattle_implants
	start_when = 1
	announce_when = 2
	fakeable = FALSE

/datum/round_event/security_deathrattle_implants/start()
	var/datum/supply_pack/security/deathrattle_implants/implant_order = SSshuttle.supply_packs[/datum/supply_pack/security/deathrattle_implants]
	implant_order.special_enabled = TRUE

/datum/round_event/security_deathrattle_implants/announce(fake)

	var/reason = "SHITCODE"
	switch(rand(1,3))
		if(1)
			var/adjectives = pick_list(ION_FILE, "ionadjectives")
			var/threats = pick_list(ION_FILE, "ionthreats")
			reason = "[adjectives] [threats]"
		if(2)
			var/abstract = pick_list(ION_FILE, "ionabstract")
			reason = "the spirit of [abstract]"
		if(3)
			var/allergy = pick_list(ION_FILE, "ionallergy")
			var/food = prob(80) ? pick_list(ION_FILE, "ionfood") : pick_list(ION_FILE, "iondrinks")
			reason = "the presence of [allergy] in the station's [food]"

	priority_announce("Due to \"[LOWER_TEXT(reason)]\", Security Deathrattle Implants are available to be purchased via the Cargo Ordering System.", "Nanotrasen Safety Division")
