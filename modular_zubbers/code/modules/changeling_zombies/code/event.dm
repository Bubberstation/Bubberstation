/datum/round_event_control/stray_cargo/changeling_zombie
	name = "Stray Changeling Zombie Virus Pod"
	typepath = /datum/round_event/stray_cargo/changeling_zombie
	weight = 0
	max_occurrences = 0
	earliest_start = 60 MINUTES
	description = "A pod containing a highly infectious (and broken) Changeling Zombie Virus reagent."
	admin_setup = list(/datum/event_admin_setup/set_location/stray_cargo)

/datum/round_event/stray_cargo/changeling_zombie
	possible_pack_types = list(/datum/supply_pack/misc/changeling_zombie)

//The virus.
/datum/supply_pack/misc/changeling_zombie
	name = "NT-CZV-1 Vials"
	desc = "Contains a NT-CZV vials. Highly classified."
	special = TRUE //Cannot be ordered via cargo
	contains = list() //We don't put contents in this to do snowflake content in populate_contents
	crate_type = /obj/structure/closet/crate/changeling_zombie

/obj/structure/closet/crate/changeling_zombie/PopulateContents()
	new /obj/item/reagent_containers/cup/glass/changeling_zombie_virus(src)
	var/obj/item/reagent_containers/cup/glass/changeling_zombie_virus/empty/broken_one = new(src)
	broken_one.smash(src.loc,null,FALSE,TRUE)


//The cure.
/obj/item/paper/fluff/shuttles/changeling_zombie_instructions
	default_raw_text = "<h1>NT-CZV-1 Cure Instructions</h1><br>To cure an infected crewmember who has not yet turned, let them have at least 100 units of toxins damage, then purge all those toxins quickly.<br>To cure an already turned crewmember, apply shotgun to head repeatedly."

/obj/structure/closet/crate/medical/changeling_zombie_cure/PopulateContents()
	new /obj/item/paper/fluff/shuttles/changeling_zombie_instructions(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)

/obj/structure/closet/crate/medical/changeling_zombie_cure/populate_contents_immediate() //This has no reason to exist other than to satisfy linters.
	new /obj/item/gun/ballistic/shotgun/lethal(src)