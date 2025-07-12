/*
Lever Rifle
*/

/obj/item/gun/energy/laser/thermal
	// How much of the cell we recharge per 'crank'.
	var/cell_recharge_amount = LASER_SHOTS(8, STANDARD_CELL_CHARGE)
	// The interaction delay before we crank the gun.
	var/recharge_time =  0.8 SECONDS
	// Whether or not we spin our gun
	var/spin_the_gun = TRUE

/obj/item/gun/energy/laser/thermal/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS)
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		spin_to_win = spin_the_gun, \
		charge_amount = cell_recharge_amount, \
		cooldown_time = recharge_time, \
		charge_sound = 'sound/items/weapons/kinetic_reload.ogg', \
		charge_sound_cooldown_time = 0.8 SECONDS, \
	)

//EspeciallyStrange's Freedom Motif here

//Some background. Me and anne had a crackhead idea of, what if you could recharge thermal pistol
// While moving... So, here it is, you can do that.
/obj/item/gun/energy/laser/thermal/lever //the common parent of these guns, it just shoots hard bullets, somoene might like that?
	name = "Winchester ELA"
	desc = "The frontier is crawling with danger.  The Kepler 'Winchester ELA' was born from a requirement to cheaply arm colonists\
	combined with rewoken nostalgia for the old west. Produced in house by Nanotrasen, the Winchester II uses a lever action to charge it's internal cell,\
	which then discharges a single shot. A punchy, affordable and simple weapon that evokes old school self reliance.\
	A perfect companion piece on the wagon trail to the stars.."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/kepler_energy_research/gun48x32.dmi'
	icon_state = "lever"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/nanite/inferno/lever, /obj/item/ammo_casing/energy/nanite/cryo/lever)
	shaded_charge = TRUE
	ammo_x_offset = 1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	modifystate = TRUE
	shaded_charge = FALSE
	cell_recharge_amount = LASER_SHOTS(1, STANDARD_CELL_CHARGE)
	recharge_time = 1 SECONDS
	spin_the_gun = FALSE

/obj/item/gun/energy/laser/thermal/lever/attack_self_secondary(mob/user, modifiers)
	if(ammo_type.len > 1 && can_select)
		select_fire(user)
	return ..()

/obj/item/gun/energy/laser/thermal/lever/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.combat_mode && isliving(interacting_with))
		return ITEM_INTERACT_SKIP_TO_ATTACK // Gun bash / bayonet attack

	if(ammo_type.len > 1 && can_select)
		select_fire(user)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/gun/energy/laser/thermal/lever/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(ammo_type.len > 1 && can_select)
		select_fire(user)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/gun/energy/laser/lever/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_KERI)

/obj/item/gun/energy/laser/lever/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 5, offset_y = 20)
