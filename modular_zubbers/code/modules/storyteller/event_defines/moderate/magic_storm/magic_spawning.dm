

/proc/spawn_space_spells(number = 10, list/magic_types, direction, atom/target, individual_homing_chance = 20)
	for(var/i in 1 to number)
		spawn_space_spell(magic_types, direction, target, homing_chance = individual_homing_chance)

/// Spawns a single space spell and launches it toward the station
///
/// - `list/magic_types` - Self explainable. If empty, any /obj/projectile/magic is launched
/// - `direction` - The cardinal direction from which we spawn spells. If empty, random direction
/// - `atom/target` - Optional victim
/// - `homing_chance` - Chance we home on the victim if they're a mob/living
/proc/spawn_space_spell(list/magic_types, direction, atom/target, distance_from_edge = 0, homing_chance = 20)
	if(SSmapping.is_planetary())
		stack_trace("Tried to spawn a space spell on a planetary map.")
		return
	var/turf/picked_start
	var/turf/picked_goal

	var/start_side
	if(direction)
		start_side = direction
	else
		start_side = pick(GLOB.cardinals)

	var/start_Z
	if(target)
		start_Z = target.z
		picked_goal = target
	else
		start_Z = pick(SSmapping.levels_by_trait(ZTRAIT_STATION))
		picked_goal = spaceDebrisFinishLoc(start_side, start_Z)
	picked_start = spaceDebrisStartLoc(start_side, start_Z, distance_from_edge)

	var/spelltype
	if(!length(magic_types))
		magic_types = typesof(/obj/projectile/magic) - /obj/projectile/magic
		spelltype = pick(magic_types)
	else
		spelltype = pick_weight(magic_types)

	var/obj/projectile/spell = new spelltype(picked_start)

	spell.fired_from = picked_start
	spell.range = 250
	spell.aim_projectile(picked_goal, picked_start)
	if(isliving(picked_goal) && prob(homing_chance))
		spell.set_homing_target(picked_goal)
	spell.fire()
