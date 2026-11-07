/datum/crafting_recipe/stingballcan
	name = "Stingball Canister"
	result = /obj/item/ammo_box/stingball
	reqs = list(
		/obj/item/grenade/stingbang = 1,
	)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 1.0 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/improvised_shotgun_shell
	name = "Improvised Shotgun Shell"
	result = /obj/item/ammo_casing/shotgun/junk
	reqs = list(
		/obj/item/stack/sheet/iron = 2,
		/obj/item/stack/cable_coil = 1,
		/obj/item/shard = 1,
		/datum/reagent/fuel = 10,
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 1.2 SECONDS
	category = CAT_WEAPON_AMMO
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/improvised_shell_box
	name = "Improvised Shell Box"
	desc = "Pry the chip out of an empty shotgun shell box so it takes improvised shells."
	result = /obj/item/ammo_box/advanced/s12gauge/junk/empty
	reqs = list(
		/obj/item/ammo_box/advanced/s12gauge = 1,
	)
	blacklist = list(
		/obj/item/ammo_box/advanced/s12gauge/junk,
		/obj/item/ammo_box/advanced/s12gauge/junk/empty,
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	steps = list("Any empty shotgun shell box works, not just slug boxes")
	time = 2 SECONDS
	category = CAT_WEAPON_AMMO
	// the box you started with decides the materials, so there's no fixed value to match
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_COLLECT_REQUIREMENTS | CRAFT_SKIP_MATERIALS_PARITY

// refuse while any box in reach still has shells, so nobody loses a box of buckshot to this
/datum/crafting_recipe/improvised_shell_box/check_requirements(mob/user, list/collected_requirements)
	for(var/obj/item/ammo_box/box as anything in collected_requirements[/obj/item/ammo_box/advanced/s12gauge])
		if(length(box.stored_ammo))
			return FALSE
	return TRUE
