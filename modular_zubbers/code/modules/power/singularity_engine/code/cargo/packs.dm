/datum/supply_pack/engine/collector
	name = "Radiation Collector Crate"
	desc = "Contains three radiation collectors. Useful for collecting energy off nearby Supermatter Crystals, Singularities or Teslas!"
	cost = CARGO_CRATE_VALUE * 8
	contains = list(
		/obj/machinery/power/energy_accumulator,
		/obj/machinery/power/energy_accumulator,
		/obj/machinery/power/energy_accumulator,
	)
	crate_name = "collector crate"

/datum/supply_pack/engine/particle_accelerator
	name = "Particle Accelerator Crate"
	desc = "A supermassive black hole or hyper-powered teslaball are the perfect way to spice up any party! This \"My First Apocalypse\" kit contains everything you need to build your own Particle Accelerator! Ages 10 and up."
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/obj/structure/particle_accelerator/fuel_chamber,
					/obj/machinery/particle_accelerator/control_box,
					/obj/structure/particle_accelerator/particle_emitter/center,
					/obj/structure/particle_accelerator/particle_emitter/left,
					/obj/structure/particle_accelerator/particle_emitter/right,
					/obj/structure/particle_accelerator/power_box,
					/obj/structure/particle_accelerator/end_cap)
	crate_name = "particle accelerator crate"

/datum/supply_pack/engine/sing_gen
	name = "Singularity Generator Crate"
	desc = "The key to unlocking the power of Lord Singuloth. Particle Accelerator not included."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/machinery/singularity_generator)
	crate_name = "singularity generator crate"

/datum/supply_pack/engine/tesla_gen
	name = "Tesla Generator Crate"
	desc = "The key to unlocking the power of the Tesla energy ball. Particle Accelerator not included."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/machinery/singularity_generator/tesla)
	crate_name = "tesla generator crate"
