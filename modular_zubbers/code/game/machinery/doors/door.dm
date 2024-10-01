/obj/machinery/door/airlock/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	var/list/ais = GLOB.ai_list
	if(ais.len)
		for(var/mob/living/silicon/ai/AI as anything in ais)
			if(AI.stat == DEAD)
				continue
			if(AI.control_disabled)
				continue
			if(AI.deployed_shell)
				if(!is_station_level(AI.deployed_shell.registered_z))
					continue
				to_chat(AI.deployed_shell, "<b><a href='?src=[REF(AI)];track=[html_encode(user.name)]'>[user]</a></b> is requesting you to open <a href='?_src_=usr;open_door=[REF(src)];user=[REF(user)]'>\a [src]</a>")
			if(!is_station_level(AI.registered_z))
				continue
			to_chat(AI, "<b><a href='?src=[REF(AI)];track=[html_encode(user.name)]'>[user]</a></b> is requesting you to open <a href='?_src_=usr;open_door=[REF(src)];user=[REF(user)]'>\a [src]</a>")
