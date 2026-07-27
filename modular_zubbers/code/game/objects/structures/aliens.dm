/obj/structure/alien/weeds/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature >= 350 //Slightly higher than moonstation external atmos.

/obj/structure/alien/weeds/xenohybrid
	name = "xenohybrid resin floor"
	desc = "A thick resin surface covers the floor. It seems weaker than what a full-blooded xenomorph would make."
	max_integrity = 5
	node_range = 1 //Lower range makes it easier to control and keep from invading public spaces

/obj/structure/alien/weeds/xenohybrid/try_expand()
	//we cant grow without a parent node
	if(!parent_node)
		return
	//lets make sure we are still on a valid location
	var/turf/src_turf = get_turf(src)
	if(is_type_in_list(src_turf, blacklisted_turfs))
		qdel(src)
		return
	//lets try to grow in a direction
	for(var/turf/check_turf in src_turf.get_atmos_adjacent_turfs())
		//we cannot grow on blacklisted turfs
		if(is_type_in_list(check_turf, blacklisted_turfs))
			continue
		var/obj/structure/alien/weeds/check_weed = locate() in check_turf
		//we cannot grow onto other weeds
		if(check_weed)
			continue
		//spawn a new one in the turf
		var/obj/structure/alien/weeds/xenohybrid/new_weed
		new_weed = new(check_turf)
		//set the new one's parent node to our parent node
		new_weed.parent_node = parent_node
		new_weed.RegisterSignal(parent_node, COMSIG_QDELETING, PROC_REF(after_parent_destroyed))


/obj/structure/alien/weeds/xenohybrid/node
	name = "xenohybrid glowing weeds"
	desc = "Purple bioluminescence shines from beneath the surface. It seems weaker than what a full-blooded xenomorph would make."
	icon = 'modular_zubbers/icons/obj/smooth_structures/alien/weednode_xenohybrid.dmi'
	icon_state = "weednode_xenohybrid-0"
	base_icon_state = "weednode_xenohybrid"
	light_color = LIGHT_COLOR_PURPLE
	light_power = 0.5
	///the range of the light for the node
	var/lon_range = 4
	///the minimum time it takes for another weed to spread from this one
	var/minimum_growtime = 30 SECONDS
	///the maximum time it takes for another weed to spread from this one
	var/maximum_growtime = 60 SECONDS
	//the cooldown between each growth
	COOLDOWN_DECLARE(growtime)

/obj/structure/alien/weeds/xenohybrid/node/Initialize(mapload)
	. = ..()

	//give it light
	set_light(lon_range)

	//we are the parent node
	parent_node = src

	return INITIALIZE_HINT_LATELOAD

// we do this in LateInitialize() because weeds on the same loc may not be done initializing yet (as in create_and_destroy)
/obj/structure/alien/weeds/xenohybrid/node/LateInitialize()
	//destroy any non-node weeds on turf
	var/obj/structure/alien/weeds/check_weed = locate(/obj/structure/alien/weeds) in loc //This can stay as non-xenohybrid weeds being included
	if(check_weed && check_weed != src)
		qdel(check_weed)

	//start the cooldown
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))

	//start processing
	START_PROCESSING(SSobj, src)

/obj/structure/alien/weeds/xenohybrid/node/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/alien/weeds/xenohybrid/node/process()
	//we need to have a cooldown, so check and then add
	if(!COOLDOWN_FINISHED(src, growtime))
		return
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))
	//attempt to grow all weeds in range
	for(var/obj/structure/alien/weeds/xenohybrid/growing_weed in range(node_range, src))
		growing_weed.try_expand()

/obj/structure/alien/weeds/xenohybrid/node/set_base_icon()
	return //No icon randomization at init. The node's icon is already well defined.

