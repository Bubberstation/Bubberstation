/datum/heretic_knowledge/loot_grasp

	name = "Grasp of Looting"
	desc = "Your mansus grasp allows you to instantly kill a living creature with 10% or less remaining life, and has a chance to grant special bonus loot on kill.\
	Additionally, secondary attack allows you to instantly break open any secure lockers, closets, or crates, spilling out the contents and having a chance to grant special bonus loot."
	gain_text = "More is never enough. Always seek more"

	next_knowledge = list(
		/datum/heretic_knowledge/bag_purchase,
		/datum/heretic_knowledge/determination,
	)

	cost = 1
	depth = 2
	route = PATH_EXILE

	research_tree_icon_path = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_ui.dmi'
	research_tree_icon_state = "looting"

/datum/heretic_knowledge/loot_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY, PROC_REF(on_secondary_mansus_grasp))
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/loot_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK_SECONDARY)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK)

/datum/heretic_knowledge/loot_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)

	SIGNAL_HANDLER

	if(target.stat != DEAD && target.health <= target.maxHealth * 0.1 && target.death(FALSE)) //Culling strike.
		log_combat(source, target, "killed via culling strike")
		target.investigate_log("has been killed by culling strike.", INVESTIGATE_DEATHS)
		var/turf/target_turf = get_turf(target)
		if(target_turf)
			var/loot_multiplier_min = 1
			var/loot_multiplier_max = 3

			if(!target.mind)
				loot_multiplier_min = 1
				loot_multiplier_max = 1
				if(prob(80)) //Culling strike optimization.
					return

			loot_multiplier_max *= (target.maxHealth/MAX_LIVING_HEALTH) //The bigger they are, the more they drop.

			loot_multiplier_min = max(loot_multiplier_min,1) //Always at least 1.
			loot_multiplier_max = max(loot_multiplier_max,1) //Always at least 1.

			if(loot_multiplier_min > loot_multiplier_max)
				loot_multiplier_min = loot_multiplier_max

			if(loot_multiplier_max < 1 && prob(100 - loot_multiplier_min*100))
				return

			loot_multiplier_min = CEILING(loot_multiplier_min,1)
			loot_multiplier_max = CEILING(loot_multiplier_max,1)

			if(loot_multiplier_max > 0)
				create_loot(
					target_turf,
					loot_multiplier_min,
					loot_multiplier_max
				)

		target.balloon_alert(source, "culling strike!")
		return

	target.balloon_alert(source, "culling strike had no effect!")

/datum/heretic_knowledge/loot_grasp/proc/create_loot(turf/desired_turf,min_loot=1,max_loot=3,do_move=TRUE)
	for(var/i in 1 to rand(min_loot,max_loot))
		var/obj/item/item_to_spawn = pick_weight(GLOB.heretic_loot_grasp_table_currency)
		item_to_spawn = new item_to_spawn(desired_turf)
		if(do_move)
			var/chosen_dir = pick(GLOB.alldirs)
			var/turf/found_step = get_step(item_to_spawn, chosen_dir)
			if(!found_step)
				continue
			item_to_spawn.Move(found_step, chosen_dir)

/datum/heretic_knowledge/loot_grasp/proc/on_secondary_mansus_grasp(mob/living/source, atom/target)

	SIGNAL_HANDLER

	if(istype(target,/obj/structure/closet))
		var/obj/structure/closet/loot_crate = target
		if(loot_crate.locked && loot_crate.secure && !loot_crate.broken && length(loot_crate.req_access) > 0)
			loot_crate.bust_open()
			var/turf/T = get_turf(loot_crate)
			if(T) //Could be destroyed or some nonsense.
				create_loot(T,1,3,FALSE)

	return COMPONENT_USE_HAND