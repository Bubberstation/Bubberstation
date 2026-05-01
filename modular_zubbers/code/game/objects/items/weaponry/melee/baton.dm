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

	block_chance = 50 //functionally a side-grade to a riot shield and baton, cannot block projectiles and is worse against tackles in exchange for being unbreakable and cool
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
		final_block_chance -= 25 //It's still worse than a shield and a baton but it's for the cool factor and to not make it that terrible in comparison
	if(attack_type == PROJECTILE_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a staff to a gunfight, and also you aren't going to really block a road roller, if one happened to hit you.
	return ..()

/obj/item/melee/baton/security/staff/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/staff/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("You can [EXAMINE_HINT("look closer")] to learn a little more about [src]."), \
		lore = "The Secure Apprehension Device (sometimes referred to as the SAD in the officer training manuals) is \
		the unholy union of a mace and- hey wait a second this is just two batons strapped to each other inside a hollow casing!"
	)
