/// Come on, I gotta do SOME stupid reference or else it isn't funny. Plus I need to make it for later.
/obj/item/toy/faustian_doll
	name = "doll"
	desc = "Typically speaking, toys don't have faustian, teleporting-for-lifeforce bargains built into them. \
	This one, however, does - and it's not quite clear how much life it thirsts for."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "assistant"

/obj/item/toy/faustian_doll/attack_self(mob/user as mob)
	var/turf/T = find_safe_turf(zlevels=SSmapping.levels_by_trait(ZTRAIT_STATION))

	playsound(src, 'sound/effects/screech.ogg', 70)
	if(T)
		var/atom/movable/AM = user.pulling
		if(AM)
			AM.forceMove(T)
		user.forceMove(T)
		if(AM)
			user.start_pulling(AM)
		to_chat(user, span_notice("You blink and find yourself in [get_area_name(T)]."))
	else
		to_chat(user, "Nothing happens. You feel that this is a bad sign.")
	if(istype(user, /mob/living))
		var/mob/living/guy_who_is_totally_screwed = user
		guy_who_is_totally_screwed.apply_damage(rand((guy_who_is_totally_screwed.health * 0.5),guy_who_is_totally_screwed.health))
	balloon_alert(user, "[src] crumbles!")
	qdel(src)
