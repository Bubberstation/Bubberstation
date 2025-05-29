/obj/effect/mob_spawn/human/fastfood
	name = "Corporate cryostasis pod"
	desc = "Through the grease-stained cryopod glass, you can see someone sleeping inside..."
	mob_name = "fastfood worker"
	job_description = "Restaurant Worker"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human
	short_desc = "It's the grand opening day!"
	flavour_text = "After you've sold your soul to corporate overlords, your contract obliged you to enter cryostasis. \
	Finally, after God knows how long, the cryopod system have awakened you with only a single sentence of information - welcome and lure in new guests into the freshly opened GATO restaurant!"
	assignedrole = "Restaurant worker"
	mirrorcanloadappearance = TRUE

/obj/effect/mob_spawn/human/fastfoodmanager
	name = "Corporate cryostasis pod"
	desc = "Through the grease-stained cryopod glass, you can see someone sleeping inside..."
	mob_name = "fastfood worker"
	job_description = "Restaurant Manager"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human
	short_desc = "It's the grand opening day!"
	flavour_text = "After you've sold your soul to corporate overlords, your contract obliged you to enter cryostasis. \
	Finally, after God knows how long, the cryopod system have awakened you with only a single sentence of information - make sure to keep the best care of GATO's restaurant, currently under your management! You have a higher say over your workers, but do not abuse this power."
	assignedrole = "Restaurant manager"
	mirrorcanloadappearance = TRUE

/obj/effect/mob_spawn/human/fastfood/Initialize(mapload)
	. = ..()
	var/arrpee = rand(1,2)
	switch(arrpee)
		if(1)
			flavour_text += "You are this restaurant's cook, using up the plethora of ingredients to cook up deliciously greasy and caloric foods. \
			The kitchen and the bar is your turf! Make sure the guests stay fed."
			outfit.glasses = /obj/item/clothing/glasses/sunglasses/reagent
			outfit.head = /obj/item/clothing/head/soft/black
			outfit.uniform = /obj/item/clothing/under/sweater/purple
			outfit.suit = /obj/item/clothing/suit/apron/chef
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant
		if(2)
			flavour_text += "You are this restaurant's waiter, responsible not only for tending to the guests, but also fixing and taking care of station's shape, power and looks. \
			Make sure everything looks squeaky clean and that the restaurant remains powered!"
			outfit.head = /obj/item/clothing/head/soft/black
			outfit.uniform = /obj/item/clothing/under/suit/waiter
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant

/obj/effect/mob_spawn/human/fastfoodmanager/Initialize(mapload)
	. = ..()
	var/arrpee = rand(1,2)
	switch(arrpee)
		if(1)
			flavour_text += "You are this restaurant's manager, taking care of all the necessary paperwork, overseeing all the workers... \
			But most importantly, you always have to make sure that the restaurant prospers and remains in good shape! "
			outfit.glasses = /obj/item/clothing/glasses/sunglasses/reagent
			outfit.uniform = /obj/item/clothing/under/suit/burgundy
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack/satchel/leather
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant
			outfit.l_pocket = /obj/item/modular_computer/tablet

		if(2)
			flavour_text += "You are this restaurant's manager, taking care of all the necessary paperwork, overseeing all the workers... \
			But most importantly, you always have to make sure that the restaurant prospers and remains in good shape! "
			outfit.glasses = /obj/item/clothing/glasses/sunglasses/reagent
			outfit.uniform = /obj/item/clothing/under/suit/navy
			outfit.shoes = /obj/item/clothing/shoes/sneakers/black
			outfit.back = /obj/item/storage/backpack/satchel/leather
			outfit.ears = /obj/item/radio/headset
			outfit.id = /obj/item/card/id/silver/restaurant
			outfit.l_pocket = /obj/item/modular_computer/tablet

/obj/effect/mob_spawn/human/fastfood/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)

/obj/effect/mob_spawn/human/fastfood/Destroy()
	new/obj/structure/fluff/empty_sleeper(get_turf(src))
	return ..()


/obj/effect/mob_spawn/human/fastfoodmanager/Destroy()
	return ..()

// Feeder's Den - fanatic (GS13)

/obj/effect/mob_spawn/human/feeders_den/fanatic
	name = "Sleeper pod"
	desc = "Through the red glass, you can see someone sleeping inside..."
	mob_name = "Feeder Fanatic"
	job_description = "Feeder Fanatic"
	short_desc = "You are a member of a niche branch of Syndicate with... strange goals."
	flavour_text = "After months of construction and gathering equipment, your den is finished - a monument to gluttony, equipped with every tool to turn any sharp body into a quivering mound of lard..."
	important_info = "Keep your den in one piece and away from curious eyes! YOU AREN'T ALLOWED TO CAPTURE / FATTEN UP PEOPLE WHO DON'T DO NON-CON OR DIDN'T AGREE TO IT! Despite being able to leave the outpost, you do NOT have a permission to antag or grief. You're supposed to stay covert, not show yourself to the whole station!"
	outfit = /datum/outfit/feeders_den/fanatic
	faction = ROLE_SYNDICATE
	assignedrole = "Space Agent"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human
	mirrorcanloadappearance = TRUE

/datum/outfit/feeders_den/fanatic
	name = "Feeder Fanatic"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	l_hand = /obj/item/gun/energy/kinetic_accelerator/crossbow/feeder
	l_pocket = /obj/item/crowbar
	r_pocket = /obj/item/gun/energy/fatoray
	id = /obj/item/card/id/syndicate/anyone
	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/feeders_den/fanatic/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

/datum/outfit/feeders_den/fanatic/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()

/obj/effect/mob_spawn/human/feeders_den/fanatic/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)


// Feeder's Den - victim (GS13)


/obj/effect/mob_spawn/human/feeders_den/victim
	name = "Grease stained cryopod"
	mob_name = "Syndicate Prisoner"
	desc = "Through the grease-stained cryopod glass, you can see someone obese sleeping inside..."
	job_description = "Den Victim"
	short_desc = "You don't remember how you even got here."
	flavour_text = "It's been a while since you've been stuck here. Each day passes by with non-stop feeding, lazing around and the pain of a stretched, creaking stomach... Is there any hope for you to get out of here before things get truly hopeless?"
	important_info = "Keep your behaviour appropriate and fitting for your role, at least loosely."
	outfit = /datum/outfit/feeders_den/victim
	assignedrole = "Imprisoned victim"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	death = FALSE
	roundstart = FALSE
	mob_species = /datum/species/human
	mirrorcanloadappearance = TRUE

/datum/outfit/feeders_den/victim
	name = "Den Victim"
	uniform = /obj/item/clothing/under/misc/gear_harness
	neck = /obj/item/electropack/shockcollar

/datum/outfit/feeders_den/victim/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()

/obj/effect/mob_spawn/human/feeders_den/victim/special(mob/living/carbon/human/new_spawn)
	ADD_TRAIT(new_spawn,TRAIT_EXEMPT_HEALTH_EVENTS,GHOSTROLE_TRAIT)

/obj/effect/mob_spawn/proc/startfat(mob/M) //move this somewhere else later when we're cleaning up our content - GLDW
	return

//GS13
/obj/machinery/cryopod/feederden //Pod for Feeder Den - not just for syndies, but for fatsos too
	name = "subspace cryogenic sleeper"
	desc = "A special mobility sleeper for storing agents in a disclosed location."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s-open"
	alert_comms = FALSE

/obj/machinery/cryopod/feederden/open_machine()
	..()
	icon_state = "sleeper_s-open"

/obj/machinery/cryopod/feederden/close_machine(mob/user)
	..()
	icon_state = "sleeper_s"

/obj/machinery/cryopod/feederden/find_control_computer(urgent = FALSE)	//We don't want to store anything
	return

/obj/machinery/cryopod/syndicate
	name = "subspace cryogenic sleeper"
	desc = "A special mobility sleeper for storing agents in a disclosed location."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s-open"
	alert_comms = FALSE

/obj/machinery/cryopod/syndicate/find_control_computer(urgent = FALSE)	//We don't want to store anything
	return

/obj/machinery/cryopod/syndicate/MouseDrop_T(mob/living/target, mob/user)
	if(!isliving(target))
		return
	if(!target.faction.Find("Syndicate"))
		to_chat(user, "<span class='warning'>The machine's internal checks prevent you from putting [target == user ? "yourself" : "[target]"] inside.</span>")
		return
	..()

/obj/machinery/cryopod/syndicate/open_machine()
	..()
	icon_state = "sleeper_s-open"

/obj/machinery/cryopod/syndicate/close_machine(mob/user)
	..()
	icon_state = "sleeper_s"
