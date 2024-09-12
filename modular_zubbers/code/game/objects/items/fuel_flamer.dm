
/obj/item/gun/fuel_thrower
	name = "fuel flamethrower"
	icon_state = "fuel_flamer"
	inhand_icon_state = "fuel_flamer"
	w_class = WEIGHT_CLASS_HUGE
	resistance_flags = FIRE_PROOF
	icon = 'modular_zubbers/icons/obj/weapons/guns/fuel_flamer.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/fuel_flamer_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/fuel_flamer_righthand.dmi'
	fire_sound = null
	suppressed_sound = null
	fire_delay = 0.3 SECONDS
	spread = 10
	force = 3
	throwforce = 10
	throw_speed = 1
	throw_range = 3
	light_on = FALSE
	light_system = OVERLAY_LIGHT
	light_color = LIGHT_COLOR_FLARE
	light_range = 2
	light_power = 2
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	var/lit = FALSE
	var/max_fuel = 200
	var/fuel_consumption = 5
	var/datum/reagent/fuel_type = /datum/reagent/fuel

/obj/item/gun/fuel_thrower/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)
	desc = "A flamethrower that uses [lowertext(initial(fuel_type.name))] as ammunition."
	chambered = new /obj/item/ammo_casing/flamer(src)
	create_reagents(max_fuel)
	reagents.add_reagent(fuel_type, max_fuel)
	update_appearance(ALL)

/obj/item/gun/fuel_thrower/update_icon_state()
	icon_state = "[initial(icon_state)][lit]"
	inhand_icon_state = "[initial(inhand_icon_state)][lit]"
	return ..()

/obj/item/gun/fuel_thrower/attack_self(mob/user)
	lit = !lit
	update_state(lit)

/obj/item/gun/fuel_thrower/proc/update_state(on = TRUE)
	lit = on
	if(lit)
		playsound(get_turf(src), 'sound/items/welderactivate.ogg', 50, TRUE)
		do_sparks(1, FALSE, src)
	else
		playsound(get_turf(src), 'sound/items/welderdeactivate.ogg', 50, TRUE)

	set_light_on(lit)
	update_appearance(UPDATE_ICON)

/obj/item/gun/fuel_thrower/examine(mob/user)
	. = ..()
	. += "[reagents.total_volume] / [max_fuel] fuel loaded."

/obj/item/gun/fuel_thrower/apply_fantasy_bonuses(bonus)
	. = ..()
	max_fuel = modify_fantasy_variable("max_fuel", max_fuel, bonus, minimum = 1)
	reagents?.maximum_volume = max_fuel

/obj/item/gun/fuel_thrower/can_shoot()
	return lit && reagents.has_reagent(fuel_type, fuel_consumption)

/obj/item/gun/fuel_thrower/recharge_newshot()
	if(chambered && !chambered.loaded_projectile && reagents.has_reagent(fuel_type, fuel_consumption))
		if(!istype(chambered, /obj/item/ammo_casing/flamer))
			return
		chambered.newshot()

/obj/item/gun/fuel_thrower/handle_chamber()
	if(chambered && !chambered.loaded_projectile) //if BB is null, i.e the shot has been fired...
		if(reagents.has_reagent(fuel_type, fuel_consumption))
			reagents.remove_reagent(fuel_type, fuel_consumption)
		else
			update_state(FALSE)
		recharge_newshot()

/obj/item/gun/fuel_thrower/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(!istype(interacting_with, /obj/structure/reagent_dispensers/fueltank))
		return NONE
	if(reagents.has_reagent(fuel_type, max_fuel))
		to_chat(user, span_warning("The [src] is already full!"))
		return ITEM_INTERACT_BLOCKING
	if(!interacting_with?.reagents.has_reagent(fuel_type))
		to_chat(user, span_warning("The [interacting_with] is empty!"))
		return ITEM_INTERACT_BLOCKING
	playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
	interacting_with.reagents.trans_to(src, max_fuel, transferred_by = user)
	user.visible_message(span_notice("[user] refills [user.p_their()] [src]."), span_notice("You refill [src]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/fuel_thrower/syndicate
	max_fuel = 500 // pyro noises
	pin = /obj/item/firing_pin/implant/pindicate

/obj/projectile/bullet/incendiary/fire/fuel_trail
	name = "fuel trail"
	suppressed = SUPPRESSED_VERY
	range = 10
	hitsound_wall = null
	var/fuel_to_use = 10
	var/fuel_consumption = 1

/obj/projectile/bullet/incendiary/fire/fuel_trail/Move()
	. = ..()
	if(fuel_to_use <= 0)
		qdel(src)
		return
	var/turf/location = get_turf(src)
	if(location)
		range -= fuel_consumption
		var/obj/effect/decal/cleanable/fuel_pool/pool = location.spawn_unique_cleanable(/obj/effect/decal/cleanable/fuel_pool)
		pool.burn_amount = fuel_to_use

/obj/item/ammo_casing/flamer
	projectile_type = /obj/projectile/bullet/incendiary/fire/fuel_trail
