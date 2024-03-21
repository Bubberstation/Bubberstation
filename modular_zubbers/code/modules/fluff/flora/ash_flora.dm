/obj/structure/flora/ash/cacti
	can_uproot = TRUE

/obj/structure/flora/attackby(obj/item/used_item, mob/living/user, params)
	if(user.combat_mode)
		return ..()
	if(flags_1 & HOLOGRAM_1)
		to_chat(user, "Your [used_item] goes right through \the [src]!")
		return ..()
	if(can_uproot && used_item.tool_behaviour == TOOL_SHOVEL)
		if(uprooted)
			if(locate(/obj/structure/flora) in (loc.contents - src))
				to_chat(user, span_warning("There's already a plant here!"))
				return

			user.visible_message(
				span_notice("[user] starts to replant [src]..."),
				span_notice("You start to replant [src]...")
			)
			used_item.play_tool_sound(src, 50)
			if(!do_after(user, harvest_time, src) || locate(/obj/structure/flora) in (loc.contents - src))
				return

			user.visible_message(
				span_notice("[user] replants [src]."),
				span_notice("You replant [src].")
			)
			replant()
		else
			user.visible_message(
				span_notice("[user] starts to uproot [src]..."),
				span_notice("You start to uproot [src]...")
			)
			used_item.play_tool_sound(src, 50)
			if(!do_after(user, harvest_time, src))
				return

			user.visible_message(
				span_notice("[user] uproots [src]."),
				span_notice("You uproot [src].")
			)
			uproot()

		used_item.play_tool_sound(src, 50)
		return

	if(!can_harvest(user, used_item))
		return ..()

	user.visible_message(
		span_notice("[user] starts to [harvest_verb] [src]..."),
		span_notice("You start to [harvest_verb] [src] with [used_item]...")
	)
	play_attack_sound(used_item.force)
	if(!do_after(user, harvest_time * used_item.toolspeed, src))
		return
	visible_message(span_notice("[user] [harvest_verb][harvest_verb_suffix] [src]."), ignored_mobs = list(user))
	play_attack_sound(used_item.force)

	if(harvest(user))
		after_harvest(user)

/obj/structure/flora/ash/cacti/uproot(mob/living/user)
	. = ..()
	qdel(GetComponent(/datum/component/caltrop))

/obj/structure/flora/ash/cacti/replant(mob/living/user)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 3, max_damage = 6, probability = 70)

