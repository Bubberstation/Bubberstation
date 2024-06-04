/obj/item/shield/big_bertha
	name = "Big Bertha"
	desc = "A shield so fat and heavy, it should block just about anything, as long as you have the satmina for it."
	icon = 'modular_zubbers/modules/big_bertha_shield/icons/shields.dmi'
	lefthand_file = 'modular_zubbers/modules/big_bertha_shield/icons/shields_both.dmi'
	righthand_file = 'modular_zubbers/modules/big_bertha_shield/icons/shields_both.dmi'
	icon_state = "big_bertha"
	block_chance = 100
	slot_flags = null
	force = 12
	throwforce = 3
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("shoves", "bashes","berthas")
	attack_verb_simple = list("shove", "bash","bertha")
	armor_type = /datum/armor/big_bertha
	block_sound = 'sound/weapons/block_shield.ogg'
	breakable_by_damage = FALSE
	item_flags = IMMUTABLE_SLOW | SLOWS_WHILE_IN_HAND
	slowdown = 2.5

/obj/item/shield/big_bertha/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)
	RemoveElement(/datum/element/disarm_attack)

/obj/item/shield/big_bertha/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)

	. = ..() //TRUE means it blocked.

	if(. && damage_type == BRUTE && damage > 10) //Most things that deal 10 or more damage are heavy, like toolboxes.
		var/owner_stamina_loss = owner.getStaminaLoss()
		var/knockdown_chance = (owner_stamina_loss + damage) - 100
		if(knockdown_chance > 0 && prob(knockdown_chance))
			var/turf/T = get_turf(src)
			owner.visible_message(
				span_warning("The force of [attack_text] from [hitby] knocks down [owner]!"),
				span_userdanger("The force of [attack_text] from [hitby] knocks you down!"),
				span_notice("You hear a loud thud!"),
				COMBAT_MESSAGE_RANGE
			)
			owner.Knockdown(2 SECONDS) //The shield saved you, but at what cost?
		owner.adjustStaminaLoss(-damage)


/datum/armor/big_bertha
	melee = 100
	bullet = 100
	laser = 75
	bomb = 50
	fire = 80
	acid = 70

/datum/area_spawn_over/big_bertha
	target_areas = list(
		/area/station/ai_monitored/security/armory,
		/area/station/ai_monitored/security/armory/upper
	)
	over_atoms = list(
		/obj/item/shield/riot
	)
	desired_atom = /obj/item/shield/big_bertha

/datum/area_spawn_over/big_bertha/New(...)
	. = ..()
	blacklisted_stations = null


