#define LOG_VIEWER_AUTHOR "author"
#define LOG_VIEWER_TIMESTAMP "timestamp"
#define LOG_VIEWER_MESSAGE "message"
#define LOG_VIEWER_NEED_RESTORE "needRestore"


/datum/computer_file/data/log_entry
	filetype = "MLOG"
	size = 1
	var/log_timestamp = ""
	var/log_author = ""
	var/log_message = ""
	var/corrupted = FALSE


/datum/computer_file/program/log_viewer
	filename = "logViewer"
	filedesc = "Log viewer"
	program_open_overlay = "text"
	extended_desc = "This program allows to view text logs."
	size = 0
	undeletable = TRUE
	power_cell_use = NONE
	program_flags = PROGRAM_HEADER | PROGRAM_RUNS_WITHOUT_POWER
	can_run_on_flags = PROGRAM_ALL
	tgui_id = "NTosTextLogViewer"
	program_icon = "comment-alt"

	var/list/logs = list()

	var/selected_log

/datum/computer_file/program/log_viewer/ui_data(mob/user)
	var/list/data = list()

	data["visible"] = TRUE
	for(var/datum/computer_file/data/log_entry/entry in computer.get_files(TRUE))
		data["messages"] += list(list(
			LOG_VIEWER_AUTHOR = entry.log_author,
			LOG_VIEWER_TIMESTAMP = entry.log_timestamp,
			LOG_VIEWER_MESSAGE = entry.log_message,
			LOG_VIEWER_NEED_RESTORE = entry.corrupted
		))
	return data

#undef LOG_VIEWER_AUTHOR
#undef LOG_VIEWER_TIMESTAMP
#undef LOG_VIEWER_MESSAGE
#undef LOG_VIEWER_NEED_RESTORE
