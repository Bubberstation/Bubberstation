PROCESSING_SUBSYSTEM_DEF(moving_turfs)
	name = "Moving turfs"
	wait = 0.1 SECONDS
	stat_tag = "MT"
	flags = SS_NO_INIT

	var/list/all_simulated_turfs = list()
	var/list/to_process = list()

/datum/controller/subsystem/processing/moving_turfs/proc/register(turf/open/moving/T)
	if(T in all_simulated_turfs)
		return
	all_simulated_turfs += T

/datum/controller/subsystem/processing/moving_turfs/proc/unregister(turf/open/moving/T)
	all_simulated_turfs -= T


/datum/controller/subsystem/processing/moving_turfs/proc/on_train_start()
	to_process = null
	for(var/turf/open/moving/T as anything in all_simulated_turfs)
		T.moving = TRUE
		T.update_appearance()
		T.check_process(register = TRUE)

/datum/controller/subsystem/processing/moving_turfs/proc/on_train_stop()
	for(var/turf/open/moving/T as anything in all_simulated_turfs)
		T.moving = FALSE
		T.update_appearance()
	to_process = null

/datum/controller/subsystem/processing/moving_turfs/proc/queue_process(turf/open/moving/T)
	if(!to_process)
		to_process = list()
	if(to_process[T])
		return
	to_process[T] = TRUE

/datum/controller/subsystem/processing/moving_turfs/proc/unqueue_process(turf/open/moving/T)
	if(to_process[T])
		to_process -= T

/datum/controller/subsystem/processing/moving_turfs/fire()
	if(!SStrain_controller.is_moving() || SStrain_controller.loading)
		return
	INVOKE_ASYNC(src, PROC_REF(process_turfs))

/datum/controller/subsystem/processing/moving_turfs/proc/process_turfs()
	set background = TRUE
	for(var/turf/open/moving/turf in to_process)
		turf.process_contents(wait * 0.1)
	CHECK_TICK
