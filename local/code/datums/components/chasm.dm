// Gas Giant chasm still kills you but to prevent free RR it drops you off at medbay now. sue me
/datum/component/chasm/gas_giant/drop(atom/movable/dropped_thing)
	. = ..()
	if(isliving(dropped_thing))
		for(var/area/station/medical/medbay/pod_collection/found_pod_collection_room in GLOB.areas)
			var/our_pod = podspawn(list(
				"target" = pick(get_area_turfs(found_pod_collection_room)), \
			))
			dropped_thing.forceMove(our_pod)
			return
		CRASH("No pod collection room on the map! Unable to save a falling mob!")
