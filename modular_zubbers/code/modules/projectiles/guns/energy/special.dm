/obj/item/gun/energy/ionrifle/precision
	name = "precision ion rifle"
	desc = "The MK.III Prototype Ion \'Precisor\' is a more advanced version of the original MK.I ion rifle, \
	built to be be more charge capacity and precision, ensuring less collateral damage when hitting targets. \
	Comes with a 2-burst fire selector and a built-in scope for the professionals."

	icon = 'modular_zubbers/icons/obj/weapons/guns/precision_ion.dmi'
	icon_state = "ionrifle"

	shaded_charge = TRUE
	w_class = WEIGHT_CLASS_HUGE
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BACK

	ammo_type = list(/obj/item/ammo_casing/energy/ion/precision)

	burst_size = 2
	fire_delay = 2

	actions_types = list(/datum/action/item_action/toggle_firemode)

	cell_type = /obj/item/stock_parts/power_store/cell/high // STANDARD_CELL_CHARGE * 10

	var/burst_fire_selection = FALSE

/obj/item/gun/energy/ionrifle/precision/Initialize(...)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1)

//Code stolen from Skyrat burst fire code.
//Not sure why they applied this to ballistic subtype and not all the gun subtypes.
/obj/item/gun/energy/ionrifle/precision/ui_action_click(mob/user, actiontype)

	if(istype(actiontype, /datum/action/item_action/toggle_firemode))
		burst_select()
		return

	. = ..()

/obj/item/gun/energy/ionrifle/precision/proc/burst_select()
	var/mob/living/carbon/human/user = usr
	burst_fire_selection = !burst_fire_selection
	if(!burst_fire_selection)
		burst_size = 1
		fire_delay = 1
		balloon_alert(user, "switched to semi-automatic")
	else
		burst_size = initial(burst_size)
		fire_delay = initial(fire_delay)
		balloon_alert(user, "switched to [burst_size]-round burst")

	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)

	update_item_action_buttons()

/obj/item/ammo_casing/energy/ion/precision
	fire_sound = 'modular_zubbers/sound/weapons/gun/ion/shot.ogg'
	projectile_type = /obj/projectile/ion/weak
	e_cost = LASER_SHOTS(14, STANDARD_CELL_CHARGE * 10)
