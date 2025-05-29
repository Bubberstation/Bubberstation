/obj/item/clothing/neck/petcollar/locked/bluespace_collar_receiver
	name = "Bluespace collar receiver"
	desc = "A collar containing a miniaturized bluespace whitehole. Other bluespace transmitter collars can connect to this, causing the wearer to receive food from other transmitter collars directly into the stomach. "
	slot_flags = ITEM_SLOT_NECK
	var/mob/living/carbon/victim = 0

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_receiver/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/wearer = user
	if(!iscarbon(wearer) || slot !=ITEM_SLOT_NECK || !wearer?.client?.prefs?.weight_gain_items)
		return FALSE
	victim = user;

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_receiver/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/wearer = user
	if(!iscarbon(wearer) || !(wearer.get_item_by_slot(ITEM_SLOT_NECK) == src) || !wearer?.client?.prefs?.weight_gain_items)
		return FALSE
	victim = 0

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_receiver/proc/isworn()
	if(istype(victim, /mob/living/carbon))
		return TRUE
	else
		return FALSE

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_receiver/attackby(obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/K, mob/user, params)
	if(istype(K, /obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter))
		K.linked_receiver = src
		var/mob/living/carbon/U = user
		to_chat(U, "<span class='notice'>You link the bluespace collar with the other transmitter</span>")
	. = ..()
	return


/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter
	name = "Bluespace collar transmitter"
	desc = "A collar containing a miniaturized bluespace blackhole. Can be connected to a bluespace collar receiver to transmit food to a linked receiver collar. "
	slot_flags = ITEM_SLOT_NECK
	var/obj/item/clothing/neck/petcollar/locked/bluespace_collar_receiver/linked_receiver = 0

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/wearer = user
	if(!iscarbon(wearer) || slot !=ITEM_SLOT_NECK || !wearer?.client?.prefs?.weight_gain_items)
		return FALSE

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/wearer = user
	if(!iscarbon(wearer) || !(wearer.get_item_by_slot(ITEM_SLOT_NECK) == src) || !wearer?.client?.prefs?.weight_gain_items)
		return FALSE

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/attackby(obj/item/K, mob/user, params)
	if(istype(K, /obj/item/clothing/neck/petcollar/locked/bluespace_collar_receiver))
		linked_receiver = K
		var/mob/living/carbon/U = user
		to_chat(U, "<span class='notice'>You link the bluespace collar to the other receiver</span>")
	. = ..()
	return

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/proc/islinked()
	if (linked_receiver && linked_receiver.isworn())
		return TRUE
	else
		return FALSE
// For food
/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/proc/transpose_food(obj/item/reagent_containers/food/snacks/owner, mob/living/original_eater, mob/living/feeder)
	if (!islinked())
		return FALSE

	var/mob/living/carbon/human/eater = linked_receiver.victim
	if(owner.reagents)
		if(eater.satiety > -200)
			eater.satiety -= owner.junkiness
		playsound(eater.loc,'sound/items/eatfood.ogg', rand(10,50), 1)
		playsound(original_eater.loc,'sound/items/eatfood.ogg', rand(10,50), 1)
		eater.visible_message("<span class='warning'>[eater]'s belly seems to visibly distend a bit further'!</span>", "<span class='danger'>You feel your stomach get filled by food!</span>")
		var/bitevolume = 1
		if(HAS_TRAIT(original_eater, TRAIT_VORACIOUS))
			bitevolume = bitevolume * 0.67
		var/mob/living/carbon/human/human_eater = eater
		if(istype(human_eater))
			human_eater.fullness += bitevolume;

		if(owner.reagents.total_volume)
			SEND_SIGNAL(owner, COMSIG_FOOD_EATEN, eater, feeder)
			var/fraction = min(owner.bitesize / owner.reagents.total_volume, 1)
			owner.reagents.reaction(eater, INGEST, fraction)
			owner.reagents.trans_to(eater, owner.bitesize, log = TRUE)
			owner.bitecount++
			owner.On_Consume(eater)
			owner.checkLiked(fraction, original_eater)
			return TRUE

// For the alternative edible functionality
/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/proc/transpose_edible(datum/component/edible/foodstuff, mob/living/original_eater, mob/living/feeder)
	if (!islinked())
		return FALSE

	var/atom/owner = foodstuff.parent
	var/mob/living/carbon/human/eater = linked_receiver.victim

	if(!owner?.reagents)
		return FALSE
	if(eater.satiety > -200)
		eater.satiety -= foodstuff.junkiness
	playsound(original_eater.loc,'sound/items/eatfood.ogg', rand(10,50), TRUE)
	playsound(eater.loc,'sound/items/eatfood.ogg', rand(10,50), TRUE)
	eater.visible_message("<span class='warning'>[eater]'s belly seems to visibly distend a bit further'!</span>", "<span class='danger'>You feel your stomach get filled by something!</span>")
	var/mob/living/carbon/human/human_eater = original_eater
	if(istype(human_eater))
		var/bitevolume = 1
		if(HAS_TRAIT(human_eater, TRAIT_VORACIOUS))
			bitevolume = bitevolume * 0.67
		if(istype(eater))
			eater.fullness += bitevolume;

	if(owner.reagents.total_volume)
		SEND_SIGNAL(foodstuff.parent, COMSIG_FOOD_EATEN, eater, original_eater)
		var/fraction = min(foodstuff.bite_consumption / owner.reagents.total_volume, 1)
		owner.reagents.reaction(eater, INGEST, fraction)
		owner.reagents.trans_to(eater, foodstuff.bite_consumption)
		foodstuff.bitecount++
		foodstuff.On_Consume(eater)
		foodstuff.checkLiked(fraction, original_eater)

		//Invoke our after eat callback if it is valid
		if(foodstuff.after_eat)
			foodstuff.after_eat.Invoke(eater, feeder)
		return TRUE

// For Drinks
/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/proc/transpose_drink(obj/item/reagent_containers/food/drinks/owner, mob/living/original_eater)
	if (!islinked())
		return FALSE

	var/mob/living/carbon/human/eater = linked_receiver.victim
	var/fraction = min(owner.gulp_size/owner.reagents.total_volume, 1)
	owner.checkLiked(fraction, eater)
	owner.reagents.reaction(eater, INGEST, fraction)
	owner.reagents.trans_to(eater, owner.gulp_size, log = TRUE)
	//GS13 Port - Fullness
	if(iscarbon(eater))
		var/mob/living/carbon/human/human_eater = eater
		var/mob/living/carbon/human/human_original_eater = original_eater
		if(HAS_TRAIT(human_original_eater, TRAIT_VORACIOUS))
			human_eater.fullness += min(owner.gulp_size * 0.67, owner.reagents.total_volume * 0.67)
		else
			human_eater.fullness += min(owner.gulp_size, owner.reagents.total_volume) // GS13 drinks will fill your stomach
	playsound(original_eater.loc,'sound/items/drink.ogg', rand(10,50), 1)
	playsound(eater.loc,'sound/items/drink.ogg', rand(10,50), 1)
	eater.visible_message("<span class='warning'>[eater]'s belly seems to visibly distend a bit further, emitting an audible sloshing noise!</span>", "<span class='danger'>You feel your stomach get filled by liquid, hearing sloshing noises coming from within!</span>")
	return TRUE

// For containers
/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/proc/transpose_container(var/datum/reagents/reagents , fraction, mob/M, mob/user)
	if (!islinked())
		return FALSE

	var/mob/living/carbon/human/eater = linked_receiver.victim
	var/self_fed = M == user
	reagents.reaction(eater, INGEST, fraction)
	addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), eater, 5, null, null, null, self_fed? "self swallowed" : "fed by [user]"), 5)
	eater.visible_message("<span class='warning'>[eater]'s belly seems to visibly distend a bit further, emitting an audible sloshing noise!</span>", "<span class='danger'>You feel your stomach get filled by liquid, hearing sloshing noises coming from within!</span>")
	return TRUE

// For industrial feeding tube
/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/proc/transpose_industrial_feeding(obj/item/reagent_containers/food/snacks/food, datum/reagents/food_reagents, mob/living/original_eater)
	if (!islinked())
		return FALSE
	var/mob/living/carbon/human/eater = linked_receiver.victim
	var/food_size = food_reagents.total_volume //We're cramming the Whole Thing down your throat~
	food_reagents.reaction(eater, INGEST, food_size)
	food_reagents.trans_to(eater, food_size)
	eater.fullness += food_size
	food.checkLiked(food_size, eater) //...Hopefully you like the taste.
	eater.visible_message("<span class='warning'>[eater]'s belly seems to greatly distend, as if it was being inflated with large amounts of food.</span>", "<span class='danger'>You feel an immense pressure in your stomach, as if large amounts of food were pumped directly into you.</span>")
	return TRUE

// For feeding tube
/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/proc/transpose_feeding(transfer_amount, var/obj/item/reagent_containers/beaker, mob/living/original_eater)
	if (!islinked())
		return FALSE
	var/mob/living/carbon/human/eater = linked_receiver.victim
	var/fraction = min(transfer_amount/beaker.reagents.total_volume, 1) //the fraction that is transfered of the total volume
	beaker.reagents.reaction(eater, INJECT, fraction, FALSE) //make reagents reacts, but don't spam messages
	beaker.reagents.trans_to(eater, transfer_amount)
	eater.fullness += transfer_amount //Added feeding tube's causing fullness (But ignores limits~)
	if(prob(10))
		eater.visible_message("<span class='warning'>[eater]'s belly seems to visibly distend, emitting an audible sloshing noise!</span>", "<span class='danger'>You feel your stomach get pumped full with liquid, hearing sloshing noises coming from within!</span>")
	return TRUE

/obj/item/clothing/neck/petcollar/locked/bluespace_collar_transmitter/attack_self(mob/user)
	linked_receiver = 0
	var/mob/living/carbon/U = user
	to_chat(U, "<span class='notice'>You remove the currently linked receiver collar from the buffer</span>")
	. = ..()
