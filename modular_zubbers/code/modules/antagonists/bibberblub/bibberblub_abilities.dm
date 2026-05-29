/datum/action/cooldown/hide //Copy-pasted from the alien larva, but removed a couple alien-specific things. for some reason the alien one didn't work.
	name = "Hide"
	desc = "Allows you to hide beneath tables and certain objects, like some kind of rodent"
	button_icon = 'icons/mob/actions/actions_xeno.dmi'
	button_icon_state = "alien_hide"
	/// The layer we are on while hiding
	var/hide_layer = ABOVE_NORMAL_TURF_LAYER

/datum/action/cooldown/hide/Activate(atom/target)
	if(owner.layer == hide_layer)
		owner.layer = initial(owner.layer)
		owner.visible_message(
			span_notice("[owner] slowly peeks up from the ground..."),
			span_noticealien("You stop hiding."),
		)
		ADD_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	else
		owner.layer = hide_layer
		owner.visible_message(
			span_name("[owner] scurries to the ground!"),
			span_noticealien("You are now hiding."),
		)
		REMOVE_TRAIT(owner, TRAIT_IGNORE_ELEVATION, ACTION_TRAIT)

	return TRUE

/datum/action/cooldown/bibberblub_reproduce
	name = "Reproduce"
	desc = "Spin a cocoon using 20 protein, allowing more Bibberblubs to flood into the station"
	button_icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	button_icon_state = "Cocoon"
	cooldown_time = 2 MINUTES
	var/mob/living/basic/bibberblub/bibberblub
	var/protein_cost = 20

/datum/action/cooldown/bibberblub_reproduce/Grant(mob/granted_to)
	. = ..()
	bibberblub = granted_to
	if(isnull(bibberblub))
		Remove(granted_to)

/datum/action/cooldown/bibberblub_reproduce/Activate(atom/target)
	. = ..()
	if(bibberblub.protein_resource < protein_cost)
		bibberblub.balloon_alert(bibberblub, "need more protein!")
		return
	if(do_after(bibberblub, 20 SECONDS, target))
		new /obj/effect/mob_spawn/ghost_role/bibberblub(get_turf(bibberblub))
		bibberblub.protein_resource -= protein_cost

/datum/action/cooldown/bibberblub_reproduce/Destroy()
	. = ..()
	bibberblub = null

/datum/action/cooldown/spell/pointed/hamster
	name = "Hamster"
	desc = "Store something in your mouth and spit it out later!"
	button_icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	button_icon_state = "Bibberblub"
	cooldown_time = 5 SECONDS
	spell_requirements = null
	antimagic_flags = null
	cast_range = 1
	var/obj/item/hamstered_item

/datum/action/cooldown/spell/pointed/hamster/on_activation(mob/on_who)
	if(!isnull(hamstered_item))
		hamstered_item.forceMove(get_turf(owner))
		hamstered_item = null
		playsound(owner, 'sound/effects/splat.ogg', 25, TRUE)
		unset_click_ability(on_who, FALSE)
		StartCooldown()
		return
	return ..()

/datum/action/cooldown/spell/pointed/hamster/is_valid_target(atom/cast_on)
	. = ..()
	if(istype(cast_on, /obj/item))
		if(istype(cast_on, /obj/item/food))
			owner.balloon_alert(owner, "you should enjoy this!")
			return FALSE //Gotta enjoy the food in small bites!
		return TRUE
	return FALSE

/datum/action/cooldown/spell/pointed/hamster/cast(atom/cast_on)
	. = ..()
	var/obj/item/slurped = cast_on
	slurped.forceMove(owner)
	hamstered_item = slurped
	playsound(owner, 'sound/effects/glug.ogg', 25, TRUE)
	owner.balloon_alert_to_viewers("Swallowed [slurped.name]!")

/datum/action/cooldown/spell/pointed/hamster/proc/expell_hamstered()
	if(!isnull(hamstered_item))
		hamstered_item.forceMove(get_turf(owner))
		hamstered_item = null
		playsound(owner, 'sound/effects/splat.ogg', 25, TRUE)
		return


/datum/action/cooldown/bibberblub_spit
	name = "Slippery Spit"
	desc = "For 10 Vitamin, Spit a puddle of slippery slime for others to slip on and ruin their clothes! This will require them to shower to clean the stains off. useful for escapes."
	button_icon = 'icons/obj/service/hydroponics/harvest.dmi'
	button_icon_state = "banana_peel"
	cooldown_time = 15 SECONDS
	var/mob/living/basic/bibberblub/bibberblub
	var/vitamin_cost = 10

/datum/action/cooldown/bibberblub_spit/Grant(mob/granted_to)
	. = ..()
	bibberblub = granted_to
	if(isnull(bibberblub))
		Remove(granted_to)

/datum/action/cooldown/bibberblub_spit/Destroy()
	. = ..()
	bibberblub = null

/datum/action/cooldown/bibberblub_spit/Activate(atom/target)
	. = ..()
	if(bibberblub.vitamin_resource < vitamin_cost)
		bibberblub.balloon_alert(bibberblub, "need more vitamins!")
		return

	new /obj/effect/decal/cleanable/bibberblub_spit(get_turf(bibberblub))
	playsound(owner, 'sound/effects/splat.ogg', 100, TRUE)
	bibberblub.vitamin_resource -= vitamin_cost

// ==== STRUCTURES ====
/datum/action/cooldown/bubberblub_structures
	name = "Build Structure"
	desc = "Build something using nutrients"
	button_icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	button_icon_state = "Bibberblub"
	cooldown_time = 1 SECONDS
	var/mob/living/basic/bibberblub/bibberblub

	var/build_time = 1 SECONDS
	var/obj/structure/structure_to_build
	var/nutriment_cost = 0

	///How far this needs to be from identical structures
	var/minimum_distance = 0
	///How many Slimy Floor tiles need to be in the area to allow this to be placed
	var/minimum_floors = 0
	///Whether this needs a slimy floor below itself to be placed. If false can only be placed on tiles without slimy floors
	var/needs_floor = TRUE


/datum/action/cooldown/bubberblub_structures/Grant(mob/granted_to)
	. = ..()
	bibberblub = granted_to
	if(isnull(bibberblub))
		Remove(granted_to)
	name = name + " ([nutriment_cost])"


/datum/action/cooldown/bubberblub_structures/Activate(atom/target)
	. = ..()
	if(!validate_placement())
		StartCooldown()
		return
	if(bibberblub.nutriment_resource < nutriment_cost)
		bibberblub.balloon_alert(bibberblub, "need more nutriment!")
		return
	if(do_after(bibberblub, build_time, target))
		new structure_to_build(get_turf(bibberblub))
		bibberblub.nutriment_resource -= nutriment_cost

/datum/action/cooldown/bubberblub_structures/Destroy()
	. = ..()
	bibberblub = null

/datum/action/cooldown/bubberblub_structures/proc/validate_placement()
	if(!bibberblub)
		return FALSE
	var/turf/build_turf = get_turf(bibberblub)
	if(!build_turf)
		return FALSE

	//Floor Validation
	var/has_slimy_floor = FALSE
	for(var/obj/structure/bibberblub/slimy_floor/floor in build_turf)
		has_slimy_floor = TRUE
		break
	if(needs_floor && !has_slimy_floor)
		bibberblub.balloon_alert(bibberblub, "need slimy floor!")
		return FALSE
	if(!needs_floor && has_slimy_floor)
		bibberblub.balloon_alert(bibberblub, "already slimy!")
		return FALSE
	// Prevent stacking structures on same tile
	for(var/obj/structure/bibberblub/existing in build_turf)
		// Ignore slimy floors
		if(istype(existing, /obj/structure/bibberblub/slimy_floor))
			continue
		bibberblub.balloon_alert(bibberblub, "something is already here!")
		return FALSE

	//Separation Validation
	if(minimum_distance > 0)
		for(var/obj/structure/nearby in range(minimum_distance, build_turf))
			if(!istype(nearby, structure_to_build))
				continue
			bibberblub.balloon_alert(bibberblub, "too close to another!")
			return FALSE

	//Area Validation
	if(minimum_floors > 0)
		var/area/current_area = get_area(build_turf)
		var/floor_count = 0
		for(var/obj/structure/bibberblub/slimy_floor/floor in current_area)
			floor_count++
			if(floor_count >= minimum_floors)
				break
		if(floor_count < minimum_floors)
			bibberblub.balloon_alert(bibberblub, "need more slimy floor!")
			return FALSE
	return TRUE

/datum/action/cooldown/bubberblub_structures/slimy_floor
	name = "Build Floor"
	desc = "Cover the floor with goop! Needed to build further structures."
	button_icon_state = "Floor"
	nutriment_cost = 5
	needs_floor = FALSE
	structure_to_build = /obj/structure/bibberblub/slimy_floor

/datum/action/cooldown/bubberblub_structures/slimy_floor/Activate(atom/target)
	var/turf/placement_turf = get_turf(bibberblub)
	var/has_vent = FALSE
	for(var/obj/machinery/atmospherics/components/unary/vent in placement_turf)
		has_vent = TRUE
		break
	if(has_vent)
		structure_to_build = /obj/structure/bibberblub/slimy_floor/vent_hole
	else
		structure_to_build = /obj/structure/bibberblub/slimy_floor

	return ..()

/datum/action/cooldown/bubberblub_structures/compost_hole
	name = "Build Compost"
	desc = "Put a hole in the goop to eat trash! This will turn it into nutritionally complete Bibberblub Rations!"
	button_icon_state = "Compost"
	nutriment_cost = 20
	minimum_distance = 5
	minimum_floors = 3
	build_time = 10 SECONDS
	cooldown_time = 30 SECONDS
	structure_to_build = /obj/structure/bibberblub/compost

/datum/action/cooldown/bubberblub_structures/blubhole
	name = "Build Blubhole"
	desc = "Build a solid wall that only Bibberblubs can pass through to secure your territory"
	button_icon_state = "Blubhole"
	nutriment_cost = 20
	minimum_distance = 0
	minimum_floors = 0
	build_time = 5 SECONDS
	cooldown_time = 30 SECONDS
	structure_to_build = /obj/structure/bibberblub/blubhole

/datum/action/cooldown/bubberblub_structures/blubgrowth
	name = "Build Blubgrowth"
	desc = "Start a slimy growth that slowly grows the nutriments invested into Protein! takes about 4 minutes to grow."
	button_icon_state = "Blubgrowth_3"
	nutriment_cost = 30
	minimum_distance = 3
	minimum_floors = 8
	build_time = 3 SECONDS
	cooldown_time = 10 SECONDS
	structure_to_build = /obj/structure/bibberblub/blubgrowth

