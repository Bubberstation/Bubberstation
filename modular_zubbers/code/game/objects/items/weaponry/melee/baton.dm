/obj/item/melee/baton/security/staff
	name = "stun staff"
	desc = "An advanced Secure Apprehension Device in the form of a quarterstaff. Debatably more effective at incapacitating targets."
	icon = 'modular_zubbers/icons/obj/weapons/baton.dmi'
	icon_state = "stunstaff"
	base_icon_state = "stunstaff"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_righthand.dmi'
	inhand_icon_state = "stunstaff"
	worn_icon = "modular_zubbers/icons/mob/clothing/back.dmi"
	worn_icon_state = "stunstaff"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	convertible = FALSE

	block_chance = 50 //functionally a side-grade to a riot shield and baton, cannot block projectiles and is worse against tackles in exchange for being unbreakable and cool and marginally statistically better
	block_sound = 'sound/items/weapons/genhit.ogg'
	stamina_damage = 65 //marginally better at stamcritting
	stun_armour_penetration = 20 //ditto
	force = 14 //bigger batong, downs in ~8 instead of 10
	throwforce = 8

/obj/item/melee/baton/security/staff/Initialize(mapload) //because it'd honestly be too much of a headache (for me) to make it activate/deactivate when wielded/unwielded especially since the way the game checks for the cell.
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/obj/item/melee/baton/security/staff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == LEAP_ATTACK)
		final_block_chance -= 35 //It's still worse than a shield and a baton but it's for the cool factor and to not make it that terrible in comparison
	if(attack_type == PROJECTILE_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a staff to a gunfight, and also you aren't going to really block a road roller, if one happened to hit you.
	return ..()

/obj/item/melee/baton/security/staff/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/staff/add_deep_lore()
	return

/obj/item/melee/baton/security/staff/prime
	name = "heroic stun staff"
	desc = "An absolutely brutal feat of non-lethal engineering.  Definitely more effective at incapacitating targets."
	icon_state = "stunstaff" //no custom sprite yet
	base_icon_state = "stunstaff"
	inhand_icon_state = "stunstaff"
	worn_icon_state = "stunstaff"

	block_chance = 75 //security desword
	block_sound = 'sound/items/weapons/genhit.ogg'
	stamina_damage = 40 //less stamina damage but oh lord it stuns twice as fast (funny enough same damage as the desword too)
	stun_armour_penetration = 35 //same as desword
	force = 15
	throwforce = 10
	knockdown_time = 2.5 SECONDS //half the knockdown
	cooldown = 1.25 SECONDS //half the cooldown

/obj/item/melee/baton/security/staff/prime/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == LEAP_ATTACK)
		final_block_chance -= 37.5
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance -= 25 
	if(attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0
	return ..()
