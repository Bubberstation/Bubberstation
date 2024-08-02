/* Certain emotes are currently missing mime varaints.
*/


/*///How confused a carbon must be before they will vomit
#define BEYBLADE_PUKE_THRESHOLD (30 SECONDS)
///How must nutrition is lost when a carbon pukes
#define BEYBLADE_PUKE_NUTRIENT_LOSS 60
///How often a carbon becomes penalized
#define BEYBLADE_DIZZINESS_PROBABILITY 20
///How long the screenshake lasts
#define BEYBLADE_DIZZINESS_DURATION (20 SECONDS)
///How much confusion a carbon gets every time they are penalized
#define BEYBLADE_CONFUSION_INCREMENT (10 SECONDS)
///A max for how much confusion a carbon will be for beyblading
#define BEYBLADE_CONFUSION_LIMIT (40 SECONDS)
*/

/datum/emote/living/ruffle
	key = "ruffle"
	key_third_person = "ruffles"
	message = "ruffles [user.p_their()] wings for a moment."

/datum/emote/living/mew
	key = "mew"
	key_third_person = "mews"
	message = "mews hysterically!"
	message_mime = "makes a cat face!"
	sound = 'modular_zzplurt/sound/voice/meow_meme.ogg'
	cooldown = 1 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fart
	key = "fart"
	key_third_person = "farts"
	message = "farts out shitcode."
	cooldown = 3 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fart/run_emote(mob/user, params, type_override, intentional)
	var/list/fart_emotes = list( //cope goonies
		"lets out a girly little 'toot' from [user.p_their()] butt.",
		"farts loudly!",
		"lets one rip!",
		"farts! It sounds wet and smells like rotten eggs.",
		"farts robustly!",
		"farted! It smells like something died.",
		"farts like a muppet!",
		"defiles the station's air supply.",
		"farts for a whole ten seconds.",
		"groans and moans, farting like the world depended on it.",
		"breaks wind!",
		"expels intestinal gas through [user.p_their()] anus.",
		"releases an audible discharge of intestinal gas.",
		"is a farting motherfucker!!!",
		"suffers from flatulence!",
		"releases flatus.",
		"releases methane.",
		"farts up a storm.",
		"farts. It smells like Soylent Surprise!",
		"farts. It smells like pizza!",
		"farts. It smells like George Melons' perfume!",
		"farts. It smells like the kitchen!",
		"farts. It smells like medbay in here now!",
		"farts. It smells like the bridge in here now!",
		"farts like a pubby!",
		"farts like a goone!",
		"sharts! That's just nasty.",
		"farts delicately.",
		"farts timidly.",
		"farts very, very quietly. The stench is OVERPOWERING.",
		"farts egregiously.",
		"farts voraciously.",
		"farts cantankerously.",
		"farts in [user.p_their()] own mouth. A shameful \the <b>[user]</b>.",
		"breaks wind noisily!",
		"releases gas with the power of the gods! The very station trembles!!",
		"<B><span style='color:red'>f</span><span style='color:blue'>a</span>r<span style='color:red'>t</span><span style='color:blue'>s</span>!</B>",
		"laughs! [user.p_their(TRUE)] breath smells like a fart.",
		"farts, and as such, blob cannot evoulate.",
		"farts. It might have been the Citizen Kane of farts."
	)
	message = pick(fart_emotes)
	. = ..()

/datum/emote/living/fart/get_sound(mob/living/user)
	return pick(GLOB.brap_noises)

/datum/emote/living/speen
	key = "speen"
	key_third_person ="speens"
	message = "speeeeens!"
	message_mime = "speeeeens silently!"
	sound = 'modular_zzplurt/sound/voice/speen.ogg'
	hands_use_check = TRUE

/datum/emote/living/speen/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	user.spin(20, 1)
/*
/datum/emote/living/speen/check_cooldown(mob/user, intentional)
	. = ..()
	if(.)
		return
	if(!can_run_emote(user, intentional=intentional))
		return
	if(!iscarbon(user))
		return

	if(user.get_timed_status_effect_duration(/datum/status_effect/confusion) > BEYBLADE_PUKE_THRESHOLD)
		user.vomit(VOMIT_CATEGORY_KNOCKDOWN, lost_nutrition = BEYBLADE_PUKE_NUTRIENT_LOSS, distance = 0)
		return

	if(prob(BEYBLADE_DIZZINESS_PROBABILITY))
		to_chat(user, span_warning("You feel woozy from spinning."))
		user.set_dizzy_if_lower(BEYBLADE_DIZZINESS_DURATION)
		user.adjust_confusion_up_to(BEYBLADE_CONFUSION_INCREMENT, BEYBLADE_CONFUSION_LIMIT)
*/

/datum/emote/living/burp/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/list/burp_noises = list(
		'modular_zzplurt/sound/voice/burps/belch1.ogg','modular_zzplurt/sound/voice/burps/belch2.ogg','modular_zzplurt/sound/voice/burps/belch3.ogg','modular_zzplurt/sound/voice/burps/belch4.ogg',
		'modular_zzplurt/sound/voice/burps/belch5.ogg','modular_zzplurt/sound/voice/burps/belch6.ogg','modular_zzplurt/sound/voice/burps/belch7.ogg','modular_zzplurt/sound/voice/burps/belch8.ogg',
		'modular_zzplurt/sound/voice/burps/belch9.ogg','modular_zzplurt/sound/voice/burps/belch10.ogg','modular_zzplurt/sound/voice/burps/belch11.ogg','modular_zzplurt/sound/voice/burps/belch12.ogg',
		'modular_zzplurt/sound/voice/burps/belch13.ogg','modular_zzplurt/sound/voice/burps/belch14.ogg','modular_zzplurt/sound/voice/burps/belch15.ogg'
	)
	if(.)
		playsound(user, pick(burp_noises), 50, 1)

/datum/emote/living/bleat
	key = "bleat"
	key_third_person = "bleats"
	message = "bleats loudly!"
	message_mime = "bleats silently!"
	sound = 'modular_zzplurt/sound/voice/bleat.ogg'
	cooldown = 0.7 SECONDS

/*
/datum/emote/living/carbon/moan/run_emote(mob/user, params, type_override, intentional)
	if(user.nextsoundemote >= world.time || user.stat != CONSCIOUS)
		return
	var/sound
	var/miming = user.mind ? user.mind.miming : 0
	if(!user.is_muzzled() && !miming)
		user.nextsoundemote = world.time + 7
		sound = pick('modular_zzplurt/soundvoice/moan_m1.ogg','modular_zzplurt/sound/voice/moan_m2.ogg','modular_zzplurt/sound/voice/moan_m3.ogg')
		if(user.gender == FEMALE)
			sound - pick('modular_zzplurt/sound/voice/moan_f1.ogg','modular_zzplurt/sound/voice/moan_f2.ogg','modular_zzplurt/sound/voice/moan_f3.ogg','modular_zzplurt/sound/voice/moan_f4.ogg','modular_zzplurt/sound/voice/moan_f5.ogg','modular_zzplurt/sound/voice/moan_f6.ogg','modular_zzplurt/sound/voice/moan_f7.ogg')
		if(isalien(user))
			sound = 'sound/voice/hiss6.ogg'
		//playlewdinteractionsound(user.loc, sound, 50, 1, 4, 1.2)
		message = "moans!"
	else if(minming)
		message = "acts out a moan."
	else
		message = "makes a very loud noise."
	. = ..()
*/

/datum/emote/living/chitter2
	key = "chitter2"
	key_third_person = "chitters2"
	message = "chitters."
	message_mime = "chitters silently!"
	sound = 'modular_zzplurt/sound/voice/moth/mothchitter2.ogg'
	audio_cooldown = 0.3 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/monkeytwerk
	key = "twerk"
	key_third_person = "twerks"
	message = "shakes it harder than James Russle himself!"
	sound = 'modular_zzplurt/sound/misc/monkey_twerk.ogg'
	audio_cooldown = 3.2 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bruh
	key = "bruh"
	key_third_person = "bruhs"
	message = "thinks this is a bruh moment."
	message_mime = "silently acknowledges the bruh moment."
	sound = 'modular_zzplurt/sound/voice/bruh.ogg'
	audio_cooldown = 0.6 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bababooey
	key = "bababooey"
	key_third_person = "bababooeys"
	message = "spews bababooey."
	message_mime = "spews something silently."
	sound = 'modt/sound/voice/bababooey/bababooey.ogg'
	audio_cooldown = 0.9 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bababooey/run_emote(mob/user, params)
 	// Check if user is muzzled
	if(user.is_muzzled())
 		// Set muzzled sound
		sound = 'modular_zzplurt/sound/voice/bababooey/ffff.ogg'

// 	// User is not muzzled
	else
		// Set random emote sound
		sound = pick('modular_zzplurt/sound/voice/bababooey/bababooey.ogg', 'modular_zzplurt/sound/voice/bababooey/bababooey2.ogg')

 	// Return normally
	. = ..()

/datum/emote/living/babafooey
	key = "babafooey"
	key_third_person = "babafooeys"
	message = "spews babafooey."
	message_mime = "spews something silently."
	sound = 'modular_zzplurt/sound/voice/bababooey/babafooey.ogg'
	audio_cooldown = 0.85 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fafafooey
	key = "fafafooey"
	key_third_person = "fafafooeys"
	message = "spews fafafooey."
	message_mime = "spews something silently."
	sound = 'modular_zzplurt/sound/voice/bababooey/fafafooey.ogg'
	audio_cooldown = 0.7 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fafafooey/run_emote(mob/user, params)
 	// Check if user is muzzled
	if(user.is_muzzled())
		// Set muzzled sound
		sound = 'modular_zzplurt/sound/voice/bababooey/ffff.ogg'

	// User is not muzzled
	else
		// Set random emote sound
		sound = pick('modular_zzplurt/sound/voice/bababooey/fafafooey.ogg', 'modular_zzplurt/sound/voice/bababooey/fafafooey2.ogg', 'modular_zzplurt/sound/voice/bababooey/fafafooey3.ogg')

	// Return normally
	. = ..()

/datum/emote/living/fafafoggy
	key = "fafafoggy"
	key_third_person = "fafafoggys"
	message = "spews fafafoggy."
	message_mime = "spews something silently."
	sound = 'modular_zzplurt/sound/voice/bababooey/fafafoggy.ogg'
	audio_cooldown = 0.9 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fafafoggy/run_emote(mob/user, params)
	// Check if user is muzzled
	if(user.is_muzzled())
		// Set muzzled sound
		sound = 'modular_zzplurt/sound/voice/bababooey/ffff.ogg'

	// User is not muzzled
	else
		// Set random emote sound
		sound = pick('modular_zzplurt/sound/voice/bababooey/fafafoggy.ogg', 'modular_zzplurt/sound/voice/bababooey/fafafoggy2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/hohohoy
	key = "hohohoy"
	key_third_person = "hohohoys"
	message = "spews hohohoy."
	message_mime = "spews something silently."
	sound = 'modular_zzplurt/sound/voice/bababooey/hohohoy.ogg'
	audio_cooldown = 0.7 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/ffff
	key = "ffff"
	key_third_person = "ffffs"
	message = "spews something softly."
	message_mime = "spews something silently."
	muzzle_ignore = TRUE
	sound = 'modular_zzplurt/sound/voice/bababooey/ffff.ogg'
	audio_cooldown = 0.85 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fafafail
	key = "fafafail"
	key_third_person = "fafafails"
	message = "spews something unintelligible."
	message_mime = "spews something silent."
	sound = 'modular_zzplurt/sound/voice/bababooey/ffffhvh.ogg'
	audio_cooldown = 1.15 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/boowomp
	key = "boowomp"
	key_third_person = "boowomps"
	message = "produces a sad boowomp."
	message_mime = "produces a silent boowomp."
	sound = 'modular_zzplurt/sound/voice/boowomp.ogg'
	audio_cooldown = 0.4 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/swaos
	key = "swaos"
	key_third_person = "swaos"
	message = "mutters swaos."
	message_mime = "imitates swaos."
	sound = 'modular_zzplurt/sound/voice/swaos.ogg'
	audio_cooldown = 0.7 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/eyebrow2
	key = "eyebrow2"
	key_third_person = "eyebrows2"
	message = "<b>raises an eyebrow.</b>"
	message_mime = "<b>raises an eyebrow with quaking force!</b>"
	sound = 'modular_zzplurt/sound/voice/vineboom.ogg'
	audio_cooldown = 2.9 SECONDS
	emote_type = EMOTE_VISIBLE

/datum/emote/living/eyebrow3
	key = "eyebrow3"
	key_third_person = "eyebrows3"
	message = "raises an eyebrow <i>quizzaciously</i>."
	sound = 'modular_zzplurt/sound/voice/moonmen.ogg'
	audio_cooldown = 7 SECONDS
	emote_type = EMOTE_VISIBLE

/datum/emote/living/blink3
	key = "blink3"
	key_third_person = "blinks3"
	message = "blinks."
	message_mime = "blinks expressively."
	sound = 'modular_zzplurt/sound/voice/blink.ogg'
	audio_cooldown = 0.25 SECONDS
	emote_type = EMOTE_VISIBLE

/datum/emote/living/laugh2
	key = "laugh2"
	key_third_person = "laughs2"
	message = "laughs like a king."
	message_mime = "acts out laughing like a king."
	sound = 'modular_zzplurt/sound/voice/laugh_king.ogg'
	// No cooldown var required
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/laugh3
	key = "laugh3"
	key_third_person = "laughs3"
	message = "laughs silly."
	message_mime = "acts out laughing silly."
	sound = 'modular_zzplurt/sound/voice/lol.ogg'
	audio_cooldown = 6.1 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/laugh4
	key = "laugh4"
	key_third_person = "laughs4"
	message = "burst into laughter!"
	message_mime = "acts out bursting into laughter."
	sound = 'modular_zzplurt/sound/voice/laugh_muta.ogg'
	audio_cooldown = 3 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/laugh5
	key = "laugh5"
	key_third_person = "laughs5"
	message = "laughs in Scottish."
	message_mime = "acts out laughing in Scottish."
	sound = 'modular_zzplurt/sound/voice/laugh_deman.ogg'
	audio_cooldown = 2.75 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/laugh6
	key = "laugh6"
	key_third_person = "laughs6"
	message = "laughs like a kettle!"
	message_mime = "acts out laughing like a kettle."
	sound = 'modular_zzplurt/sound/voice/laugh6.ogg'
	audio_cooldown = 4.45 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/breakbad
	key = "breakbad"
	key_third_person = "breakbads"
	message = "stares intensively with determination."
	sound = 'modular_zzplurt/sound/voice/breakbad.ogg'
	audio_cooldown = 6.4 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/lawyerup
	key = "lawyerup"
	key_third_person = "lawyerups"
	message = "emits an aura of expertise."
	sound = 'modular_zzplurt/sound/voice/lawyerup.ogg'
	audio_cooldown = 7.5 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/goddamn
	key = "damn"
	key_third_person = "damns"
	message = "is in utter stupor."
	message_mime = "appears to be in utter stupor."
	sound = 'modular_zzplurt/sound/voice/god_damn.ogg'
	audio_cooldown = 1.25 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/spoonful
	key = "spoonful"
	key_third_person = "spoonfuls"
	message = "asks for a spoonful."
	message_mime = "pretends to ask for a spoonful."
	sound = 'modular_zzplurt/sound/voice/spoonful.ogg'
	// No cooldown var required
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/ohhmygod
	key = "mygod"
	key_third_person = "omgs"
	message = "invokes the presence of Jesus Christ."
	message_mime = "invokes the presence of Jesus Christ through silent prayer."
	sound = 'modular_zzplurt/sound/voice/OMG.ogg'
	audio_cooldown = 1.6 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/whatthehell
	key = "wth"
	key_third_person = "wths"
	message = "condemns the abysses of hell!"
	message_mime = "silently condemns the abysses of hell!"
	sound = 'modular_zzplurt/sound/voice/WTH.ogg'
	audio_cooldown = 4.4 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fusrodah
	key = "fusrodah"
	key_third_person = "furodahs"
	message = "yells, \"<b>FUS RO DAH!!!</b>\""
	message_mime = "acts out a dragon shout."
	sound = 'modular_zzplurt/sound/voice/fusrodah.ogg'
	audio_cooldown = 7 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/skibidi
	key = "skibidi"
	key_third_person = "skibidis"
	message = "yells, \"<b>Skibidi bop mm dada!</b>\""
	message_mime = "makes incoherent mouth motions."
	sound = 'modular_zzplurt/sound/voice/skibidi.ogg'
	audio_cooldown = 1.1 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/fbi
	key = "fbi"
	key_third_person = "fbis"
	message = "yells, \"<b>FBI OPEN UP!</b>\""
	message_mime = "acts out being the FBI."
	sound = 'modular_zzplurt/sound/voice/fbi.ogg'
	audio_cooldown = 2 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/illuminati
	key = "illuminati"
	key_third_person = "illuminatis"
	message = "exudes a mysterious aura!"
	sound = 'modular_zzplurt/sound/voice/illuminati.ogg'
	audio_cooldown = 7.8 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bonerif
	key = "bonerif"
	key_third_person = "bonerifs"
	message = "riffs!"
	message_mime = "riffs silently!"
	sound = 'modular_zzplurt/sound/voice/bonerif.ogg'
	audio_cooldown = 2 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cry2
	key = "cry2"
	key_third_person = "cries2"
	message = "cries like a king."
	message_mime = "acts out crying like a king."
	sound = 'modular_zzplurt/sound/voice/cry_king.ogg'
	audio_cooldown = 1.6 SECONDS // Uses longest sound's time
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cry2/run_emote(mob/user, params)
	// Set random emote sound
	sound = pick('modular_zzplurt/sound/voice/cry_king.ogg', 'modular_zzplurt/sound/voice/cry_king2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/choir
	key = "choir"
	key_third_person = "choirs"
	message = "let out a choir!"
	message_mime = "acts out a choir."
	sound = 'modular_zzplurt/sound/voice/choir.ogg'
	audio_cooldown = 6 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/agony
	key = "agony"
	key_third_person = "agonys"
	message = "let out a choir of agony!"
	message_mime = "is visibly in agony."
	sound = 'modular_zzplurt/sound/voice/agony.ogg'
	audio_cooldown = 7 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/wtune
	key = "whistletune"
	key_third_person = "whistletunes"
	message = "whistles a tune."
	message_mime = "makes an expression as if whistling."
	sound = 'modular_zzplurt/sound/voice/wtune1.ogg'
	audio_cooldown = 4.55 SECONDS // Uses longest sound's time.
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/wtune/run_emote(mob/user, params)
	// Set random emote sound
	sound = pick('modular_zzplurt/sound/voice/wtune1.ogg', 'modular_zzplurt/sound/voice/wtune2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/fiufiu
	key = "wolfwhistle"
	key_third_person = "wolfwhistles"
	message = "wolf-whistles!" // i am not creative
	message_param = "audibly approves %t's appearance."
	message_mime = "makes an expression as if <i>inappropriately</i> whistling."
	sound = 'modular_zzplurt/sound/voice/wolfwhistle.ogg'
	audio_cooldown = 0.78 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/terror
	key = "terror"
	key_third_person = "terrors"
	message = "whistles some dreadful tune..."
	message_mime = "stares with aura full of dread..."
	sound = 'modular_zzplurt/sound/voice/terror1.ogg'
	audio_cooldown = 13.07 SECONDS // Uses longest sound's time.
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/terror/run_emote(mob/user, params)
	// Set random emote sound
	sound = pick('modular_zzplurt/sound/voice/terror1.ogg', 'modular_zzplurt/sound/voice/terror2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/deathglare
	key = "glare2"
	key_third_person = "glares2"
	message = "<b><i>glares</b></i>."
	message_param = "<b><i>glares</b></i> at %t."
	sound = 'modular_zzplurt/sound/voice/deathglare.ogg'
	audio_cooldown = 4.4 SECONDS
	emote_type = EMOTE_VISIBLE
	is_muzzled = FALSE

/datum/emote/living/sicko
	key = "sicko"
	key_third_person = "sickos"
	message = "briefly goes sicko mode!"
	message_mime = "briefly imitates sicko mode!"
	sound = 'modular_zzplurt/sound/voice/sicko.ogg'
	audio_cooldown = 0.8 SECONDS
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/chill
	key = "chill"
	key_third_person = "chills"
	message = "feels a chill running down their spine..."
	message_mime = "acts out a chill running down their spine..."
	sound = 'modular_zzplurt/sound/voice/waterphone.ogg'
	audio_cooldown = 3.4 SECONDS
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/taunt
	key = "tt"
	key_third_person = "taunts"
	message = "strikes a pose!"
	message_param = "taunts %t!"
	sound = 'modular_zzplurt/sound/voice/phillyhit.ogg'
	emote_type = EMOTE_VISIBLE
	is_muzzled = FALSE

/datum/emote/living/taunt/alt
	key = "tt2"
	key_third_person = "taunts2"
	sound_volume = 100
	sound = 'modular_zzplurt/sound/voice/orchestrahit.ogg'
	emote_type = EMOTE_VISIBLE

/datum/emote/living/weh2
	key = "weh2"
	key_third_person = "wehs2"
	message = "let out a weh!"
	message_mime = "acts out a weh!"
	sound = 'modular_zzplurt/sound/voice/weh2.ogg'
	audio_cooldown = 0.25 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/weh3
	key = "weh3"
	key_third_person = "wehs3"
	message = "let out a weh!"
	message_mime = "acts out a weh!"
	sound = 'modular_zzplurt/sound/voice/weh3.ogg'
	audio_cooldown = 0.25 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/weh4
	key = "weh4"
	key_third_person = "wehs4"
	message = "let out a surprised weh!"
	message_mime = "acts out a surprised weh!"
	sound = 'modular_zzplurt/sound/voice/weh_s.ogg'
	audio_cooldown = 0.35 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/waa
	key = "waa"
	key_third_person = "waas"
	message = "let out a waa!"
	message_mime = "acts out a waa!"
	sound = 'modular_zzplurt/sound/voice/waa.ogg'
	audio_cooldown = 3.5 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bark2
	key = "bark2"
	key_third_person = "barks2"
	message = "barks!"
	message_mime = "acts out a bark!"
	sound = 'modular_zzplurt/sound/voice/bark_alt.ogg'
	audio_cooldown = 0.35 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/yap
	key = "yap"
	key_third_person = "yaps"
	message = "yaps!"
	message_mime = "acts out a yap!"
	sound = 'modular_zzplurt/sound/voice/yap.ogg'
	audio_cooldown = 0.28 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/yip
	key = "yip"
	key_third_person = "yips"
	message = "yips!"
	message_mime = "acts out a yip!"
	sound = 'modular_zzplurt/sound/voice/yip.ogg'
	audio_cooldown = 0.2 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/woof/alt
	key = "woof2"
	key_third_person = "woofs2"
	sound = 'modular_zzplurt/sound/voice/woof2.ogg'
	audio_cooldown = 0.3 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/coyhowl
	key = "coyhowl"
	key_third_person = "coyhowls"
	message = "howls like coyote!"
	message_mime = "acts out a coyote's howl!"
	sound = 'modular_zzplurt/sound/voice/coyotehowl.ogg'
	audio_cooldown = 2.94 SECONDS // Uses longest sound's time
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/coyhowl/run_emote(mob/user, params)
	sound = pick('modular_zzplurt/sound/voice/coyotehowl.ogg', 'modular_zzplurt/sound/voice/coyotehowl2.ogg', 'modular_zzplurt/sound/voice/coyotehowl3.ogg', 'modular_zzplurt/sound/voice/coyotehowl4.ogg', 'modular_zzplurt/sound/voice/coyotehowl5.ogg')
	. = ..()

/datum/emote/living/mlem
	key = "mlem"
	key_third_person = "mlems"
	message = "sticks their tongue for a moment. Mlem!"
	emote_type = EMOTE_VISIBLE

/datum/emote/living/snore/snore2
	key = "snore2"
	key_third_person = "snores2"
	message = "lets out an <b>earthshaking</b> snore"
	message_mime = "lets out an <b>inaudible</b> snore!"
	sound = 'modular_zzplurt/sound/voice/aauugghh1.ogg'
	audio_cooldown = 2.1 SECONDS
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snore/snore2/run_emote(mob/user, params)
	var/datum/dna/D = user.has_dna()
	var/say_mod = (D ? D.species.say_mod : "says")
	var/list/aaauughh = list(
		"lets out an <b>earthshaking</b> snore.",
		"lets out what sounds like a <b>painful</b> snore.",
		"[say_mod], <b>\"AAAAAAUUUUUUGGGHHHHH!!!\"</b>"
	)
	message = pick(aaauughh)

	// Set random emote sound
	sound = pick('modular_zzplurt/sound/voice/aauugghh1.ogg', 'modular_zzplurt/sound/voice/aauugghh2.ogg')

	// Return normally
	. = ..()

/datum/emote/living/pant
	key = "pant"
	key_third_person = "pants"
	message = "pants!"

/datum/emote/living/pant/run_emote(mob/user, params, type_override, intentional)
	var/list/pants = list(
				"pants!",
		"pants like a dog.",
		"lets out soft pants.",
		"pulls [user.p_their()] tongue out, panting."
	)
	message = pick(pants)
	. = ..()

/datum/emote/living/yippee
	key = "yippee"
	key_third_person = "yippees"
	message = "lets out a yippee!"
	message_mime = "acts out a yippee!"
	sound =
	cooldown = 1.2 SECONDS

/datum/emote/living/mewo
	key = "mewo"
	key_thr


/*
#undef BEYBLADE_PUKE_THRESHOLD
#undef BEYBLADE_PUKE_NUTRIENT_LOSS
#undef BEYBLADE_DIZZINESS_PROBABILITY
#undef BEYBLADE_DIZZINESS_DURATION
#undef BEYBLADE_CONFUSION_INCREMENT
#undef BEYBLADE_CONFUSION_LIMIT
*/
