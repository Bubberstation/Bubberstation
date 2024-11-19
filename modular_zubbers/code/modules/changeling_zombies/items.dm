/obj/item/melee/arm_blade/changeling_zombie

	name = "prototype arm blade"

	force = 21 //Normally 25.

	wound_bonus = 0
	bare_wound_bonus = 0

	var/blood_chance = 100

	var/static/list/attack_living_sounds = list(
		'sound/hallucinations/growl1.ogg',
		'sound/hallucinations/growl2.ogg',
		'sound/hallucinations/growl3.ogg'
	)

	var/static/list/attack_inanimate_sounds = list(
		'sound/hallucinations/wail.ogg',
	)

	COOLDOWN_DECLARE(sound_cooldown)
	COOLDOWN_DECLARE(infection_cooldown)

/obj/item/melee/arm_blade/changeling_zombie/examine(mob/user)
	. = ..()
	if(blood_chance <= 0)
		. += span_warning("This variant is non-infectious.")
	else
		. += span_warning("Has a [blood_chance]% chance to infect when drawing blood on hit, with a [CHANGELING_ZOMBIE_REINFECT_DELAY/10] second cooldown.")

/obj/item/melee/arm_blade/changeling_zombie/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	if(COOLDOWN_FINISHED(src,sound_cooldown) && prob(length(attack_living_sounds)*25))
		playsound(src,pick(attack_living_sounds),50,TRUE,SOUND_RANGE*2)
		COOLDOWN_START(src, sound_cooldown, 3 SECONDS)

/obj/item/melee/arm_blade/changeling_zombie/attack_atom(atom/attacked_atom, mob/living/user, params)
	. = ..()
	if(COOLDOWN_FINISHED(src,sound_cooldown) && prob(length(attack_inanimate_sounds)*25))
		playsound(src,pick(attack_inanimate_sounds),50,TRUE,SOUND_RANGE*2)
		COOLDOWN_START(src, sound_cooldown, 3 SECONDS)


/obj/item/melee/arm_blade/changeling_zombie/add_mob_blood(mob/living/injected_mob)

	if(blood_chance <= 0) //Can't infect. Will still draw blood anyways.
		return ..()

	if(!injected_mob.stat && !prob(blood_chance)) //Alive mobs have additional checks.
		return

	. = ..()

	if(!.)
		return

	if(!ishuman(injected_mob))
		return

	if(!injected_mob.stat && !COOLDOWN_FINISHED(src,infection_cooldown))
		return

	COOLDOWN_START(src, infection_cooldown, CHANGELING_ZOMBIE_REINFECT_DELAY)

	var/mob/living/carbon/human/host = injected_mob

	if(can_become_changeling_zombie(host) && host.AddComponent(/datum/component/changeling_zombie_infection))
		var/mob/living/arm_user = src.loc
		if(istype(arm_user))
			var/datum/component/changeling_zombie_infection/component = arm_user.GetComponent(/datum/component/changeling_zombie_infection)
			if(component && component.infect_objective)
				component.infect_objective.total_infections += 1

/obj/item/clothing/suit/armor/changeling/prototype
	name = "prototype chitinous mass"
	armor_type = /datum/armor/armor_changeling_zombie

/datum/armor/armor_changeling_zombie
	melee = 15
	bullet = 15
	laser = 15
	energy = 25
	bomb = 5
	bio = 5
	fire = 0
	acid = 75
