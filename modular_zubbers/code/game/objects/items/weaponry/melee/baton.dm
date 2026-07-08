/obj/item/melee/baton/security/staff
	name = "stun staff"
	desc = "An advanced Secure Apprehension Device in the form of a quarterstaff. Debatably more effective at incapacitating targets."
	icon = 'modular_zubbers/icons/obj/weapons/baton.dmi'
	icon_state = "stunstaff"
	base_icon_state = "stunstaff"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/staves_righthand.dmi'
	inhand_icon_state = "stunstaff"
	worn_icon = 'modular_zubbers/icons/mob/clothing/back.dmi'
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

/obj/item/melee/baton/security/staff/attack(mob/target, mob/living/carbon/human/user)
	..()
	if(prob(50))
		INVOKE_ASYNC(src, PROC_REF(jedi_spin), user)

/obj/item/melee/baton/security/staff/proc/jedi_spin(mob/living/user)
	dance_rotate(user, CALLBACK(user, TYPE_PROC_REF(/mob, dance_flip)))

/obj/item/melee/baton/security/staff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == LEAP_ATTACK)
		final_block_chance -= 30 //It's still worse than a shield and a baton but it's for the cool factor and to not make it that terrible in comparison
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance -= 40 //Don't rely on this.
	if(attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a staff to a road roller roller fight.
	return ..()

/obj/item/melee/baton/security/staff/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/staff/add_deep_lore()
	return

/obj/item/melee/baton/security/staff/prime
	name = "\improper Magna-staff"
	desc = "An absolutely brutal feat of less-lethal engineering. The unique construction allows it to recharge between shocks incredibly quickly. Definitely more effective at incapacitating targets and posesses exceptional blocking capabilities."
	icon_state = "stunstaff_prime"
	base_icon_state = "stunstaff_prime"
	inhand_icon_state = "stunstaff_prime"
	worn_icon_state = "stunstaff_prime"

	block_chance = 75 //security desword
	block_sound = 'sound/items/weapons/genhit.ogg'
	stamina_damage = 24 //way less stamina damage but oh lord it attacks fast
	stun_armour_penetration = 35 //same as desword
	force = 15
	throwforce = 10
	throw_stun_chance = 75
	throw_range = 6
	cell_hit_cost = STANDARD_CELL_CHARGE * 4 //guzzler. It's overcharged, what do you expect?
	knockdown_time = 0.5 SECONDS //one tenth the knockdown
	cooldown = 0 SECONDS //as fast as you can attack (probably)

	light_color = LIGHT_COLOR_FLARE

/obj/item/melee/baton/security/staff/prime/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range + 2, TRUE)

/obj/item/melee/baton/security/staff/prime/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == LEAP_ATTACK)
		final_block_chance -= 45 //effective 30
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance -= 25  //effective 50
	if(attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0
	return ..()

/obj/item/melee/baton/security/staff/prime/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/bluespace
