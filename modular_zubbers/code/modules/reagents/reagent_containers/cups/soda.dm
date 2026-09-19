//Soda Modular File for Bubber
////Add your custom sodas here, use this first one as a reference if you want

/obj/item/reagent_containers/cup/soda_cans/bubber/blood_tea
	name = "Hemoglobin Iced Tea"
	desc = "Kinda like that rich golfer, but it's actually blood!"
	icon_state = "blood_tea"
	list_reagents = list(/datum/reagent/consumable/icetea/blood_tea = 25, /datum/reagent/consumable/ethanol/bloodshot = 5)

/obj/item/reagent_containers/cup/soda_cans/bubber/tangorine_soda
	name = "Tang-O-Rine"
	desc = "A refreshing blend of tangerine juice with a bubbly fizz. The soda can features a vibrant orange and green Teshari mascot."
	icon_state = "tangorine_soda"
	drink_type = SUGAR | FRUIT
	list_reagents = list(/datum/reagent/consumable/orangejuice = 20, /datum/reagent/consumable/sodawater = 10)

//CODING SIN BYOND HERE - This is reusing some code from 'code/modules/reagents/reagent_containers/cups/soda.dm' to crush cans and to throw it. Subtype moment.

/obj/item/trash/can/bubber
	icon = 'modular_zubbers/icons/obj/janitor.dmi'
	icon_state = "tangorine_soda"

/*
*	BUBBER SODA CANS
*/

/// How much fizziness is added to the can of soda by throwing it, in percentage points
#define SODA_FIZZINESS_THROWN 15
/// How much fizziness is added to the can of soda by shaking it, in percentage points
#define SODA_FIZZINESS_SHAKE 5

/obj/item/reagent_containers/cup/soda_cans/bubber
	icon = 'modular_zubbers/icons/obj/drinks/soda.dmi'
	icon_state = null

/obj/item/reagent_containers/cup/soda_cans/bubber/attack(mob/M, mob/living/user)
	if(istype(M, /mob/living/carbon) && !reagents.total_volume && user.combat_mode && user.zone_selected == BODY_ZONE_HEAD)
		if(M == user)
			user.visible_message(span_warning("[user] crushes the can of [src] on [user.p_their()] forehead!"), span_notice("You crush the can of [src] on your forehead."))
		else
			user.visible_message(span_warning("[user] crushes the can of [src] on [M]'s forehead!"), span_notice("You crush the can of [src] on [M]'s forehead."))
		playsound(M,'sound/items/weapons/pierce.ogg', rand(10,50), TRUE)
		var/obj/item/trash/can/bubber/crushed_can = new /obj/item/trash/can/bubber(M.loc)
		crushed_can.icon_state = icon_state
		qdel(src)
		return TRUE
	. = ..()

/obj/item/reagent_containers/cup/soda_cans/bubber/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()

	if(. != BULLET_ACT_HIT)
		return

	if(hitting_projectile.damage > 0 && hitting_projectile.damage_type == BRUTE && !QDELETED(src))
		var/obj/item/trash/can/bubber/crushed_can = new /obj/item/trash/can/bubber(src.loc)
		crushed_can.icon_state = icon_state
		var/atom/throw_target = get_edge_target_turf(crushed_can, pick(GLOB.alldirs))
		crushed_can.throw_at(throw_target, rand(1,2), 7)
		qdel(src)
		return

/**
 * Burst the soda open on someone. Fun! Opens and empties the soda can, but does not crush it.
 *
 * Arguments:
 * * target - Who's getting covered in soda
 * * hide_message - Stops the generic fizzing message, so you can do your own
 */

/obj/item/reagent_containers/cup/soda_cans/bubber/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(. || !reagents.total_volume) // if it was caught, already opened, or has nothing in it
		return

	fizziness += SODA_FIZZINESS_THROWN
	if(!prob(fizziness))
		return

	burst_soda(hit_atom, hide_message = TRUE)
	visible_message(span_danger("[src]'s impact with [hit_atom] causes it to rupture, spilling everywhere!"))
	var/obj/item/trash/can/bubber/crushed_can = new /obj/item/trash/can/bubber(src.loc)
	crushed_can.icon_state = icon_state
	moveToNullspace()
	QDEL_IN(src, 1 SECONDS) // give it a second so it can still be logged for the throw impact

#undef SODA_FIZZINESS_THROWN
#undef SODA_FIZZINESS_SHAKE
