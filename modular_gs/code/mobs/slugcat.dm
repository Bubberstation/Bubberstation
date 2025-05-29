/mob/living/simple_animal/pet/slugcat
	name = "slugcat"
	desc = "It's a cat . . . Thing from another planet, maybe from another world. You think it's not dangerous, but you can't be sure. "
	icon = 'GainStation13/icons/mob/pets.dmi'
	icon_state = "slugcat"
	icon_living = "slugcat"
	icon_dead = "slugcat_dead"
	emote_see = list("stares at the ceiling.", "shivers.")
	speak_chance = 1
	turns_per_move = 20
	can_be_held = TRUE
	see_in_dark = 6
	ventcrawler = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	minbodytemp = 200
	maxbodytemp = 400
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 2)
	unsuitable_atmos_damage = 0.5
	animal_species = /mob/living/simple_animal/pet/slugcat
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "kicks"
	gold_core_spawnable = FRIENDLY_SPAWN
	attack_sound = 'sound/effects/attackblob.ogg'
	do_footstep = TRUE
	gold_core_spawnable = FRIENDLY_SPAWN
	size_multiplier = 0.5
	obj_damage = 0
	melee_damage_lower = 0
	melee_damage_upper = 0
	var/held_icon = "slugcat"
	do_footstep = TRUE
	//lizard food
	vore_flags = DEVOURABLE | DIGESTABLE | FEEDING
	var/obj/item/spear/weapon

/mob/living/simple_animal/pet/slugcat/Initialize(mapload)
	. = ..()
	add_verb(src, /mob/living/proc/lay_down)

/mob/living/simple_animal/pet/slugcat/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "purrs!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "hisses!", EMOTE_AUDIBLE)
	AddElement(/datum/element/mob_holder, held_icon)

/mob/living/simple_animal/pet/slugcat/update_mobility()
	..()
	if(client && stat != DEAD)
		if (resting)
			icon_state = "[icon_living]_rest"
		else
			icon_state = "[icon_living]"
	regenerate_icons()

/mob/living/simple_animal/pet/slugcat/UnarmedAttack(atom/A)
	. = ..()
	if(!isitem(A))
		return

	if(!weapon && istype(A, /obj/item/spear))
		visible_message("<span class='notice'>[src] pick up the [A].</span>", "<span class='notice'>You pick up the [A].</span>")
		weapon = A
		weapon.forceMove(src)
		melee_damage_lower = weapon.force + weapon.force_wielded
		melee_damage_upper = weapon.force + weapon.force_wielded
		armour_penetration = weapon.armour_penetration
		melee_damage_type = weapon.damtype
		attack_sound = weapon.hitsound
		update_icons()
	else if(!weapon && !istype(A, /obj/item/spear))
		to_chat(src, "<span class='warning'>You do not know how to wield the [A]!</span>")

/mob/living/simple_animal/pet/slugcat/RangedAttack(atom/A, params)
	. = ..()
	if(!weapon)
		return
	visible_message("<span class='warning'>[src] throws the [weapon] at [A]!</span>","<span class='warning'>You throw the [weapon] at [A]!</span>")
	melee_damage_lower = initial(melee_damage_lower)
	melee_damage_upper = initial(melee_damage_upper)
	armour_penetration = initial(armour_penetration)
	melee_damage_type = initial(melee_damage_type)
	attack_sound = initial(attack_sound)
	weapon.forceMove(get_turf(src))
	weapon.throw_at(A, weapon.throw_range, weapon.throw_speed, src)
	weapon = null
	update_icons()

/mob/living/simple_animal/pet/slugcat/update_icons()
	. = ..()
	if(stat == DEAD || resting)
		return
	icon_state = weapon ? initial(icon_state) + "_spear" : initial(icon_state)

/mob/living/simple_animal/pet/slugcat/death(gibbed)
	if(weapon)
		weapon.forceMove(get_turf(src))
		weapon = null
	update_icons()
	. = ..()

/mob/living/simple_animal/pet/slugcat/attack_ghost(mob/user)
	if(key)
		return
	if(CONFIG_GET(flag/use_age_restriction_for_jobs))
		if(!isnum(user.client.player_age))
			return
	if(!SSticker.mode)
		to_chat(user, "Can't become a slugcat before the game has started.")
		return
	var/be_scug = alert("Become a slugcat? (Warning, You can no longer be cloned!)",,"Yes","No")
	if(be_scug == "No" || QDELETED(src) || !isobserver(user))
		return
	sentience_act()
	key = user.key

