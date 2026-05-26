/mob/living/basic/bibberblub
	name = "Bibberblub"
	desc = "A horrible slimy little creature and a nuisence to all! Kill it before it lays eggs!"
	icon = 'modular_zubbers/icons/bibberblub/bibberblub.dmi'
	icon_state = "Bibberblub"

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

	speak_emote = list("blorbles")
	bubble_icon = "slime"
	initial_language_holder = /datum/language_holder/slime

	verb_say = "blorbles"
	verb_ask = "inquisitively blorbles"
	verb_exclaim = "loudly blorbles"
	verb_yell = "loudly blorbles"

	///Amount of reagents taken per bite
	var/bite_consumption = 1
	///The starting reagents of whatever food we are currently eating
	var/list/current_food_reagents

	var/datum/action/cooldown/hide/hide_ability
	var/datum/action/cooldown/bibberblub_reproduce/reproduction_ability
	var/datum/action/cooldown/spell/pointed/hamster/hamster_stuff

	//building abilities
	var/datum/action/cooldown/bubberblub_structures/slimy_floor/build_slime_floor
	var/datum/action/cooldown/bubberblub_structures/compost_hole/build_compost

	var/nutriment_resource = 0
	var/protein_resource = 0
	var/vitamin_resource = 0

	/// TRUE while the capsaicin debuff loop is running
	var/capsaicin_active = FALSE
	var/capsaicin_poisoning = 0


/mob/living/basic/bibberblub/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	hide_ability = new()
	hide_ability.Grant(src)

	hamster_stuff = new()
	hamster_stuff.Grant(src)

	reproduction_ability = new()
	reproduction_ability.Grant(src)

	build_slime_floor = new()
	build_slime_floor.Grant(src)

	build_compost = new()
	build_compost.Grant(src)

/mob/living/basic/bibberblub/death(gibbed)
	. = ..()
	hamster_stuff.expell_hamstered()
	qdel(src)



/mob/living/basic/bibberblub/examine(mob/user)
	. = ..()
	if (user == src)
		. += "You have the following resources:"
		. += "[nutriment_resource] Nutriment"
		. += "[protein_resource] Protein"
		. += "[vitamin_resource] Vitamin"

/mob/living/basic/bibberblub/death(gibbed)
	. = ..()

/mob/living/basic/bibberblub/melee_attack(atom/target, list/modifiers, ignore_cooldown)
	if(istype(target, /obj/machinery/vending))
		raid_vendor(target)
	if(istype(target, /obj/item/food))
		consume_food(target)
	if(istype(target, /obj/item/storage))
		empty_container(target)



/mob/living/basic/bibberblub/proc/raid_vendor(obj/machinery/vending/vendor)
	playsound(vendor, 'sound/machines/airlock/airlock_alien_prying.ogg', 50, TRUE)
	if(!do_after(src, 3 SECONDS, vendor))
		return
	var/datum/data/vending_product/record = pick(vendor.product_records)
	var/obj/item/spoils = vendor.dispense(record, get_turf(vendor))
	var/turf/throw_at = get_ranged_target_turf_direct(vendor, src, 7, rand(-60,60))
	if(spoils.safe_throw_at(throw_at, rand(2,4), rand(1,3), src, spin = TRUE))
		playsound(get_turf(src), 'sound/items/weapons/punchmiss.ogg', 10)

/mob/living/basic/bibberblub/proc/empty_container(obj/item/storage/container)
	//toss out everything in here
	for(var/obj/item/thing in container.contents)
		if(!do_after(src, 0.5 SECONDS, container))
			return
		container.quick_remove_item(thing, src, FALSE)
		var/turf/throw_at = get_ranged_target_turf_direct(container, src, 7, rand(-60,60))
		if(thing.safe_throw_at(throw_at, rand(2,4), rand(1,3), src, spin = TRUE))
			playsound(get_turf(src), 'sound/items/weapons/punchmiss.ogg', 10)
	to_chat(src, span_red("The container is empty!"))



/mob/living/basic/bibberblub/proc/consume_food(obj/item/food/our_lunch)
	to_chat(src, span_red("You nibble on \the [our_lunch]"))
	if(!do_after(src, 2 SECONDS, our_lunch))
		return
	take_bite(our_lunch)


/mob/living/basic/bibberblub/proc/take_bite(obj/item/food/our_lunch)
	playsound(src, 'sound/items/eatfood.ogg', rand(10,50), TRUE)
	if(!our_lunch.reagents)
		return

	var/remaining_bite = bite_consumption
	// Copy the list so removal during iteration doesn't explode
	for(var/datum/reagent/consumed as anything in shuffle(our_lunch.reagents.reagent_list.Copy()))

		if(remaining_bite <= 0)
			break

		var/amount_to_consume = min(consumed.volume, remaining_bite)

		process_reagent(consumed.type, amount_to_consume)

		our_lunch.reagents.remove_reagent(consumed.type, amount_to_consume)

		remaining_bite -= amount_to_consume


	if(!our_lunch.reagents.total_volume)
		if(!isnull(our_lunch.trash_type))
			new our_lunch.trash_type(get_turf(our_lunch))
		qdel(our_lunch)
		return

	//Conditions for stopping eating early
	if(QDELETED(our_lunch))
		return

	if(!Adjacent(our_lunch))
		return

	if(capsaicin_active)
		return

	consume_food(our_lunch)

/mob/living/basic/bibberblub/proc/process_reagent(reagent_type, amount)

	// Vitamins
	if(ispath(reagent_type, /datum/reagent/consumable/nutriment/vitamin))
		vitamin_resource += amount
		return

	// Protein
	if(ispath(reagent_type, /datum/reagent/consumable/nutriment/protein))
		protein_resource += amount
		return

	// Capsaicin
	if(ispath(reagent_type, /datum/reagent/consumable/capsaicin))
		capsaicin_poisoning += (amount * 10 SECONDS)

		if(!capsaicin_active)
			INVOKE_ASYNC(src, PROC_REF(handle_capsaicin))

		return

	// Any other nutriment subtype
	if(ispath(reagent_type, /datum/reagent/consumable/nutriment))
		nutriment_resource += amount


/mob/living/basic/bibberblub/proc/handle_capsaicin()
	capsaicin_active = TRUE
	balloon_alert(src, "too spicy!!")
	// Apply heavy slowdown
	add_movespeed_modifier(/datum/movespeed_modifier/bibberblub_capsaicin)
	while(capsaicin_poisoning > 0 && stat != DEAD)
		// Shake/jitter
		do_jitter_animation(5)
		// Occasional coughing
		if(prob(50))
			emote("cough")
		// Tiny bit of visible suffering
		if(prob(20))
			visible_message(span_warning("[src] writhes from the spicy food!"))

		if(prob(50))
			nutriment_resource -= min(nutriment_resource, 1)
			protein_resource -= min(protein_resource, 1)
			vitamin_resource -= min(vitamin_resource, 1)
		sleep(1 SECONDS)
		capsaicin_poisoning -= 1 SECONDS

	// Cleanup
	remove_movespeed_modifier(/datum/movespeed_modifier/bibberblub_capsaicin)

	capsaicin_active = FALSE

	balloon_alert(src, "finally recovered")

/datum/movespeed_modifier/bibberblub_capsaicin
	multiplicative_slowdown = 8
