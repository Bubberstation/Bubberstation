/// Checks every MODsuit skin with GAGS layers.
/// The configs must cover every color channel, and the stock colors must rebuild the
/// original sprites pixel for pixel. This sweeps the chestplate and the backpack of every
/// skin, in every direction, for the worn and inventory icons.
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

			var/icon/generated = icon(SSgreyscale.GetColoredIconByType(config_type, entry.stock_colors))
			for(var/part in list("chestplate-sealed", "control-sealed"))
				var/state = "[skin_name]-[part]"
				if(!config.icon_states[state])
					continue
				for(var/direction in GLOB.cardinals)
					var/icon/original = icon(file_path, state, direction, 1)
					var/icon/rebuilt = icon(generated, state, direction, 1)
					compare_icons(original, rebuilt, "[config.DebugName()] '[state]' [dir2text(direction)]")

/datum/unit_test/mod_gags/proc/compare_icons(icon/original, icon/rebuilt, label)
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
	var/channel_count = length(splittext(entry.stock_colors, "#")) - 1
	var/test_colors = ""
	for(var/i in 1 to channel_count)
		test_colors += "#ff00ff"

	for(var/attempt in 1 to 2)
		TEST_ASSERT(mod.set_gags_colors(test_colors), "set_gags_colors() failed on paint [attempt].")
		TEST_ASSERT_NOTEQUAL(mod.icon, stock_icon, "Paint [attempt] did not change the control unit icon.")
		TEST_ASSERT_NOTEQUAL(chestplate.worn_icon, stock_worn, "Paint [attempt] did not change the chestplate worn icon.")
		mod.set_gags_colors(entry.stock_colors)
		TEST_ASSERT_EQUAL(mod.icon, stock_icon, "Painting back to the stock colors on paint [attempt] did not restore the control unit icon.")
