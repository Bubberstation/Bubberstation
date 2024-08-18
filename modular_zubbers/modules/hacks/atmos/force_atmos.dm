
SUBSYSTEM_DEF(force_atmos)
	name = "Atmospherics Forcer"
	init_order = INIT_ORDER_AIR
	priority = FIRE_PRIORITY_AIR
	wait = 1 SECONDS
	flags =  SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	can_fire = FALSE // VAREDIT to make atmos actually forcefully run

/datum/controller/subsystem/force_atmos/fire()
	if(can_fire)
		SSair.fire() // holy shitcode, batman

GLOBAL_VAR(atmos_is_broken)

/proc/atmos_is_broke()

	if(GLOB.atmos_is_broken) // end/start this all by varediting the global var atmos_is_broken
		SSair.fire()
		sleep(2 SECONDS) // We don't even trust the MC for timing. How did it get so bad? Overly complicated problems? Simple solutions. Horrible!
		atmos_is_broke() // RECURSIVE OH NO
