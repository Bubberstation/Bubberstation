
//it's a crusher that the ashwalkers can make. Has the same stats as a default one, it's just made from monster parts.

/obj/item/kinetic_crusher/ashwalker
	name = "Necropolis greatsword"
	desc = "A massive blade of bone, imbued with demonic energy through runes carved along the blade. \
	Made of monsters, by killing monsters, for killing even more monsters than ever."
	lefthand_file = 'modular_zubbers/icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon = 'modular_zubbers/icons/obj/mining.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/backpack.dmi'
	icon_state = "crusher-ashwalker"
	inhand_icon_state = "crusher0"
	armour_penetration = 15
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'
	attack_verb_continuous = list("slashes", "cleaves", "chops", "rends", "stabs", "gores", "cuts")
	attack_verb_simple = list("slash", "cleave", "chop", "rend", "stab", "gore", "cut")

