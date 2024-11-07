#define NO_ANIMAL 0
#define ANIMAL_ALIVE 1
#define ANIMAL_DEAD 2

/obj/item/nyamagotchi
	name = "nyamagotchi"
	icon = 'modular_zubbers/code/modules/nyamagotchi/sprites/nyamagotchi.dmi'
	desc = "A small electronic 'pet' that requires care and attention. An ancient relic sure to evoke nostalgic feelings."
	icon_state = "default"
	worn_icon_state = "nothing"
	base_icon_state = "default"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 2
	throwforce = 2
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)
	// interaction_flags_atom = parent_type::interaction_flags_atom | INTERACT_ATOM_ALLOW_USER_LOCATION | INTERACT_ATOM_IGNORE_MOBILITY
	var/list/icons_available = list()
	var/radial_icon_file = 'modular_zubbers/code/modules/nyamagotchi/sprites/radial_nyamagotchi.dmi'

	/// Hunger level (0 = full, 100 = starving)
	var/hunger = 0
	/// Happiness level (0 = sad, 100 = very happy)
	var/happiness = 100
	/// Energy level (0 = tired, 100 = full of energy)
	var/energy = 0
	/// Age in "days" or some unit of time
	var/age = 0

	var/alive = NO_ANIMAL

/obj/item/clothing/suit/Initialize(mapload)
  . = ..()
    allowed += list(
        /obj/item/nyamagotchi,
    )

/obj/item/nyamagotchi/Initialize(mapload)
	. = ..()               // Call the parent constructor
	update()   // Start the update loop

/obj/item/nyamagotchi/examine(mob/user)
	. = ..()
	if(in_range(src, user) || isobserver(user))
		. += "[readout()]"

/obj/item/nyamagotchi/proc/readout()
	switch(alive)
		if(NO_ANIMAL)
			return span_notice("The Nyamagotchi is ready to be started!")
		if(ANIMAL_ALIVE)
			return span_notice("The Nyamagotchi is alive! Use the 'Check Status button to see its stats!")
		if(ANIMAL_DEAD)
			return span_purple("The Nyamagotchi is DEAD. You're a terrible person.")


/obj/item/nyamagotchi/proc/update_available_icons()
	icons_available = list()
	if(alive == NO_ANIMAL || alive == ANIMAL_DEAD)
		icons_available += list("Start!" = image(radial_icon_file,"start"))
	else
		icons_available += list("Feed" = image(radial_icon_file,"feed"),
			"Play" = image(radial_icon_file,"play"),
			"Rest" = image(radial_icon_file,"rest"),
			"Check Status" = image(radial_icon_file,"status"))

/obj/item/nyamagotchi/attack_self(mob/user)
	update_available_icons()
	if(icons_available)
		var/selection = show_radial_menu(user, src, icons_available, radius = 38, require_near = TRUE, tooltips = TRUE)
		if(!selection)
			return
		switch(selection)
			if("Start!")
				start()
			if("Feed")
				feed()
			if("Play")
				play()
			if("Rest")
				rest()
			if("Check Status")
				check_status()

/obj/item/nyamagotchi/proc/play_meow_sound()
	playsound(src, 'sound/creatures/cat/cat_meow1.ogg', 50, FALSE)

/obj/item/nyamagotchi/proc/start()
	alive = ANIMAL_ALIVE
	// give a slightly random start
	hunger = rand(30, 60)
	happiness = rand(80, 100)
	energy = rand(60, 90)
	say(message="I'm alive, nya!", message_range=2)
	playsound(src, 'sound/misc/bloop.ogg', 50, FALSE)
	addtimer(CALLBACK(src, PROC_REF(play_meow_sound)), 0.25 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(update)), 12 SECONDS)


// status update loop
/obj/item/nyamagotchi/proc/update()
	if(!alive)
		update_available_icons()
		return

	age += 1       // Increase age over time
	hunger += rand(1, 3)    // Increase hunger over time
	happiness -= rand(1,3) // Decrease happiness over time
	energy -= rand(1,3)    // Decrease energy over time

	// check if the nyamagotchi is still alive
	if(hunger >= 100 || energy <= 0)
		die()
		return
	// make the nyamagotchi say things if an attentio is needed
	if (hunger >= 85 || happiness <= 10 || energy <= 20)
		var/tama_alerts = list()
		if (hunger >= 85)
			tama_alerts += "hungry"
		if (happiness <= 10)
			tama_alerts += "sad"
		if (energy <= 20)
			tama_alerts += "tired"

		playsound(src, 'sound/machines/beep/triple_beep.ogg', 20, FALSE)
		addtimer(CALLBACK(src, PROC_REF(play_meow_sound)), 0.25 SECONDS)
		var/alert_proc = pick(tama_alerts) // pick a random alert to say
		if (alert_proc)
			switch  (alert_proc)
				if ("hungry")
					say(message=pick("Wowzers meowzers, I'm hungry, nya!", "Excuse me! I'm feeling a bit peckish, nya!",
					"I could eat the world right now, nya!", "Soooo hongry!", "HELLO! Food, pwease?",
					"HEY!!! I'm feeling a bit hungry, nya!", "HONNNNGRYYY!!!", "I needs the food, mrow!"), message_range=2)
				if ("sad")
					say(message=pick("Some fun would be purrfect, nya...", "I'm feeling a bit down, nya...", "Playtime! Now!",
					"This is no fun...", "I'm BORED, nya!", "So sad! So bored! Need to play!", "Wah... So sad, nya...",
					"I'm feeling a bit blue, nya...", "I'm sad...", "Play with meeee! PLEASE.", "My fun levels are low, nya..."),
					message_range=2)
				if ("tired")
					say(message=pick("SO, SO EEPY, NYA...", "I'm feeling a bit sleepy, nya...", "I'm gonna pass out and DIE!",
					"Sleempy...", "I be needin' a naps, nya!", "Need to do the big sleeps, please!",
					"I'm feeling a bit exhausted, nya...", "I could go for a nap...", "EEPY. EEPY. EEPY..."),
					message_range=2)
	addtimer(CALLBACK(src, PROC_REF(update)), 12 SECONDS)

// Interactions
/obj/item/nyamagotchi/proc/feed()
	if(hunger > 0)
		hunger -= 10
		if (hunger < 0)
			hunger = 0
		balloon_alert(usr, "Nyamagotchi fed!")
		to_chat(usr, span_purple("You fed your Nyamagotchi! Its hunger is now at [hunger]."))
		playsound(src, 'sound/items/eatfood.ogg', 50, FALSE)
		addtimer(CALLBACK(src, PROC_REF(play_meow_sound)), 0.25 SECONDS)
		say(message=pick("NOM NOM NOM. Ice cream, yum!", "Mmm, that was tasty!", "So yummy!", "Oooh! Delicious!", "MONCH MONCH MONCH.",
			"MUNCH MUNCH, that was so heckin' tasty, nya!", "Yum, that was delicious!", "What a PURRFECT meal, nya!"), message_range=2)
	else
		to_chat(usr, "Your Nyamagotchi isn't hungry!")

/obj/item/nyamagotchi/proc/play()
	if (happiness < 100)
		happiness += 10
		if (happiness > 100)
			happiness = 100
		balloon_alert(usr, "Nyamagotchi played with!")
		to_chat(usr, span_purple("You play with your Nyamsagotchi! Its happiness is now [happiness]."))
		playsound(src, 'sound/creatures/cat/cat_purr1.ogg', 50, FALSE)
		say(message=pick("Wowzers meowzers, that was fun!", "That was so much fun, nya!", "YAY!!!",
		"I had a great time playing with you!", "YIPPEEE!!!", "That was a blast!", "Wowzers meowzers, that was a blast!"), message_range=2)
	else
		to_chat(usr, span_purple("Your Nyamagotchi is already very happy!"))

/obj/item/nyamagotchi/proc/rest()
	if(energy < 100)
		energy += 20
		if(energy > 100)
			energy = 100
		balloon_alert(usr, "Nyamagotchi rested!")
		to_chat(usr, span_purple("Your Nyamagotchi rests and regains energy. Its energy is now [energy]."))
		playsound(src, 'sound/creatures/cat/cat_purr3.ogg', 50, FALSE)
		say(message=pick("Zzz... Zzz... Zzz...", "Honk, shew! Hooonk, shewww...!", "Snoozin' time, nya...", "Honk shoo!",
		"I'm feeling so energized!", "I'm feeling so well-rested!", "Zzz... Zzz... Zzz... Zzz... Zzz..."), message_range=2)
	else
		to_chat(usr, span_purple("Your Nyamagotchi is fully rested."))

// Function for when the nyamagotchi dies
/obj/item/nyamagotchi/proc/die()
	alive = ANIMAL_DEAD
	say("I'M DEAD, NYA. BAI!!")
	to_chat(usr, span_warning("Your Nyamagotchi shows an x3 on its display. It's dead. You're a terrible person."))
	//src.icon_state = "dead"
	playsound(src, 'sound/misc/sadtrombone.ogg',20, FALSE)
	balloon_alert(usr, "Nyamagotchi died!")

/obj/item/nyamagotchi/proc/check_status()
	balloon_alert(usr, "Hunger: [hunger], Happiness: [happiness], Energy: [energy], Age: [age].")

#undef NO_ANIMAL
#undef ANIMAL_ALIVE
#undef ANIMAL_DEAD
