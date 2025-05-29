/mob/living/simple_animal/friendly/cakegolem //I told you I'd do it, Remie //sorry Remie -Eye
	name = "Puffball"
	desc = "It's a person made out of cake."
	icon = 'GainStation13/icons/mob/cakegolem.dmi'
	icon_state = "cakegolem"
	icon_living = "cakegolem"
	icon_dead = "cakegolem_dead"
	health = 200
	maxHealth = 200  //health buffed because you all know how people get here -Eye
	gender = FEMALE
	harm_intent_damage = 10
	butcher_results = list(/obj/item/organ/brain = 1, /obj/item/organ/heart = 1, /obj/item/reagent_containers/food/snacks/cakeslice/birthday = 9,  \
	/obj/item/reagent_containers/food/snacks/meat/slab = 2)
	response_harm_simple = "takes a bite out of"
	attacked_sound = 'sound/items/eatfood.ogg'
	deathmessage = "loses its false life and collapses!"
	death_sound = "bodyfall"
	//held_icon = "cakegolem"

/mob/living/simple_animal/friendly/cakegolem/CheckParts(list/parts)
	..()
	var/obj/item/organ/brain/B = locate(/obj/item/organ/brain) in contents
	if(!B || !B.brainmob || !B.brainmob.mind)
		return
	B.brainmob.mind.transfer_to(src)
	to_chat(src, "<span class='big bold'>You are a cake person!</span><b> You're a harmless cake/person hybrid that everyone loves. People can take bites out of you if they're hungry, but there is plenty of you to go around, and you regenerate health \
	so quickly that it generally doesn't matter. You're remarkably resilient to any damage besides this and it's hard for you to really die at all. You should go around and bring happiness and \
	free cake to the station!</b>")
	var/new_name = stripped_input(src, "Enter your name, or press \"Cancel\" to stick with Puffball.", "Name Change")
	if(new_name)
		to_chat(src, "<span class='notice'>Your name is now <b>\"new_name\"</b>!</span>")
		name = new_name

/mob/living/simple_animal/friendly/cakegolem/Life()
	..()
	if(stat)
		return
	if(health < maxHealth)
		adjustBruteLoss(-5) //Fast life regen
	for(var/obj/item/reagent_containers/food/snacks/donut/D in range(1, src)) //Frosts nearby donuts!
		if(!D.is_decorated)
			D.decorate_donut()

/mob/living/simple_animal/friendly/cakegolem/attack_hand(mob/living/L)
	. = ..()

	//if(.) //the attack was blocked
		//return
	if(L.a_intent == INTENT_HARM && L.reagents && !stat)
		L.reagents.add_reagent(/datum/reagent/consumable/nutriment, 0.4)
		L.reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 0.4)
