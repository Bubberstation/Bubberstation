/obj/item/clothing/neck/human_petcollar/locked/ringbell
	name = "ringing bell collar"
	desc = "A soft collar that chimes for your little pet!"
	icon_state = "ringbell"
	greyscale_config = /datum/greyscale_config/collar/ringbell
	greyscale_config_worn = /datum/greyscale_config/collar/ringbell/worn
	greyscale_colors = "#FF4F66#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/ringbell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/misc/collarbell1.ogg'=1,'modular_zubbers/sound/misc/collarbell2.ogg'=1), 50, 100, 8)


/obj/item/clothing/neck/kink_collar/locked/gps
	name = "tracking collar"
	desc = "A collar that lets you find your pet anywhere!"
	var/datum/component/gps/gps

/obj/item/clothing/neck/kink_collar/locked/gps/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, name)
	gps = GetComponent(/datum/component/gps)

/obj/item/clothing/neck/kink_collar/locked/gps/attack_self(mob/user)
	. = ..()
	gps.gpstag = .

/obj/item/clothing/neck/kink_collar/locked/gps/examine(mob/user)
	. = ..()
	. += span_notice("Alt-right-click to [gps.tracking ? "disable":"enable"] tracking.")

///Calls toggletracking
/obj/item/clothing/neck/kink_collar/locked/gps/click_alt_secondary(mob/user)
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
	// here's where we'd update the icon's tracking light! If we had one!

/obj/item/clothing/neck/kink_collar/locked/gps/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!locked)
		context[SCREENTIP_CONTEXT_ALT_RMB] = "[gps.tracking ? "Disable":"Enable"] tracking"
