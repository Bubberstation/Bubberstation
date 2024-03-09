/obj/item/crusher_trophy/vortex_talisman
	icon = 'modular_zubbers/icons/obj/artefacts.dmi'
	icon_state = "vortex_talisman"

//stupid to have both crusher and crusher_comp as params but it helps with reducing core code mods
/obj/item/crusher_trophy/proc/add_to(obj/item/crusher, mob/living/user, datum/component/kinetic_crusher/crusher_comp)
	for(var/obj/item/crusher_trophy/trophy as anything in crusher_comp.stored_trophies)
		if(istype(trophy, denied_type) || istype(src, trophy.denied_type))
			to_chat(user, span_warning("You can't seem to attach [src] to [crusher]. Maybe remove a few trophies?"))
			return FALSE

	if(!user.transferItemToLoc(src, crusher))
		return

	crusher_comp.stored_trophies += src
	to_chat(user, span_notice("You attach [src] to [crusher]."))
	return TRUE

/obj/projectile/destabilizer
	name = "destabilizing force"
	icon_state = "pulse1"
	damage = 0 //We're just here to mark people. This is still a melee weapon.
	damage_type = BRUTE
	armor_flag = BOMB
	range = 6
	log_override = TRUE
	var/datum/component/kinetic_crusher/hammer_synced

/obj/projectile/destabilizer/Destroy()
	hammer_synced = null
	return ..()

/obj/projectile/destabilizer/on_hit(atom/target, blocked = 0, pierce_hit)
	if(isliving(target))
		var/mob/living/victim = target
		var/had_effect = victim.has_status_effect(/datum/status_effect/crusher_mark) //used as a boolean
		var/datum/status_effect/crusher_mark/mark = had_effect || victim.apply_status_effect(/datum/status_effect/crusher_mark, hammer_synced)
		NO_DEBUG_GUH("GUH. HAD_EFECT:[had_effect], MARK:[mark]")

		for(var/obj/item/crusher_trophy/trophy as anything in hammer_synced?.stored_trophies)
			trophy.on_mark_application(target, mark, had_effect)

	var/turf/closed/mineral/target_turf = get_turf(target) //sure i guess
	if(istype(target_turf))
		new /obj/effect/temp_visual/kinetic_blast(target_turf)
		target_turf.gets_drilled(firer)

	return ..()
