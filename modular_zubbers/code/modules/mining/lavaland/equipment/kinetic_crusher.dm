/obj/item/crusher_trophy/vortex_talisman
	icon = 'modular_zubbers/icons/obj/artefacts.dmi'
	icon_state = "vortex_talisman"

/obj/item/crusher_trophy/watcher_eye
	name = "watcher eye"
	desc = "An eye ripped out from some unfortunate watcher's eyesocket. Suitable as a trophy for a kinetic crusher."
	icon = 'modular_zubbers/icons/obj/artefacts.dmi'
	icon_state = "watcher_eye"
	denied_type = /obj/item/crusher_trophy/watcher_eye
	var/used_color = "#ff7777"

/obj/item/crusher_trophy/watcher_eye/effect_desc()
	return "<font color='[used_color]'>very pretty colors to imbue the destabilizer shots</font>"

/obj/item/crusher_trophy/watcher_eye/attack_self(mob/user, modifiers)
	var/chosen_color = input(user, "Pick a new color", "[src]", used_color) as color|null
	if(chosen_color)
		used_color = chosen_color
		to_chat(user, span_notice("You recolor [src]."))
		update_appearance()

/obj/item/crusher_trophy/watcher_eye/update_overlays()
	. = ..()
	var/mutable_appearance/overlay = mutable_appearance('modular_zubbers/icons/obj/artefacts.dmi', "watcher_eye_iris")
	overlay.color = used_color
	. += overlay

/obj/item/crusher_trophy/watcher_eye/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	marker.icon = 'modular_zubbers/icons/obj/weapons/guns/projectiles.dmi'
	marker.icon_state = "pulse1_g"
	marker.color = used_color
