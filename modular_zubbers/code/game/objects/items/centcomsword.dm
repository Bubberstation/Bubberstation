/obj/item/melee/sabre/centcom
	name = "Commander's sabre"
	desc = "An even more elegant weapon with a purer golden grip guard, with even rarer redwood wooden grip. The blade is made of plasteel infused gold, which makes it incredibly good at cutting."
	icon = 'modular_zubbers/icons/obj/weapons/melee/swords.dmi'
	icon_state = "cent_sabre"
	inhand_icon_state = "cent_sabre"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	force = 15
	throwforce = 10
	demolition_mod = 0.75 //but not metal
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 50
	armour_penetration = 75
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	block_sound = 'sound/weapons/parry.ogg'
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	wound_bonus = 10
	bare_wound_bonus = 25

/obj/item/storage/belt/sabre/centcom/PopulateContents()
	new /obj/item/melee/sabre/centcom(src)
	update_appearance()
