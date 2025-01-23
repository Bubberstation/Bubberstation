
/obj/effect/spawner/random/techstorage/rnd_all/Initialize(mapload)
	loot += list(
		/obj/item/circuitboard/computer/nanite_chamber_control,
		/obj/item/circuitboard/computer/nanite_cloud_controller,
		/obj/item/circuitboard/machine/nanite_chamber,
		/obj/item/circuitboard/machine/nanite_programmer,
		/obj/item/circuitboard/machine/nanite_program_hub,
		/obj/item/circuitboard/computer/scan_consolenew,
	)
	. = ..()
