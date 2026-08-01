/obj/item/foam_baton
	name = "foam force baton"
	desc = "A foam truncheon for beating criminal scum."
	icon = 'modular_zubbers/icons/obj/weapons/foam_melee.dmi'
	icon_state = "foam_baton"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "foam_baton"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'
	inhand_icon_state = "foam_baton"
	force = 3 //basically harmless
	throwforce = 1
	force_string = "robust-ish"
	w_class = WEIGHT_CLASS_NORMAL
	damtype = STAMINA

/obj/item/foam_baton/sword
	name = "foam force claymore"
	desc = "What are you standing around staring at this for? Get to whacking!"
	icon_state = "foam_sword"
	inhand_icon_state = "foam_sword"
	worn_icon_state = "foam_sword"
	force = 5
	throwforce = 3
	force_string = "robustn't"

/obj/item/foam_baton/sword/traitor
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "This foam force sword has had a lightweight lead core put in place within the foam blade, giving a lot more weight to your strikes. \
					Additionally provides minor ability to block incoming attacks. Not usable as a bludgeon though."
	force = 30
	throwforce = 20
	force_string = "robust?"
	block_chance = 25

/obj/item/foam_baton/sword/traitor/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0
	return ..()
