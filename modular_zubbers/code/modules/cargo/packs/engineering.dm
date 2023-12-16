/datum/supply_pack/engine/particle_accelerator
	name = "Particle Accelerator Crate"
	desc = "Crate containing parts required to build Particle Accelerator."
	cost = CARGO_CRATE_VALUE * 80
	access = ACCESS_CE
	contains = list(/obj/machinery/particle_accelerator/control_box,
					/obj/structure/particle_accelerator/end_cap,
					/obj/structure/particle_accelerator/power_box,
					/obj/structure/particle_accelerator/fuel_chamber,
					/obj/structure/particle_accelerator/particle_emitter/center,
					/obj/structure/particle_accelerator/particle_emitter/left,
					/obj/structure/particle_accelerator/particle_emitter/right
					)
	crate_name = "PA crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	dangerous = TRUE

/datum/supply_pack/engine/tesla_rod
	name = "Tesla Rod Crate"
	desc = "May god help us."
	cost = CARGO_CRATE_VALUE * 80
	access = ACCESS_CE
	contains = list(/obj/machinery/the_singularitygen/tesla
	)
	crate_name = "Tesla Rod Crate"
	crate_type = /obj/structure/closet/crate/secure/engineering
	dangerous = TRUE
