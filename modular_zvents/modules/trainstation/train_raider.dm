/obj/item/tank/jump_jetpack
	name = "Jump jetpack"
	desc = "A tank of compressed gas for use as propulsion in zero-gravity areas. Use with caution."
	icon_state = "jetpack-mini"
	inhand_icon_state = "jetpack-black"
	lefthand_file = 'icons/mob/inhands/equipment/jetpacks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/jetpacks_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT
	distribute_pressure = ONE_ATMOSPHERE * O2STANDARD
	actions_types = list(/datum/action/cooldown/jetpack_jump)

	var/jump_range = 7
	var/jump_speed = 1

/datum/action/cooldown/jetpack_jump
	name = "Jump with jetpack"
	desc = "Click this ability to attack."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "jetboot"
	background_icon = 'icons/mob/actions/actions_items.dmi'
	background_icon_state = "storage_gather_switch"
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED
	cooldown_time = 10 SECONDS
	text_cooldown = TRUE
	click_to_activate = TRUE
	shared_cooldown = MOB_SHARED_COOLDOWN_1

/datum/action/cooldown/jetpack_jump/Activate(atom/target)
	if(!target)
		return FALSE
	var/mob/living/carbon/human/jumper = owner
	var/obj/item/tank/jump_jetpack/jetpack = locate() in owner.contents
	if(!jetpack)
		jumper.balloon_alert(jumper, "Your jump jetpack is missing!")
		return FALSE
	if(isclosedturf(target))
		jumper.balloon_alert(jumper, "Can't jump there!")
		return FALSE

	var/turf/target_turf = target
	if(!can_see(target_turf, jumper, jetpack.jump_range))
		jumper.balloon_alert(jumper, "Can't jump there!")
		return FALSE
	new /obj/effect/temp_visual/telegraphing/boss_hit(target_turf)

	var/ignores = IGNORE_SLOWDOWNS|IGNORE_TARGET_LOC_CHANGE|IGNORE_USER_LOC_CHANGE
	if(!do_after(jumper, 1 SECONDS, jumper, ignores, max_interact_count = 1))
		StartCooldown(3 SECONDS)
		jumper.balloon_alert(jumper, "Interupted!")
		return FALSE

	INVOKE_ASYNC(src, PROC_REF(perform_jump), jumper, target_turf)
	return ..()

/datum/action/cooldown/jetpack_jump/proc/perform_jump(mob/living/carbon/human/jumper, turf/target_turf)
	jumper.movement_type = FLYING

	if(jumper.buckled)
		var/atom/movable/our_vehicle = jumper.buckled
		our_vehicle.unbuckle_mob(jumper, TRUE, FALSE)

	playsound(jumper, 'sound/items/weapons/resonator_blast.ogg', 100, TRUE)
	new /obj/effect/temp_visual/fire(get_turf(jumper))

	var/start_z = jumper.pixel_z
	var/start_y = jumper.pixel_y

	jumper.set_anchored(TRUE)

	var/dist_to_turf = get_dist(jumper, target_turf)
	var/steps = dist_to_turf * 4
	var/apex_height = 60 + dist_to_turf * 9
	for(var/i in 1 to steps)
		if(get_turf(jumper) == target_turf)
			break

		var/t = i / steps
		var/height_mult = 1.0
		if(t < 0.15)
			height_mult = 1 + 2.5 * (1 - t/0.15)**2

		var/height = 4 * t * (1 - t)
		height *= 1 + 0.25 * sin(t * 180)

		var/current_z = start_z + apex_height * height * height_mult
		var/current_y = start_y + (apex_height * 0.55) * height
		var/lean = -sin(t * 180) * 25
		var/dx = target_turf.x - jumper.x
		lean += dx * 8

		jumper.transform = matrix(jumper.transform) * matrix(lean, MATRIX_ROTATE)
		jumper.pixel_z = current_z
		jumper.pixel_y = current_y
		new /obj/effect/temp_visual/decoy/fading/halfsecond(get_turf(jumper), jumper, 200)
		if(i % 4 == 0)
			var/turf/next_turf = get_step_towards(jumper, target_turf)

			if(isclosedturf(next_turf))
				jumper.Knockdown(3 SECONDS)
				break

			if(next_turf.is_blocked_turf(TRUE, jumper))
				jumper.Knockdown(1 SECONDS)
				break

			jumper.forceMove(next_turf)

		sleep(2 TICKS)

	jumper.set_anchored(FALSE)
	jumper.movement_type = GROUND


	jumper.pixel_z = start_z
	jumper.pixel_y = start_y
	jumper.transform = initial(jumper.transform)

	playsound(jumper, 'sound/items/weapons/kinetic_accel.ogg', 100, TRUE)

	for(var/mob/living/L in get_turf(jumper))
		if(L == jumper)
			continue
		L.Knockdown(2 SECONDS)

/datum/outfit/train_raider
	name = "Train raider - basic"

	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/industrial/cin_surplus
	ears = /obj/item/radio/headset/syndicate/alt
	suit = /obj/item/clothing/suit/armor/vest/hecu
	r_pocket = /obj/item/knife/combat
	l_pocket = /obj/item/ammo_box/magazine/c35sol_pistol
	id = /obj/item/card/id/advanced/chameleon/black
	belt = /obj/item/tank/jump_jetpack



	box = /obj/item/storage/box/survival/syndie
	id_trim = /datum/id_trim/chameleon/operative
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/sol = 1,
		/obj/item/ammo_box/magazine/c35sol_pistol = 2,
		/obj/item/storage/medkit/frontier/stocked = 1,
		/obj/item/stack/medical/suture = 2,
	)

	var/winter_coat = /obj/item/clothing/suit/hooded/wintercoat

/datum/outfit/train_raider/post_equip(mob/living/carbon/human/user, visuals_only)
	. = ..()

	var/obj/item/radio/radio = user.ears
	radio.set_frequency(FREQ_SYNDICATE)
	radio.freqlock = RADIO_FREQENCY_LOCKED

	var/obj/item/implant/weapons_auth/weapons_implant = new/obj/item/implant/weapons_auth(user)
	weapons_implant.implant(user)
	var/obj/item/clothing/suit/coat = new winter_coat()
	if(istype(coat, /obj/item/clothing/suit))
		coat.functional_suit_values = list(
			"fs_slots" = coat.slot_flags,
			"fs_cold" = coat.cold_protection,
			"fs_heat" = coat.heat_protection,
			"fs_slow" = coat.slowdown,
			"fs_slow" = coat.get_armor(),
		)
		coat.slot_flags = ITEM_SLOT_NECK
		coat.cold_protection = null
		coat.heat_protection = null
		coat.slowdown = 0
		coat.set_armor(/datum/armor/none)
		user.equip_to_slot_or_del(coat, ITEM_SLOT_NECK)
	user.faction |= ROLE_SYNDICATE
	user.update_icons()

/datum/outfit/train_raider/shotgun
	name = "Train raider - shotgun"
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat


/datum/outfit/train_raider/shotgun/New()
	backpack_contents += list(
		/obj/item/storage/box/lethalshot = 1,
	)
	. = ..()

/datum/outfit/train_raider/rifleman
	name = "Train raider - rifleman"
	suit_store = /obj/item/gun/ballistic/automatic/sol_smg/evil


/datum/outfit/train_raider/rifleman/New()
	backpack_contents += list(
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 3,
	)
	. = ..()

/datum/job/train_raider
	title = "Train raider"

/datum/antagonist/train_raider
	name = "Train raider"
	roundend_category = "raiders"
	antagpanel_category = ANTAG_GROUP_SYNDICATE
	pref_flag = ROLE_TRAITOR
	antag_hud_name = "synd"
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = TRUE
	hijack_speed = 2 //If you can't take out the station, take the shuttle instead.
	suicide_cry = "FOR THE SYNDICATE!!"

	var/static/list/possible_outfits = list(
		/datum/outfit/train_raider/rifleman,
		/datum/outfit/train_raider/shotgun,
	)

/datum/antagonist/train_raider/on_gain()
	forge_objectives()
	equip_raider()
	. = ..()

/datum/antagonist/train_raider/forge_objectives()
	var/datum/objective/custom/destroy_cargo = new()
	destroy_cargo.name = "Destroy the cargo"
	destroy_cargo.explanation_text = "Break the integrity of the cargo transported by train and seize the resources!"
	objectives += destroy_cargo

/datum/antagonist/train_raider/proc/equip_raider()
	var/outfit = pick(possible_outfits)
	if(!ishuman(owner.current))
		return

	var/mob/living/carbon/human/raider = owner.current
	ADD_TRAIT(raider, TRAIT_NOFEAR_HOLDUPS, INNATE_TRAIT)
	ADD_TRAIT(raider, TRAIT_DESENSITIZED, INNATE_TRAIT)

	if(!outfit)
		return
	raider.equip_species_outfit(outfit)

/datum/round_event_control/train_raiders
	name = "Train raiders"
	category = EVENT_CATEGORY_INVASION
	description = "Raiders gathered around the train to break into it and destroy the cargo."
	typepath = /datum/round_event/ghost_role/train_raiders
	weight = 0

/datum/round_event/ghost_role/train_raiders
	minimum_required = 1

	var/static/list/possible_vehicles = list(
		/obj/vehicle/ridden/trainstation/bike,
		/obj/vehicle/ridden/trainstation/bike/red,
		/obj/vehicle/ridden/trainstation/bike/blue,
		/obj/vehicle/ridden/trainstation/bike/green,
	)
	announce_when = 20


/datum/round_event/ghost_role/train_raiders/spawn_role()
	var/list/chosen = SSpolling.poll_ghost_candidates(check_jobban = ROLE_TRAITOR, role = ROLE_TRAITOR, role_name_text = "Train raider", alert_pic = /obj/vehicle/ridden/trainstation, amount_to_pick = 4)
	if(!islist(chosen))
		chosen = list(chosen)

	if(isnull(chosen))
		return NOT_ENOUGH_PLAYERS

	var/list/spawn_points = null
	for(var/obj/effect/landmark/trainstation/raider_spawnpoint/spawn_point in GLOB.landmarks_list)
		LAZYADD(spawn_points, spawn_point)
	if(!length(spawn_points))
		return MAP_ERROR
	for(var/mob/mob in chosen)
		var/turf/spawn_location = get_turf(pick(spawn_points))
		spawn_bad_guy(spawn_location, mob.client)
	return SUCCESSFUL_SPAWN

/datum/round_event/ghost_role/train_raiders/proc/spawn_bad_guy(turf/spawn_turf, client/bad_guy)
	var/mob/living/carbon/human/raider = new(spawn_turf)
	raider.randomize_human_appearance(~RANDOMIZE_SPECIES)
	raider.dna.update_dna_identity()
	var/datum/mind/mind = new /datum/mind(bad_guy.key)
	mind.set_assigned_role(SSjob.get_job_type(/datum/job/train_raider))
	mind.active = TRUE
	mind.transfer_to(raider)
	if(!raider.client?.prefs.read_preference(/datum/preference/toggle/nuke_ops_species))
		var/species_type = raider.client.prefs.read_preference(/datum/preference/choiced/species)
		raider.set_species(species_type)
	mind.add_antag_datum(/datum/antagonist/train_raider)
	var/bike_type = pick(possible_vehicles)
	var/obj/vehicle/ridden/trainstation/raider_bike = new bike_type(spawn_turf)
	raider_bike.dir = SStrain_controller.abstract_moving_direction
	raider_bike.buckle_mob(raider)
	INVOKE_ASYNC(src, PROC_REF(strike_raider), raider, raider_bike)
	spawned_mobs += raider
	message_admins("[ADMIN_LOOKUPFLW(raider)] has been made into lone train raider by an event.")
	raider.log_message("was spawned as a train raider by an event.", LOG_GAME)

/datum/round_event/ghost_role/train_raiders/proc/strike_raider(mob/living/raider, obj/vehicle/ridden/trainstation/raider_bike)
	if(!raider || !raider_bike)
		return
	if(raider.open_uis)
		for(var/datum/tgui/ui in raider.open_uis)
			ui.close(FALSE)

	var/turf/target_turf = get_ranged_target_turf(raider_bike, raider_bike.dir, 15)
	if(!target_turf)
		return
	for(var/i = 1 to 15)
		raider_bike.Shake()
		new /obj/effect/temp_visual/decoy/fading/halfsecond(get_turf(raider_bike), raider_bike, 200)
		new /obj/effect/temp_visual/decoy/fading/halfsecond(get_turf(raider_bike), raider, 200)
		raider_bike.forceMove(get_step_towards(raider_bike, target_turf))
		sleep(3 TICKS)
		CHECK_TICK
	raider_bike.last_real_move = world.time + 10 SECONDS
	if(station_time() > 18 HOURS)
		raider_bike.set_light_on(TRUE)
