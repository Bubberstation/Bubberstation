/**
 * Called from subsystem's PreInit and builds sprite_accessories list with (almost) all existing sprite accessories
 */
/datum/controller/subsystem/accessories/proc/make_sprite_accessory_references()
	for(var/path in subtypesof(/datum/sprite_accessory))
		var/datum/sprite_accessory/P = path
		if(initial(P.key) && initial(P.name))
			P = new path()
			if(!sprite_accessories[P.key])
				sprite_accessories[P.key] = list()
			sprite_accessories[P.key][P.name] = P
