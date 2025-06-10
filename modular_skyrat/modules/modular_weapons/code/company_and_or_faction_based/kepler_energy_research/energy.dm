/*
Lever Rifle
*/

/obj/item/gun/energy/laser/lever //the common parent of these guns, it just shoots hard bullets, somoene might like that?
	name = "hardlight rifle"
	desc = "A high velocity slugthrower created by kepler energy research."
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
		spin_to_win = TRUE, \
		charge_amount = STANDARD_CELL_CHARGE,  \
		cooldown_time = 0.1 SECONDS, \
		charge_sound = 'sound/items/weapons/kinetic_reload.ogg', \
		charge_sound_cooldown_time = 0.6 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE
	)
