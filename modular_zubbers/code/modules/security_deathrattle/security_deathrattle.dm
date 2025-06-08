//Setup the deathrattle group

GLOBAL_VAR_INIT(security_deathrattle,create_security_deathrattle())

GLOBAL_VAR(allow_security_deathrattle,TRUE)

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

//Add to lockers.
/obj/structure/closet/secure_closet/security_medic/PopulateContents()
	. = ..()
	if(allow_security_deathrattle)
		new /obj/item/storage/lockbox/security_deathrattle(src)

/obj/structure/closet/secure_closet/warden/PopulateContents()
	. = ..()
	if(allow_security_deathrattle)
		new /obj/item/storage/lockbox/security_deathrattle(src)

//Add supply pack to cargo.

/datum/supply_pack/security/deathrattle_implants
	name = "Security Deathrattle Implants"
	desc = "Demoralize your fellow officers by telling them the exact moment you die! Comes with a lockbox of 4 security deathrattle implants."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_ARMORY
	contains = list(/obj/item/storage/lockbox/security_deathrattle = 1)
	crate_name = "deathrattle implant crate"
	special_enabled = TRUE
	special = TRUE

//Disable deathrattles if security already has them
/datum/station_trait/deathrattle_department/security/New(..,)
	. = ..()
	GLOB.allow_security_deathrattle = FALSE
	var/datum/supply_pack/security/deathrattle_implants/implant_order = SSshuttle.supply_packs[/datum/supply_pack/security/deathrattle_implants]
	implant_order.special_enabled = FALSE

/datum/station_trait/deathrattle_all/New(..,)
	. = ..()
	GLOB.allow_security_deathrattle = FALSE
	var/datum/supply_pack/security/deathrattle_implants/implant_order = SSshuttle.supply_packs[/datum/supply_pack/security/deathrattle_implants]
	implant_order.special_enabled = FALSE