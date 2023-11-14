/obj/item/melee/sabre/centcom
	name = "commander's sabre"
	desc = "An even more elegant weapon with a purer golden grip guard, with even rarer redwood wooden grip. The blade is made of plasteel infused gold, which makes it incredibly good at cutting."
	icon = 'modular_zubbers/icons/obj/weapons/melee/swords.dmi'
	icon_state = "cent_sabre"
	inhand_icon_state = "cent_sabre"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'

/obj/item/storage/belt/sabre/centcom/PopulateContents()
	new /obj/item/melee/sabre/centcom(src)
	update_appearance()
