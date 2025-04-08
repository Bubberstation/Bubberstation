#define SPAWN_MODE_MOB_COOLDOWN 5 SECONDS
#define SPAWN_MODE_MEGAFAUNA_COOLDOWN 30 SECONDS

/datum/phystool_mode/spawn_mode
	name = "Spawn mode"
	desc = "Use LMB to spawn, use in hands to choose spawn type."
	var/atom/selected_object

	var/list/atom/black_list = list(
		/obj/narsie,
		/obj/cascade_portal,
		/obj/singularity,
		/obj/effect,
		/mob/living/basic/supermatter_spider,
		/area,
		/turf
	)
	COOLDOWN_DECLARE(spawn_cooldown)

/datum/phystool_mode/spawn_mode/use_act(mob/user)
	. = ..()
	var/text_path = tgui_input_text(user, "Enter object path:", "Spawn tool", "none", 256, FALSE)
	if(!text_path)
		user.balloon_alert(user, "enter path!")
		return FALSE
	selected_object = text2path(text_path)
	if(!ispath(selected_object))
		selected_object = pick_closest_path(text_path)
	for(var/black_list_item in black_list)
		if(ispath(selected_object, black_list_item))
			selected_object = null
			user.balloon_alert(user, "spawn blocked!")
			return FALSE
	user.balloon_alert(user, "selected!")
	to_chat(user, span_notice("Current spawn type [selected_object]."))

/datum/phystool_mode/spawn_mode/main_act(atom/target, mob/user)
	. = ..()

	if(!selected_object)
		user.balloon_alert(user, "select type first!")
		return FALSE

	if(!COOLDOWN_FINISHED(src, spawn_cooldown))
		user.balloon_alert(user, "wait!")
		return FALSE
	var/target_cooldown
	if(ispath(selected_object, /mob/living/simple_animal/hostile/megafauna))
		target_cooldown = SPAWN_MODE_MEGAFAUNA_COOLDOWN
	if(ispath(selected_object, /mob/living))
		target_cooldown = SPAWN_MODE_MOB_COOLDOWN
	if(target_cooldown)
		COOLDOWN_START(src, spawn_cooldown, target_cooldown)

	new selected_object(get_turf(target))
	return TRUE

#undef SPAWN_MODE_MOB_COOLDOWN
#undef SPAWN_MODE_MEGAFAUNA_COOLDOWN
