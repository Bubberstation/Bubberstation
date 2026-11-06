/// All 12 gauge shells are required to have an ammo shotbox. A shell with no ammo box will display a notice but not fail since there's a fallback. Bad box_sprite or box_colors values still fail.
/datum/unit_test/shotgun_shell_boxes

/datum/unit_test/shotgun_shell_boxes/Run()
	var/static/regex/valid_colors = regex(@"^#[0-9a-fA-F]{6}(#[0-9a-fA-F]{6}#[0-9a-fA-F]{6})?$")
	var/static/list/valid_sprites = list(SHELL_BOX_SPRITE_N, SHELL_BOX_SPRITE_STRIPE, SHELL_BOX_SPRITE_HAZARD)

	var/list/boxed_shells = list()
	for(var/obj/item/ammo_box/advanced/s12gauge/box_type as anything in typesof(/obj/item/ammo_box/advanced/s12gauge))
		boxed_shells[initial(box_type.ammo_type)] = TRUE

	for(var/obj/item/ammo_casing/shotgun/shell_type as anything in typesof(/obj/item/ammo_casing/shotgun))
		var/sprite = initial(shell_type.box_sprite)
		var/colors = initial(shell_type.box_colors)
		if(!(sprite in valid_sprites))
			TEST_FAIL("[shell_type] has box_sprite \"[sprite]\". Use one of: [jointext(valid_sprites, ", ")].")
			continue
		if(!valid_colors.Find(colors))
			TEST_FAIL("[shell_type] has box_colors \"[colors]\". Use one or three six digit hex colors, like \"#c8c8c8\" or \"#c8c8c8#ffffff#2a2a2a\".")
			continue

		if(boxed_shells[shell_type])
			continue

		var/obj/item/ammo_box/advanced/s12gauge/generic/stand_in = allocate(/obj/item/ammo_box/advanced/s12gauge/generic)
		stand_in.dress_for_shell(shell_type)
		if(!(stand_in.icon_state in icon_states(stand_in.icon)))
			TEST_FAIL("The generic box for [shell_type] came out without its \"[stand_in.icon_state]\" icon state.")
			continue
		TEST_NOTICE(src, "Generated 12 gauge [initial(shell_type.name)] box using color [colors] and sprite [sprite], you should make a custom sprite for this! ([shell_type] has no ammo box.)")
