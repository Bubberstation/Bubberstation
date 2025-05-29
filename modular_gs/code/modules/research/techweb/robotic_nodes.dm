//////////////////////////////
/////Any new robotic nodes////
//////////////////////////////

/datum/techweb_node/ipc_tech
	id = "ipc_tech"
	display_name = "IPC. parts"
	description = "IPC. parts research."
	prereq_ids = list("biotech")
	design_ids = list("ipc_eyes", "ipc_stomach", "ipc_heart", "ipc_liver", "ipc_ears", "ipc_tongue", "ci-power-cord" )
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
