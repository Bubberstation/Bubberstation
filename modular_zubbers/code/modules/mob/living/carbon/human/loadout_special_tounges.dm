/obj/item/organ/tongue/xenobubble_tongue
	name = "alien tongue"
	icon_state = "tonguexeno"
	say_mod = "hisses"
	taste_sensitivity = 10

/obj/item/organ/tongue/xenobubble_tongue/Initialize(mapload)
	. = ..()
	var/obj/item/organ/tongue/alien/alien_tongue_type = /obj/item/organ/tongue/alien
	voice_filter = initial(alien_tongue_type.voice_filter)
	AddComponent(/datum/component/bubble_icon_override, "alien", BUBBLE_ICON_PRIORITY_ORGAN)

/obj/item/organ/tongue/robotic_speaker
	name = "robotic speaker"
	organ_flags = ORGAN_ROBOTIC
	icon_state = "tonguerobot"
	say_mod = "beeps"
	modifies_speech = TRUE
	taste_sensitivity = 25
	organ_traits = list(TRAIT_SPEAKS_CLEARLY, TRAIT_SILICON_EMOTES_ALLOWED)
	voice_filter = "alimiter=0.9,acompressor=threshold=0.2:ratio=20:attack=10:release=50:makeup=2,highpass=f=1000"

/obj/item/organ/tongue/robotic_speaker/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "machine", BUBBLE_ICON_PRIORITY_ORGAN)

/obj/item/organ/tongue/robotic_speaker/modify_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/organ/tongue/holo_bubble
	name = "holographic tongue"
	icon_state = "tongue-ghost"
	say_mod = "transmits"

/obj/item/organ/tongue/holo_bubble/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "guardian", BUBBLE_ICON_PRIORITY_ORGAN)

/obj/item/organ/tongue/slimebubble_tounge
	name = "slime tongue"
	icon_state = "tonguetied"
	say_mod = "blorbles"

/obj/item/organ/tongue/slimebubble_tounge/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/bubble_icon_override, "slime", BUBBLE_ICON_PRIORITY_ORGAN)
