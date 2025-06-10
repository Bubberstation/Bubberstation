//Security Crafting Recipe

/datum/crafting_recipe/sol_smg_rapidfire_kit
	name = "'Shaytan' SMG Conversion" //edited by Bangle
	result = /obj/item/gun/ballistic/automatic/rom_smg/no_mag
	reqs = list(
		/obj/item/gun/ballistic/automatic/sol_smg = 1,
		/obj/item/weaponcrafting/gunkit/sol_smg_rapidfire_kit = 1,
	)
	steps = list(
		"Remove the magazine",
		"Leave the bolt open"
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/sol_smg_rapidfire_kit/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/ballistic/automatic/sol_smg/the_piece = collected_requirements[/obj/item/gun/ballistic/automatic/sol_smg][1]
	if(the_piece.bolt_locked)
		return FALSE
	if(the_piece.magazine)
		return FALSE
	return ..()

//Generic Gun Resource here
