//Strikes the target with a lightning bolt, killing them instantly.
/datum/smite/lightning_instant_death
	name = "Lightning Bolt (Instant Death)"
	var/ouchie = 600

/datum/smite/lightning_instant_death/effect(client/user, mob/living/target)
	. = ..()
	to_chat(target, span_userdanger("The gods have punished you for your sins!"), confidential = TRUE)

	var/turf/lightning_source = get_step(get_step(target, NORTH), NORTH)
	lightning_source.Beam(target, icon_state="lightning[rand(1,12)]", time = 5)
	lightning_source.Beam(target, icon_state="lightning[rand(1,12)]", time = 5.1)
	lightning_source.Beam(target, icon_state="lightning[rand(1,12)]", time = 5.2)
	target.adjust_fire_loss(ouchie)
	playsound(target, 'sound/effects/magic/lightningbolt.ogg', 100, TRUE)
	playsound(target, 'sound/items/weapons/zapbang.ogg', 40, TRUE)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		human_target.electrocution_animation(LIGHTNING_BOLT_ELECTROCUTION_ANIMATION_LENGTH)

//Explodes our victim into gibs and explosive fire after a short delay.
/datum/smite/lightning_instant_death/explosive_gib
	name = "Lightning Bolt (Explosive Gib)"
	ouchie = 100

/datum/smite/lightning_instant_death/explosive_gib/effect(client/user, mob/living/target)
	. = ..()
	target.Stun(3 SECONDS, ignore_canstun = TRUE)
	addtimer(CALLBACK(src, PROC_REF(delayed_effect), user, target), 2.5 SECONDS, TIMER_UNIQUE)

/datum/smite/lightning_instant_death/explosive_gib/delayed_effect(client/user, mob/living/target)
	new /obj/effect/temp_visual/explosion/fast(target.loc)
	explosion(target, devastation_range = -1, heavy_impact_range = -1, light_impact_range = 2, flame_range = 3)
	target.gib(DROP_ORGANS|DROP_BODYPARTS)
