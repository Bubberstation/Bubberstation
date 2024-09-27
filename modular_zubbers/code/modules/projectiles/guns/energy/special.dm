/obj/item/gun/energy/ionrifle/precision
	name = "precision ion rifle"
	desc = "The MK.III Prototype Ion \'Precisor\' is a slightly smaller version of the larger ion rifle, \
	built to be be more precise and ensure less collateral damage when hitting targets. \
	Has a built in burst fire mode, or single target firemode if you're feeling professional."

	icon = 'modular_zubbers/icons/obj/weapons/guns/precision_ion.dmi'
	icon_state = "ion"


	fire_sound = 'modular_zubbers/sound/weapons/gun/precision_ion/shot.ogg'

	inhand_icon_state = null
	worn_icon_state = null
	shaded_charge = TRUE
	w_class = WEIGHT_CLASS_HUGE
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK

	ammo_type = list(/obj/item/ammo_casing/energy/ion/hos)

	burst_size = 3
	fire_delay = 2

	actions_types = list(/datum/action/item_action/toggle_firemode)
