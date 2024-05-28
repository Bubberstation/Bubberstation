/obj/item/melee/arm_blade_zombie

	name = "prototype arm blade"
	desc = "A grotesque blade made out of bone and flesh that cleaves through people as a hot knife through butter."

	icon = 'modular_zubbers/code/modules/changeling_zombies/icons/items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	lefthand_file = 'modular_zubbers/code/modules/changeling_zombies/icons/inhand_left.dmi'
	righthand_file = 'modular_zubbers/code/modules/changeling_zombies/icons/inhand_right.dmi'

	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

	force = 21 // Just enough to break airlocks with melee attacks
	armour_penetration = 25
	wound_bonus = -30
	bare_wound_bonus = 15
	demolition_mod = 2 //So it can actually destroy airlocks.

	w_class = WEIGHT_CLASS_HUGE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL

	hitsound = SFX_SWING_HIT
	sharpness = SHARP_EDGED


	var/static/list/attack_living_sounds = list(
		'sound/hallucinations/growl1.ogg',
		'sound/hallucinations/growl2.ogg',
		'sound/hallucinations/growl3.ogg'
	)

	var/static/list/attack_inanimate_sounds = list(
		'sound/hallucinations/wail.ogg',
	)

	COOLDOWN_DECLARE(sound_cooldown)

/obj/item/melee/arm_blade_zombie/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, \
		speed = 3 SECONDS, \
		effectiveness = 95, \
		bonus_modifier = 5, \
	)

/obj/item/melee/arm_blade_zombie/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	if(COOLDOWN_FINISHED(src,sound_cooldown) && prob(length(attack_living_sounds)*25))
		playsound(src,pick(attack_living_sounds),50,TRUE,SOUND_RANGE*2)
		COOLDOWN_START(src, sound_cooldown, 3 SECONDS)

/obj/item/melee/arm_blade_zombie/attack_atom(atom/attacked_atom, mob/living/user, params)
	. = ..()
	if(COOLDOWN_FINISHED(src,sound_cooldown) && prob(length(attack_inanimate_sounds)*25))
		playsound(src,pick(attack_inanimate_sounds),50,TRUE,SOUND_RANGE*2)
		COOLDOWN_START(src, sound_cooldown, 3 SECONDS)


/obj/item/melee/arm_blade_zombie/add_mob_blood(mob/living/injected_mob)

	. = ..()

	if(!.)
		return

	if(!ishuman(injected_mob))
		return

	var/mob/living/carbon/human/host = injected_mob

	if(can_become_changeling_zombie(host) && host.AddComponent(/datum/component/changeling_zombie_infection))
		var/mob/living/arm_user = src.loc
		if(istype(arm_user))
			var/datum/component/changeling_zombie_infection/component = arm_user.GetComponent(/datum/component/changeling_zombie_infection)
			if(component && component.infect_objective)
				component.infect_objective.total_infections += 1

/obj/item/clothing/suit/armor/changeling_zombie

	name = "prototype chitinous mass"
	desc = "A tough, hard covering of black chitin."

	icon = 'modular_zubbers/code/modules/changeling_zombies/icons/armor.dmi'
	icon_state = "lingarmor"

	worn_icon = 'modular_zubbers/code/modules/changeling_zombies/icons/armor_worn.dmi'

	armor_type = /datum/armor/armor_changeling_zombie

	w_class = WEIGHT_CLASS_HUGE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL

/datum/armor/armor_changeling_zombie
	melee = 20
	bullet = 20
	laser = 20
	energy = 25
	bomb = 5
	bio = 5
	fire = 45
	acid = 45
