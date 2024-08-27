/obj/item/storage/belt/wizardblood
	name = "Wizardblood"
	desc = "A creepy heavy belt with an IV drip attached. It seems to have space for some specialized containers."
	icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_inventory.dmi'
	icon_state = "wizardblood"
	//worn_icon = 'modular_zubbers/code/modules/true_heretic_path/icons/heretic_clothing_worn.dmi'
	//worn_icon_state = "wizardblood"

	var/mob/living/carbon/owner

	var/amount_to_inject = 10

/obj/item/storage/belt/wizardblood/Destroy()
	owner = null
	. = ..()

/obj/item/storage/belt/wizardblood/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 4
	atom_storage.set_holdable(
		list(
			/obj/item/reagent_containers/cup/endless_flask
		)
	)

/obj/item/storage/belt/wizardblood/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_BELT && iscarbon(user) && user.reagents)
		START_PROCESSING(SSobj,src)
		owner = user

/obj/item/storage/belt/wizardblood/dropped(mob/user, silent)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	owner = null

/obj/item/storage/belt/wizardblood/process(seconds_per_tick)

	if(!owner || !owner.reagents)
		STOP_PROCESSING(SSobj, src)
		return

	for(var/obj/item/reagent_containers/cup/endless_flask/flask in src.contents)
		var/desired_amount = amount_to_inject
		var/datum/reagent/found_reagent = locate(flask.reagent_to_create) in owner.reagents.reagent_list
		if(found_reagent)
			desired_amount -= found_reagent.volume
		if(desired_amount <= 0)
			break
		owner.reagents.add_reagent(flask.reagent_to_create,desired_amount)