/obj/item/reagent_containers/cup/endless_flask //Thankfully this is automatically excluded in silver slime extracts.
	name = "water from the Nile"
	desc = "Excuse me a minute. Water from the Nile. Nile water. Heh."

	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_flasks.dmi'
	icon_state = "health"

	fill_icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_flasks_fillings.dmi'
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)

	volume = 30

	var/amount_to_create = 1 //Every 2 seconds.
	var/datum/reagent/reagent_to_create = /datum/reagent/water //Fallback

///Stolen from plubming code.
/obj/item/reagent_containers/cup/endless_flask/create_reagents(max_vol, flags)
	. = ..()
	name = "endless flask of [initial(reagent_to_create.name)]"
	desc = "An endless magical flask that refills over time. This one produces [initial(reagent_to_create.name)] at a rate of [amount_to_create]u every [SSobj.wait/10] seconds, up to a maximum of [reagents.maximum_volume]."
	START_PROCESSING(SSobj,src)

/// Handles properly detaching signal hooks.
/obj/item/reagent_containers/cup/endless_flask/on_reagents_del(datum/reagents/reagents)
	. = ..()
	UnregisterSignal(reagents, list(COMSIG_REAGENTS_ADD_REAGENT, COMSIG_REAGENTS_NEW_REAGENT, COMSIG_REAGENTS_REM_REAGENT, COMSIG_REAGENTS_DEL_REAGENT, COMSIG_REAGENTS_CLEAR_REAGENTS, COMSIG_REAGENTS_REACTED, COMSIG_QDELETING))


/obj/item/reagent_containers/cup/endless_flask/on_reagent_change()
	. = ..()
	START_PROCESSING(SSobj,src)


/obj/item/reagent_containers/cup/endless_flask/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/reagent_containers/cup/endless_flask/process(seconds_per_tick)

	if(!reagents || !reagent_to_create || amount_to_create <= 0) //uhhh
		STOP_PROCESSING(SSobj, src)
		return

	var/desired_amount = min(1, reagents.maximum_volume - reagents.total_volume)
	if(desired_amount <= 0)
		STOP_PROCESSING(SSobj, src)
		return

	reagents.add_reagent(reagent_to_create,desired_amount)


/obj/item/reagent_containers/cup/endless_flask/vitfro
	reagent_to_create = /datum/reagent/consumable/vitfro
	icon_state = "health"

/obj/item/reagent_containers/cup/endless_flask/saturnx
	reagent_to_create = /datum/reagent/drug/saturnx
	icon_state = "evasion"


/obj/item/reagent_containers/cup/endless_flask/blastoff
	reagent_to_create = /datum/reagent/drug/blastoff
	icon_state = "speed"


/obj/item/reagent_containers/cup/endless_flask/determination
	reagent_to_create = /datum/reagent/determination
	icon_state = "armor"


/obj/item/reagent_containers/cup/endless_flask/random
	reagent_to_create = null
	icon_state = "phasing"

/obj/item/reagent_containers/cup/endless_flask/random/New(...)
	reagent_to_create = get_random_reagent_id()
	. = ..()

/obj/item/reagent_containers/cup/endless_flask/burger
	icon_state = "health"

/obj/item/reagent_containers/cup/endless_flask/burger/New(...)
	reagent_to_create = pick(/datum/reagent/consumable/bbqsauce,/datum/reagent/consumable/mayonnaise,/datum/reagent/consumable/salt,/datum/reagent/consumable/capsaicin,/datum/reagent/consumable/ketchup,/datum/reagent/consumable/soysauce)
	. = ..()