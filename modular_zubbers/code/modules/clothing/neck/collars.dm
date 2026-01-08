/obj/item/clothing/neck/human_petcollar/locked/ringbell
	name = "ringing bell collar"
	desc = "A soft collar that chimes for your little pet!"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/ringbell"
	post_init_icon_state = "ringbell"
	greyscale_config = /datum/greyscale_config/collar/ringbell
	greyscale_config_worn = /datum/greyscale_config/collar/ringbell/worn
	greyscale_colors = "#FF4F66#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/ringbell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/misc/collarbell1.ogg'=1,'modular_zubbers/sound/misc/collarbell2.ogg'=1), 50, 100, 8)

/obj/item/clothing/neck/kink_collar/locked/gps
	name = "tracking collar"
	desc = "A collar that lets you find your pet anywhere with GPS!"
	icon_state = "/obj/item/clothing/neck/kink_collar/locked/gps"
	var/datum/component/gps/gps
	post_init_icon_state = "gps"
	greyscale_config = /datum/greyscale_config/collar/gps
	greyscale_config_worn = /datum/greyscale_config/collar/gps/worn
	greyscale_config_inhand_left = /datum/greyscale_config/collar/gps/lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/collar/gps/righthand
	greyscale_colors = "#8B96B7#505665"
	flags_1 = IS_PLAYER_COLORABLE_1
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/kink_collar/locked/gps/Initialize(mapload)
	. = ..()
	atom_storage.click_alt_open = FALSE
	gps = AddComponent(/datum/component/gps, name)
	register_context()
	update_icon(UPDATE_OVERLAYS)
	RegisterSignal(src, COMSIG_NAME_CHANGED, PROC_REF(on_update_name))
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/neck/kink_collar/locked/gps/proc/on_update_name()
	SIGNAL_HANDLER
	gps.gpstag = name

/obj/item/clothing/neck/kink_collar/locked/gps/attack_self(mob/user)
	. = ..()
	gps.gpstag = tagname

/obj/item/clothing/neck/kink_collar/locked/gps/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to [gps.tracking ? "disable":"enable"] tracking.")

///Calls toggletracking
/obj/item/clothing/neck/kink_collar/locked/gps/click_alt(mob/user)
	if(locked)
		balloon_alert(user, "it's locked!")
		playsound(src, 'sound/items/click.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
	else
		toggletracking(user)
		balloon_alert(user, "tracking [gps.tracking ? "enabled":"disabled"]")
		playsound(src, 'sound/machines/click.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/neck/kink_collar/locked/gps/proc/toggletracking(mob/user)
	gps.tracking = !gps.tracking
	update_icon(UPDATE_OVERLAYS)
	user.update_worn_neck()

/obj/item/clothing/neck/kink_collar/locked/gps/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!locked)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "[gps.tracking ? "Disable":"Enable"] tracking"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/clothing/neck/kink_collar/locked/gps/update_overlays()
	. = ..()
	if(gps.tracking)
		. += mutable_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "light")
		. += emissive_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "light", src, alpha = src.alpha)

/obj/item/clothing/neck/kink_collar/locked/gps/worn_overlays(mutable_appearance/standing, isinhands = FALSE)
	. = ..()
	if(gps.tracking && !isinhands)
		. += mutable_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "collar_mob_tracker_light")
		. += emissive_appearance('modular_zubbers/icons/obj/clothing/GAGS/collar.dmi', "collar_mob_tracker_light", src, alpha = src.alpha)
