/obj/effect/spawner/random/entertainment/arcade/Initialize(mapload)
	loot |= list(
		/obj/machinery/computer/arcade/minesweeper = 49,
	)
	loot[/obj/machinery/computer/arcade/amputation] += 1 // Increase this each time you add a new arcade machine
	. = ..()

