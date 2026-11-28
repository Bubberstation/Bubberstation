/obj/item/melee/arm_blade/changeling_zombie

	name = "prototype arm blade"

	force = 21 //Normally 25.

	wound_bonus = 0
	exposed_wound_bonus = 0

	var/blood_chance = 100

	var/static/list/attack_living_sounds = list(
		'sound/effects/hallucinations/growl1.ogg',
		'sound/effects/hallucinations/growl2.ogg',
		'sound/effects/hallucinations/growl3.ogg'
	)

	var/static/list/attack_inanimate_sounds = list(
		'sound/effects/hallucinations/wail.ogg',
	)

	COOLDOWN_DECLARE(sound_cooldown)
	COOLDOWN_DECLARE(infection_cooldown)

/obj/item/melee/arm_blade/changeling_zombie/examine(mob/user)
	. = ..()
	if(blood_chance <= 0)
		. += span_warning("This variant is non-infectious.")
	else
		. += span_warning("Has a [blood_chance]% chance to infect when drawing blood on hit, with a [CHANGELING_ZOMBIE_REINFECT_DELAY/10] second cooldown.")

/obj/item/melee/arm_blade/changeling_zombie/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(COOLDOWN_FINISHED(src, sound_cooldown) && prob(length(attack_living_sounds) * 25))
		playsound(src, pick(attack_living_sounds), 50, TRUE, SOUND_RANGE * 2)
		COOLDOWN_START(src, sound_cooldown, 3 SECONDS)
	if(.) // TRUE means we were blocked
		return
	if(blood_chance <= 0 || target_mob.stat == DEAD || !user) //Can't infect. Will still draw blood anyways.
		return
	var/final_force = CALCULATE_FORCE(src, attack_modifiers)
	if(final_force <= 0 || !ishuman(target_mob) || !COOLDOWN_FINISHED(src, infection_cooldown))
		return
	COOLDOWN_START(src, infection_cooldown, CHANGELING_ZOMBIE_REINFECT_DELAY)
	if(!prob(blood_chance))
		return
	if(!can_become_changeling_zombie(target_mob))
		target_mob.balloon_alert(user, "cannot infect")
		return
	var/mob/living/carbon/human/host = target_mob
	var/datum/component/changeling_zombie_infection/infection = host.AddComponent(/datum/component/changeling_zombie_infection)
	if(!infection)
		return
	target_mob.balloon_alert(user, "infected")
	var/datum/component/changeling_zombie_infection/component = user.GetComponent(/datum/component/changeling_zombie_infection)
	if(!component)
		return
	infection.was_changeling_husked = component.was_changeling_husked
	if(component.infect_objective)
		component.infect_objective.total_infections += 1

/obj/item/melee/arm_blade/changeling_zombie/attack_atom(atom/attacked_atom, mob/living/user, params)
	. = ..()
	if(COOLDOWN_FINISHED(src, sound_cooldown) && prob(length(attack_inanimate_sounds) * 25))
		playsound(src, pick(attack_inanimate_sounds), 50, TRUE, SOUND_RANGE * 2)
		COOLDOWN_START(src, sound_cooldown, 3 SECONDS)

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
