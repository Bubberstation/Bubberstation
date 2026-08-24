/datum/component/bayonet_attachable/no_overlay/on_update_overlays(obj/item/source, list/overlays)
	return

/datum/component/seclite_attachable/compact_shotgun/on_update_overlays(obj/item/source, list/overlays)
	if(!light_overlay || !light_overlay_icon || !light)
		return

	overlays += mutable_appearance(light_overlay_icon, "[light_overlay]_[light.light_on ? "on" : "off"]")

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable/compact_shotgun, \
		light_overlay_icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi', \
		light_overlay = "cshotgunc_light")

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable/no_overlay)

/obj/item/gun/ballistic/shotgun/automatic/combat/compact
	var/compact_bolt_animating = FALSE

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/update_overlays()
	. = ..()
	var/datum/component/bayonet_attachable/bayonet_component = GetComponent(/datum/component/bayonet_attachable)
	var/has_bayonet = bayonet_component?.bayonet ? TRUE : FALSE
	if(has_bayonet)
		. += "cshotgunc_bayonet"
	. += has_bayonet ? "cshotgunc_laser_bayonet" : "cshotgunc_laser"

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/shoot_live_shot(mob/living/user)
	. = ..()
	animate_compact_bolt()

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/proc/animate_compact_bolt()
	compact_bolt_animating = TRUE
	update_appearance(UPDATE_OVERLAYS)
	var/icon/bolt_icon = icon(src.icon, "cshotgunc_bolt_animated", SOUTH, 1)
	var/atom/movable/flick_visual/bolt = flick_overlay_view(mutable_appearance(bolt_icon, "", layer + 0.1), 1)
	if(bolt)
		animate(bolt, icon = icon(src.icon, "cshotgunc_bolt_animated", SOUTH, 2), time = 0.2)
		for(var/frame in 3 to 6)
			animate(icon = icon(src.icon, "cshotgunc_bolt_animated", SOUTH, frame), time = 0.2)
	addtimer(CALLBACK(src, PROC_REF(reset_compact_bolt_animation)), 1)

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/proc/reset_compact_bolt_animation()
	compact_bolt_animating = FALSE
	update_appearance(UPDATE_OVERLAYS)
/obj/item/gun/ballistic/shotgun/bulldog/beanbag
	name = "\improper Beandog Shotgun"
	desc = "A 2-round burst fire, mag-fed shotgun for target suppression in narrow corridors, \
		nicknamed 'Beandog' by internal security. Compatible only with specialized 8-round beanbag slug drum magazines. \
		Can have a secondary magazine attached to quickly reload."
	accepted_magazine_type = /obj/item/ammo_box/magazine/beandog
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "beandog"
	burst_size = 2
	burst_delay = 2
	pin = /obj/item/firing_pin
