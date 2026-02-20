GLOBAL_LIST_INIT(train_spwaner_themes, init_train_themes())
GLOBAL_LIST_EMPTY(train_object_spawners)

/proc/init_train_themes()
	var/list/themes = list()
	for (var/datum/train_object_spawner_theme/theme as anything in subtypesof(/datum/train_object_spawner_theme))
		themes[theme] = new theme()
	return themes

/datum/train_object_spawner_theme
	var/list/weighted_spawnlist
	var/min_delay = 1 SECONDS
	var/max_delay = 3 SECONDS
	var/accuracy_min = 1
	var/accuracy_max = 1
	var/allow_selection = TRUE

/datum/train_object_spawner_theme/proc/on_selected()
	return

/datum/train_object_spawner_theme/proc/on_deselected()
	return


/datum/train_object_spawner_theme/forest
	weighted_spawnlist = list(
		/obj/structure/flora/tree/pine/style_random = 60,
		/obj/structure/flora/bush/snow/style_random = 20,
		/obj/structure/flora/grass/both/style_random = 20,
	)
	accuracy_max = 3
	max_delay = 4 SECONDS

/datum/train_object_spawner_theme/war
	weighted_spawnlist = list(
		/obj/structure/flora/tree/dead/style_random = 60,
		/obj/structure/flora/grass/both/style_random = 20,
		/obj/effect/decal/cleanable/blood/gibs/body = 15,
		/obj/effect/decal/cleanable/blood/gibs/down = 15,
		/obj/structure/mecha_wreckage/durand = 15,
		/obj/structure/mecha_wreckage/seraph = 15,
		/obj/structure/mecha_wreckage/marauder = 15,
		/obj/structure/prop/vehicle/tank/broken = 5,
	)
	accuracy_max = 2
	max_delay = 3 SECONDS
	allow_selection = FALSE

/datum/train_object_spawner_theme/they
	weighted_spawnlist = list(
		/obj/structure/flora/tree/dead/style_random = 70,
		/obj/structure/flora/grass/both/style_random = 25,
		/obj/structure/prop/special_they = 5,
	)
	accuracy_max = 2
	max_delay = 7 SECONDS
	allow_selection = FALSE



/obj/effect/landmark/trainstation/object_spawner
	name = "Object spawner"

	var/spawn_chance = 100
	VAR_PRIVATE/datum/train_object_spawner_theme/theme
	VAR_PRIVATE/spawning = FALSE
	COOLDOWN_DECLARE(spawn_cd)


/obj/effect/landmark/trainstation/object_spawner/Initialize(mapload)
	. = ..()
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_BEGIN_MOVING, PROC_REF(on_train_begin_moving))
	RegisterSignal(SStrain_controller, COMSIG_TRAIN_STOP_MOVING, PROC_REF(on_train_stop_moving))
	GLOB.train_object_spawners += src
	theme = SStrain_controller.selected_theme
	if(SStrain_controller.is_moving())
		START_PROCESSING(SSobj, src)

/obj/effect/landmark/trainstation/object_spawner/Destroy()
	. = ..()
	GLOB.train_object_spawners -= src

/obj/effect/landmark/trainstation/object_spawner/proc/set_theme(datum/train_object_spawner_theme/new_theme)
	theme = new_theme

/obj/effect/landmark/trainstation/object_spawner/proc/on_train_begin_moving()
	SIGNAL_HANDLER
	START_PROCESSING(SSobj, src)

/obj/effect/landmark/trainstation/object_spawner/proc/on_train_stop_moving()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSobj, src)

/obj/effect/landmark/trainstation/object_spawner/process(seconds_per_tick)
	if(spawning || !SStrain_controller.allow_spawning() || !theme)
		return
	if(spawn_chance < 100 && !ROUND_PROB(spawn_chance))
		return
	if(!COOLDOWN_FINISHED(src, spawn_cd))
		return
	COOLDOWN_START(src, spawn_cd, rand(theme.min_delay, theme.max_delay))
	INVOKE_ASYNC(src, PROC_REF(attempt_spawn))

/obj/effect/landmark/trainstation/object_spawner/proc/attempt_spawn()
	if(!length(theme.weighted_spawnlist))
		return
	spawning = TRUE
	var/turf/target_turf = get_turf(src)
	var/accuracy = rand(theme.accuracy_min, theme.accuracy_max)
	if(accuracy > 0)
		for(var/turf/T as anything in shuffle(RANGE_TURFS(accuracy, src)))
			if(!can_see(src, T, accuracy))
				continue
			if(isopenturf(T) || !T.density || T.type == target_turf.type)
				target_turf = T
				break
	var/selected = pick_weight(theme.weighted_spawnlist)
	var/atom/movable/new_obj = new selected(src)
	if(new_obj)
		ASYNC
			new_obj.Move(target_turf, update_dir = FALSE)
	spawning = FALSE

/obj/effect/landmark/trainstation/object_spawner/low_chance
	spawn_chance = 50

/obj/effect/landmark/trainstation/object_spawner/very_low_chance
	spawn_chance = 20
