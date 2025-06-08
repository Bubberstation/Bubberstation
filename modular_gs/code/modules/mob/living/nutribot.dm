//nutribot
//nutribot PATHFINDING
//nutribot ASSEMBLY
#define NUTRIBOT_PANIC_NONE	0
#define NUTRIBOT_PANIC_LOW	15
#define NUTRIBOT_PANIC_MED	35
#define NUTRIBOT_PANIC_HIGH	55
#define NUTRIBOT_PANIC_FUCK	70
#define NUTRIBOT_PANIC_ENDING	90
#define NUTRIBOT_PANIC_END	100

/mob/living/simple_animal/bot/nutribot
	name = "\improper Nutribot"
	desc = "A little nutritional robot. He looks somewhat underwhelmed."
	icon = 'modular_gs/icons/mob/nutribot.dmi'
	icon_state = "nutribot0"
	density = FALSE
	anchored = FALSE
	health = 20
	maxHealth = 20
	pass_flags = PASSMOB

	status_flags = (CANPUSH | CANSTUN)

	radio_key = /obj/item/encryptionkey/headset_med
	radio_channel = RADIO_CHANNEL_SERVICE

	bot_type = MED_BOT
	model = "Nutribot"
	bot_core_type = /obj/machinery/bot_core/nutribot
	window_id = "auto_nutrition"
	window_name = "Automatic Nutritional Unit v1.1"
	data_hud_type = DATA_HUD_MEDICAL_ADVANCED
	path_image_color = "#DDDDFF"

	var/obj/item/reagent_containers/glass/reagent_glass = null //Can be set to draw from this for reagents.
	var/skin = null //Set to "tox", "ointment" or "o2" for the other two firstaid kits.
	var/mob/living/carbon/patient = null
	var/mob/living/carbon/oldpatient = null
	var/oldloc = null
	var/last_found = 0
	var/last_newpatient_speak = 0 //Don't spam the "HEY I'M COMING" messages
	var/injection_amount = 15 //How much reagent do we inject at a time?
	var/feed_threshold = 200 // The weight that people should be fed to!
	var/use_beaker = 0 //Use reagents in beaker instead of default treatment agents.
	var/declare_cooldown = 0 //Prevents spam of critical patient alerts.
	var/stationary_mode = 0 //If enabled, the Nutribot will not move automatically.
	//Setting which reagents to use to treat what by default. By id.
	var/treatment_thin = /datum/reagent/consumable/nutriment
	var/treatment_thirsty = /datum/reagent/water
	var/hunger_check = NUTRITION_LEVEL_HUNGRY
	var/shut_up = 0 //self explanatory :)

	//How panicked we are about being tipped over (why would you do this?)
	var/tipped_status = NUTRIBOT_PANIC_NONE
	//The name we got when we were tipped
	var/tipper_name
	//The last time we were tipped/righted and said a voice line, to avoid spam
	var/last_tipping_action_voice = 0


/mob/living/simple_animal/bot/nutribot/update_icon()
	cut_overlays()
	if(!on)
		icon_state = "nutribot0"
		return
	if(IsStun())
		icon_state = "nutribota"
		return
	if(mode == BOT_HEALING)
		icon_state = "nutribots[stationary_mode]"
		return
	else if(stationary_mode) //Bot has yellow light to indicate stationary mode.
		icon_state = "nutribot2"
	else
		icon_state = "nutribot1"

/mob/living/simple_animal/bot/nutribot/Initialize(mapload, new_skin)
	. = ..()
	var/datum/job/cook/J = new /datum/job/cook
	access_card.access += J.get_access()
	prev_access = access_card.access
	qdel(J)
	skin = new_skin
	update_icon()

/mob/living/simple_animal/bot/nutribot/update_mobility()
	. = ..()
	update_icon()

/mob/living/simple_animal/bot/nutribot/bot_reset()
	..()
	patient = null
	oldpatient = null
	oldloc = null
	last_found = world.time
	declare_cooldown = 0
	update_icon()

/mob/living/simple_animal/bot/nutribot/proc/soft_reset() //Allows the Nutribot to still actively perform its medical duties without being completely halted as a hard reset does.
	path = list()
	patient = null
	mode = BOT_IDLE
	last_found = world.time
	update_icon()

/mob/living/simple_animal/bot/nutribot/set_custom_texts()

	text_hack = "You corrupt [name]'s reagent processor circuits."
	text_dehack = "You reset [name]'s reagent processor circuits."
	text_dehack_fail = "[name] seems damaged and does not respond to reprogramming!"

/mob/living/simple_animal/bot/nutribot/attack_paw(mob/user)
	return attack_hand(user)

/mob/living/simple_animal/bot/nutribot/proc/get_controls(mob/user)
	var/dat
	dat += "<TT><B>Nutritional Unit Controls v1.1</B></TT><BR><BR>"
	dat += "Status: <A href='?src=[REF(src)];power=1'>[on ? "On" : "Off"]</A><BR>"
	dat += "Maintenance panel panel is [open ? "opened" : "closed"]<BR>"
	dat += "Beaker: "
	if(reagent_glass)
		dat += "<A href='?src=[REF(src)];eject=1'>Loaded \[[reagent_glass.reagents.total_volume]/[reagent_glass.reagents.maximum_volume]\]</a>"
	else
		dat += "None Loaded"
	dat += "<br>Behaviour controls are [locked ? "locked" : "unlocked"]<hr>"
	if(!locked || issilicon(user) || IsAdminGhost(user))

		dat += "<TT>Feed Amount: "
		dat += "<a href='?src=[REF(src)];adj_inject=-5'>-</a> "
		dat += "[injection_amount] "
		dat += "<a href='?src=[REF(src)];adj_inject=5'>+</a> "
		dat += "</TT><br>"

		dat += "Reagent Source: "
		dat += "<a href='?src=[REF(src)];use_beaker=1'>[use_beaker ? "Loaded Beaker (When available)" : "Internal Synthesizer"]</a><br>"

		dat += "Hunger Check: "
		dat += "<a href='?src=[REF(src)];hunger_check=1'>[(hunger_check==NUTRITION_LEVEL_HUNGRY) ? "Yes" : "No"]</a><br>"

		dat += "<TT>Maximum BFI: "
		dat += "[feed_threshold ? feed_threshold : "???"] "
		dat += "<br>"
		dat += "Disable Maximum BFI: <a href='?src=[REF(src)];feed_threshold=1'>["Disable"]</a><br> "
		dat += "<a href='?src=[REF(src)];feed_threshold=-100'>-</a> "
		dat += "<a href='?src=[REF(src)];feed_threshold=100'>+</a> "
		dat += "</TT><br>"

		dat += "The speaker switch is [shut_up ? "off" : "on"]. <a href='?src=[REF(src)];togglevoice=[1]'>Toggle</a><br>"
		dat += "Patrol Station: <a href='?src=[REF(src)];operation=patrol'>[auto_patrol ? "Yes" : "No"]</a><br>"
		dat += "Stationary Mode: <a href='?src=[REF(src)];stationary=1'>[stationary_mode ? "Yes" : "No"]</a><br>"

	return dat

/mob/living/simple_animal/bot/nutribot/Topic(href, href_list)
	if(..())
		return TRUE

	else if(href_list["adj_inject"])
		var/adjust_num = text2num(href_list["adj_inject"])
		injection_amount += adjust_num
		if(injection_amount < 5)
			injection_amount = 5
		if(injection_amount > 15)
			injection_amount = 15

	else if(href_list["use_beaker"])
		use_beaker = !use_beaker

	else if(href_list["eject"] && (!isnull(reagent_glass)))
		reagent_glass.forceMove(drop_location())
		reagent_glass = null

	else if(href_list["togglevoice"])
		shut_up = !shut_up

	else if(href_list["stationary"])
		stationary_mode = !stationary_mode
		path = list()
		update_icon()

	else if(href_list["hunger_check"])
		hunger_check = ((hunger_check==NUTRITION_LEVEL_HUNGRY) ? NUTRITION_LEVEL_FULL : NUTRITION_LEVEL_HUNGRY)

	else if(href_list["feed_threshold"])
		var/adjust_num = text2num(href_list["feed_threshold"])
		feed_threshold += adjust_num
		if(adjust_num == 1)
			feed_threshold = 0
		if(feed_threshold < 0)
			feed_threshold = 0

	update_controls()
	return

/mob/living/simple_animal/bot/nutribot/attackby(obj/item/W as obj, mob/user as mob, params)
	if(istype(W, /obj/item/reagent_containers/glass))
		. = 1 //no afterattack
		if(locked)
			to_chat(user, "<span class='warning'>You cannot insert a beaker because the panel is locked!</span>")
			return
		if(!isnull(reagent_glass))
			to_chat(user, "<span class='warning'>There is already a beaker loaded!</span>")
			return
		if(!user.transferItemToLoc(W, src))
			return

		reagent_glass = W
		to_chat(user, "<span class='notice'>You insert [W].</span>")
		show_controls(user)

	else
		var/current_health = health
		..()
		if(health < current_health) //if nutribot took some damage
			step_to(src, (get_step_away(src,user)))

/mob/living/simple_animal/bot/nutribot/emag_act(mob/user)
	..()
	if(emagged == 2)
		if(user)
			to_chat(user, "<span class='notice'>You short out [src]'s reagent synthesis circuits.</span>")
		audible_message("<span class='danger'>[src] buzzes oddly!</span>")
		flick("nutribot_spark", src)
		playsound(src, "sparks", 75, 1)
		if(user)
			oldpatient = user

/mob/living/simple_animal/bot/nutribot/process_scan(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return

	if((H == oldpatient) && (world.time < last_found + 200))
		return

	if(assess_patient(H))
		last_found = world.time
		if((last_newpatient_speak + 300) < world.time) //Don't spam these messages!
			var/list/messagevoice = list("Hey, [H.name]! Hold on, I'm coming." = 'sound/voice/medbot/coming.ogg',"Wait [H.name]! I want to help!" = 'sound/voice/medbot/help.ogg')
			var/message = pick(messagevoice)
			if(prob(2) && ISINRANGE_EX(H.getFireLoss(), 0, 20))
				message = "Notices your minor burns*OwO what's this?"
				messagevoice[message] = 'sound/voice/medbot/owo.ogg'
			speak(message)
			playsound(loc, messagevoice[message], 50, 0)
			last_newpatient_speak = world.time
		return H
	else
		return

/mob/living/simple_animal/bot/nutribot/proc/tip_over(mob/user)
	mobility_flags &= ~MOBILITY_MOVE
	playsound(src, 'sound/machines/warning-buzzer.ogg', 50)
	user.visible_message("<span class='danger'>[user] tips over [src]!</span>", "<span class='danger'>You tip [src] over!</span>")
	mode = BOT_TIPPED
	var/matrix/mat = transform
	transform = mat.Turn(180)

/mob/living/simple_animal/bot/nutribot/proc/set_right(mob/user)
	mobility_flags &= MOBILITY_MOVE
	var/list/messagevoice
	if(user)
		user.visible_message("<span class='notice'>[user] sets [src] right-side up!</span>", "<span class='green'>You set [src] right-side up!</span>")
		if(user.name == tipper_name)
			messagevoice = list("I forgive you." = 'sound/voice/medbot/forgive.ogg')
		else
			messagevoice = list("Thank you!" = 'sound/voice/medbot/thank_you.ogg', "You are a good person." = 'sound/voice/medbot/youre_good.ogg')
	else
		visible_message("<span class='notice'>[src] manages to writhe wiggle enough to right itself.</span>")
		messagevoice = list("Fuck you." = 'sound/voice/medbot/fuck_you.ogg', "Your behavior has been reported, have a nice day." = 'sound/voice/medbot/reported.ogg')

	tipper_name = null
	if(world.time > last_tipping_action_voice + 15 SECONDS)
		last_tipping_action_voice = world.time
		var/message = pick(messagevoice)
		speak(message)
		playsound(src, messagevoice[message], 70)
	tipped_status = NUTRIBOT_PANIC_NONE
	mode = BOT_IDLE
	transform = matrix()

// if someone tipped us over, check whether we should ask for help or just right ourselves eventually
/mob/living/simple_animal/bot/nutribot/proc/handle_panic()
	tipped_status++
	var/list/messagevoice
	switch(tipped_status)
		if(NUTRIBOT_PANIC_LOW)
			messagevoice = list("I require assistance." = 'sound/voice/medbot/i_require_asst.ogg')
		if(NUTRIBOT_PANIC_MED)
			messagevoice = list("Please put me back." = 'sound/voice/medbot/please_put_me_back.ogg')
		if(NUTRIBOT_PANIC_HIGH)
			messagevoice = list("Please, I am scared!" = 'sound/voice/medbot/please_im_scared.ogg')
		if(NUTRIBOT_PANIC_FUCK)
			messagevoice = list("I don't like this, I need help!" = 'sound/voice/medbot/dont_like.ogg', "This hurts, my pain is real!" = 'sound/voice/medbot/pain_is_real.ogg')
		if(NUTRIBOT_PANIC_ENDING)
			messagevoice = list("Is this the end?" = 'sound/voice/medbot/is_this_the_end.ogg', "Nooo!" = 'sound/voice/medbot/nooo.ogg')
		if(NUTRIBOT_PANIC_END)
			speak("PSYCH ALERT: Crewmember [tipper_name] recorded displaying antisocial tendencies torturing bots in [get_area(src)]. Please schedule psych evaluation.", radio_channel)
			set_right() // strong independent nutribot

	if(prob(tipped_status))
		do_jitter_animation(tipped_status * 0.1)

	if(messagevoice)
		var/message = pick(messagevoice)
		speak(message)
		playsound(src, messagevoice[message], 70)
	else if(prob(tipped_status * 0.2))
		playsound(src, 'sound/machines/warning-buzzer.ogg', 30, extrarange=-2)

/mob/living/simple_animal/bot/nutribot/examine(mob/user)
	. = ..()
	if(tipped_status == NUTRIBOT_PANIC_NONE)
		return

	switch(tipped_status)
		if(NUTRIBOT_PANIC_NONE to NUTRIBOT_PANIC_LOW)
			. += "It appears to be tipped over, and is quietly waiting for someone to set it right."
		if(NUTRIBOT_PANIC_LOW to NUTRIBOT_PANIC_MED)
			. += "It is tipped over and requesting help."
		if(NUTRIBOT_PANIC_MED to NUTRIBOT_PANIC_HIGH)
			. += "They are tipped over and appear visibly distressed." // now we humanize the nutribot as a they, not an it
		if(NUTRIBOT_PANIC_HIGH to NUTRIBOT_PANIC_FUCK)
			. += "<span class='warning'>They are tipped over and visibly panicking!</span>"
		if(NUTRIBOT_PANIC_FUCK to INFINITY)
			. += "<span class='warning'><b>They are freaking out from being tipped over!</b></span>"

/mob/living/simple_animal/bot/nutribot/handle_automated_action()
	if(!..())
		return

	if(mode == BOT_TIPPED)
		handle_panic()
		return

	if(mode == BOT_HEALING)
		return

	if(IsStun())
		oldpatient = patient
		patient = null
		mode = BOT_IDLE
		return

	if(frustration > 8)
		oldpatient = patient
		soft_reset()

	if(QDELETED(patient))
		if(!shut_up && prob(1))
			if(emagged && prob(30))
				var/list/i_need_scissors = list('sound/voice/medbot/fuck_you.ogg', 'sound/voice/medbot/turn_off.ogg', 'sound/voice/medbot/im_different.ogg', 'sound/voice/medbot/close.ogg', 'sound/voice/medbot/shindemashou.ogg')
				playsound(src, pick(i_need_scissors), 70)
			else
				var/list/messagevoice = list("Radar, put a mask on!" = 'sound/voice/medbot/radar.ogg',"There's always a catch, and I'm the best there is." = 'sound/voice/medbot/catch.ogg',"I knew it, I should've been a plastic surgeon." = 'sound/voice/medbot/surgeon.ogg',"What kind of medbay is this? Everyone's dropping like flies." = 'sound/voice/medbot/flies.ogg',"Delicious!" = 'sound/voice/medbot/delicious.ogg', "Why are we still here? Just to suffer?" = 'sound/voice/medbot/why.ogg')
				var/message = pick(messagevoice)
				speak(message)
				playsound(src, messagevoice[message], 50)
		var/scan_range = (stationary_mode ? 1 : DEFAULT_SCAN_RANGE) //If in stationary mode, scan range is limited to adjacent patients.
		patient = scan(/mob/living/carbon/human, oldpatient, scan_range)
		oldpatient = patient

	if(patient && (get_dist(src,patient) <= 1)) //Patient is next to us, begin treatment!
		if(mode != BOT_HEALING)
			mode = BOT_HEALING
			update_icon()
			frustration = 0
			medicate_patient(patient)
		return

	//Patient has moved away from us!
	else if(patient && path.len && (get_dist(patient,path[path.len]) > 2))
		path = list()
		mode = BOT_IDLE
		last_found = world.time

	else if(stationary_mode && patient) //Since we cannot move in this mode, ignore the patient and wait for another.
		soft_reset()
		return

	if(patient && path.len == 0 && (get_dist(src,patient) > 1))
		path = get_path_to(src, get_turf(patient), /turf/proc/Distance_cardinal, 0, 30,id=access_card)
		mode = BOT_MOVING
		if(!path.len) //try to get closer if you can't reach the patient directly
			path = get_path_to(src, get_turf(patient), /turf/proc/Distance_cardinal, 0, 30,1,id=access_card)
			if(!path.len) //Do not chase a patient we cannot reach.
				soft_reset()

	if(path.len > 0 && patient)
		if(!bot_move(path[path.len]))
			oldpatient = patient
			soft_reset()
		return

	if(path.len > 8 && patient)
		frustration++

	if(auto_patrol && !stationary_mode && !patient)
		if(mode == BOT_IDLE || mode == BOT_START_PATROL)
			start_patrol()

		if(mode == BOT_PATROL)
			bot_patrol()

	return

/mob/living/simple_animal/bot/nutribot/proc/assess_patient(mob/living/carbon/C)
	//Time to see if they need medical help!
	if(C.stat == DEAD || (HAS_TRAIT(C, TRAIT_FAKEDEATH)))
		return FALSE	//welp too late for them!

	if(!(loc == C.loc) && !(isturf(C.loc) && isturf(loc)))
		return FALSE

	if(C.suiciding)
		return FALSE //Kevorkian school of robotic medical assistants.

	if(!C?.client?.prefs.bot_feeding)
		return FALSE

	if(emagged == 2) //Everyone needs our medicine. (Our medicine is corn oil)
		return TRUE

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if (H.wear_suit && H.head && istype(H.wear_suit, /obj/item/clothing) && istype(H.head, /obj/item/clothing))
			var/obj/item/clothing/CS = H.wear_suit
			var/obj/item/clothing/CH = H.head
			if (CS.clothing_flags & CH.clothing_flags & THICKMATERIAL)
				return FALSE // Skip over them if they have no exposed flesh.

	//if(declare_crit && C.health <= 0) //Critical condition! Call for help!
		//declare(C)

	//If they're injured, we're using a beaker, and don't have one of our WONDERCHEMS.
	if((reagent_glass) && (use_beaker) && (C.nutrition <= hunger_check) && ((C.fatness <= feed_threshold) || (feed_threshold == 0)))
		for(var/A in reagent_glass.reagents.reagent_list)
			var/datum/reagent/R = A
			if(!C.reagents.has_reagent(R.type))
				return TRUE

	//They're injured enough for it!

	//nutrition check
	if((C.nutrition <= hunger_check) && ((C.fatness <= feed_threshold) || (feed_threshold == 0)) && (!C.reagents.has_reagent(treatment_thin)))
		return TRUE //If they're already medicated don't bother!

	return FALSE

/mob/living/simple_animal/bot/nutribot/attack_hand(mob/living/carbon/human/H)
	if(H.a_intent == INTENT_DISARM && mode != BOT_TIPPED)
		H.visible_message("<span class='danger'>[H] begins tipping over [src].</span>", "<span class='warning'>You begin tipping over [src]...</span>")

		if(world.time > last_tipping_action_voice + 15 SECONDS)
			last_tipping_action_voice = world.time // message for tipping happens when we start interacting, message for righting comes after finishing
			var/list/messagevoice = list("Hey, wait..." = 'sound/voice/medbot/hey_wait.ogg',"Please don't..." = 'sound/voice/medbot/please_dont.ogg',"I trusted you..." = 'sound/voice/medbot/i_trusted_you.ogg', "Nooo..." = 'sound/voice/medbot/nooo.ogg', "Oh fuck-" = 'sound/voice/medbot/oh_fuck.ogg')
			var/message = pick(messagevoice)
			speak(message)
			playsound(src, messagevoice[message], 70, FALSE)

		if(do_after(H, 3 SECONDS, target=src))
			tip_over(H)

	else if(H.a_intent == INTENT_HELP && mode == BOT_TIPPED)
		H.visible_message("<span class='notice'>[H] begins righting [src].</span>", "<span class='notice'>You begin righting [src]...</span>")
		if(do_after(H, 3 SECONDS, target=src))
			set_right(H)
	else
		..()

/mob/living/simple_animal/bot/nutribot/UnarmedAttack(atom/A)
	if(iscarbon(A))
		var/mob/living/carbon/C = A
		patient = C
		mode = BOT_HEALING
		update_icon()
		medicate_patient(C)
		update_icon()
	else
		..()

/mob/living/simple_animal/bot/nutribot/examinate(atom/A as mob|obj|turf in view())
	..()
	if(!is_blind(src))
		chemscan(src, A)

/mob/living/simple_animal/bot/nutribot/proc/medicate_patient(mob/living/carbon/C)
	if(!on)
		return

	if(!istype(C))
		oldpatient = patient
		soft_reset()
		return

	if(C.stat == DEAD || (HAS_TRAIT(C, TRAIT_FAKEDEATH)))
		var/list/messagevoice = list("No! Stay with me!" = 'sound/voice/medbot/no.ogg',"Live, damnit! LIVE!" = 'sound/voice/medbot/live.ogg',"I...I've never lost a patient before. Not today, I mean." = 'sound/voice/medbot/lost.ogg')
		var/message = pick(messagevoice)
		speak(message)
		playsound(loc, messagevoice[message], 50, 0)
		oldpatient = patient
		soft_reset()
		return

	var/reagent_id = null

	if(emagged == 2) //Emagged! Time to poison everybody.
		reagent_id = /datum/reagent/consumable/cornoil //evil fucking check for a string as a reagent this shit is evil. its supposed to inject corn oil AND filzulphite but ill handle that later

	else

		if(!reagent_id && ((feed_threshold == 0) || (C.fatness <= feed_threshold)) && (C.nutrition <= hunger_check))
			if(!C.reagents.has_reagent(treatment_thin))
				reagent_id = treatment_thin

		//If the patient is injured but doesn't have our special reagent in them then we should give it to them first
		if(reagent_id && use_beaker && reagent_glass && reagent_glass.reagents.total_volume)
			for(var/A in reagent_glass.reagents.reagent_list)
				var/datum/reagent/R = A
				if(!C.reagents.has_reagent(R.type))
					reagent_id = "internal_beaker"
					break

	if(!reagent_id) //If they don't need any of that they're probably cured!
		if((C.nutrition >= hunger_check) || (C.fatness >= feed_threshold))
			to_chat(src, "<span class='notice'>[C] is full, or fat! Your programming prevents you from feeding anyone who is over the maximum weight, or doesn't need food!</span>")
		var/list/messagevoice = list("All patched up!" = 'sound/voice/medbot/patchedup.ogg',"An apple a day keeps me away." = 'sound/voice/medbot/apple.ogg',"Feel better soon!" = 'sound/voice/medbot/feelbetter.ogg')
		var/message = pick(messagevoice)
		speak(message)
		playsound(loc, messagevoice[message], 50, 0)
		bot_reset()
		return
	else
		if(!emagged && check_overdose(patient,reagent_id,injection_amount))
			soft_reset()
			return
		C.visible_message("<span class='danger'>[src] is trying to feed [patient]!</span>", \
			"<span class='userdanger'>[src] is trying to feed you!</span>")

		var/failed = FALSE
		if(do_mob(src, patient, 30))	//Is C == patient? This is so confusing
			if((get_dist(src, patient) <= 1) && (on) && assess_patient(patient))
				if(reagent_id == "internal_beaker")
					if(use_beaker && reagent_glass && reagent_glass.reagents.total_volume)
						var/fraction = min(injection_amount/reagent_glass.reagents.total_volume, 1)
						reagent_glass.reagents.reaction(patient, INJECT, fraction)
						reagent_glass.reagents.trans_to(patient,injection_amount) //Inject from beaker instead.
				else
					patient.reagents.add_reagent(reagent_id,injection_amount)
				C.visible_message("<span class='danger'>[src] feeds [patient] with its tube!</span>", \
					"<span class='userdanger'>[src] feeds you with its tube!</span>")
			else
				failed = TRUE
		else
			failed = TRUE

		if(failed)
			visible_message("[src] retracts its tube.")
		update_icon()
		soft_reset()
		return

/mob/living/simple_animal/bot/nutribot/proc/check_overdose(mob/living/carbon/patient,reagent_id,injection_amount)
	var/datum/reagent/R  = GLOB.chemical_reagents_list[reagent_id]
	if(!R.overdose_threshold) //Some chems do not have an OD threshold
		return FALSE
	var/current_volume = patient.reagents.get_reagent_amount(reagent_id)
	if(current_volume + injection_amount > R.overdose_threshold)
		return TRUE
	return FALSE

/mob/living/simple_animal/bot/nutribot/explode()
	on = FALSE
	visible_message("<span class='boldannounce'>[src] blows apart!</span>")
	var/atom/Tsec = drop_location()

	new /obj/item/stack/sheet/cardboard(Tsec)
	new /obj/item/assembly/prox_sensor(Tsec)
	new /obj/item/stack/sheet/mineral/calorite(Tsec)

	if(reagent_glass)
		drop_part(reagent_glass, Tsec)

	if(prob(50))
		drop_part(robot_arm, Tsec)

	if(emagged && prob(25))
		playsound(loc, 'sound/voice/medbot/insult.ogg', 50, 0)

	do_sparks(3, TRUE, src)
	..()

/obj/machinery/bot_core/nutribot
	req_one_access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_ROBOTICS)

/// Add these for now, until it is upgraded to TGUI.
/mob/living/simple_animal/bot/nutribot/proc/show_controls(mob/M)
	users |= M
	var/dat = ""
	dat = get_controls(M)
	var/datum/browser/popup = new(M,window_id,window_name,350,600)
	popup.set_content(dat)
	popup.open(use_onclose = 0)
	onclose(M,window_id,ref=src)
	return

/mob/living/simple_animal/bot/nutribot/proc/update_controls()
	for(var/mob/M in users)
		show_controls(M)

#undef NUTRIBOT_PANIC_NONE
#undef NUTRIBOT_PANIC_LOW
#undef NUTRIBOT_PANIC_MED
#undef NUTRIBOT_PANIC_HIGH
#undef NUTRIBOT_PANIC_FUCK
#undef NUTRIBOT_PANIC_ENDING
#undef NUTRIBOT_PANIC_END
