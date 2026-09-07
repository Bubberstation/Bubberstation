/mob/proc/manipulate_emotes()
	if(!mind)
		return
	var/list/available_emotes = list()
	var/list/all_emotes = list()

	// code\modules\mob\emote.dm
	var/static/list/mob_emotes = list(
		/mob/proc/emote_flip,
		/mob/proc/emote_spin
	)
	all_emotes += mob_emotes

	// code\modules\mob\living\emote.dm
	var/static/list/living_emotes = list(
		/mob/living/proc/emote_blush,
		/mob/living/proc/emote_bow,
		/mob/living/proc/emote_burp,
		/mob/living/proc/emote_choke,
		/mob/living/proc/emote_cross,
		/mob/living/proc/emote_chuckle,
		/mob/living/proc/emote_collapse,
		/mob/living/proc/emote_cough,
		/mob/living/proc/emote_dance,
		/mob/living/proc/emote_drool,
		/mob/living/proc/emote_faint,
		/mob/living/proc/emote_flap,
		/mob/living/proc/emote_aflap,
		/mob/living/proc/emote_frown,
		/mob/living/proc/emote_gag,
		/mob/living/proc/emote_giggle,
		/mob/living/proc/emote_glare,
		/mob/living/proc/emote_grin,
		/mob/living/proc/emote_groan,
		/mob/living/proc/emote_grimace,
		/mob/living/proc/emote_jump,
		/mob/living/proc/emote_kiss,
		/mob/living/proc/emote_laugh,
		/mob/living/proc/emote_look,
		/mob/living/proc/emote_nod,
		/mob/living/proc/emote_point,
		/mob/living/proc/emote_pout,
		/mob/living/proc/emote_scream,
		/mob/living/proc/emote_scowl,
		/mob/living/proc/emote_shake,
		/mob/living/proc/emote_shiver,
		/mob/living/proc/emote_sigh,
		/mob/living/proc/emote_sit,
		/mob/living/proc/emote_smile,
		/mob/living/proc/emote_sneeze,
		/mob/living/proc/emote_smug,
		/mob/living/proc/emote_sniff,
		/mob/living/proc/emote_stare,
		/mob/living/proc/emote_strech,
		/mob/living/proc/emote_sulk,
		/mob/living/proc/emote_sway,
		/mob/living/proc/emote_tilt,
		/mob/living/proc/emote_tremble,
		/mob/living/proc/emote_twitch,
		/mob/living/proc/emote_twitch_s,
		/mob/living/proc/emote_wave,
		/mob/living/proc/emote_whimper,
		/mob/living/proc/emote_wsmile,
		/mob/living/proc/emote_yawn,
		/mob/living/proc/emote_gurgle,
		/mob/living/proc/emote_inhale,
		/mob/living/proc/emote_exhale,
		/mob/living/proc/emote_swear
	)
	all_emotes += living_emotes

	// code\modules\mob\living\carbon\emote.dm
	var/static/list/carbon_emotes = list(
		/mob/living/carbon/proc/emote_airguitar,
		/mob/living/carbon/proc/emote_blink,
		/mob/living/carbon/proc/emote_blink_r,
		/mob/living/carbon/proc/emote_crack,
		/mob/living/carbon/proc/emote_circle,
		/mob/living/carbon/proc/emote_moan,
		/mob/living/carbon/proc/emote_slap,
		/mob/living/carbon/proc/emote_wink
	)
	all_emotes += carbon_emotes

	// code\modules\mob\living\carbon\human\emote.dm
	var/static/list/human_emotes = list(
		/mob/living/carbon/human/proc/emote_cry,
		/mob/living/carbon/human/proc/emote_eyebrow,
		/mob/living/carbon/human/proc/emote_grumble,
		/mob/living/carbon/human/proc/emote_mumble,
		/mob/living/carbon/human/proc/emote_pale,
		/mob/living/carbon/human/proc/emote_raise,
		/mob/living/carbon/human/proc/emote_salute,
		/mob/living/carbon/human/proc/emote_shrug,
		/mob/living/carbon/human/proc/emote_wag,
		/mob/living/carbon/human/proc/emote_wing
	)
	all_emotes += human_emotes

	// modular_skyrat\modules\emotes\code\emote.dm
	var/static/list/skyrat_living_emotes = list(
		/mob/living/proc/emote_peep,
		/mob/living/proc/emote_peep2,
		/mob/living/proc/emote_snap,
		/mob/living/proc/emote_snap2,
		/mob/living/proc/emote_snap3,
		/mob/living/proc/emote_awoo,
		/mob/living/proc/emote_nya,
		/mob/living/proc/emote_weh,
		/mob/living/proc/emote_mothsqueak,
		/mob/living/proc/emote_mousesqueak,
		/mob/living/proc/emote_merp,
		/mob/living/proc/emote_bark,
		/mob/living/proc/emote_squish,
		/mob/living/proc/emote_meow,
		/mob/living/proc/emote_hiss1,
		/mob/living/proc/emote_chitter,
		/mob/living/proc/emote_snore,
		/mob/living/proc/emote_clap,
		/mob/living/proc/emote_clap1,
		/mob/living/proc/emote_headtilt,
		/mob/living/proc/emote_blink2,
		/mob/living/proc/emote_rblink,
		/mob/living/proc/emote_squint,
		/mob/living/proc/emote_smirk,
		/mob/living/proc/emote_eyeroll,
		/mob/living/proc/emote_huff,
		/mob/living/proc/emote_etwitch,
		/mob/living/proc/emote_clear,
		/mob/living/proc/emote_bawk,
		/mob/living/proc/emote_caw,
		/mob/living/proc/emote_caw2,
		/mob/living/proc/emote_whistle,
		/mob/living/proc/emote_blep,
		/mob/living/proc/emote_bork,
		/mob/living/proc/emote_hoot,
		/mob/living/proc/emote_growl,
		/mob/living/proc/emote_woof,
		/mob/living/proc/emote_baa,
		/mob/living/proc/emote_baa2,
		/mob/living/proc/emote_wurble,
		/mob/living/proc/emote_rattle,
		/mob/living/proc/emote_cackle,
		/mob/living/proc/emote_warble,
		/mob/living/proc/emote_trills,
		/mob/living/proc/emote_rpurr,
		/mob/living/proc/emote_purr,
		/mob/living/proc/emote_moo,
		/mob/living/proc/emote_honk1,
		/mob/living/proc/emote_mggaow,
		/mob/living/proc/emote_slowclap,
		/mob/living/proc/emote_teshchirp,
		/mob/living/proc/emote_teshsqueak,
		/mob/living/proc/emote_teshtrill,
	)
	all_emotes += skyrat_living_emotes

	// code\modules\mob\living\brain\emote.dm
	var/static/list/brain_emotes = list(
		/mob/living/brain/proc/emote_alarm,
		/mob/living/brain/proc/emote_alert,
		/mob/living/brain/proc/emote_flash,
		/mob/living/brain/proc/emote_notice,
		/mob/living/brain/proc/emote_whistle_brain
	)
	all_emotes += brain_emotes

	// code\modules\mob\living\carbon\alien\emote.dm
	var/static/list/alien_emotes = list(
		/mob/living/carbon/alien/proc/emote_gnarl,
		/mob/living/carbon/alien/proc/emote_hiss,
		/mob/living/carbon/alien/proc/emote_roar
	)
	all_emotes += alien_emotes

	// modular_skyrat\modules\emotes\code\synth_emotes.dm
	var/static/list/synth_emotes = list(
		/mob/living/proc/emote_dwoop,
		/mob/living/proc/emote_yes,
		/mob/living/proc/emote_no,
		/mob/living/proc/emote_boop,
		/mob/living/proc/emote_buzz,
		/mob/living/proc/emote_beep,
		/mob/living/proc/emote_beep2,
		/mob/living/proc/emote_buzz2,
		/mob/living/proc/emote_chime,
		/mob/living/proc/emote_honk,
		/mob/living/proc/emote_ping,
		/mob/living/proc/emote_sad,
		/mob/living/proc/emote_warn,
	)
	all_emotes += synth_emotes
	var/static/list/allowed_species_synth = list(
		/datum/species/synthetic
	)

	// modular_skyrat\modules\emotes\code\additionalemotes\overlay_emote.dm
	var/static/list/skyrat_living_emotes_overlay = list(
		/mob/living/proc/emote_sweatdrop,
		/mob/living/proc/emote_exclaim,
		/mob/living/proc/emote_question,
		/mob/living/proc/emote_realize,
		/mob/living/proc/emote_annoyed,
		/mob/living/proc/emote_glasses
	)
	all_emotes += skyrat_living_emotes_overlay

	// modular_skyrat\modules\emotes\code\additionalemotes\turf_emote.dm
	all_emotes += /mob/living/proc/emote_mark_turf

	// Clearing all emotes before applying new ones
	verbs -= all_emotes

	// Checking if preferences allow emote panel
	if(!src.client?.prefs?.read_preference(/datum/preference/toggle/emote_panel))
		return

	// Checking emote availability
	if(isbrain(src))
		// Only brains in MMI have emotes
		var/mob/living/brain/current_brain = src
		if(current_brain.container && istype(current_brain.container, /obj/item/mmi))
			available_emotes += brain_emotes
	else
		if(ismob(src))
			available_emotes += mob_emotes
		if(isliving(src))
			available_emotes += living_emotes
			available_emotes += skyrat_living_emotes
			available_emotes += skyrat_living_emotes_overlay
			available_emotes += /mob/living/proc/emote_mark_turf
		if(iscarbon(src))
			available_emotes += carbon_emotes
		if(ishuman(src))
			available_emotes += human_emotes
			// Checking if should apply Synth emotes
			var/mob/living/carbon/human/current_mob = src
			if(!HAS_TRAIT(current_mob, TRAIT_SILICON_EMOTES_ALLOWED))
				available_emotes += synth_emotes
			// Checking if can wag tail
			var/obj/item/organ/tail/tail = current_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
			if(!(tail?.wag_flags & WAG_ABLE))
				available_emotes -= /mob/living/carbon/human/proc/emote_wag
			// Checking if has wings
			if(!current_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS))
				available_emotes -= /mob/living/carbon/human/proc/emote_wing
		if(isalien(src))
			available_emotes += alien_emotes
		if(issilicon(src))
			available_emotes += synth_emotes

	// Applying emote panel if preferences allow
	for(var/emote in available_emotes)
		verbs |= emote

/mob/mind_initialize()
	. = ..()
	manipulate_emotes()

// code\modules\mob\emote.dm
GAME_VERB_PROC(/mob, emote_flip, "| Flip |", "Emotes")
	src.emote("flip", intentional = TRUE)

GAME_VERB_PROC(/mob, emote_spin, "| Spin |", "Emotes")
	src.emote("spin", intentional = TRUE)

// code\modules\mob\living\emote.dm
GAME_VERB_PROC(/mob/living, emote_blush, "~ Blush", "Emotes")
	src.emote("blush", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bow, "~ Bow", "Emotes")
	src.emote("bow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_burp, "> Burp", "Emotes")
	src.emote("burp", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_choke, "~ Choke", "Emotes")
	src.emote("choke", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_cross, "~ Cross", "Emotes")
	src.emote("cross", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_chuckle, "~ Chuckle", "Emotes")
	src.emote("chuckle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_collapse, "~ Collapse", "Emotes")
	src.emote("collapse", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_cough, "> Cough", "Emotes")
	src.emote("cough", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_dance, "~ Dance", "Emotes")
	src.emote("dance", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_drool, "~ Drool", "Emotes")
	src.emote("drool", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_faint, "~ Faint", "Emotes")
	src.emote("faint", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_flap, "~ Flap", "Emotes")
	src.emote("flap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_aflap, "~ Angry Flap", "Emotes")
	src.emote("aflap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_frown, "~ Frown", "Emotes")
	src.emote("frown", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_gag, "~ Gag", "Emotes")
	src.emote("gag", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_giggle, "~ Giggle", "Emotes")
	src.emote("giggle", intentional = TRUE)


GAME_VERB_PROC(/mob/living, emote_glare, "~ Glare", "Emotes")
	src.emote("glare", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_grin, "~ Grin", "Emotes")
	src.emote("grin", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_groan, "~ Groan", "Emotes")
	src.emote("groan", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_grimace, "~ Grimace", "Emotes")
	src.emote("grimace", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_jump, "~ Jump", "Emotes")
	src.emote("jump", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_kiss, "| Kiss |", "Emotes")
	src.emote("kiss", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_laugh, "> Laugh", "Emotes")
	src.emote("laugh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_look, "~ Look", "Emotes")
	src.emote("look", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_nod, "~ Nod", "Emotes")
	src.emote("nod", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_nodnod, "~ Nodnod", "Emotes")
	src.emote("nod2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_point, "~ Point", "Emotes")
	src.emote("point", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_pout, "~ Pout", "Emotes")
	src.emote("pout", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_scream, "> Scream", "Emotes")
	src.emote("scream", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_scowl, "~ Scowl", "Emotes")
	src.emote("scowl", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_shake, "~ Shake", "Emotes")
	src.emote("shake", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_shiver, "~ Shiver", "Emotes")
	src.emote("shiver", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sigh, "> Sigh", "Emotes")
	src.emote("sigh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sit, "~ Sit", "Emotes")
	src.emote("sit", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_smile, "~ Smile", "Emotes")
	src.emote("smile", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sneeze, "> Sneeze", "Emotes")
	src.emote("sneeze", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_smug, "~ Smug", "Emotes")
	src.emote("smug", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sniff, "> Sniff", "Emotes")
	src.emote("sniff", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_stare, "~ Stare", "Emotes")
	src.emote("stare", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_strech, "~ Stretch", "Emotes")
	src.emote("stretch", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sulk, "~ Sulk", "Emotes")
	src.emote("sulk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sway, "~ Sway", "Emotes")
	src.emote("sway", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_tilt, "~ Tilt", "Emotes")
	src.emote("tilt", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_tremble, "~ Tremble", "Emotes")
	src.emote("tremble", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_twitch, "~ Twitch", "Emotes")
	src.emote("twitch", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_twitch_s, "~ Twitch Slightly", "Emotes")
	src.emote("twitch_s", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_wave, "~ Wave", "Emotes")
	src.emote("wave", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_whimper, "~ Whimper", "Emotes")
	src.emote("whimper", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_wsmile, "~ Smile Weak", "Emotes")
	src.emote("wsmile", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_yawn, "~ Yawn", "Emotes")
	src.emote("yawn", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_gurgle, "~ Gurgle", "Emotes")
	src.emote("gurgle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_inhale, "~ Inhale", "Emotes")
	src.emote("inhale", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_exhale, "~ Exhale", "Emotes")
	src.emote("exhale", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_swear, "~ Swear", "Emotes")
	src.emote("swear", intentional = TRUE)

// code\modules\mob\living\carbon\emote.dm
GAME_VERB_PROC(/mob/living/carbon, emote_airguitar, "~ Airguitar", "Emotes")
	src.emote("airguitar", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_blink, "~ Blink", "Emotes")
	src.emote("blink", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_blink_r, "~ Blink Rapidly", "Emotes")
	src.emote("blink_r", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_crack, "> Crack", "Emotes")
	src.emote("crack", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_circle, "| Circle |", "Emotes")
	src.emote("circle", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_moan, "~ Moan", "Emotes")
	src.emote("moan", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_slap, "| Slap |", "Emotes")
	src.emote("slap", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon, emote_wink, "~ Wink", "Emotes")
	src.emote("wink", intentional = TRUE)

// code\modules\mob\living\carbon\human\emote.dm
GAME_VERB_PROC(/mob/living/carbon/human, emote_cry, "~ Cry", "Emotes")
	src.emote("cry", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_eyebrow, "~ Eyebrow", "Emotes")
	src.emote("eyebrow", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_grumble, "~ Grumble", "Emotes")
	src.emote("grumble", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_mumble, "~ Mumble", "Emotes")
	src.emote("mumble", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_pale, "~ Pale", "Emotes")
	src.emote("pale", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_raise, "~ Raise Hand", "Emotes")
	src.emote("raise", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_salute, "~ Salute", "Emotes")
	src.emote("salute", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_shrug, "~ Shrug", "Emotes")
	src.emote("shrug", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_wag, "| Wag |", "Emotes")
	src.emote("wag", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/human, emote_wing, "| Wing |", "Emotes")
	src.emote("wing", intentional = TRUE)

// modular_skyrat\modules\emotes\code\emote.dm
GAME_VERB_PROC(/mob/living, emote_peep, "> Peep", "Emotes+")
	src.emote("peep", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_peep2, "> Peep Twice", "Emotes+")
	src.emote("peep2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snap, "> Snap", "Emotes+")
	src.emote("snap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snap2, "> Snap Twice", "Emotes+")
	src.emote("snap2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snap3, "> Snap Thrice", "Emotes+")
	src.emote("snap3", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_awoo, "> Awoo", "Emotes+")
	src.emote("awoo", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_nya, "> Nya", "Emotes+")
	src.emote("nya", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_weh, "> Weh", "Emotes+")
	src.emote("weh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_mothsqueak, "> Moth Squeak", "Emotes+")
	src.emote("msqueak", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_mousesqueak, "> Mouse Squeak", "Emotes+")
	src.emote("squeak", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_merp, "> Merp", "Emotes+")
	src.emote("merp", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bark, "> Bark", "Emotes+")
	src.emote("bark", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_squish, "> Squish", "Emotes+")
	src.emote("squish", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_meow, "> Meow", "Emotes+")
	src.emote("meow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_hiss1, "> Hiss", "Emotes+")
	src.emote("hiss1", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_chitter, "> Chitter", "Emotes+")
	src.emote("chitter", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snore, "> Snore", "Emotes+")
	src.emote("snore", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_clap, "> Clap", "Emotes+")
	src.emote("clap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_clap1, "> Clap once", "Emotes+")
	src.emote("clap1", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_slowclap, "> Slow Clap", "Emotes")
	src.emote("slowclap", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_headtilt, "~ Head Hilt", "Emotes+")
	src.emote("tilt", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_blink2, "~ Blink Twice", "Emotes+")
	src.emote("blink2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_rblink, "~ Blink Rapidly", "Emotes+")
	src.emote("rblink", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_squint, "~ Squint", "Emotes+")
	src.emote("squint", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_smirk, "~ Smirk", "Emotes+")
	src.emote("smirk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_eyeroll, "~ Eyeroll", "Emotes+")
	src.emote("eyeroll", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_huff, "~ Huff", "Emotes+")
	src.emote("huff", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_etwitch, "~ Ears twitch", "Emotes+")
	src.emote("etwitch", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_clear, "~ Clear Throat", "Emotes+")
	src.emote("clear", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bawk, "> Bawk", "Emotes+")
	src.emote("bawk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_caw, "> Caw", "Emotes+")
	src.emote("caw", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_caw2, "> Caw-caw", "Emotes+")
	src.emote("caw2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_whistle, "~ Whistle", "Emotes+")
	src.emote("whistle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_mggaow, "> Mggaow", "Emotes+")
	src.emote("mggaow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_blep, "~ Blep", "Emotes+")
	src.emote("blep", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bork, "> Bork", "Emotes+")
	src.emote("bork", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_hoot, "> Hoot", "Emotes+")
	src.emote("hoot", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_growl, "> Growl", "Emotes+")
	src.emote("growl", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_woof, "> Woof", "Emotes+")
	src.emote("woof", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_baa, "> Baa", "Emotes+")
	src.emote("baa", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_baa2, "> Bleat", "Emotes+")
	src.emote("baa2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_wurble, "> Wurble", "Emotes+")
	src.emote("wurble", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_rattle, "> Rattle", "Emotes+")
	src.emote("rattle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_cackle, "> Cackle", "Emotes+")
	src.emote("cackle", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_warble, "> Warble", "Emotes+")
	src.emote("warble", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_trills, "> Trills", "Emotes+")
	src.emote("trills", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_rpurr, "> Raptor", "Emotes+")
	src.emote("rpurr", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_purr, "> Purr", "Emotes+")
	src.emote("purr", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_moo, "> Moo", "Emotes+")
	src.emote("moo", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_honk1, "> Honk", "Emotes+")
	src.emote("honk1", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_neigh, "> Neigh", "Emotes+")
	src.emote("neigh", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_neigh2, "> Neigh2", "Emotes+")
	src.emote("neigh2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_snort, "> Snort", "Emotes+")
	src.emote("snort", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bray, "> Bray", "Emotes+")
	src.emote("bray", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_bellow, "> Bellow", "Emotes+")
	src.emote("bellow", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_teshchirp, "> Tesh Chirp", "Emotes+")
	src.emote("teshchirp", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_teshsqueak, "> Tesh Squeak", "Emotes+")
	src.emote("teshsqueak", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_teshtrill, "> Tesh Trill", "Emotes+")
	src.emote("teshtrill", intentional = TRUE)

// code\modules\mob\living\brain\emote.dm
GAME_VERB_PROC(/mob/living/brain, emote_alarm, "< Alarm >", "Emotes")
	src.emote("alarm", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_alert, "< Alert >", "Emotes")
	src.emote("alert", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_flash, "< Flash >", "Emotes")
	src.emote("flash", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_notice, "< Notice >", "Emotes")
	src.emote("notice", intentional = TRUE)

GAME_VERB_PROC(/mob/living/brain, emote_whistle_brain, "< Whistle >", "Emotes")
	src.emote("whistle", intentional = TRUE)

// code\modules\mob\living\carbon\alien\emote.dm
GAME_VERB_PROC(/mob/living/carbon/alien, emote_gnarl, "< Gnarl >", "Emotes")
	src.emote("gnarl", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/alien, emote_hiss, "< Hiss >", "Emotes")
	src.emote("hiss", intentional = TRUE)

GAME_VERB_PROC(/mob/living/carbon/alien, emote_roar, "< Roar >", "Emotes")
	src.emote("roar", intentional = TRUE)

// modular_skyrat\modules\emotes\code\synth_emotes.dm
GAME_VERB_PROC(/mob/living, emote_dwoop, "< Dwoop >", "Emotes")
	src.emote("dwoop", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_yes, "< Yes >", "Emotes")
	src.emote("yes", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_no, "< No >", "Emotes")
	src.emote("no", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_boop, "< Boop >", "Emotes")
	src.emote("boop", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_buzz, "< Buzz >", "Emotes")
	src.emote("buzz", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_beep, "< Beep >", "Emotes")
	src.emote("beep", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_beep2, "< Beep Sharply >", "Emotes")
	src.emote("beep2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_buzz2, "< Buzz Twice >", "Emotes")
	src.emote("buzz2", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_chime, "< Chime >", "Emotes")
	src.emote("chime", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_honk, "< Honk >", "Emotes")
	src.emote("honk", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_ping, "< Ping >", "Emotes")
	src.emote("ping", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_sad, "< Sad >", "Emotes")
	src.emote("sad", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_warn, "< Warn >", "Emotes")
	src.emote("warn", intentional = TRUE)

// modular_skyrat\modules\emotes\code\additionalemotes\overlay_emote.dm
GAME_VERB_PROC(/mob/living, emote_sweatdrop, "| Sweatdrop |", "Emotes+")
	src.emote("sweatdrop", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_exclaim, "| Exclaim |", "Emotes+")
	src.emote("exclaim", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_question, "| Question |", "Emotes+")
	src.emote("question", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_realize, "| Realize |", "Emotes+")
	src.emote("realize", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_annoyed, "| Annoyed |", "Emotes+")
	src.emote("annoyed", intentional = TRUE)

GAME_VERB_PROC(/mob/living, emote_glasses, "| Adjust Glasses |", "Emotes+")
	src.emote("glasses", intentional = TRUE)

// modular_skyrat\modules\emotes\code\additionalemotes\turf_emote.dm
GAME_VERB_PROC(/mob/living, emote_mark_turf, "| Mark Turf |", "Emotes+")
	src.emote("turf", intentional = TRUE)
