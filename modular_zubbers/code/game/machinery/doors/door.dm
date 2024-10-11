#define LINK_DENY "<a href='?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=deny'>\a (deny)</a>"
#define LINK_OPEN "<a href='?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=open'>\a (open)</a>"
#define LINK_BOLT "<a href='?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=bolt'>\a (bolt)</a>"
#define LINK_SHOCK "<a href='?_src_=usr;open_door=[REF(src)];user=[REF(user)];action=shock'>\a (shock)</a>"

/obj/machinery/door/airlock
	//so the AI doesn't get spammed
	COOLDOWN_DECLARE(answer_cd)
	/// List of ai door requesters
	var/static/list/requesters = list()

/obj/machinery/door/airlock/attack_hand_secondary(mob/living/user, list/modifiers)
	if(world.time < requesters[user.name] + 10 SECONDS)
		to_chat(user, span_warning("Hold on, let the AI parse your request."))
		return
	. = ..()

	if(!hasPower())
		to_chat(user, span_warning("This door isn't powered."))
		return

	src.balloon_alert(user, "AI requested")

	for(var/mob/living/silicon/ai/AI as anything in GLOB.ai_list)
		if(AI.stat == DEAD)
			continue
		if(AI.control_disabled)
			continue
		if(AI.deployed_shell)
			if(!is_station_level(AI.deployed_shell.registered_z))
				continue
			to_chat(AI.deployed_shell, "<b><a href='?src=[REF(AI)];track=[html_encode(user.name)]'>[user]</a></b> is requesting you to open the [src] [LINK_DENY][LINK_OPEN][LINK_BOLT][LINK_SHOCK]")
		if(!is_station_level(AI.registered_z))
			continue
		to_chat(AI, "<b><a href='?src=[REF(AI)];track=[html_encode(user.name)]'>[user]</a></b> is requesting you to open the [src] [LINK_DENY][LINK_OPEN][LINK_BOLT][LINK_SHOCK]")
	requesters[user.name] = world.time

#undef LINK_DENY
#undef LINK_OPEN
#undef LINK_BOLT
#undef LINK_SHOCK
