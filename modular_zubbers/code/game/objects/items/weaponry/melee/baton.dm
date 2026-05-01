/obj/item/melee/baton/security/staff
	name = "stun staff" 
	desc = "An advanced double-ended baton. Bulky, but good for enhanced stun applications."
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "stun_staff"
	base_icon_state = "stun_staff"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_righthand.dmi'
	inhand_icon_state = "stun_staff"
	worn_icon = ""
	worn_icon_state = "stun_staff"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY

	var/block_chance = 50 //functionally a side-grade to a riot shield and baton, but is worse overall in exchange for being unbreakable and cool
	stamina_damage = 65 //marginal increase because staff
	force = 13 //bigger batong
	throw_force = 10

/obj/item/melee/baton/security/staff/Initialize(mapload) //because it'd honestly be too much of a headache to make it activate/deactivate when wielded/unwielded especially since the way the game checks for the cell.
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/obj/item/melee/baton/security/staff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == LEAP_ATTACK)
		final_block_chance -= 25 //It's still worse than a shield and a baton but it's for the cool factor and to not make it that terrible in comparison
	if(attack_type == PROJECTILE_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a staff to a gunfight, and also you aren't going to really block a road roller, if one happened to hit you.
	return ..()
