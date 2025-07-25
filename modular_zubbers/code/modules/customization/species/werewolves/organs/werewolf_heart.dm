/obj/item/organ/heart/werewolf
	name = "lupine heart"
	desc = "A large heart that beats powerfully. The veins on it are far larger than normal."

/obj/item/organ/heart/werewolf/on_mob_insert(mob/living/carbon/organ_owner, special)
	. = ..()
	if(!ishuman(organ_owner))
		return

	if(!iswerewolf(organ_owner)) // So non-werewolves don't get the damage reduction.
		return

	var/mob/living/carbon/human/human_owner = organ_owner

	RegisterSignal(human_owner, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(modify_damage))
	RegisterSignal(human_owner, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(do_block_effect))

/obj/item/organ/heart/werewolf/on_mob_remove(mob/living/carbon/organ_owner, special)
	. = ..()
	if(!ishuman(organ_owner) || QDELETED(organ_owner))
		return

	var/mob/living/carbon/human/human_owner = organ_owner

	UnregisterSignal(human_owner, list(COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, COMSIG_MOB_AFTER_APPLY_DAMAGE))

/**
 * Signal proc for [COMSIG_MOB_APPLY_DAMAGE_MODIFIERS]
 * Taken from the snail heart and modified for werewolves.
 * Reduces damage taken from brute + burn attacks.
 */
/obj/item/organ/heart/werewolf/proc/modify_damage(mob/living/carbon/human/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(damagetype = BRUTE)
		damage_mods += 0.5 // 50% damage resistance on brute attacks.
	else if(damagetype = BURN)
		damage_mods += 0.8 // 20% damage resistance on burn/energy attacks.
