/obj/effect/accelerated_particle
	name = "Accelerated Particles"
	desc = "Small things moving very fast."
	icon = 'modular_zubbers/icons/obj/machines/particle_accelerator.dmi'
	icon_state = "particle"
	anchored = TRUE
	density = FALSE
	var/movement_range = 10
	var/energy = 10
	var/speed = 1

/obj/effect/accelerated_particle/weak
	movement_range = 8
	energy = 5

/obj/effect/accelerated_particle/strong
	movement_range = 15
	energy = 15

/obj/effect/accelerated_particle/powerful
	movement_range = 20
	energy = 50


/obj/effect/accelerated_particle/New(loc)
	..()

	addtimer(CALLBACK(src, PROC_REF(move)), 1)


/obj/effect/accelerated_particle/Bump(atom/A)
	if(A)
		if(isliving(A))
		else if(istype(A, /obj/machinery/singularitygen))
			var/obj/machinery/singularitygen/S = A
			S.energy += energy
		else if(istype(A, /obj/singularity))
			var/obj/singularity/S = A
			S.energy += energy
		else if(istype(A, /obj/structure/blob))
			var/obj/structure/blob/B = A
			B.take_damage(energy*0.6)
			movement_range = 0


/obj/effect/accelerated_particle/singularity_pull()
	return

/obj/effect/accelerated_particle/singularity_act()
	return


/obj/effect/accelerated_particle/proc/move()
	if(QDELETED(src))
		return
	if(!step(src,dir))
		forceMove(get_step(src,dir))
	if(movement_range == 0)
		qdel(src)
		return
	movement_range--
	addtimer(CALLBACK(src, PROC_REF(move)), speed)
