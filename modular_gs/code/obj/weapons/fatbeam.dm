/obj/item/gun/fatbeam // GS13
	name = "Fatbeam Gun"
	desc = "Apparently used to treat malnourished patients from a safe distance... But we all know what it will truly be used for."
	icon = 'GainStation13/icons/obj/weapons/fatbeam.dmi'
	icon_state = "fatbeam"
	item_state = "fatbeam"
	w_class = WEIGHT_CLASS_NORMAL

	var/mob/living/current_target
	var/last_check = 0
	var/check_delay = 10 //Check los as often as possible, max resolution is SSobj tick though
	var/max_range = 8
	var/active = 0
	var/datum/beam/current_beam = null
	var/mounted = 0 //Denotes if this is a handheld or mounted version

	weapon_weight = WEAPON_MEDIUM

/obj/item/gun/fatbeam/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/gun/fatbeam/Destroy(mob/user)
	STOP_PROCESSING(SSobj, src)
	LoseTarget()
	return ..()

/obj/item/gun/fatbeam/dropped(mob/user)
	..()
	LoseTarget()

/obj/item/gun/fatbeam/equipped(mob/user)
	..()
	LoseTarget()

/obj/item/gun/fatbeam/proc/LoseTarget()
	if(active)
		qdel(current_beam)
		current_beam = null
		active = 0
		on_beam_release(current_target)
	current_target = null

/obj/item/gun/fatbeam/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(isliving(user))
		add_fingerprint(user)

	if(current_target)
		LoseTarget()
	if(!isliving(target))
		return

	current_target = target
	active = TRUE
	current_beam = new(user,current_target,time=6000,beam_icon_state="fatbeam",btype=/obj/effect/ebeam/medical)
	INVOKE_ASYNC(current_beam, TYPE_PROC_REF(/datum/beam,Start))

	SSblackbox.record_feedback("tally", "gun_fired", 1, type)

/obj/item/gun/fatbeam/process()

	var/source = loc
	if(!mounted && !isliving(source))
		LoseTarget()
		return

	if(!current_target)
		LoseTarget()
		return

	if(world.time <= last_check+check_delay)
		return

	last_check = world.time

	if(get_dist(source, current_target)>max_range || !los_check(source, current_target))
		LoseTarget()
		if(isliving(source))
			to_chat(source, "<span class='warning'>You lose control of the beam!</span>")
		return

	if(current_target)
		on_beam_tick(current_target)

/obj/item/gun/fatbeam/proc/los_check(atom/movable/user, mob/target)
	var/turf/user_turf = user.loc
	if(mounted)
		user_turf = get_turf(user)
	else if(!istype(user_turf))
		return FALSE
	var/obj/dummy = new(user_turf)
	dummy.pass_flags |= PASSTABLE|PASSGLASS|PASSGRILLE //Grille/Glass so it can be used through common windows
	for(var/turf/turf in getline(user_turf,target))
		if(mounted && turf == user_turf)
			continue //Mechs are dense and thus fail the check
		if(turf.density)
			qdel(dummy)
			return FALSE
		for(var/atom/movable/AM in turf)
			if(!AM.CanPass(dummy,turf,1))
				qdel(dummy)
				return FALSE
		for(var/obj/effect/ebeam/medical/B in turf)// Don't cross the str-beams!
			if(B.owner.origin != current_beam.origin)
				explosion(B.loc,0,1,3,4)
				qdel(dummy)
				return FALSE
	qdel(dummy)
	return TRUE

/obj/item/gun/fatbeam/proc/on_beam_hit(var/mob/living/target)
	return

/obj/item/gun/fatbeam/proc/on_beam_tick(var/mob/living/target)
	if(target.health != target.maxHealth)
		new /obj/effect/temp_visual/heal(get_turf(target), "#fabb62")
	if(target?.client?.prefs?.weight_gain_weapons)
		target.nutrition += 50
	return

/obj/item/gun/fatbeam/proc/on_beam_release(var/mob/living/target)
	return

/obj/effect/ebeam/medical
	name = "fattening beam"

