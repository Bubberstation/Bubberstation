/mob/living/basic/bibberblub
	name = "Bibberblub"
	desc = "A horrible slimy little creature and a nuisence to all! Kill it before it lays eggs!"
	icon_state = "mouse_gray"
	icon_living = "mouse_gray"
	icon_dead = "mouse_gray_dead"
	held_state = "mouse_gray"

	maxHealth = 5
	health = 5
	density = FALSE
	pass_flags = PASSTABLE|PASSGRILLE|PASSMOB
	mob_size = MOB_SIZE_TINY
	can_be_held = TRUE
	held_w_class = WEIGHT_CLASS_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	faction = list(FACTION_MAINT_CREATURES)
	speed = 0.05

	var/datum/action/cooldown/hide/hide_ability

/mob/living/basic/bibberblub/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	hide_ability = new()
	hide_ability.Grant(src)

/mob/living/basic/bibberblub/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	if(istype(target, /obj/machinery/vending))
		raid_vendor(target)



/mob/living/basic/bibberblub/proc/raid_vendor(obj/machinery/vending/vendor)
	playsound(vendor, 'sound/machines/airlock/airlock_alien_prying.ogg', 10, TRUE)
	if(!do_after(src, 3 SECONDS, vendor))
		return
	var/datum/data/vending_product/record = pick(vendor.product_records)
	var/obj/item/spoils = vendor.dispense(record, get_turf(vendor))
	var/turf/throw_at = get_ranged_target_turf_direct(vendor, src, 7, rand(-60,60))
	if(spoils.safe_throw_at(throw_at, rand(2,4), rand(1,3), src, spin = TRUE))
		playsound(get_turf(src), 'sound/items/weapons/punchmiss.ogg', 10)
