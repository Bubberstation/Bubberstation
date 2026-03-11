//This effectively prevents any runtimes with creating machines early and deleting them early when doing loadout generation.
//Feels awfully shitty to do this but the alternative is overhauling the entire loadout system and changing how that interacts with other subsystems and that's a fucking nightmare.

/datum/controller/subsystem/machines/unregister_machine(obj/machinery/machine)
	var/list/existing = machines_by_type[machine.type]
	if(existing)
		existing -= machine
		if(!length(existing))
			machines_by_type -= machine.type
	if(all_machines)
		all_machines -= machine
