/obj/structure/spider/stickyweb/wirecutter_act(mob/living/user, obj/item/tool)
	. = ..()
	if(tool.use_tool(src, user, 1.5 SECONDS, volume = 50))
		if(QDELETED(src))
			return
		qdel(src)
