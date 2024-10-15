//////////////////////////////////////
///////ENTHRAL VELVET CHORDS//////////
//////////////////////////////////////

//Heavily modified voice of god code
/obj/item/organ/internal/vocal_cords/velvet
	name = "Velvet chords"
	desc = "The voice spoken from these just make you want to drift off, sleep and obey."
	icon = 'modular_zubbers/code/modules/mkultra/vocal_cords.dmi'
	icon_state = "velvet_chords"
	actions_types = list(/datum/action/item_action/organ_action/velvet)
	spans = list("velvet")

/datum/action/item_action/organ_action/velvet
	name = "Velvet chords"
	var/obj/item/organ/internal/vocal_cords/velvet/cords = null

/datum/action/item_action/organ_action/velvet/New()
	..()
	cords = target

/datum/action/item_action/organ_action/velvet/IsAvailable(feedback = TRUE)
	return TRUE

/datum/action/item_action/organ_action/velvet/Trigger(trigger_flags)
	. = ..()
	var/command = input(owner, "Speak in a sultry tone", "Command")
	if(QDELETED(src) || QDELETED(owner))
		return
	if(!command)
		return
	owner.say(".x[command]")

/obj/item/organ/internal/vocal_cords/velvet/can_speak_with()
	return TRUE

/obj/item/organ/internal/vocal_cords/velvet/handle_speech(message) //actually say the message
	owner.say(message, spans = spans, sanitize = FALSE)
	velvetspeech(message, owner, 1)

//////////////////////////////////////
///////////FermiChem//////////////////
//////////////////////////////////////
//Removed span_list from input arguments.
/proc/velvetspeech(message, mob/living/user, base_multiplier = 1, message_admins = FALSE, debug = FALSE)

	if(!user || !user.can_speak() || user.stat)
		return 0 //no cooldown

	var/log_message = message

	//FIND THRALLS
	message = lowertext(message)
	var/list/mob/living/listeners = list()
	for(var/mob/living/L in get_hearers_in_view(8, user))
		if(L.can_hear() && L.stat != DEAD)
			if(L.has_status_effect(/datum/status_effect/chem/enthrall))//Check to see if they have the status
				var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)//Check to see if pet is on cooldown from last command and if the master is right
				if(E.master != user)
					continue
				if(ishuman(L))
					var/mob/living/carbon/human/H = L
					if(istype(H.ears, /obj/item/clothing/ears/earmuffs))
						continue

				if (E.cooldown > 0)//If they're on cooldown you can't give them more commands.
					continue
				listeners += L

	if(!listeners.len)
		return 0

	//POWER CALCULATIONS

	var/power_multiplier = base_multiplier

	// Not sure I want to give extra power to anyone at the moment...? We'll see how it turns out
	if(user.mind)
		//Chaplains are very good at indoctrinating
		if(user.mind.assigned_role == "Chaplain")
			power_multiplier *= 1.2

	//Cultists are closer to their gods and are better at indoctrinating
	if(IS_CULTIST(user))
		power_multiplier *= 1.2
	else if (IS_CLOCK(user))
		power_multiplier *= 1.2

	//range = 0.5 - 1.4~
	//most cases = 1

	//Try to check if the speaker specified a name or a job to focus on
	var/list/specific_listeners = list()
	var/found_string = null

	//Get the proper job titles
	message = get_full_job_name(message)

	for(var/V in listeners)
		var/mob/living/L = V
		if(findtext(message, L.real_name, 1, length(L.real_name) + 1))
			specific_listeners += L //focus on those with the specified name
			//Cut out the name so it doesn't trigger commands
			found_string = L.real_name
			power_multiplier += 0.5

		else if(findtext(message, L.first_name(), 1, length(L.first_name()) + 1))
			specific_listeners += L //focus on those with the specified name
			//Cut out the name so it doesn't trigger commands
			found_string = L.first_name()
			power_multiplier += 0.5

		else if(L.mind && L.mind.assigned_role && findtext(message, L.mind.assigned_role, 1, length(L.mind.assigned_role) + 1))
			specific_listeners += L //focus on those with the specified job
			//Cut out the job so it doesn't trigger commands
			found_string = L.mind.assigned_role
			power_multiplier += 0.25

	if(specific_listeners.len)
		listeners = specific_listeners
		//power_multiplier *= (1 + (1/specific_listeners.len)) //Put this is if it becomes OP, power is judged internally on a thrall, so shouldn't be nessicary.
		message = copytext(message, length(found_string) + 1)//I have no idea what this does

	if(debug == TRUE)
		to_chat(world, "[user]'s power is [power_multiplier].")

	//Mixables
	var/static/regex/enthrall_words = regex("relax|obey|love|serve|so easy|ara ara")
	var/static/regex/reward_words = regex("good boy|good girl|good pet|good job|good")
	var/static/regex/punish_words = regex("bad boy|bad girl|bad pet|bad job|bad")
	//phase 0
	var/static/regex/saymyname_words = regex("say my name|who am i")
	var/static/regex/wakeup_words = regex("revert|awaken|snap|attention")
	//phase1
	var/static/regex/petstatus_words = regex("how are you|what is your status|are you okay")
	var/static/regex/silence_words = regex("shut up|silence|be silent|shh|quiet|hush")
	var/static/regex/speak_words = regex("talk to me|speak")
	var/static/regex/antiresist_words = regex("unable to resist|give in|stop being difficult")//useful if you think your target is resisting a lot
	var/static/regex/resist_words = regex("resist|snap out of it|fight")//useful if two enthrallers are fighting
	var/static/regex/forget_words = regex("forget|muddled|awake and forget")
	var/static/regex/attract_words = regex("come here|come to me|get over here|attract")
	//phase 2
	var/static/regex/sleep_words = regex("sleep|slumber|rest")
	var/static/regex/strip_words = regex("strip|derobe|nude|at ease|suit off")
	var/static/regex/walk_words = regex("slow down|walk")
	var/static/regex/run_words = regex("run|speed up")
	var/static/regex/liedown_words = regex("lie down")
	var/static/regex/knockdown_words = regex("drop|fall|trip|knockdown|kneel|army crawl")
	//phase 3
	var/static/regex/statecustom_words = regex("state triggers|state your triggers")
	var/static/regex/custom_words = regex("new trigger|listen to me")
	var/static/regex/custom_words_words = regex("speak|echo|shock|kneel|strip|trance")//What a descriptive name!
	var/static/regex/custom_echo = regex("obsess|fills your mind|loop")
	var/static/regex/instill_words = regex("feel|entice|overwhelm")
	var/static/regex/recognise_words = regex("recognise me|did you miss me?")
	var/static/regex/objective_words = regex("new objective|obey this command|unable to resist|compelled")
	var/static/regex/heal_words = regex("live|heal|survive|mend|life")
	var/static/regex/stun_words = regex("stop|wait|stand still|hold on|halt")
	var/static/regex/hallucinate_words = regex("get high|hallucinate|trip balls")
	var/static/regex/hot_words = regex("heat|hot|hell")
	var/static/regex/cold_words = regex("cold|cool down|chill|freeze")
	var/static/regex/getup_words = regex("get up|hop to it")
	var/static/regex/pacify_words = regex("docile|complacent|friendly|pacifist")
	var/static/regex/charge_words = regex("charge|oorah|attack")

	var/distancelist = list(2,2,1.5,1.3,1.15,1,0.8,0.6,0.5,0.25)

	//CALLBACKS ARE USED FOR MESSAGES BECAUSE SAY IS HANDLED AFTER THE PROCESSING.

	//Tier 1
	//ENTHRAL mixable (works I think)
	if(findtext(message, enthrall_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			power_multiplier *= distancelist[get_dist(user, V)+1]
			if(L == user)
				continue
			if(length(message))
				E.enthrallTally += (power_multiplier*(((length(message))/200) + 1)) //encourage players to say more than one word.
			else
				E.enthrallTally += power_multiplier*1.25 //thinking about it, I don't know how this can proc
			if(E.lewd)
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='nicegreen'><i><b>[E.enthrallGender] is so nice to listen to.</b></i></span>"), 5)
			E.cooldown += 1

	//REWARD mixable works
	if(findtext(message, reward_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			power_multiplier *= distancelist[get_dist(user, V)+1]
			if(L == user)
				continue
			if (E.lewd)
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='love'>[E.enthrallGender] has praised me!!</span>"), 5)
				if(HAS_TRAIT(L, TRAIT_MASOCHISM))
					E.enthrallTally -= power_multiplier
					E.resistanceTally += power_multiplier
					E.cooldown += 1
			else
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='nicegreen'><b><i>I've been praised for doing a good job!</b></i></span>"), 5)
			E.resistanceTally -= power_multiplier
			E.enthrallTally += power_multiplier
			var/descmessage = "<span class='love'><i>[(E.lewd?"I feel so happy! I'm a good pet who [E.enthrallGender] loves!":"I did a good job!")]</i></span>"
			L.add_mood_event("enthrallpraise", /datum/mood_event/enthrallpraise, descmessage)
			E.cooldown += 1

	//PUNISH mixable  works
	else if(findtext(message, punish_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			var/descmessage = "[(E.lewd?"I've failed [E.enthrallGender]... What a bad, bad pet!":"I did a bad job...")]"
			if(L == user)
				continue
			if (E.lewd)
				if(HAS_TRAIT(L, TRAIT_MASOCHISM))
					if(ishuman(L))
						var/mob/living/carbon/human/H = L
						H.adjust_arousal(3*power_multiplier)
					descmessage += "And yet, it feels so good..!</span>" //I don't really understand masco, is this the right sort of thing they like?
					E.enthrallTally += power_multiplier
					E.resistanceTally -= power_multiplier
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='love'>I've let [E.enthrallGender] down...!</b></span>"), 5)
				else
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='warning'>I've let [E.enthrallGender] down...</b></span>"), 5)
			else
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='warning'>I've failed [E.master]...</b></span>"), 5)
				E.resistanceTally += power_multiplier
				E.enthrallTally += power_multiplier
				E.cooldown += 1
			L.add_mood_event("enthrallscold", /datum/mood_event/enthrallscold, descmessage)
			E.cooldown += 1



	//tier 0
	//SAY MY NAME works
	if((findtext(message, saymyname_words)))
		for(var/V in listeners)
			var/mob/living/carbon/C = V
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			REMOVE_TRAIT(C, TRAIT_MUTE, "enthrall")
			if(E.lewd)
				addtimer(CALLBACK(C, /atom/movable/proc/say, "[E.enthrallGender]"), 5)
			else
				addtimer(CALLBACK(C, /atom/movable/proc/say, "[E.master]"), 5)

	//WAKE UP
	else if((findtext(message, wakeup_words)))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			L.SetSleeping(0)//Can you hear while asleep?
			switch(E.phase)
				if(0)
					E.phase = 3
					E.status = null
					user.emote("snap")
					if(E.lewd)
						addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='big warning'>The snapping of your [E.enthrallGender]'s fingers brings you back to your enthralled state, obedient and ready to serve.</b></span>"), 5)
					else
						addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='big warning'>The snapping of [E.master]'s fingers brings you back to being under their influence.</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You wake up [L]!</i></span>")

	//tier 1

	//PETSTATUS i.e. how they are
	else if((findtext(message, petstatus_words)))
		for(var/V in listeners)
			var/mob/living/carbon/human/H = V
			var/datum/status_effect/chem/enthrall/E = H.has_status_effect(/datum/status_effect/chem/enthrall)
			REMOVE_TRAIT(H, TRAIT_MUTE, "enthrall")
			var/speaktrigger = ""
			//phase
			switch(E.phase)
				if(0)
					continue
				if(1)
					addtimer(CALLBACK(H, /atom/movable/proc/say, "I feel happy being with you."), 5)
					continue
				if(2)
					speaktrigger += "[(E.lewd?"I think I'm in love with you... ":"I find you really inspirational, ")]" //'
				if(3)
					speaktrigger += "[(E.lewd?"I'm devoted to being your pet":"I'm commited to following your cause!")]! "
				if(4)
					speaktrigger += "[(E.lewd?"You are my whole world and all of my being belongs to you, ":"I cannot think of anything else but aiding your cause, ")] "//Redflags!!

			//mood
			if(H.mob_mood)
				switch(H.mob_mood.sanity_level)
					if(SANITY_GREAT to INFINITY)
						speaktrigger += "I'm beyond elated!! " //did you mean byond elated? hohoho
					if(SANITY_NEUTRAL to SANITY_GREAT)
						speaktrigger += "I'm really happy! "
					if(SANITY_DISTURBED to SANITY_NEUTRAL)
						speaktrigger += "I'm a little sad, "
					if(SANITY_UNSTABLE to SANITY_DISTURBED)
						speaktrigger += "I'm really upset, "
					if(SANITY_CRAZY to SANITY_UNSTABLE)
						speaktrigger += "I'm about to fall apart without you! "
					if(SANITY_INSANE to SANITY_CRAZY)
						speaktrigger += "Hold me, please.. "

			//Withdrawal
			switch(E.withdrawalTick)
				if(10 to 36) //denial
					speaktrigger += "I missed you, "
				if(36 to 66) //barganing
					speaktrigger += "I missed you, but I knew you'd come back for me! "
				if(66 to 90) //anger
					speaktrigger += "I couldn't take being away from you like that, "
				if(90 to 140) //depression
					speaktrigger += "I was so scared you'd never come back, "
				if(140 to INFINITY) //acceptance
					speaktrigger += "I'm hurt that you left me like that... I felt so alone... "

			//hunger
			switch(H.nutrition)
				if(0 to NUTRITION_LEVEL_STARVING)
					speaktrigger += "I'm famished, please feed me..! "
				if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_HUNGRY)
					speaktrigger += "I'm so hungry... "
				if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
					speaktrigger += "I'm hungry, "
				if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
					speaktrigger += "I'm sated, "
				if(NUTRITION_LEVEL_WELL_FED to NUTRITION_LEVEL_FULL)
					speaktrigger += "I've a full belly! "
				if(NUTRITION_LEVEL_FULL to INFINITY)
					speaktrigger += "I'm fat... "

			//health
			switch(H.health)
				if(100 to INFINITY)
					speaktrigger += "I feel fit, "
				if(80 to 99)
					speaktrigger += "I ache a little bit, "
				if(40 to 80)
					speaktrigger += "I'm really hurt, "
				if(0 to 40)
					speaktrigger += "I'm in a lot of pain, help! "
				if(-INFINITY to 0)
					speaktrigger += "I'm barely concious and in so much pain, please help me! "
			//toxin
			switch(H.getToxLoss())
				if(10 to 30)
					speaktrigger += "I feel a bit queasy... "
				if(30 to 60)
					speaktrigger += "I feel nauseous... "
				if(60 to INFINITY)
					speaktrigger += "My head is pounding and I feel like I'm going to be sick... "
			//oxygen
			if (H.getOxyLoss() >= 25)
				speaktrigger += "I can't breathe! "
			//deaf..?
			if (HAS_TRAIT(H, TRAIT_DEAF))//How the heck you managed to get here I have no idea, but just in case!
				speaktrigger += "I can barely hear you! "
			//And the brain damage. And the brain damage. And the brain damage. And the brain damage. And the brain damage.
			switch(H.get_organ_loss(ORGAN_SLOT_BRAIN))
				if(20 to 40)
					speaktrigger += "I have a mild head ache, "
				if(40 to 80)
					speaktrigger += "I feel disorentated and confused, "
				if(80 to 120)
					speaktrigger += "My head feels like it's about to explode, "
				if(120 to 160)
					speaktrigger += "You are the only thing keeping my mind sane, "
				if(160 to INFINITY)
					speaktrigger += "I feel like I'm on the brink of losing my mind, "

			//collar
			if(istype(H.wear_neck, /obj/item/clothing/neck/petcollar) && E.lewd)
				speaktrigger += "I love the collar you gave me, "
			//End
			if(E.lewd)
				speaktrigger += "[E.enthrallGender]!"
			else
				speaktrigger += "[user.first_name()]!"
			//say it!
			addtimer(CALLBACK(H, /atom/movable/proc/say, "[speaktrigger]"), 5)
			E.cooldown += 1

	//SILENCE
	else if((findtext(message, silence_words)))
		for(var/mob/living/carbon/C in listeners)
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			power_multiplier *= distancelist[get_dist(user, C)+1]
			if (E.phase >= 3) //If target is fully enthralled,
				ADD_TRAIT(C, TRAIT_MUTE, "enthrall")
			else
				C.adjust_silence((10 SECONDS * power_multiplier) * E.phase)
			addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='notice'>You are unable to speak!</b></span>"), 5)
			to_chat(user, "<span class='notice'><i>You silence [C].</i></span>")
			E.cooldown += 3

	//SPEAK
	else if((findtext(message, speak_words)))//fix
		for(var/mob/living/carbon/C in listeners)
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			REMOVE_TRAIT(C, TRAIT_MUTE, "enthrall")
			C.set_silence(0 SECONDS)
			E.cooldown += 3
			to_chat(user, "<span class='notice'><i>You [(E.lewd?"allow [C] to speak again":"encourage [C] to speak again")].</i></span>")


	//Antiresist
	else if((findtext(message, antiresist_words)))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			E.status = "Antiresist"
			addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='big warning'>Your mind clouds over, as you find yourself unable to resist!</b></span>"), 5)
			E.statusStrength = (1 * power_multiplier * E.phase)
			E.cooldown += 15//Too short? yes, made 15
			to_chat(user, "<span class='notice'><i>You frustrate [L]'s attempts at resisting.</i></span>")

	//RESIST
	else if((findtext(message, resist_words)))
		for(var/mob/living/carbon/C in listeners)
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			power_multiplier *= distancelist[get_dist(user, C)+1]
			E.deltaResist += (power_multiplier)
			E.owner_resist()
			E.cooldown += 2
			addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='notice'>You are spurred into resisting from [user]'s words!'</b></span>"), 5)
			to_chat(user, "<span class='notice'><i>You spark resistance in [C].</i></span>")

	//FORGET (A way to cancel the process)
	else if((findtext(message, forget_words)))
		for(var/mob/living/carbon/C in listeners)
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			if(E.phase == 4)
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='warning'>You're unable to forget about [(E.lewd?"the dominating presence of [E.enthrallGender]":"[E.master]")]!</b></span>"), 5)
				continue
			addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='warning'>You wake up, forgetting everything that just happened. You must've dozed off..? How embarassing!</b></span>"), 5)
			C.Sleeping(50)
			switch(E.phase)
				if(1 to 2)
					E.phase = -1
					to_chat(C, "<span class='big warning'>You have no recollection of being enthralled by [E.master]!</b></span>")
					to_chat(user, "<span class='notice'><i>You revert [C] back to their state before enthrallment.</i></span>")
				if(3)
					E.phase = 0
					E.cooldown = 0
					if(E.lewd)
						addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='big warning'>You revert to yourself before being enthralled by your [E.enthrallGender], with no memory of what happened.</b></span>"), 5)
					else
						addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='big warning'>You revert to who you were before, with no memory of what happened with [E.master].</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You put [C] into a sleeper state, ready to turn them back at the snap of your fingers.</i></span>")

	//ATTRACT
	else if((findtext(message, attract_words)))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			L.throw_at(get_step_towards(user,L), 3 * power_multiplier, 1 * power_multiplier)
			E.cooldown += 3
			addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You are drawn towards [user]!</b></span>"), 5)
			to_chat(user, "<span class='notice'><i>You draw [L] towards you!</i></span>")

	//SLEEP
	else if((findtext(message, sleep_words)))
		for(var/mob/living/carbon/C in listeners)
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(2 to INFINITY)
					C.Sleeping(45 * power_multiplier)
					E.cooldown += 10
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='notice'>Drowsiness suddenly overwhelms you as you fall asleep!</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You send [C] to sleep.</i></span>")

	//STRIP
	else if((findtext(message, strip_words)))
		for(var/V in listeners)
			var/mob/living/carbon/human/H = V
			var/datum/status_effect/chem/enthrall/E = H.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(2 to INFINITY)
					var/items = H.get_contents()
					for(var/obj/item/W in items)
						if(W == H.wear_suit)
							H.dropItemToGround(W, TRUE)
							return
						if(W == H.w_uniform && W != H.wear_suit)
							H.dropItemToGround(W, TRUE)
							return
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, H, "<span class='[(E.lewd?"love":"warning")]'>Before you can even think about it, you quickly remove your clothes in response to [(E.lewd?"your [E.enthrallGender]'s command'":"[E.master]'s directive'")].</b></span>"), 5)
					E.cooldown += 10

	//WALK
	else if((findtext(message, walk_words)))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(2 to INFINITY)
					if(L.move_intent != MOVE_INTENT_WALK)
						L.toggle_move_intent()
						E.cooldown += 1
						addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You slow down to a walk.</b></span>"), 5)
						to_chat(user, "<span class='notice'><i>You encourage [L] to slow down.</i></span>")

	//RUN
	else if((findtext(message, run_words)))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(2 to INFINITY)
					if(L.move_intent != MOVE_INTENT_RUN)
						L.toggle_move_intent()
						E.cooldown += 1
						addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You speed up into a jog!</b></span>"), 5)
						to_chat(user, "<span class='notice'><i>You encourage [L] to pick up the pace!</i></span>")

	//LIE DOWN
	else if(findtext(message, liedown_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(2 to INFINITY)
					L.toggle_resting()
					E.cooldown += 10
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "[(E.lewd?"<span class='love'>You eagerly lie down!":"<span class='notice'>You suddenly lie down!")]</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You encourage [L] to lie down.</i></span>")

	//KNOCKDOWN
	else if(findtext(message, knockdown_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(2 to INFINITY)
					L.StaminaKnockdown(30 * power_multiplier * E.phase)
					E.cooldown += 8
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You suddenly drop to the ground!</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You encourage [L] to drop down to the ground.</i></span>")

	//tier3

	//STATE TRIGGERS
	else if((findtext(message, statecustom_words)))//doesn't work
		for(var/V in listeners)
			var/mob/living/carbon/C = V
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			if (E.phase == 3)
				var/speaktrigger = ""
				C.emote("me", EMOTE_VISIBLE, "whispers something quietly.")
				if (get_dist(user, C) > 1)//Requires user to be next to their pet.
					to_chat(user, "<span class='warning'>You need to be next to your pet to hear them!</b></span>")
					continue
				for (var/trigger in E.customTriggers)
					speaktrigger += "[trigger], "
				to_chat(user, "<b>[C]</b> whispers, \"<i>[speaktrigger] are my triggers.</i>\"")//So they don't trigger themselves!
				addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, C, "<span class='notice'>You whisper your triggers to [(E.lewd?"Your [E.enthrallGender]":"[E.master]")].</span>"), 5)


	//CUSTOM TRIGGERS
	else if((findtext(message, custom_words)))
		for(var/V in listeners)
			var/mob/living/carbon/human/H = V
			var/datum/status_effect/chem/enthrall/E = H.has_status_effect(/datum/status_effect/chem/enthrall)
			if(E.phase == 3)
				if (get_dist(user, H) > 1)//Requires user to be next to their pet.
					to_chat(user, "<span class='warning'>You need to be next to your pet to give them a new trigger!</b></span>")
					continue
				if(!E.lewd)
					to_chat(user, "<span class='warning'>[H] seems incapable of being implanted with triggers.</b></span>")
					continue
				else
					user.emote("me", EMOTE_VISIBLE, "puts their hands upon [H.name]'s head and looks deep into their eyes, whispering something to them.")
					user.SetStun(1000)//Hands are handy, so you have to stay still
					H.SetStun(1000)
					if (E.mental_capacity >= 5)
						var/trigger = html_decode(stripped_input(user, "Enter the trigger phrase", MAX_MESSAGE_LEN))
						var/custom_words_words_list = list("Speak", "Echo", "Shock", "Kneel", "Strip", "Trance", "Cancel")
						var/trigger2 = input(user, "Pick an effect", "Effects") in custom_words_words_list
						trigger2 = lowertext(trigger2)
						if ((findtext(trigger2, custom_words_words)))
							if (trigger2 == "speak" || trigger2 == "echo")
								var/trigger3 = html_decode(stripped_input(user, "Enter the phrase spoken. Abusing this to self antag is bannable.", MAX_MESSAGE_LEN))
								E.customTriggers[trigger] = list(trigger2, trigger3)
								if(findtext(trigger3, "admin"))
									message_admins("FERMICHEM: [user] maybe be trying to abuse MKUltra by implanting by [H] with [trigger], triggering [trigger2], to send [trigger3].")
							else
								E.customTriggers[trigger] = trigger2
							E.mental_capacity -= 5
							addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, H, "<span class='notice'>[(E.lewd?"your [E.enthrallGender]":"[E.master]")] whispers you a new trigger.</span>"), 5)
							to_chat(user, "<span class='notice'><i>You sucessfully set the trigger word [trigger] in [H]</i></span>")
						else
							to_chat(user, "<span class='warning'>Your pet looks at you confused, it seems they don't understand that effect!</b></span>")
					else
						to_chat(user, "<span class='warning'>Your pet looks at you with a vacant blase expression, you don't think you can program anything else into them</b></span>")
					user.SetStun(0)
					H.SetStun(0)

	//CUSTOM ECHO
	else if((findtext(message, custom_echo)))
		for(var/V in listeners)
			var/mob/living/carbon/human/H = V
			var/datum/status_effect/chem/enthrall/E = H.has_status_effect(/datum/status_effect/chem/enthrall)
			if(E.phase == 3)
				if (get_dist(user, H) > 1)//Requires user to be next to their pet.
					to_chat(user, "<span class='warning'>You need to be next to your pet to give them a new echophrase!</b></span>")
					continue
				if(!E.lewd)
					to_chat(user, "<span class='warning'>[H] seems incapable of being implanted with an echoing phrase.</b></span>")
					continue
				else
					user.emote("me", EMOTE_VISIBLE, "puts their hands upon [H.name]'s head and looks deep into their eyes, whispering something to them.")
					user.SetStun(1000)//Hands are handy, so you have to stay still
					H.SetStun(1000)
					var/trigger = stripped_input(user, "Enter the loop phrase", MAX_MESSAGE_LEN)
					var/customSpan = list("Notice", "Warning", "Hypnophrase", "Love", "Velvet")
					var/trigger2 = input(user, "Pick the style", "Style") in customSpan
					trigger2 = lowertext(trigger2)
					E.customEcho = trigger
					E.customSpan = trigger2
					user.SetStun(0)
					H.SetStun(0)
					to_chat(user, "<span class='notice'><i>You sucessfully set an echoing phrase in [H]</i></span>")

	//CUSTOM OBJECTIVE
	else if((findtext(message, objective_words)))
		for(var/V in listeners)
			var/mob/living/carbon/human/H = V
			var/datum/status_effect/chem/enthrall/E = H.has_status_effect(/datum/status_effect/chem/enthrall)
			if(E.phase == 3)
				if (get_dist(user, H) > 1)//Requires user to be next to their pet.
					to_chat(user, "<span class='warning'>You need to be next to your pet to give them a new objective!</b></span>")
					continue
				else
					user.emote("me", EMOTE_VISIBLE, "puts their hands upon [H.name]'s head and looks deep into their eyes, whispering something to them.'")
					user.SetStun(1000)//So you can't run away!
					H.SetStun(1000)
					if (E.mental_capacity >= 200)
						var/datum/objective/brainwashing/objective = stripped_input(user, "Add an objective to give your pet.", MAX_MESSAGE_LEN)
						if(!LAZYLEN(objective))
							to_chat(user, "<span class='warning'>You can't give your pet an objective to do nothing!</b></span>")
							continue
						//Pets don't understand harm
						objective = replacetext(lowertext(objective), "kill", "hug")
						objective = replacetext(lowertext(objective), "murder", "cuddle")
						objective = replacetext(lowertext(objective), "harm", "snuggle")
						objective = replacetext(lowertext(objective), "decapitate", "headpat")
						objective = replacetext(lowertext(objective), "strangle", "meow at")
						objective = replacetext(lowertext(objective), "suicide", "self-love")
						message_admins("[H] has been implanted by [user] with the objective [objective].")
						addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, H, "<span class='notice'>[(E.lewd?"Your [E.enthrallGender]":"[E.master]")] whispers you a new objective.</span>"), 5)
						brainwash(H, objective)
						E.mental_capacity -= 200
						to_chat(user, "<span class='notice'><i>You sucessfully give an objective to [H]</i></span>")
					else
						to_chat(user, "<span class='warning'>Your pet looks at you with a vacant blasé expression, you don't think you can program anything else into them</b></span>")
					user.SetStun(0)
					H.SetStun(0)

	//INSTILL
	else if((findtext(message, instill_words)))
		for(var/V in listeners)
			var/mob/living/carbon/human/H = V
			var/datum/status_effect/chem/enthrall/E = H.has_status_effect(/datum/status_effect/chem/enthrall)
			if(E.phase >= 3 && E.lewd)
				var/instill = stripped_input(user, "Instill an emotion in [H].", MAX_MESSAGE_LEN)
				to_chat(H, "<i>[instill]</i>")
				to_chat(user, "<span class='notice'><i>You sucessfully instill a feeling in [H]</i></span>")
				E.cooldown += 1

	//RECOGNISE
	else if((findtext(message, recognise_words)))
		for(var/V in listeners)
			var/mob/living/carbon/human/H = V
			var/datum/status_effect/chem/enthrall/E = H.has_status_effect(/datum/status_effect/chem/enthrall)
			if(E.phase > 1)
				if(user.ckey == E.enthrallID && user.real_name == E.master.real_name)
					E.master = user
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, H, "<span class='nicegreen'>[(E.lewd?"You hear the words of your [E.enthrallGender] again!! They're back!!":"You recognise the voice of [E.master].")]</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>[H] looks at you with sparkling eyes, recognising you!</i></span>")

	//I dunno how to do state objectives without them revealing they're an antag

	//HEAL (maybe make this nap instead?)
	else if(findtext(message, heal_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3)//Tier 3 only
					E.status = "heal"
					E.statusStrength = (5 * power_multiplier)
					E.cooldown += 5
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You begin to lick your wounds.</b></span>"), 5)
					L.Stun(15 * power_multiplier)
					to_chat(user, "<span class='notice'><i>[L] begins to lick their wounds.</i></span>")

	//STUN
	else if(findtext(message, stun_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3 to INFINITY)
					L.Stun(40 * power_multiplier)
					E.cooldown += 8
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>Your muscles freeze up!</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You cause [L] to freeze up!</i></span>")

	//HALLUCINATE
	else if(findtext(message, hallucinate_words))
		for(var/V in listeners)
			var/mob/living/carbon/C = V
			var/datum/status_effect/chem/enthrall/E = C.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3 to INFINITY)
					new /datum/hallucination/delusion(C, TRUE, null,150 * power_multiplier,0)
					to_chat(user, "<span class='notice'><i>You send [C] on a trip.</i></span>")

	//HOT
	else if(findtext(message, hot_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3 to INFINITY)
					L.adjust_bodytemperature(50 * power_multiplier)//This seems nuts, reduced it, but then it didn't do anything, so I reverted it.
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You feel your metabolism speed up!</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You speed [L]'s metabolism up!</i></span>")

	//COLD
	else if(findtext(message, cold_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3 to INFINITY)
					L.adjust_bodytemperature(-50 * power_multiplier)
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You feel your metabolism slow down!</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You slow [L]'s metabolism down!</i></span>")

	//GET UP
	else if(findtext(message, getup_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3 to INFINITY)//Tier 3 only
					L.set_resting(FALSE, TRUE, FALSE)
					L.SetAllImmobility(0)
					L.SetUnconscious(0) //i said get up i don't care if you're being tased
					E.cooldown += 10 //This could be really strong
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You jump to your feet from sheer willpower!</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You spur [L] to their feet!</i></span>")

	//PACIFY
	else if(findtext(message, pacify_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3)//Tier 3 only
					E.status = "pacify"
					E.cooldown += 10
					addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, L, "<span class='notice'>You feel like never hurting anyone ever again.</b></span>"), 5)
					to_chat(user, "<span class='notice'><i>You remove any intent to harm from [L]'s mind.</i></span>")

	//CHARGE
	else if(findtext(message, charge_words))
		for(var/V in listeners)
			var/mob/living/L = V
			var/datum/status_effect/chem/enthrall/E = L.has_status_effect(/datum/status_effect/chem/enthrall)
			switch(E.phase)
				if(3)//Tier 3 only
					E.statusStrength = 2* power_multiplier
					E.status = "charge"
					E.cooldown += 10
					to_chat(user, "<span class='notice'><i>You rally [L], leading them into a charge!</i></span>")

	if(message_admins || debug)//Do you want this in?
		message_admins("[ADMIN_LOOKUPFLW(user)] has said '[log_message]' with a Velvet Voice, affecting [english_list(listeners)], with a power multiplier of [power_multiplier].")
	SSblackbox.record_feedback("tally", "fermi_chem", 1, "Times people have spoken with a velvet voice")
	//SSblackbox.record_feedback("tally", "Velvet_voice", 1, log_message) If this is on, it fills the thing up and OOFs the server

	return
