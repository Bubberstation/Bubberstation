/datum/emote/living/gurgle
	key = "gurgle"
	key_third_person = "gurgles"
	message = "'s belly gurgles"
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/gurgle1.ogg'

/datum/emote/living/gurgle/get_sound()
	return get_sfx("gurgle") // Lets get any of the gurgle sounds we have set.

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "burps"
	emote_type = EMOTE_AUDIBLE
	var/reduction_min = 4
	var/reduction_max = 8
	var/noise_type = "burp"
	var/noise_pref = BURPING_NOISES

/datum/emote/living/burp/run_emote(mob/living/user, params)
	. = ..()
	if(!.)
		return FALSE

	playsound_prefed(user, noise_type, noise_pref, 100, TRUE, -4)

	var/mob/living/carbon/carbon_user = user
	carbon_user.reduce_fullness(rand(reduction_min,reduction_max))

/datum/emote/living/burp/fart //Butt burp.
	key = "fart"
	key_third_person = "farts"
	message = "farts"
	//god hates me for this -Metha
	noise_type = "fart"
	noise_pref = FARTING_NOISES

/datum/emote/living/burp/fart/run_emote(mob/living/user, params)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/storage/book/bible/b = locate(/obj/item/storage/book/bible) in get_turf(user) //Biblefart
	if(b)//Devine Retribution
		var/mob/living/heretic = user //Heresy.
		heretic.visible_message(
		"<span class='danger'>\The [heretic] farts on \the [b], causing a violent, otherworldly ripple to echo \
		outwards before they explode in a gorey mess of divine retribution!</span>",
		"<span class='userdanger'>You feel a deep sense of dread as you release pressure from your rear over \the [b], \
		immediately realizing your mistake as Divine Retribution rends your form into a gorey mess.</span>")
		heretic.emote("scream")
		message_admins("[ADMIN_LOOKUPFLW(heretic)] farted on a bible at [ADMIN_VERBOSEJMP(heretic)] and was gibbed.")
		log_game("[key_name(heretic)] farted on a bible at [AREACOORD(heretic)] and was gibbed")
		heretic.gib()
		return  //Gassy is dead

/datum/emote/living/burp/belch
	key = "belch"
	key_third_person = "belches loudly"
	message = "belches"
	//god hates me for this -Metha
	noise_type = "belch"
	reduction_min = 6
	reduction_max = 12

/datum/emote/living/burp/fart/brap
	key = "brap"
	key_third_person = "braps"
	message = ""
	reduction_min = 6
	reduction_max = 12

/datum/emote/living/burp/fart/brap/select_message_type(var/mob/living/user)
    return pick("farts loudly!", "cuts a fat one!", "rips absolute ass!")

/datum/emote/living/burp/fart/goon // Fart but it's funny !
	key = "goonfart"
	key_third_person = "goonfarts"
	noise_type = 'GainStation13/sound/voice/farts/fart4.ogg'

//Shhh... It's a secret! Don't tell or I'll steal your legs
/datum/emote/living/burunyu
	key = "burunyu"
	key_third_person = "burunyues"
	message = "emits a strange feline sound"
	emote_type = EMOTE_AUDIBLE
	sound = 'GainStation13/sound/voice/funnycat.ogg'

/datum/emote/living/bellyrub
	key = "bellyrub"
	key_third_person = "bellyrubs"
	message = "rubs their belly"
	emote_type  = EMOTE_VISIBLE

/datum/emote/living/bellyrub/run_emote(mob/living/user, params)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/carbon_user = user
	carbon_user.reduce_fullness(rand(4,16), FALSE)
