//Port Tarkon Xeno Nests

/obj/structure/spawner/tarkon_xenos
	name = "infested warren"
	desc = "A deep tunnel that goes deeper than any light can reach. A distant roaring could be heard within..."
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	pressure_resistance = 200 //No more pressure cheating. Burn it and its reward or fight.
	max_integrity = 500
	max_mobs = 7
	spawn_time = 20 SECONDS
	mob_types = list(
		/mob/living/basic/alien/drone/tarkon,
		/mob/living/basic/alien/sentinel
	)
	spawn_text = "crawls out of"
	faction = list(ROLE_ALIEN)
	var/boss_mob = /mob/living/basic/alien/queen/large
	var/loot_drop = /obj/effect/mob_spawn/corpse/human/tarkon

/obj/structure/spawner/tarkon_xenos/atom_deconstruct(disassembled)
	var/obj/effect/nest_break/nest = new /obj/effect/nest_break(loc)
	nest.loot_drop = loot_drop
	nest.boss_mob = boss_mob
	return ..()

/obj/effect/nest_break
	name = "collapsing infested nest"
	desc = "Stop standing and get clear!"
	layer = TABLE_LAYER
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	icon_state = "hole"
	anchored = TRUE
	density = TRUE
	var/boss_mob = null
	var/loot_drop = null

/obj/effect/nest_break/proc/rustle()
	for(var/mob/M in range(7,src))
		shake_camera(M, 15, 1)
	playsound(get_turf(src),'sound/effects/explosion/explosionfar.ogg', 200, TRUE)
	visible_message(span_boldannounce("The nest's entrance starts to crumble before something charges forth!"))
	new boss_mob(loc)
	new loot_drop(loc)
	qdel(src)

/obj/effect/nest_break/Initialize(mapload)
	. = ..()
	visible_message(span_boldannounce("The nest rumbles violently as the entrance begins to crack and break apart!"))
	playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
	addtimer(CALLBACK(src, PROC_REF(rustle)), 5 SECONDS)
	do_jiggle_sr()

/obj/structure/spawner/tarkon_xenos/common
	name = "infested nest"
	desc = "A deep tunnel lined with weeds, something can be heard stirring within..."
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	max_integrity = 300
	max_mobs = 4
	spawn_time = 30 SECONDS
	boss_mob = /mob/living/basic/alien/queen
	loot_drop = /obj/effect/spawner/random/astrum/sci_loot/tarkon

/obj/structure/spawner/tarkon_xenos/minor
	name = "infested tunnel"
	desc = "A tunnel lined with weeds, something can be heard clicking deep within..."
	icon_state = "hole"
	icon = 'icons/mob/simple/lavaland/nest.dmi'
	max_integrity = 150
	max_mobs = 2
	spawn_time = 30 SECONDS
	mob_types = list(
		/mob/living/basic/alien/drone
	)
	boss_mob = /mob/living/basic/alien/sentinel
	loot_drop = /obj/effect/spawner/random/exotic/technology/tarkon

/obj/effect/spawner/random/astrum/sci_loot/tarkon
	name = "abductor scientist loot"
	loot = list(/obj/item/circular_saw/alien = 10,
				/obj/item/retractor/alien = 10,
				/obj/item/scalpel/alien = 10,
				/obj/item/hemostat/alien = 10,
				/obj/item/crowbar/abductor = 10,
				/obj/item/screwdriver/abductor = 10,
				/obj/item/wrench/abductor = 10,
				/obj/item/weldingtool/abductor = 10,
				/obj/item/crowbar/abductor = 10,
				/obj/item/wirecutters/abductor = 10,
				/obj/item/multitool/abductor = 10,
				)

/obj/effect/spawner/random/exotic/technology/tarkon
	spawn_loot_count = 1
