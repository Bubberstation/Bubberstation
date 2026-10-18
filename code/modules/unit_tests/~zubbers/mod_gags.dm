/// Checks every MODsuit skin with GAGS layers.
/// The configs must cover every color channel and every state of the skin, and the stock colors
/// must rebuild the original sprites pixel for pixel. Every configured state is compared in
/// every cardinal direction, and the animated backpack states in every frame.
/datum/unit_test/mod_gags

/datum/unit_test/mod_gags/Run()
	TEST_ASSERT(length(GLOB.mod_gags_skins), "No MODsuit GAGS skins are registered.")
	for(var/skin_name in GLOB.mod_gags_skins)
		var/datum/mod_gags_skin/entry = GLOB.mod_gags_skins[skin_name]
		var/channel_count = length(splittext(entry.stock_colors, "#")) - 1
		TEST_ASSERT_EQUAL(length(splittext(entry.default_colors, "#")) - 1, channel_count, "[skin_name]: default_colors and stock_colors have a different number of colors.")
		TEST_ASSERT_EQUAL(length(entry.color_labels), channel_count, "[skin_name]: color_labels does not name every channel.")

		var/datum/greyscale_config/menu_config = SSgreyscale.configurations["[entry.menu_config]"]
		TEST_ASSERT_NOTNULL(menu_config, "[skin_name]: menu config [entry.menu_config] is not loaded.")
		TEST_ASSERT_EQUAL(menu_config.expected_colors, channel_count, "[skin_name]: the paint kit menu config does not use every channel.")

		for(var/file_path in entry.file_configs)
			var/config_type = entry.file_configs[file_path]
			var/datum/greyscale_config/config = SSgreyscale.configurations["[config_type]"]
			TEST_ASSERT_NOTNULL(config, "[skin_name]: config [config_type] is not loaded.")
			TEST_ASSERT_EQUAL(config.expected_colors, channel_count, "[config.DebugName()] does not use every channel, so GAGS previews would crash.")

			var/list/original_states = icon_states(file_path)
			for(var/state in config.icon_states)
				if(state == "gags_channels")
					continue
				TEST_ASSERT(state in original_states, "[config.DebugName()] has state '[state]' that is not in [file_path].")
			for(var/state in original_states)
				if(!is_skin_state(state, skin_name))
					continue
				TEST_ASSERT(config.icon_states[state], "[config.DebugName()] is missing state '[state]' from [file_path], so it would not be painted.")

			var/icon/generated = icon(SSgreyscale.GetColoredIconByType(config_type, entry.stock_colors))
			for(var/state in config.icon_states)
				if(state == "gags_channels")
					continue
				var/frame_count = findtext(state, "control-sealed") ? 4 : 1
				for(var/direction in GLOB.cardinals)
					for(var/frame in 1 to frame_count)
						compare_icons(icon(file_path, state, direction, frame), icon(generated, state, direction, frame), "[config.DebugName()] '[state]' [dir2text(direction)] frame [frame]")

/// TRUE if this icon state belongs to the skin: "skin", "skin-part..." or a module faceplate like "module_armorbooster_on-skin"
/datum/unit_test/mod_gags/proc/is_skin_state(state, skin_name)
	if(state == skin_name || findtext(state, "[skin_name]-") == 1)
		return TRUE
	return findtext(state, "module_armorbooster_") == 1 && (findtext(state, "-[skin_name]") == length(state) - length(skin_name) || findtext(state, "-[skin_name]_"))

/datum/unit_test/mod_gags/proc/compare_icons(icon/original, icon/rebuilt, label)
	if(md5(fcopy_rsc(original)) == md5(fcopy_rsc(rebuilt)))
		return
	for(var/x in 1 to original.Width())
		for(var/y in 1 to original.Height())
			var/original_pixel = original.GetPixel(x, y)
			var/rebuilt_pixel = rebuilt.GetPixel(x, y)
			if(original_pixel == rebuilt_pixel)
				continue
			TEST_FAIL("[label] differs from the original sprite at ([x], [y]): expected [original_pixel || "transparent"], got [rebuilt_pixel || "transparent"].")
			return

/// Paints a suit twice. The second paint must still change the sprites.
/// The first paint swaps icon and worn_icon for generated icons, so the configs must not be looked up from them again.
/datum/unit_test/mod_gags_repaint

/datum/unit_test/mod_gags_repaint/Run()
	var/obj/item/mod/control/pre_equipped/standard/mod = allocate(/obj/item/mod/control/pre_equipped/standard)
	var/datum/mod_gags_skin/entry = mod.get_gags_skin()
	TEST_ASSERT_NOTNULL(entry, "The standard skin has no GAGS entry.")
	var/obj/item/chestplate = mod.get_part_from_slot(ITEM_SLOT_OCLOTHING)
	TEST_ASSERT_NOTNULL(chestplate, "The standard suit has no chestplate.")

	var/stock_icon = mod.icon
	var/stock_worn = chestplate.worn_icon
	var/test_colors = mod_gags_test_colors(entry)

	for(var/attempt in 1 to 2)
		TEST_ASSERT(mod.set_gags_colors(test_colors), "set_gags_colors() failed on paint [attempt].")
		TEST_ASSERT_NOTEQUAL(mod.icon, stock_icon, "Paint [attempt] did not change the control unit icon.")
		TEST_ASSERT_NOTEQUAL(chestplate.worn_icon, stock_worn, "Paint [attempt] did not change the chestplate worn icon.")
		mod.set_gags_colors(entry.stock_colors)
		TEST_ASSERT_EQUAL(mod.icon, stock_icon, "Painting back to the stock colors on paint [attempt] did not restore the control unit icon.")
		TEST_ASSERT_EQUAL(chestplate.worn_icon, stock_worn, "Painting back to the stock colors on paint [attempt] did not restore the chestplate worn icon.")

/// A chameleon disguise and the paint both set the control unit's icons. Neither may clobber the other.
/datum/unit_test/mod_gags_chameleon

/datum/unit_test/mod_gags_chameleon/Run()
	var/obj/item/mod/control/pre_equipped/standard/mod = allocate(/obj/item/mod/control/pre_equipped/standard)
	var/datum/mod_gags_skin/entry = mod.get_gags_skin()
	TEST_ASSERT_NOTNULL(entry, "The standard skin has no GAGS entry.")
	mod.complexity_max = INFINITY
	var/obj/item/mod/module/chameleon/chameleon = allocate(/obj/item/mod/module/chameleon)
	TEST_ASSERT(mod.install(chameleon, null, TRUE), "Could not install the chameleon module.")
	var/test_colors = mod_gags_test_colors(entry)
	var/obj/item/disguise
	for(var/disguise_name in chameleon.possible_disguises)
		var/obj/item/disguise_path = chameleon.possible_disguises[disguise_name]
		if(initial(disguise_path.icon))
			disguise = disguise_path
			break
	TEST_ASSERT_NOTNULL(disguise, "The chameleon module has no disguise with an icon.")
	var/disguise_icon = initial(disguise.icon)

	// Paint, disguise, undisguise: the paint must come back
	mod.set_gags_colors(test_colors)
	var/painted_icon = mod.icon
	chameleon.current_disguise = disguise
	chameleon.update_look()
	TEST_ASSERT_EQUAL(mod.icon, disguise_icon, "The disguise did not replace the control unit icon.")
	chameleon.return_look()
	TEST_ASSERT_EQUAL(mod.icon, painted_icon, "Removing the disguise did not restore the painted control unit.")

	// Disguise, paint, undisguise: the paint must not replace the disguise, then show up afterwards
	mod.set_gags_colors(entry.stock_colors)
	chameleon.current_disguise = disguise
	chameleon.update_look()
	mod.set_gags_colors(test_colors)
	TEST_ASSERT_EQUAL(mod.icon, disguise_icon, "Painting while disguised replaced the disguise.")
	chameleon.return_look()
	TEST_ASSERT_EQUAL(mod.icon, painted_icon, "Paint applied while disguised did not show after the disguise was removed.")

/// One color per channel of the skin, all bright magenta
/proc/mod_gags_test_colors(datum/mod_gags_skin/entry)
	. = ""
	for(var/i in 1 to length(splittext(entry.stock_colors, "#")) - 1)
		. += "#ff00ff"
