/datum/design/board/minesweeper
	name = "Minesweeper Arcade Machine Board"
	desc = "Allows for the construction of circuit boards used to build a new arcade machine."
	id = "minesweeper"
	build_path = /obj/item/circuitboard/computer/arcade/minesweeper
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_ENTERTAINMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/board/mechpad_console
	name = "Mecha Orbital Pad Console Board"
	desc = "The circuit board for the console of the mecha orbital pad."
	id = "mechlauncher_console"
	build_path = /obj/item/circuitboard/computer/mechpad
	category = list(
		RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_RESEARCH
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE
