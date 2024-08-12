

/datum/emote/living/ruffle
	key = "ruffle"
	key_third_person = "ruffles"
	message = "ruffles their wings for a moment."

/datum/emote/living/ruffle/run_emote(mob/user, params, type_override, intentional)
	message = "ruffles [user.p_their()] wings for a moment."
	. = ..()

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

/datum/emote/living/speen/check_cooldown(mob/user, intentional)
	. = ..()
	if(.)
		return
	if(!can_run_emote(user, intentional=intentional))
		return
	if(!iscarbon(user))
		return


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
	sound = 'modular_zzplurt/sound/voice/bababooey/bababooey.ogg'
	audio_cooldown = 0.9 SECONDS
	emote_type = EMOTE_AUDIBLE

/*
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
*/

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

/*
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
*/

/datum/emote/living/fafafoggy
	key = "fafafoggy"
	key_third_person = "fafafoggys"
	message = "spews fafafoggy."
	message_mime = "spews something silently."
	sound = 'modular_zzplurt/sound/voice/bababooey/fafafoggy.ogg'
	audio_cooldown = 0.9 SECONDS
	emote_type = EMOTE_AUDIBLE

/*
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
*/

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
	//is_muzzled = FALSE

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
	//is_muzzled = FALSE

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
	sound = 'modular_zzplurt/sound/voice/yippee.ogg'
	cooldown = 1.2 SECONDS

/datum/emote/living/mewo
	key = "mewo"
	key_third_person = "mewos"
	message = "mewos!"
	message_mime = "mewos silently!"
	sound = 'modular_zzplurt/sound/voice/mewo.ogg'
	cooldown = 0.7 SECONDS

/datum/emote/living/ara_ara
	key = "ara"
	key_third_person = "aras"
	message = "coos with sultry surprise~..."
	message_mime = "exudes a sultry aura~"
	sound = 'modular_zzplurt/sound/voice/ara-ara.ogg'
	cooldown = 1.25 SECONDS

/datum/emote/living/ara_ara/alt
	key = "ara2"
	sound = 'modular_zzplurt/sound/voice/ara-ara2.ogg'
	cooldown = 1.25 SECONDS

/datum/emote/living/missouri
	key = "missouri"
	key_third_person = "missouris"
	message = "has relocated to Missouri."
	message_mime = "starts thinking about Missouri."
	sound = 'modular_zzplurt/sound/voice/missouri.ogg'
	cooldown = 3.4 SECONDS

/datum/emote/living/missouri/run_emote(mob/user, params, type_override, intentional)
	// Set message pronouns
	message = "appears to believe [user.p_theyre()] in Missouri."

	// Return normally
	. = ..()

/datum/emote/living/facemetacarpus
	key = "facehand"
	key_third_person = "facepalms"
	message = "creates an error in the code."
	//muzzle_ignore = TRUE
//	restraint_check = TRUE
	sound = 'modular_zzplurt/sound/effects/slap.ogg'
	var/metacarpus_type = "palm"
	cooldown = 0.25 SECONDS

/datum/emote/living/facemetacarpus/run_emote(mob/user, params, type_override, intentional)
	message = pick(list(
		"places [usr.p_their()] [metacarpus_type] across [usr.p_their()] face.",
			"lowers [usr.p_their()] face into [usr.p_their()] [metacarpus_type].",
			"face[metacarpus_type]s",
	))
	. = ..()

/datum/emote/living/facemetacarpus/paw
	key = "facepaw"
	key_third_person = "facepaws"
	metacarpus_type = "paw"

/datum/emote/living/facemetacarpus/claw
	key = "faceclaw"
	key_third_person = "faceclaws"
	metacarpus_type = "claw"

/datum/emote/living/facemetacarpus/wing
	key = "facewing"
	key_third_person = "facewings"
	metacarpus_type = "wing"

/datum/emote/living/facemetacarpus/hoof
	key = "facehoof"
	key_third_person = "facehoofs"
	metacarpus_type = "hoof"

/datum/emote/living/poyo
	key = "poyo"
	key_third_person = "poyos"
	message = "%SAYS, \"Poyo!\""
	message_mime = "acts out an excited motion!"
	sound = 'modular_zzplurt/sound/voice/barks/poyo.ogg'

/datum/emote/living/poyo/run_emote(mob/user, params, type_override, intentional)
	var/datum/dna/D = user.has_dna()
	var/say_mod = (D ? D.species.say_mod : "says")
	message = replacetextEx(message, "%SAYS", say_mod)
	. = ..()

/datum/emote/living/rizz
	key = "rizz"
	key_third_person = "rizzes"
	message = "gives <b>\[<u><i>The Look</i></u>\]</b>."
	message_param = "looks at %t with bedroom eyes."
	message_mime = "makes bedroom eyes."
	sound = 'modular_zzplurt/sound/voice/rizz.ogg'
	cooldown = 1.43 SECONDS

/datum/emote/living/buff
	key = "buff"
	key_third_person = "buffs"
	message = "shows off their muscles."
	message_param = "shows off their muscles to %t."
	sound = 'modular_zzplurt/sound/voice/buff.ogg'
	cooldown = 4.77 SECONDS
//  vary = FALSE

/datum/emote/living/merowr
	key = "merowr"
	key_third_person = "merowrs"
	message = "merowrs!"
	message_mime = "acts out a merowr!"
	sound = 'modular_zzplurt/sound/voice/merowr.ogg'
	cooldown = 1.2 SECONDS

/datum/emote/living/untitledgoose
	key = "goosehonk"
	key_third_person = "honks"
	message = "honks!"
	message_mime = "looks like a duck from hell!"
	sound = 'modular_zzplurt/sound/voice/goosehonk/sfx_goose_honk_b_01.ogg'
	cooldown = 0.8 SECONDS

/datum/emote/living/untitledgoose/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/goosehonk/sfx_goose_honk_b_01.ogg', 'modular_zzplurt/sound/voice/goosehonk/sfx_goose_honk_b_02.ogg','modular_zzplurt/sound/voice/goosehonk/sfx_goose_honk_b_03.ogg','modular_zzplurt/sound/voice/goosehonk/sfx_goose_honk_b_06.ogg')
	. = ..()

/datum/emote/living/untitledgooseB
	key = "goosehonkb"
	key_third_person = "honks differently!"
	message_mime = "looks like a duck from hell!"
	sound = 'modular_zzplurt/sound/voice/goosehonk/sfx_goose_honk_b_01.ogg'
	cooldown = 0.8 SECONDS

/datum/emote/untitledgooseB/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/goosehonk/sfx_gooseB_honk_02.ogg', 'modular_zzplurt/sound/voice/goosehonk/sfx_gooseB_honk_03.ogg', 'modular_zzplurt/sound/voice/goosehonk/sfx_gooseB_honk_04.ogg', 'modular_zzplurt/sound/voice/goosehonk/sfx_gooseB_honk_06.ogg', 'modular_zzplurt/sound/voice/goosehonk/sfx_gooseB_honk_07.ogg', 'modular_zzplurt/sound/voice/goosehonk/sfx_gooseB_honk_08.ogg', 'modular_zzplurt/sound/voice/goosehonk/sfx_gooseB_honk_09.ogg')
	. = ..()

/datum/emote/living/scream2
	key = "scream2"
	key_third_person = "screams2"
	message = "screams!"
	message_mime = "acts out a rather silly scream!"
	sound = 'modular_zzplurt/sound/voice/cscream1.ogg'
// 	vary = FALSE

/datum/emote/living/scream2/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/cscream1.ogg', 'modular_zzplurt/sound/voice/cscream2.ogg', 'modular_zzplurt/sound/voice/cscream3.ogg', 'modular_zzplurt/sound/voice/cscream4.ogg', 'modular_zzplurt/sound/voice/cscream5.ogg', 'modular_zzplurt/sound/voice/cscream6.ogg', 'modular_zzplurt/sound/voice/cscream7.ogg', 'modular_zzplurt/sound/voice/cscream8.ogg', 'modular_zzplurt/sound/voice/cscream9.ogg', 'modular_zzplurt/sound/voice/cscream10.ogg', 'modular_zzplurt/sound/voice/cscream11.ogg', 'modular_zzplurt/sound/voice/cscream12.ogg')
	. = ..()

/datum/emote/living/scream3
	key = "scream3"
	key_third_person = "screams3"
	message = "screams manly!"
	message_mime = "acts out a rather manly scream!"
	sound = 'modular_zzplurt/sound/voice/gachi/scream1.ogg'

/datum/emote/living/scream3/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/gachi/scream1.ogg', 'modular_zzplurt/sound/voice/gachi/scream2.ogg', 'modular_zzplurt/sound/voice/gachi/scream3.ogg', 'modular_zzplurt/sound/voice/gachi/scream4.ogg')
	. = ..()

/datum/emote/living/moan2
	key = "moan2"
	key_third_person = "moans2"
	message = "moans somewhat manly!!"
	message_mime = "acts out a rather manly scream!"
	sound = 'modular_zzplurt/sound/voice/gachi/moan1.ogg'

/datum/emote/living/scream3/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/gachi/moan1.ogg', 'modular_zzplurt/sound/voice/gachi/moan2.ogg', 'modular_zzplurt/sound/voice/gachi/moan3.ogg', 'modular_zzplurt/sound/voice/gachi/moan4.ogg')
	. = ..()

/datum/emote/living/woop
	key = "woop"
	key_third_person = "woops"
	message = "woops!"
	message_mime = "silently woops!"
	sound = 'modular_zzplurt/sound/voice/gachi/woop.ogg'
	sound_volume = 35
	cooldown = 0.4 SECONDS

/datum/emote/living/whatthehell/right
	key = "wth2"
	key_third_person = "wths2"
	sound = 'modular_zzplurt/sound/voice/gachi/wth2.ogg'
	sound_volume = 100
	cooldown = 1.0 SECONDS

/datum/emote/living/pardon
	key = "sorry"
	key_third_person = "sorrys"
	message = "exclaims, \"Oh shit, I am sorry!\""
	sound = 'modular_zzplurt/sound/voice/gachi/sorry.ogg'
	cooldown = 1.3 SECONDS

/datum/emote/living/pardonfor
	key = "sorryfor"
	key_third_person = "sorrysfor"
	message = "asks, \"Sorry for what?\""
	message_param = "curses %t!"
	message_mime = "silently curses someone!"
	sound = 'modular_zzplurt/sound/voice/gachi/sorryfor.ogg'
	cooldown = 0.9 SECONDS

/datum/emote/living/fock
	key = "fuckyou"
	key_third_person = "fuckyous"
	message = "curses someone!"
	message_param = "curses %t!"
	message_mime = "silently curses someone!"
	sound = 'modular_zzplurt/sound/voice/gachi/fockyou1.ogg'
	cooldown = 1.18 SECONDS

/datum/emote/living/fock/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/gachi/fockyou1.ogg','modular_zzplurt/sound/voice/gachi/fockyou2.ogg')
	. = ..()


/datum/emote/living/letsgo
	key = "go"
	key_third_person = "goes"
	message = "yells, \"Come on, lets go!\""
	message_mime = "motions moving forward!"
	sound = 'modular_zzplurt/sound/voice/gachi/go.ogg'
	cooldown = 1.6

/datum/emote/living/chuckle2
	key = "chuckle2"
	key_third_person = "chuckles2"
	message = "chuckles."
	message_mime = "chuckles silently."
	sound = 'modular_zzplurt/sound/voice/gachi/chuckle.ogg'
	cooldown = 1.01 SECONDS

/datum/emote/living/fockslaves
	key = "slaves"
	key_third_person = "slaves"
	message = "curses slaves!"
	message_mime = "silently curses slaves!"
	sound = 'modular_zzplurt/sound/voice/gachi/fokensleves.ogg'
	cooldown = 1.2 SECONDS

/datum/emote/living/getbuttback
	key = "assback"
	key_third_person = "assbacks"
	message = "demands someone's ass to get back here!"
	message_param = "demands %t's ass to get back here!"
	message_mime = "motions for someone's ass to get back here!"
	sound = 'modular_zzplurt/sound/voice/gachi/assback.ogg'
	cooldown = 1.9 SECONDS

/datum/emote/living/boss
	key = "boss"
	key_third_person = "boss"
	message = "seeks the boss of this place!"
	message_mime = "stares at the potential boss of this place!"
	sound = 'modular_zzplurt/sound/voice/gachi/boss.ogg'
	cooldown = 1.68 SECONDS

/datum/emote/living/attention
	key = "attention"
	key_third_person = "attentions"
	message = "demands an attention!"
	message_mime = "seems to be looking for an attention."
	sound_volume = 100
	sound = 'modular_zzplurt/sound/voice/gachi/attention.ogg'
	cooldown = 1.36 SECONDS


/datum/emote/living/boolets
	key = "ammo"
	key_third_person = "ammos"
	message = "is requesting ammo!"
	message_mime = "seem to ask for ammo!"
	sound = 'modular_zzplurt/sound/voice/gachi/boolets.ogg'
	cooldown = 1.1 SECONDS
	sound_volume = 10

/datum/emote/living/boolets/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/gachi/boolets.ogg','modular_zzplurt/sound/voice/gachi/boolets2.ogg')
	. = ..()

/datum/emote/living/wepon
	key = "wepon"
	key_third_person = "wepons"
	message = "is requesting bigger weapons!"
	message_mime = "seem to ask for weapons!"
	sound = 'modular_zzplurt/sound/voice/gachi/wepons.ogg'
	cooldown = 1.07 SECONDS
	sound_volume = 10

/datum/emote/living/sciteam
	key = "sciteam"
	key_third_person = "sciteams"
	message = "exclaims, \"I am with the <b>Science</b> team!\""
	message_mime = "gestures being with the Science team!"
	sound = 'modular_zzplurt/sound/voice/sciteam.ogg'
	cooldown = 1.32 SECONDS
	sound_volume = 90

/datum/emote/living/ambatukam
	key = "ambatukam"
	key_third_person = "ambatukams"
	message = "is about to come!"
	message_mime = "seems like about to come!"
	sound = 'modular_zzplurt/sound/voice/ambatukam.ogg'
	cooldown = 2.75 SECONDS

/datum/emote/living/ambatukam2
	key = "ambatukam2"
	key_third_person = "ambatukams2"
	message = "is about to come in harmony!"
	message_mime = "seems like about to come in harmony!"
	sound = 'modular_zzplurt/sound/voice/ambatukam_harmony.ogg'
	cooldown = 3.42 SECONDS

/datum/emote/living/eekum
	key = "eekumbokum"
	key_third_person = "eekumbokums"
	message = "eekum-bokums!"
	message_mime = "seems to eekum-bokum!"
	sound = 'modular_zzplurt/sound/voice/eekum-bokum.ogg'
	cooldown = 0.9

/datum/emote/living/eekum/run_emote(mob/user, params, type_override, intentional)
	switch(user.gender)
		if(MALE)
			sound = 'modular_zzplurt/sound/voice/eekum-bokum.ogg'
		if(FEMALE)
			sound = pick('modular_zzplurt/sound/voice/eekum-bokum_f1.ogg','modular_zzplurt/sound/voice/eekum-bokum_f2.ogg')
		else
			sound = pick('modular_zzplurt/sound/voice/eekum-bokum.ogg','modular_zzplurt/sound/voice/eekum-bokum_f1.ogg','modular_zzplurt/sound/voice/eekum-bokum_f2.ogg')
	. = ..()

/datum/emote/living/bazinga
	key = "bazinga"
	key_third_person = "bazingas"
	message = "exclaims, \"<i>Bazinga!</i>\""
	message_mime = "fools someone, silently."
	sound = 'modular_zzplurt/sound/voice/bazinga.ogg'
	cooldown = 0.65 SECONDS

/datum/emote/living/bazinga/run_emote(mob/user, params, type_override, intentional)
	if(prob(1))
		sound = 'modular_zzplurt/sound/voice/bazinga_ebil.ogg'
		vary = FALSE
		cooldown = 1.92 SECONDS
		sound_volume = 110
	else
		sound = 'modular_zzplurt/sound/voice/bazinga.ogg'
		vary = TRUE
		cooldown = 0.65 SECONDS
		sound_volume = 50
	. = ..()

/datum/emote/living/yooo
	key = "yooo"
	key_third_person = "yooos"
	message = "thinks they are part of Kabuki play."
	sound = 'modular_zzplurt/sound/voice/yooo.ogg'
	cooldown = 2.54 SECONDS

/datum/emote/living/buzzer_correct
	key = "correct"
	key_third_person = "corrects"
	message = "thinks someone is correct."
	message_param = "thinks %t is correct."
	sound = 'modular_zzplurt/sound/voice/buzzer_correct.ogg'
	cooldown = 0.84 SECONDS

/datum/emote/living/buzzer_incorrect
	key = "incorrect"
	key_third_person = "incorrects"
	message = "thinks someone is incorrect."
	message_param = "thinks %t is incorrect."
	sound = 'modular_zzplurt/sound/voice/buzzer_incorrect.ogg'
	cooldown = 1.21 SECONDS

/datum/emote/living/ace/
	key = "objection0"
	key_third_person = "objections0"
	message = "<b><i>\<\< OBJECTION!! \>\></i></b>"
	message_mime = "points their finger with determination!"
	sound = 'modular_zzplurt/sound/voice/ace/ace_objection_generic.ogg'
	cooldown = 6.0 SECONDS
	sound_volume = 30

/datum/emote/living/ace/objection
	key = "objection"
	key_third_person = "objections"
	sound = 'modular_zzplurt/sound/voice/ace/ace_objection_m1.ogg'
	vary = FALSE

/datum/emote/living/ace/objection/run_emote(mob/user, params, type_override, intentional)
	switch(user.gender)
		if(MALE)
			sound = pick('modular_zzplurt/sound/voice/ace/ace_objection_m1.ogg', 'modular_zzplurt/sound/voice/ace/ace_objection_m2.ogg', 'modular_zzplurt/sound/voice/ace/ace_objection_m3.ogg')
		if(FEMALE)
			sound = pick('modular_zzplurt/sound/voice/ace/ace_objection_f1.ogg', 'modular_zzplurt/sound/voice/ace/ace_objection_f2.ogg')
		else
			sound = pick('modular_zzplurt/sound/voice/ace/ace_objection_m1.ogg', 'modular_zzplurt/sound/voice/ace/ace_objection_m2.ogg', 'modular_zzplurt/sound/voice/ace/ace_objection_m3.ogg', 'modular_zzplurt/sound/voice/ace/ace_objection_f1.ogg', 'modular_zzplurt/sound/voice/ace/ace_objection_f2.ogg')
	. = ..()

/datum/emote/living/ace/takethat
	key = "takethat"
	key_third_person = "tkakesthat"
	message = "<b><i>\<\< TAKE THAT!! \>\></i></b>"
	sound = 'modular_zzplurt/sound/voice/ace/ace_takethat_m1.ogg'

/datum/emote/living/ace/takethat/run_emote(mob/user, params, type_override, intentional)
	switch(user.gender)
		if(MALE)
			sound = pick('modular_zzplurt/sound/voice/ace/ace_takethat_m1.ogg', 'modular_zzplurt/sound/voice/ace/ace_takethat_m2.ogg', 'modular_zzplurt/sound/voice/ace/ace_takethat_m3.ogg')
		if(FEMALE)
			sound = pick('modular_zzplurt/sound/voice/ace/ace_takethat_f1.ogg', 'modular_zzplurt/sound/voice/ace/ace_takethat_f2.ogg')
		else
			sound = pick('modular_zzplurt/sound/voice/ace/ace_takethat_m1.ogg', 'modular_zzplurt/sound/voice/ace/ace_takethat_m2.ogg', 'modular_zzplurt/sound/voice/ace/ace_takethat_m3.ogg', 'modular_zzplurt/sound/voice/ace/ace_takethat_f1.ogg', 'modular_zzplurt/sound/voice/ace/ace_takethat_f2.ogg')
	. = ..()

/datum/emote/living/ace/hold_it
	key = "holdit"
	key_third_person = "holdsit"
	message = "<b><i>\<\< HOLD IT!! \>\></i></b>"
	sound = 'modular_zzplurt/sound/voice/ace/ace_holdit_m1.ogg'
	vary = FALSE

/datum/emote/living/ace/hold_it/run_emote(mob/user, params, type_override, intentional)
	switch(user.gender)
		if(MALE)
			sound = pick('modular_zzplurt/sound/voice/ace/ace_holdit_m1.ogg', 'modular_zzplurt/sound/voice/ace/ace_holdit_m2.ogg', 'modular_zzplurt/sound/voice/ace/ace_holdit_m3.ogg')
		if(FEMALE)
			sound = pick('modular_zzplurt/sound/voice/ace/ace_holdit_f1.ogg', 'modular_zzplurt/sound/voice/ace/ace_holdit_f2.ogg')
		else
			sound = pick('modular_zzplurt/sound/voice/ace/ace_holdit_m1.ogg', 'modular_zzplurt/sound/voice/ace/ace_holdit_m2.ogg', 'modular_zzplurt/sound/voice/ace/ace_holdit_m3.ogg', 'modular_zzplurt/sound/voice/ace/ace_holdit_f1.ogg', 'modular_zzplurt/sound/voice/ace/ace_holdit_f2.ogg')
	. = ..()

/datum/emote/living/smirk2
	key = "smirk2"
	key_third_person = "smirks2"
	message = "<i>smirks</i>."
	sound = 'modular_zzplurt/sound/voice/ace/ace_wubs.ogg'
	cooldown = 0.5 SECONDS

/datum/emote/living/nani
	key = "nani"
	key_third_person = "nanis"
	message = "seems confused."
	sound = 'modular_zzplurt/sound/voice/nani.ogg'
	cooldown = 0.5 SECONDS

/datum/emote/living/canonevent
	key = "2099"
	key_third_person = "canons"
	message = "thinks this is a canon event."
	sound = 'modular_zzplurt/sound/voice/canon_event.ogg'
	cooldown = 5.0 SECONDS
	sound_volume = 27

/datum/emote/living/meow2/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/catpeople/cat_meow1.ogg', 'modular_zzplurt/sound/voice/catpeople/cat_meow2.ogg', 'modular_zzplurt/sound/voice/catpeople/cat_meow3.ogg')
	. = ..()


/datum/emote/living/meow2
	key = "meow2"
	key_third_person = "meows"
	message = "meows!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_meow1.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

/datum/emote/living/meow2/run_emote(mob/user, params, type_override, intentional)
	sound = pick('modular_zzplurt/sound/voice/catpeople/cat_mew1.ogg', 'modular_zzplurt/sound/voice/catpeople/cat_mew2.ogg')
	. = ..()

/datum/emote/living/meow3
	key = "meow3"
	key_third_person = "mews!"
	message = "mews!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_mew1.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

/datum/emote/living/mrrp
	key = "mrrp"
	key_third_person = "mrrps"
	message = "trills like a cat!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_mrrp1.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

/datum/emote/living/mrrp2
	key = "mrrp2"
	key_third_person = "mrrps"
	message = "trills like a cat!"
	sound = 'modular_zzplurt/sound/voice/catpeople/cat_mrrp2.ogg'
	cooldowns = 0.8 SECONDS
	vary = FALSE

/datum/emote/living/gay
	key = "gay"
	key_third_person = "points at a player"
	message = "saw something gay."
	sound = 'modular_zzplurt/sound/voice/gay-echo.ogg'
	cooldown = 0.95 SECONDS
	vary = FALSE

/datum/emote/living/flabbergast
	key = "flabbergast"
	key_third_person = "is flabbergasted"
	message = "looks flabbergasted!"
	sound = 'modular_zzplurt/sound/voice/flabbergasted.ogg'
	cooldown = 3.0 SECONDS
	vary = FALSE
	sound_volume = 70

/datum/emote/living/sadness
	key = "sadness"
	key_third_person = "feels sadness"
	message = "is experiencing <b><i>Profound Sadness</i></b>!"
	sound = 'modular_zzplurt/sound/voice/sadness.ogg'
	cooldown = 4.0 SECONDS
	vary = FALSE
	sound_volume = 30

/datum/emote/living/ah
	key = "ah"
	key_third_person = "ahs"
	message = "ahs!"
	message_mime = "ahs silently"
	sound = 'modular_zzplurt/sound/voice/gachi/ah.ogg'
	cooldown = 0.67 SECONDS
	sound_volume = 25
