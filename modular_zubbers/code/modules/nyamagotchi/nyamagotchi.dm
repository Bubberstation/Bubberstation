#define NO_ANIMAL 0
#define ANIMAL_ALIVE 1
#define ANIMAL_DEAD 2

#define MEOW_NORMAL 'sound/mobs/non-humanoids/cat/cat_meow1.ogg'
#define MEOW_SAD 'modular_zubbers/code/modules/nyamagotchi/sound/cat_sad.ogg'
#define MEOW_CRITICAL 'modular_zubbers/code/modules/nyamagotchi/sound/cat_alert.ogg'
#define EAT_FOOD 'modular_zubbers/code/modules/nyamagotchi/sound/cat_eat.ogg'
#define PURR_PLAY 'sound/mobs/non-humanoids/cat/cat_purr1.ogg'
#define PURR_SLEEP 'sound/mobs/non-humanoids/cat/cat_purr3.ogg'

/obj/item/toy/nyamagotchi
	name = "Nyamagotchi"
	desc = "A small electronic 'pet' that requires care and attention. An ancient relic sure to evoke nostalgic feelings."
	icon = 'modular_zubbers/icons/obj/toys/toys.dmi'
	icon_state = "nya"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	force = 2
	throwforce = 2
	actions_types = list(/datum/action/item_action/nyamagotchi_menu)
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
	/// How often a 'life' cycle of the pet runs
	var/update_rate = 45 SECONDS
	/// The last action the pet performed
	var/last_task = null

	var/alive = NO_ANIMAL
	var/list/rest_messages = list(
		"Zzz... Zzz... Zzz...",
		"Honk, shew! Hooonk, shewww...!",
		"Snoozin' time, nya...",
		"Honk shoo!",
		"Nini...~",
		"Zzz... Zzz... Zzz... Zzz... Zzz...",
	)
	var/list/play_messages = list(
		"Wowzers meowzers, that was fun!",
		"That was so much fun, nya!",
		"YAY!!!",
		"I had a great time playing with you!",
		"YIPPEEE!!!", "That was a blast!",
		"Wowzers meowzers, that was a blast!",
	)
	var/list/feed_messages = list(
		"NOM NOM NOM. Ice cream, yum!",
		"Mmm, that was tasty!",
		"So yummy!",
		"Oooh! Delicious!",
		"MONCH MONCH MONCH.",
		"MUNCH MUNCH, that was so heckin' tasty, nya!",
		"Yum, that was delicious!",
		"What a PURRFECT meal, nya!",
	)
	var/list/hunger_warning = list(
		"Wowzers meowzers, I'm hungry, nya!",
		"Excuse me! I'm feeling a bit peckish, nya!",
		"I could eat the world right now, nya!",
		"Soooo hongry!",
		"I'm feeling a bit hungry, nya!",
		"I needs the food, mrow!",
	)
	var/list/hunger_critical = list(
		"HELLO! Food, pwease?...",
		"HEY!!! I'm starving...",
		"HONNNNGRYYY!!!",
		"so so hungry...",
	)
	var/list/happiness_warning = list(
		"Some fun would be purrfect, nya...",
		"I'm feeling a bit down, nya...",
		"Playtime! Now!",
		"This is no fun...",
		"I'm BORED, nya!",
		"So sad! So bored! Need to play!",
		"Wah... So sad, nya...",
		"I'm feeling a bit blue, nya...",
		"I'm sad...",
		"Play with meeee! PLEASE.",
		"My fun levels are low, nya...",
	)
	var/list/full_critical = list(
		"So this... is how it ends for me...",
		"Is this how it ends... cold, alone, unfed...",
		"Fading... fast... my last request: snacks and snuggles, please...",
		"I see the end... all nine lives gone...",
		"Abandoned... like a stray... in my own virtual world...",
		"It’s getting so dark and cold...",
	)
	var/list/energy_warning = list(
		"I'm feeling a bit sleepy, nya...",
		"Sleempy...",
		"I be needin' a naps, nya!",
		"Need to do the big sleeps, please!",
		"I'm feeling a bit exhausted, nya...",
		"I could go for a nap...",
	)
	var/list/energy_critical = list(
		"SO, SO EEPY, NYA...",
		"Please, I need to rest...",
		"I'm feel like I'm gonna pass out...",
		"Why won't you let me sleep?...",
		"EEPY. EEPY. eepy...",
	)
	COOLDOWN_DECLARE(mute_pet)
	COOLDOWN_DECLARE(needs_alert)

/obj/item/toy/nyamagotchi/Initialize(mapload)
	. = ..()
	if(prob(3))
		name = "pocket pussy" // mrowwww!
	register_context()
	update_available_icons()

/obj/item/toy/nyamagotchi/examine(mob/user)
	. = ..()
	if(in_range(src, user) || isobserver(user))
		. += "[readout()]"
		if(!COOLDOWN_FINISHED(src, mute_pet))
			. += span_notice("<b>Alt-click</b> to disable mute feature.")
		else
			. += span_notice("<b>Alt-click</b> to temporarily mute notifications.")

/obj/item/toy/nyamagotchi/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	context[SCREENTIP_CONTEXT_LMB] = "Interact"
	context[SCREENTIP_CONTEXT_ALT_LMB] = "Toggle mute"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/toy/nyamagotchi/proc/readout()
	switch(alive)
		if(NO_ANIMAL)
			return span_notice("[src] is ready to be started!")
		if(ANIMAL_ALIVE)
			return span_notice("[src] is alive, it has reached age [age]! Use the <b>'Check Status'</b> button to see its stats!")
		if(ANIMAL_DEAD)
			return span_purple("[src] is DEAD. You're a terrible person.")

/obj/item/toy/nyamagotchi/proc/update_available_icons()
	icons_available = list()
	if(alive == ANIMAL_ALIVE)
		icons_available += list(
			"Feed" = image(radial_icon_file, "feed"),
			"Play" = image(radial_icon_file, "play"),
			"Rest" = image(radial_icon_file, "rest"),
			"Check Status" = image(radial_icon_file, "status",
		))
	else
		icons_available += list("Start!" = image(radial_icon_file, "start"))

/obj/item/toy/nyamagotchi/attack_self(mob/user)
	pet_menu(user)

/obj/item/toy/nyamagotchi/proc/pet_menu(mob/user, list/modifiers)
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

/obj/item/toy/nyamagotchi/click_alt(mob/living/user)
	if(user != loc)
		return

	if(COOLDOWN_FINISHED(src, mute_pet))
		COOLDOWN_START(src, mute_pet, update_rate * 5.75)
		user.balloon_alert(user, "muted!")
		to_chat(user, span_notice("You turn on [src]'s mute feature."))

	else
		COOLDOWN_RESET(src, mute_pet)
		user.balloon_alert(user, "unmuted!")
		to_chat(user, span_notice("You turn off [src]'s mute feature."))
		be_known(sfx = MEOW_NORMAL)

/obj/item/toy/nyamagotchi/proc/start()
	alive = ANIMAL_ALIVE
	// give a slightly random start
	hunger = rand(30, 60)
	happiness = rand(80, 100)
	energy = rand(60, 90)
	be_known(sfx = 'sound/misc/bloop.ogg', speech = "I'm alive, nya!")
	addtimer(CALLBACK(src, PROC_REF(be_known), MEOW_NORMAL), 2 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(update)), update_rate)

// status update loop
/obj/item/toy/nyamagotchi/proc/update()
	if(!alive)
		return

	last_task = null

	if(happiness <= 21) // unhappy pets get hungry and tired faster
		hunger += rand(1, 2)
		energy -= rand(1, 3)

	if(hunger >= 70 || energy <= 30)
		happiness -= clamp(rand(2, 4), 0, happiness)

	age += 1										// Increase age over time
	hunger += rand(1, 3)							// Increase hunger over time
	happiness -= clamp(rand(1, 3), 0, happiness)	// Decrease happiness over time
	energy -= rand(1, 3)							// Decrease energy over time

	// check if the nyamagotchi is still alive
	if(hunger >= 100 || energy <= 0)
		die()
		return

	// schedule our next check
	addtimer(CALLBACK(src, PROC_REF(update)), update_rate)

	// make the nyamagotchi say things if attention is needed, otherwise just a small chance of a reminder meow
	var/list/tama_alerts = list()
	var/selected_alert
	if((hunger >= 83 || energy <= 17) && happiness <= 21)
		be_known(sfx = MEOW_CRITICAL, speech = pick(full_critical))
		return
	if(hunger >= 83)
		tama_alerts += "vhungry"
	if(energy <= 17)
		tama_alerts += "vtired"
	if(tama_alerts.len)
		selected_alert = pick(tama_alerts)
		switch(selected_alert)
			if("vhungry")
				be_known(sfx = MEOW_CRITICAL, speech = pick(hunger_critical))
				return
			if("vtired")
				be_known(sfx = MEOW_CRITICAL, speech = pick(energy_critical))
				return

	if(!COOLDOWN_FINISHED(src, needs_alert))
		return // to not be too annoying

	if(hunger >= 70)
		tama_alerts += "hungry"
	if(happiness <= 30)
		tama_alerts += "sad"
	if(energy <= 30)
		tama_alerts += "tired"
	if(tama_alerts.len)
		COOLDOWN_START(src, needs_alert, update_rate * 2.25)
		selected_alert = pick(tama_alerts)
		switch(selected_alert)
			if("hungry")
				be_known(sfx = MEOW_SAD, speech = pick(hunger_warning))
			if("sad")
				be_known(sfx = MEOW_SAD, speech = pick(happiness_warning))
			if("tired")
				be_known(sfx = MEOW_SAD, speech = pick(energy_warning))
	else if(prob(25))
		be_known(sfx = MEOW_NORMAL)

/obj/item/toy/nyamagotchi/proc/be_known(sfx, speech, visible)
	if(!COOLDOWN_FINISHED(src, mute_pet))
		return

	if(!isnull(sfx))
		playsound(source = src, soundin = sfx, vol = 40, vary = TRUE, extrarange = SHORT_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE)

	if(!isnull(speech))
		say(speech, message_range = 2)

	if(!isnull(visible))
		balloon_alert_to_viewers(message = visible, vision_distance = COMBAT_MESSAGE_RANGE + 2)

// Interactions
/obj/item/toy/nyamagotchi/proc/action_check()
	if(!isnull(last_task))
		usr.balloon_alert(usr, "still [last_task]!")
		be_known(sfx = MEOW_SAD)
		return FALSE
	return TRUE

/obj/item/toy/nyamagotchi/proc/feed()
	if(!action_check())
		return
	else if(hunger > 20)
		hunger -= min(rand(30, 40), hunger)
		to_chat(usr, span_purple("You fed [src]! Its hunger is now at [hunger]."))
		be_known(sfx = EAT_FOOD, speech = pick(feed_messages))
		last_task = "eating"
	else
		usr.balloon_alert(usr, "not hungry!")

/obj/item/toy/nyamagotchi/proc/play()
	if(!action_check())
		return
	else if(happiness < 80)
		happiness += min(rand(30, 40), 100 - happiness)
		to_chat(usr, span_purple("You play with [src]! Its happiness is now [happiness]."))
		be_known(sfx = PURR_PLAY, speech = pick(play_messages))
		last_task = "playing"
	else
		usr.balloon_alert(usr, "not bored!")

/obj/item/toy/nyamagotchi/proc/rest()
	if(!action_check())
		return
	else if(energy < 80)
		energy += min(rand(30, 40), 100 - energy)
		to_chat(usr, span_purple("[src] rests and regains energy. Its energy is now [energy]."))
		be_known(sfx = PURR_SLEEP, speech = pick(rest_messages))
		last_task = "resting"
	else
		usr.balloon_alert(usr, "not tired!")

// Function for when the nyamagotchi dies
/obj/item/toy/nyamagotchi/proc/die()
	last_task = null
	alive = ANIMAL_DEAD
	audible_message(span_warning("[src] makes a weak, sad noise and then goes silent... Rest in peace."), hearing_distance = COMBAT_MESSAGE_RANGE)
	if(ishuman(loc))
		to_chat(loc, span_warning("[src] shows an x3 on its display. It's dead. You're a terrible person."))
	//src.icon_state = "dead"
	be_known(sfx = 'sound/misc/sadtrombone.ogg', visible = "nyamagotchi died!")
	update_available_icons()

/obj/item/toy/nyamagotchi/proc/check_status()
	balloon_alert(usr, "hunger: [hunger] happiness: [happiness] energy: [energy]")

/datum/action/item_action/nyamagotchi_menu
	name = "Check Nyamagotchi"
	button_icon = 'modular_zubbers/icons/obj/toys/toys.dmi'
	button_icon_state = "nya"

/datum/job/psychologist/New()
	LAZYADDASSOC(mail_goodies, /obj/item/toy/nyamagotchi, 45)
	. = ..()

/obj/effect/spawner/random/entertainment/dice
	name = "dice spawner"
	icon_state = "dice_bag"
	spawn_loot_count = 3
	spawn_loot_double = FALSE
	spawn_loot_split = TRUE
	loot = list(
		/obj/item/dice/d4,
		/obj/item/dice/d6,
		/obj/item/dice/d8,
		/obj/item/dice/d10,
		/obj/item/dice/d12,
		/obj/item/dice/d20,
		/obj/item/dice/fourdd6,
		/obj/item/toy/nyamagotchi,
	)

#undef NO_ANIMAL
#undef ANIMAL_ALIVE
#undef ANIMAL_DEAD

#undef MEOW_NORMAL
#undef MEOW_SAD
#undef MEOW_CRITICAL
#undef EAT_FOOD
#undef PURR_PLAY
#undef PURR_SLEEP
