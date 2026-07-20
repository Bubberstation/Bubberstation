/obj/item/gun/energy/syndie_raygun
	name = "ray gun"
	desc = "A dubious energy emitter with a small folding crank. Specifically targets the selected organ, causing rapid decay and internal damage. \
		Side effects include dizziness, slurred speech, stuttered speech, minor toxic buildup, fatigue, and the aforementioned organ damage. \
		Neatly fits into a pocket, but is overall kinda bulky."
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_NORMAL
	ammo_type = list(
		/obj/item/ammo_casing/energy/syndie_raygun/heart,
		/obj/item/ammo_casing/energy/syndie_raygun/liver,
		/obj/item/ammo_casing/energy/syndie_raygun/lungs,
		/obj/item/ammo_casing/energy/syndie_raygun/stomach,
		/obj/item/ammo_casing/energy/syndie_raygun/brain,
		/obj/item/ammo_casing/energy/syndie_raygun/sensory,
		/obj/item/ammo_casing/energy/syndie_raygun/appendix,
		/obj/item/ammo_casing/energy/syndie_raygun/random
	)

/obj/item/gun/energy/syndie_raygun/Initialize(mapload)
	. = ..()
	name = pick("ray gun", "death ray", "syndicate death ray", "debilitation ray", "ray of sickness", "organ-fucker X7")
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = STANDARD_CELL_CHARGE * 0.05, \
		cooldown_time = 3 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 2.8 SECONDS, \
		charge_move = IGNORE_USER_LOC_CHANGE, \
	)
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS, allow_akimbo = FALSE)
