/atom/movable/proc/get_alt_name()

/atom/movable/virtualspeaker
	var/realvoice

/atom/movable/virtualspeaker/get_voice(add_id_name)
	if(add_id_name && realvoice)
		return realvoice
	else
		return "[src]"

