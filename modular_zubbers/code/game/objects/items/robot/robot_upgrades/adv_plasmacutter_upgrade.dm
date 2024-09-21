/obj/item/gun/energy/plasmacutter/brg // Plasma cutter for Mining cyborg, recharges on power.
	name = "advanced plasma cutter"
	icon_state = "adv_plasmacutter"
	inhand_icon_state = "adv_plasmacutter"
	force = 15
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/brg)
	use_cyborg_cell = TRUE

/obj/item/ammo_casing/energy/plasma/brg
	projectile_type = /obj/projectile/plasma/adv
	delay = 10
	e_cost = 300 // This is based off of the cyborgs cell, soo each shot costs 300 power, needs balance checks

/obj/item/borg/upgrade/advcutter
	name = "mining cyborg advanced plasma cutter"
	desc = "An upgrade for the mining cyborgs plasma cutter, bringing it to advanced operation."
	icon_state = "module_miner"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER

/obj/item/borg/upgrade/advcutter/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/gun/energy/plasmacutter/brg/AC = locate() in R.model.modules
		if(AC)
			to_chat(user, span_warning("This unit is already equipped with A plasma Cutter!"))
			return FALSE
		AC = new(R.model)
		R.model.basic_modules += AC
		R.model.add_module(AC, FALSE, TRUE)

/obj/item/borg/upgrade/advcutter/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/gun/energy/plasmacutter/brg/AC in R.model.modules)
			R.model.remove_module(AC, TRUE)


