
/obj/item/gun/fuel_thrower
	name = "fuel flamethrower"
	icon_state = "flamethrowerbase"
	inhand_icon_state = "flamethrower_0"
	resistance_flags = FIRE_PROOF
	icon = 'icons/obj/weapons/flamethrower.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/flamethrower_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/flamethrower_righthand.dmi'
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
	var/max_fuel = 100
	var/fuel_consumption = 5
	var/datum/reagent/fuel_type = /datum/reagent/fuel

/obj/item/gun/fuel_thrower/update_icon_state()
	inhand_icon_state = "flamethrower_[lit]"
	return ..()

/obj/item/gun/fuel_thrower/update_overlays()
	. = ..()
	. += "+igniter1"
	. += "+ptank"
	if(lit)
		. += "+lit"

/obj/item/gun/fuel_thrower/attack_self(mob/user)
	lit = !lit
	if(lit)
		playsound(get_turf(src), 'sound/items/welderactivate.ogg', 50, TRUE)
	else
		playsound(get_turf(src), 'sound/items/welderdeactivate.ogg', 50, TRUE)
	set_light_on(lit)
	update_appearance(UPDATE_ICON)

/obj/item/gun/fuel_thrower/examine(mob/user)
	. = ..()
	. += "[reagents.total_volume] / [max_fuel] fuel loaded."

/obj/item/gun/fuel_thrower/Initialize(mapload)
	. = ..()
	desc = "A flamethrower that uses [initial(fuel_type.name)] as ammunition."
	chambered = new /obj/item/ammo_casing/flamer(src)
	create_reagents(max_fuel)
	reagents.add_reagent(fuel_type, max_fuel)

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
		var/obj/item/ammo_casing/flamer/casing = chambered
		casing.fuel_type = fuel_type
		casing.fuel_to_use = fuel_consumption
		chambered.newshot()

/obj/item/gun/magic/handle_chamber()
	if(chambered && !chambered.loaded_projectile) //if BB is null, i.e the shot has been fired...
		reagents.remove_reagent(fuel_type, fuel_consumption)
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

/obj/projectile/bullet/incendiary/fire/fuel_trail
	var/datum/reagent/fuel_type
	var/fuel_to_use = 20
	var/fuel_consumption = 1

/obj/projectile/bullet/incendiary/fire/fuel_trail/Move()
	. = ..()
	if(fuel_to_use <= 0)
		qdel(src)
		return
	var/turf/location = get_turf(src)
	if(location)
		fuel_to_use -= fuel_consumption
		var/obj/effect/decal/cleanable/fuel_pool/pool = location.spawn_unique_cleanable(/obj/effect/decal/cleanable/fuel_pool)
		pool.burn_amount = fuel_to_use

/obj/item/ammo_casing/flamer
	projectile_type = /obj/projectile/bullet/incendiary/fire/fuel_trail
