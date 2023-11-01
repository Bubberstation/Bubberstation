/datum/computer_file/program/flappy_moth
	filename = "flappymoth"

	filedesc = "Nanotrasen Micro Game: Flappy Moth"
	extended_desc = "Guide the moth through several obstacles and reach the BIG LAMP (Big lamp not included)"
	category = PROGRAM_CATEGORY_GAME

	requires_ntnet = FALSE
	size = 4 //By all means less complex than minesweeper

	tgui_id = "ZubbersFlappyMoth"

	program_icon_state = "arcade"
	program_icon = "gamepad"

	var/obj/item/modular_computer/host

/datum/computer_file/program/flappy_moth/ui_data(mob/user)
	var/list/data = list()
	data["difficulty"] = 1

	return data

/*
/datum/computer_file/program/flappy_moth/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id)
*/

/datum/computer_file/program/flappy_moth/ui_act(action, list/params, mob/user)
	. = ..()
	if(.)
		return

	switch(action)
		if("win")
			complete(win = TRUE)
		if("lose")
			complete(win = FALSE)

/datum/computer_file/program/flappy_moth/proc/complete(win)
	computer.say("Somehow you won at flappy moth")
