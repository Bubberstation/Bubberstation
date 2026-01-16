/datum/component/seethrough/filtered
	var/list/valid_targets = list()

/datum/component/seethrough/filtered/Initialize(see_through_map, target_alpha, animation_time, perimeter_reset_timer, clickthrough)
	. = ..()

/datum/component/seethrough/filtered/on_entered(atom/source, atom/movable/entered)
	if(WEAKREF(entered) in valid_targets)
		return ..()

/datum/component/seethrough/filtered/proc/add_valid_target(atom/movable/target)
	valid_targets += WEAKREF(target)
	if(target.loc in watched_turfs)
		on_entered(target, target)

/datum/component/seethrough/filtered/proc/remove_valid_target(atom/movable/target)
	valid_targets -= WEAKREF(target)
	on_exited(target, target)

/datum/component/seethrough/filtered/setup_perimeter(atom/parent)
	if(isnull(watched_turfs))
		watched_turfs = list()

	for(var/list/coordinates as anything in see_through_map)
		var/turf/target = TURF_FROM_COORDS_LIST(list(parent.x + coordinates[1], parent.y + coordinates[2], parent.z + coordinates[3]))

		if(isnull(target))
			continue

		RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(on_entered))
		RegisterSignal(target, COMSIG_ATOM_EXITED, PROC_REF(on_exited))

		watched_turfs.Add(target)
