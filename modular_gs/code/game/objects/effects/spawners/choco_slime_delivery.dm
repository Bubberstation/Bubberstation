/obj/effect/spawner/chocoslime_delivery
	name = "choco slime delivery"
	icon = 'GainStation13/icons/mob/candymonster.dmi'
	icon_state = "a_c_slime"
	var/announcement_time = 2

/obj/effect/spawner/chocoslime_delivery/Initialize(mapload)
	..()
	var/turf/T = get_turf(src)

	new /mob/living/simple_animal/hostile/feed/chocolate_slime(T)
	new /obj/effect/temp_visual/gravpush(T)
	playsound(T, 'sound/items/party_horn.ogg', 50, 1, -1)

	message_admins("A choco slime has been delivered to [ADMIN_VERBOSEJMP(T)].")
	log_game("A choco slime has been delivered to [AREACOORD(T)]")
	var/message = "Attention [station_name()], we have entrusted you with a research specimen in [get_area_name(T, TRUE)]. Remember to follow all safety precautions when dealing with the specimen."
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_addtimer), CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(print_command_report), message), announcement_time))
	return INITIALIZE_HINT_QDEL



// spawner object used for mapping

/obj/effect/spawner/lootdrop/fiftypercent_chocoslimespawn
	name = "50% Chocolate Slime Spawn"
	loot = list(
		/obj/item/reagent_containers/food/snacks/chocolatebar = 70,
		/obj/effect/spawner/chocoslime_delivery = 30)
