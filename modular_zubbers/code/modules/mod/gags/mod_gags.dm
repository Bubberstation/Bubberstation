/**
 * MODsuit GAGS
 *
 * Some MODsuit skins have greyscale layers, so players can recolor them with the paint kit.
 * Each skin gets one /datum/mod_gags_skin (see mod_gags_skins.dm). That datum maps every icon file
 * the suit draws from (obj, worn, digi, vox, module overlays) to a GAGS config made from that file.
 *
 * At the stock colors, every config rebuilds the original sprites pixel for pixel.
 * Skins without an entry keep working the old way.
 */

/// Lookup of skin name -> /datum/mod_gags_skin
GLOBAL_LIST_INIT(mod_gags_skins, init_mod_gags_skins())

/proc/init_mod_gags_skins()
	var/list/skins = list()
	for(var/datum/mod_gags_skin/skin_type as anything in subtypesof(/datum/mod_gags_skin))
		var/datum/mod_gags_skin/entry = new skin_type()
		skins[entry.skin] = entry
	return skins

/datum/mod_gags_skin
	/// The skin name, the same as the key in /datum/mod_theme/var/variants
	var/skin
	/// Colors that rebuild the original sprites exactly
	var/stock_colors
	/// Colors a new suit with this skin starts with
	var/default_colors
	/// Names shown next to each color in the paint kit menu
	var/list/color_labels
	/// Config used by the paint kit menu. It has every color channel in it.
	var/menu_config
	/// Original icon file path -> GAGS config made from it
	var/list/file_configs
	/// Module overlay states that have greyscale layers for this skin
	var/list/module_states

// MOD channels are not in the order species fallback sprites (Teshari) expect, so those sample the painted sprite instead.
/obj/item/mod/control
	sample_worn_colors_for_fallback = TRUE

/obj/item/clothing/suit/mod
	sample_worn_colors_for_fallback = TRUE

/obj/item/clothing/head/mod
	sample_worn_colors_for_fallback = TRUE

/obj/item/clothing/gloves/mod
	sample_worn_colors_for_fallback = TRUE

/obj/item/clothing/shoes/mod
	sample_worn_colors_for_fallback = TRUE

/// Returns the GAGS config made from this icon file, or null if this skin has none for it
/datum/mod_gags_skin/proc/config_for(icon_file)
	if(isnull(icon_file))
		return null
	return file_configs["[icon_file]"]

/// The colors a fresh suit with this skin starts with. Themes can override this.
/datum/mod_theme/proc/get_gags_default_colors(datum/mod_gags_skin/entry)
	return entry.default_colors

/// Applies or removes the GAGS layers on one part, after set_skin() has set its icon files
/obj/item/proc/apply_mod_gags(datum/mod_gags_skin/entry, colors)
	if(!entry || !colors)
		clear_mod_gags()
		return
	greyscale_config = entry.config_for(icon)
	greyscale_config_worn = entry.config_for(worn_icon)
	greyscale_config_worn_digi = entry.config_for(initial(worn_icon_digi))
	greyscale_config_worn_muzzled = entry.config_for(initial(worn_icon_muzzled))
	greyscale_config_worn_vox = entry.config_for(initial(worn_icon_vox))
	greyscale_config_worn_better_vox = entry.config_for(initial(worn_icon_better_vox))
	set_greyscale(colors)

/// Puts a part back on its plain icon files
/obj/item/proc/clear_mod_gags()
	if(isnull(greyscale_colors))
		return
	greyscale_config = null
	greyscale_config_worn = null
	greyscale_config_worn_digi = null
	greyscale_config_worn_muzzled = null
	greyscale_config_worn_vox = null
	greyscale_config_worn_better_vox = null
	greyscale_colors = null
	worn_icon_digi = initial(worn_icon_digi)
	worn_icon_muzzled = initial(worn_icon_muzzled)
	worn_icon_vox = initial(worn_icon_vox)
	worn_icon_better_vox = initial(worn_icon_better_vox)

/// The GAGS entry for this suit's current skin, if it has one
/obj/item/mod/control/proc/get_gags_skin()
	return GLOB.mod_gags_skins[skin]

/// The plain icon file for this suit's skin. After painting, icon points at a generated icon instead.
/obj/item/mod/control/proc/get_source_icon()
	var/list/used_skin = theme ? theme.variants[skin] : null
	return LAZYACCESS(used_skin, MOD_ICON_OVERRIDE) || 'icons/obj/clothing/modsuit/mod_clothing.dmi'

/// Recolors every part of the suit. Colors is a GAGS color string with one color per channel.
/obj/item/mod/control/proc/set_gags_colors(colors)
	if(!get_gags_skin())
		return FALSE
	// set_skin() already gave every part its configs. Only the colors change here.
	// Do not look the configs up again: after the first paint, icon and worn_icon point at generated icons, not the original files.
	for(var/obj/item/part as anything in get_parts(all = TRUE))
		part.set_greyscale(colors)
	wearer?.regenerate_icons()
	return TRUE

/**
 * Module overlays (like the syndicate faceplate) are drawn from their own icon files.
 * If this suit has greyscale layers for that file and state, use the recolored icon instead.
 */
/obj/item/mod/control/proc/get_gags_module_icon(icon_file, icon_state)
	var/datum/mod_gags_skin/entry = get_gags_skin()
	if(!entry || !greyscale_colors || !(icon_state in entry.module_states))
		return icon_file
	var/config = entry.config_for(icon_file)
	if(!config)
		return icon_file
	return SSgreyscale.GetColoredIconByType(config, greyscale_colors)

/obj/item/mod/control
	/// The paint kit color menu open for this suit, if any
	var/datum/greyscale_modify_menu/gags_menu

/obj/item/mod/control/Destroy()
	close_gags_menu()
	return ..()

/// Closes the paint kit color menu, for example when the skin changes under it
/obj/item/mod/control/proc/close_gags_menu()
	if(isnull(gags_menu))
		return
	var/datum/greyscale_modify_menu/menu = gags_menu
	gags_menu = null
	SStgui.close_uis(menu)
	if(!QDELETED(menu))
		qdel(menu)

/obj/item/mod/control/proc/on_gags_menu_deleted(datum/source)
	SIGNAL_HANDLER
	if(gags_menu == source)
		gags_menu = null

/// Opens the GAGS color menu for a suit that supports it
/obj/item/mod/paint/proc/open_gags_menu(obj/item/mod/control/mod, mob/user)
	var/datum/mod_gags_skin/entry = mod.get_gags_skin()
	mod.close_gags_menu()
	var/datum/greyscale_modify_menu/menu = new(
		mod,
		user.client,
		list("[entry.menu_config]"),
		CALLBACK(src, PROC_REF(apply_gags_menu), mod, user),
		starting_icon_state = "worn [mod.skin]-chestplate-sealed",
		starting_config = entry.menu_config,
		starting_colors = mod.greyscale_colors || entry.default_colors,
	)
	menu.color_labels = entry.color_labels
	mod.gags_menu = menu
	mod.RegisterSignal(menu, COMSIG_QDELETING, TYPE_PROC_REF(/obj/item/mod/control, on_gags_menu_deleted))
	menu.ui_interact(user)

/obj/item/mod/paint/proc/apply_gags_menu(obj/item/mod/control/mod, mob/user, datum/greyscale_modify_menu/menu)
	if(QDELETED(mod) || !check_menu(mod, user))
		return
	if(mod.active || mod.activating)
		mod.balloon_alert(user, "unit active!")
		return
	var/datum/mod_gags_skin/entry = mod.get_gags_skin()
	if(!entry || menu.config?.type != entry.menu_config)
		mod.balloon_alert(user, "skin changed!")
		mod.close_gags_menu()
		return
	if(mod.set_gags_colors(menu.split_colors.Join("")))
		playsound(mod, 'sound/effects/spray.ogg', 25, TRUE, 5)
		mod.balloon_alert(user, "suit painted")
