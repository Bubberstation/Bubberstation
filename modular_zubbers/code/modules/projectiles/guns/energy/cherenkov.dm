/obj/item/gun/energy/event_horizon
	name = "\improper Event Horizon anti-existential beam rifle"
	desc = "Nanotrasen developed experimental weapons platform for accelerating heated sub-atomic particles at near-lightspeed by utilizing a\
	blackhole generator to accelerate them past an immense gravitational field. Keep your fingers away from the barrel during firing.\
	Might cause unexpected spaggetification"

/obj/projectile/beam/event_horizon
	damage = HUMAN_HEALTH_MODIFIER * 100
	damage_type = BRUTE
	armor_flag = ENERGY
	range = 150
	jitter = 5 SECONDS

/obj/item/gun/energy/laser/cherenkov //the common parent of these guns, it just shoots hard bullets, somoene might like that?
	name = "nanite pistol"
	desc = "A modified handcannon with a metamorphic reserve of decommissioned weaponized nanites. Spit globs of angry robots into the bad guys."
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/nanite)
	shaded_charge = TRUE
	ammo_x_offset = 1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_GIGANTIC
	can_charge = FALSE
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "esniper"
	worn_icon_state = null
	fire_sound = 'sound/items/weapons/beam_sniper.ogg'
	var/pulse = 0
	var/cooldown = 0
	var/pulseicon = "plutonium_core_pulse"

/obj/item/gun/energy/laser/cherenkov/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS) //WHAT DO YOU MEAN YOU EMP'D THE NUCLEAR REACTOR? FIX IT, OR YOU'RE BOTH FIRED!
	AddComponent( \
		/datum/component/crank_recharge, \
		charging_cell = get_cell(), \
		charge_amount = 300, \
		cooldown_time = 5 SECONDS, \
		charge_sound = 'sound/items/weapons/laser_crank.ogg', \
		charge_sound_cooldown_time = 1 SECONDS )
	START_PROCESSING(SSobj, src)

/obj/item/gun/energy/laser/cherenkov/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/gun/energy/laser/cherenkov/process()
    if(cooldown < world.time - 60)
        cooldown = world.time
        if(cell && cell.charge >= cell.maxcharge)
            flick(pulseicon, src)
            if(istype(loc, /mob/living)) // Check if the gun is held by a mob
                var/mob/living/holder = loc
                to_chat(holder, span_alert("You feel the air around the rifle growing warm... Ruh roh"))
            radiation_pulse(src, max_range = 2, threshold = RAD_EXTREME_INSULATION)
