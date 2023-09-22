#define SATCHEL_TC_LIMIT 2

/datum/controller/subsystem/traitor

	var/list/smuggler_satchel_contraband = list(
		/obj/item/reagent_containers/crackbrick,
		/obj/item/reagent_containers/crack,
		/obj/item/reagent_containers/cocaine,
		/obj/item/reagent_containers/cocainebrick,
		/obj/item/reagent_containers/hashbrick,
		/obj/item/reagent_containers/heroin,
		/obj/item/reagent_containers/heroinbrick,
		/obj/item/reagent_containers/blacktar,
		/obj/item/reagent_containers/syringe/contraband/methamphetamine,
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/storage/pill_bottle/stimulant,
		/obj/item/storage/box/fireworks/dangerous
	)

	var/list/smuggler_satchel_items = list() //Assoc list generated on Initialize()

/datum/controller/subsystem/traitor/Initialize()

	. = ..()

	var/start_time = REALTIMEOFDAY

	for(var/datum/uplink_item/u_item as anything in uplink_items)
		if(!u_item.item || u_item.limited_stock >= 0 || u_item.restricted || u_item.cost > SATCHEL_TC_LIMIT)
			continue
		if((u_item.purchasable_from == UPLINK_NUKE_OPS) || (u_item.purchasable_from == UPLINK_CLOWN_OPS) || (u_item.purchasable_from == (UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS))) //No clown ops or nuke ops exclusive items (or both).
			continue
		if(ispath(u_item.item,/obj/item)) //Accepts only items. For some reason Skyrat made it so that a debug /obj/effect can be a spawn objection for some reason.
			continue
		if(ispath(u_item.item,/obj/item/storage)) //This solves a lot of nonsense balance problems and storage recursion issues. Seriously. 2TC for a fuckton of EMPs???? 2TC for very explosive mailbombs???? hello?????
			continue
		//Make cheap TC items more likely.
		var/cost_mod = (u_item.cost >= 1 ? (SATCHEL_TC_LIMIT/u_item.cost) : SATCHEL_TC_LIMIT+1)**2 //Zero cost items are more weighty because they're usually weird items. We square the final number because why not.
		smuggler_satchel_items[u_item.item] = cost_mod //Remember: The higher the weight, the more likely it is to be picked.

	if(!isnull(start_time))
		var/tracked_time = (REALTIMEOFDAY - start_time) / 10
		var/complete_message = "Generated [length(smuggler_satchel_items)] possible smuggler satchel traitor items in [tracked_time] second[tracked_time == 1 ? "" : "s"]!"
		to_chat(world, span_boldannounce(complete_message))
		log_world(complete_message)

#undef SATCHEL_TC_LIMIT
