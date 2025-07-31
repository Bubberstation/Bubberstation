/obj/item/melee/sabre/luna
	name = "Luna"
	desc = "Forged by a madwoman, in recognition of a time, a place - she thought almost real. Various etchings of moons are inscribed onto the surface, different phases marking different parts of the blade."
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/items_and_weapons.dmi'
	lefthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"
	inhand_icon_state = "luna"

/obj/machinery/vending/security/noaccess
	req_access = null
	allow_custom = FALSE

/obj/structure/closet/secure_closet/medical2/unlocked/Initialize(mapload)
	. = ..()
	locked = FALSE
	update_appearance()
