/*
Lever Rifle
*/

/obj/item/gun/energy/laser/lever //the common parent of these guns, it just shoots hard bullets, somoene might like that?
	name = "hardlight rifle"
	desc = "The frontier is crawling with danger.  The Kepler 'Winchester ELA' was born from a requirement to cheaply arm colonists\
	combined with rewoken nostalgia for the old west. Produced in house by Nanotrasen, the Winchester II uses a lever action to charge it's internal cell,\
	which then discharges a single shot. A punchy, affordable and simple weapon that evokes old school self reliance.\
	A perfect companion piece on the wagon trail to the stars.."
	icon_state = "infernopistol"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/nanite)
	shaded_charge = TRUE
	ammo_x_offset = 1
	obj_flags = UNIQUE_RENAME

/obj/item/gun/energy/laser/lever/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KERI)

/obj/item/gun/energy/laser/lever/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 5, offset_y = 20)

/obj/item/gun/energy/laser/lever/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS)
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = STANDARD_CELL_CHARGE, \
		cooldown_time = 2 SECONDS, \
		charge_sound = 'sound/items/weapons/kinetic_reload.ogg', \
		charge_sound_cooldown_time = 0.8 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)
