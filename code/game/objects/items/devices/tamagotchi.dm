/obj/item/tamagotchi
	name = "nyamagotchi"
	icon = 'icons/obj/devices/tamagotchi.dmi'
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
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT, /datum/material/glass=SMALL_MATERIAL_AMOUNT, /datum/material/plastic=SMALL_MATERIAL_AMOUNT)
	// interaction_flags_atom = parent_type::interaction_flags_atom | INTERACT_ATOM_ALLOW_USER_LOCATION | INTERACT_ATOM_IGNORE_MOBILITY
	var/list/icons_available = list()
	var/radial_icon_file = 'icons/hud/radial_tamagotchi.dmi'

	var/hunger = 0       // Hunger level (0 = full, 100 = starving)
	var/happiness = 100    // Happiness level (0 = sad, 100 = very happy)
	var/energy = 100       // Energy level (0 = tired, 100 = full of energy)
	var/age = 0            // Age in "days" or some unit of time
	var/alive = 0          // Status flag (1 = alive, 0 = dead)
	var/died = 0		   // Status flag (1 = died, 0 = alive)


/obj/item/tamagotchi/Initialize(mapload)
	. = ..()               // Call the parent constructor
	spawn()
	update()   // Start the update loop


/obj/item/tamagotchi/examine(mob/user)
	. = ..()
	if(in_range(src, user) || isobserver(user))
		. += "[readout()]"

/obj/item/tamagotchi/proc/readout()
	if (alive == 0 && died == 0)
		var/status = "The Nyamagotchi is ready to be started!"
		return span_notice(status)
	if (alive == 0 && died == 1)
		var/status = "The Nyamagotchi is DEAD. You're a terrible person."
		return span_notice(status)
	else
		var/status = "Hunger: [hunger], Happiness: [happiness], Energy: [energy], Age: [age]"
		return span_notice(status)

/obj/item/tamagotchi/proc/update_available_icons()
	icons_available = list()
	if(alive == 0)
		icons_available += list("Start!" = image(radial_icon_file,"start"))
	else
		icons_available += list("Feed" = image(radial_icon_file,"feed"),
			"Play" = image(radial_icon_file,"play"),
			"Rest" = image(radial_icon_file,"rest"),
			"Check Status" = image(radial_icon_file,"status"))

/obj/item/tamagotchi/attack_self(mob/user)
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


/obj/item/tamagotchi/proc/start()
	alive = 1
	died = 0
	say("I'm alive, nya!")
	playsound(src, 'sound/misc/bloop.ogg', 50, FALSE)
	timer(1 SECONDS, /obj/item/tamagotchi/proc/play_meow_sound)
	update()  // Start the update loop

/obj/item/tamagotchi/proc/play_meow_sound()
	playsound(src, 'sound/creatures/cat/cat_meow1.ogg', 50, FALSE)

// status update loop
/obj/item/tamagotchi/proc/update()
	if(alive)
		age += 1       // Increase age over time
		hunger += rand(1,5)    // Increase hunger over time
		happiness -= rand(1,5) // Decrease happiness over time
		energy -= rand(1,5)    // Decrease energy over time

		// check if the Tamagotchi is still alive
		if(hunger >= 100 || energy <= 0)
			die()
			return
		// make the tamagotchi say things if an attentio is needed
		if (hunger >= 80 || happiness <= 20 || energy <= 20)
			// Make the tamagotchi shake around
			animate(src, transform = matrix(1, 0, rand(-5, 5), 0, 1, rand(-5, 5)), time = 2, loop = -1)
			var/tama_alerts = list()
			if (hunger >= 80)
				tama_alerts += "hungry"
			if (happiness <= 20)
				tama_alerts += "sad"
			if (energy <= 20)
				tama_alerts += "tired"

			playsound(src, 'sound/machines/beep/triple_beep.ogg', 20, FALSE)
			timer(1 SECONDS, /obj/item/tamagotchi/proc/play_meow_sound)
			var/alert_proc = pick(tama_alerts) // pick a random alert to say
			switch  (alert_proc)
				if ("hungry")
					say(pick("Wowzers meowzers, I'm hungry, nya!", "Excuse me! I'm feeling a bit peckish, nya!", "HEY!!! I'm feeling a bit hungry, nya!"))
				if ("sad")
					say(pick("Some fun would be purrfect, nya...", "I'm feeling a bit down, nya...", "I'm feeling a bit blue, nya..."))
				if ("tired")
					say(pick("SO, SO EEPY, NYA...", "I'm feeling a bit sleepy, nya...", "I'm feeling a bit exhausted, nya..."))
			else
				// make the tamagotchi stop shaking
				animate(src, transform = matrix(1, 0, 0, 0, 1, 0), time = 2, loop = -1)

			// update status messages
			update_status()
			timer(9 SECONDS, /obj/item/tamagotchi/proc/update)
	else
			update_available_icons()

// func to update the status message
/obj/item/tamagotchi/proc/update_status()
	var/status = "Hunger: [hunger], Happiness: [happiness], Energy: [energy], Age: [age]"

// Interactions
/obj/item/tamagotchi/proc/feed()
	if(hunger > 0)
		hunger -= 10
		if (hunger < 0)
			hunger = 0
		balloon_alert(usr, "You fed your Nyamagotchi! Its hunger is now at [hunger].")
		playsound(src, 'sound/items/eatfood.ogg', 50, FALSE)
		timer(1 SECONDS, /obj/item/tamagotchi/proc/play_meow_sound)
		say(pick("NOM NOM NOM. Ice cream, yum!", "Mmm, that was tasty!",
			"MUNCH MUNCH, that was so heckin' tasty, nya!", "Yum, that was delicious!", "What a PURRFECT meal, nya!"))
	else
		balloon_alert(usr, "Your Nyamagotchi isn't hungry!")

/obj/item/tamagotchi/proc/play()
	if (happiness < 100)
		happiness += 10
		if (happiness > 100)
			happiness = 100
		balloon_alert(usr, "You play with your Nyamagotchi! Its happiness is now [happiness].")
		playsound(src, 'sound/creatures/cat/cat_purr1.ogg', 50, FALSE)
		say(pick("Wowzers meowzers, that was fun!", "That was so much fun, nya!", "I had a great time playing with you!"))
	else
		balloon_alert(usr, "Your Nyamagotchi is already very happy!")

/obj/item/tamagotchi/proc/rest()
	if(energy < 100)
		energy += 20
		if(energy > 100)
			energy = 100
		balloon_alert(usr, "Your Nyamagotchi rests and regains energy. Its energy is now [energy].")
		playsound(src, 'sound/creatures/cat/cat_purr3.ogg', 50, FALSE)
		say(pick("Zzz... Zzz... Zzz...", "Honk, shew! Hooonk, shewww...!", "I'm feeling so energized!", "I'm feeling so well-rested!"))
	else
		balloon_alert(usr, "Your Nyamagotchi is fully rested.")

// Function for when the Tamagotchi dies
/obj/item/tamagotchi/proc/die()
	alive = 0
	died = 1
	say("I'M DEAD, NYA. BAI!!")
	visible_message("Your Nyamagotchi shows an x3 on its display. It's dead. You're a terrible person.")
	//src.icon_state = "dead"
	playsound(src, 'sound/misc/sadtrombone.ogg',50, FALSE)
	balloon_alert(usr, "Your Nyamagotchi has died!")

/obj/item/tamagotchi/proc/check_status()
	balloon_alert(usr, "Hunger: [hunger], Happiness: [happiness], Energy: [energy], Age: [age].")
