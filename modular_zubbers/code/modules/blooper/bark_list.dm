/datum/blooper/mutedc2
	name = "Muted String (Low)"
	id = "mutedc2"
	soundpath = 'sound/runtime/instruments/synthesis_samples/guitar/crisis_muted/C2.ogg'
	allow_random = TRUE

/datum/blooper/mutedc3
	name = "Muted String (Medium)"
	id = "mutedc3"
	soundpath = 'sound/runtime/instruments/synthesis_samples/guitar/crisis_muted/C3.ogg'
	allow_random = TRUE

/datum/blooper/mutedc4
	name = "Muted String (High)"
	id = "mutedc4"
	soundpath = 'sound/runtime/instruments/synthesis_samples/guitar/crisis_muted/C4.ogg'
	allow_random = TRUE

/datum/blooper/banjoc3
	name = "Banjo (Medium)"
	id = "banjoc3"
	soundpath = 'sound/runtime/instruments/banjo/Cn3.ogg'
	allow_random = TRUE

/datum/blooper/banjoc4
	name = "Banjo (High)"
	id = "banjoc4"
	soundpath = 'sound/runtime/instruments/banjo/Cn4.ogg'
	allow_random = TRUE

/datum/blooper/squeaky
	name = "Squeaky"
	id = "squeak"
	soundpath = 'sound/items/toy_squeak/toysqueak1.ogg'
	maxspeed = 4

/datum/blooper/beep
	name = "Beepy"
	id = "beep"
	soundpath = 'sound/machines/terminal/terminal_select.ogg'
	maxpitch = 1 //Bringing the pitch higher just hurts your ears :<
	maxspeed = 4 //This soundbyte's too short for larger speeds to not sound awkward

/datum/blooper/chitter
	name = "Chittery"
	id = "chitter"
	minspeed = 4 //Even with the sound being replaced with a unique, shorter sound, this is still a little too long for higher speeds
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/chitter.ogg'

/datum/blooper/synthetic_grunt
	name = "Synthetic (Grunt)"
	id = "synthgrunt"
	soundpath = 'sound/misc/bloop.ogg'

/datum/blooper/synthetic
	name = "Synthetic (Normal)"
	id = "synth"
	soundpath = 'sound/machines/uplink/uplinkerror.ogg'

/datum/blooper/bullet
	name = "Windy"
	id = "bullet"
	maxpitch = 1.6
	soundpath = 'sound/items/weapons/bulletflyby.ogg'

/datum/blooper/coggers
	name = "Brassy"
	id = "coggers"
	soundpath = 'sound/machines/clockcult/integration_cog_install.ogg'

/datum/blooper/moff/short
	name = "Moff squeak"
	id = "moffsqueak"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/mothsqueak.ogg'
	allow_random = TRUE
	ignore = FALSE

/datum/blooper/meow //Meow blooper?
	name = "Meow"
	id = "meow"
	allow_random = TRUE
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/meow1.ogg'
	minspeed = 5
	maxspeed = 11

/datum/blooper/chirp
	name = "Chirp"
	id = "chirp"
	allow_random = TRUE
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/chirp.ogg'

/datum/blooper/caw
	name = "Caw"
	id = "caw"
	allow_random = TRUE
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/caw.ogg'

//Undertale
/datum/blooper/alphys
	name = "Alphys"
	id = "alphys"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_alphys.ogg'
	minvariance = 0

/datum/blooper/asgore
	name = "Asgore"
	id = "asgore"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_asgore.ogg'
	minvariance = 0

/datum/blooper/flowey
	name = "Flowey (normal)"
	id = "flowey1"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_flowey_1.ogg'
	minvariance = 0

/datum/blooper/flowey/evil
	name = "Flowey (evil)"
	id = "flowey2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_flowey_2.ogg'
	minvariance = 0

/datum/blooper/papyrus
	name = "Papyrus"
	id = "papyrus"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_papyrus.ogg'
	minvariance = 0

/datum/blooper/ralsei
	name = "Ralsei"
	id = "ralsei"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_ralsei.ogg'
	minvariance = 0

/datum/blooper/sans //real
	name = "Sans"
	id = "sans"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_sans.ogg'
	minvariance = 0

/datum/blooper/toriel
	name = "Toriel"
	id = "toriel"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_toriel.ogg'
	minvariance = 0
	maxpitch = BLOOPER_DEFAULT_MAXPITCH*2

/datum/blooper/undyne
	name = "Undyne"
	id = "undyne"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_undyne.ogg'
	minvariance = 0

/datum/blooper/temmie
	name = "Temmie"
	id = "temmie"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_temmie.ogg'
	minvariance = 0

/datum/blooper/susie
	name = "Susie"
	id = "susie"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_susie.ogg'
	minvariance = 0

/datum/blooper/gaster
	name = "Gaster"
	id = "gaster"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_gaster_1.ogg'
	minvariance = 0

/datum/blooper/mettaton
	name = "Mettaton"
	id = "mettaton"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_metta_1.ogg'
	minvariance = 0

/datum/blooper/gen_monster
	name = "Generic Monster 1"
	id = "gen_monster_1"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_monster1.ogg'
	minvariance = 0

/datum/blooper/gen_monster/alt
	name = "Generic Monster 2"
	id = "gen_monster_2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/undertale/voice_monster2.ogg'
	minvariance = 0

/datum/blooper/wilson
	name = "Wilson"
	id = "wilson"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/dont_starve/wilson_blooper.ogg'

/datum/blooper/wolfgang
	name = "Wolfgang"
	id = "wolfgang"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/dont_starve/wolfgang_blooper.ogg'
	minspeed = 4
	maxspeed = 10

/datum/blooper/woodie
	name = "Woodie"
	id = "woodie"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/dont_starve/woodie_blooper.ogg'
	minspeed = 4
	maxspeed = 10

/datum/blooper/wurt
	name = "Wurt"
	id = "wurt"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/dont_starve/wurt_blooper.ogg'

/datum/blooper/wx78
	name = "wx78"
	id = "wx78"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/dont_starve/wx78_blooper.ogg'
	minspeed = 3
	maxspeed = 9

/datum/blooper/blub
	name = "Blub"
	id = "blub"
	soundpath = 'goon/sounds/blub.ogg'

/datum/blooper/bottalk
	name = "Bottalk 1"
	id = "bottalk1"
	soundpath = 'goon/sounds/bottalk_1.ogg'
	minspeed = 3
	maxspeed = 9

/datum/blooper/bottalk/alt1
	name = "Bottalk 2"
	id = "bottalk2"
	soundpath = 'goon/sounds/bottalk_2.ogg'

/datum/blooper/bottalk/alt2
	name = "Bottalk 3"
	id = "bottalk3"
	soundpath = 'goon/sounds/bottalk_3.ogg'

/datum/blooper/bottalk/alt3
	name = "Bottalk 4"
	id = "bottalk4"
	soundpath = 'goon/sounds/bottalk_4.ogg'

/datum/blooper/buwoo
	name = "Buwoo"
	id = "buwoo"
	soundpath = 'goon/sounds/buwoo.ogg'

/datum/blooper/cow
	name = "Cow"
	id = "cow"
	soundpath = 'goon/sounds/cow.ogg'

/datum/blooper/lizard
	name = "Lizard"
	id = "lizard"
	soundpath = 'goon/sounds/lizard.ogg'

/datum/blooper/pug
	name = "Pug"
	id = "pug"
	soundpath = 'goon/sounds/pug.ogg'

/datum/blooper/pugg
	name = "Pugg"
	id = "pugg"
	soundpath = 'goon/sounds/pugg.ogg'

/datum/blooper/radio
	name = "Radio 1"
	id = "radio1"
	soundpath = 'goon/sounds/radio.ogg'

/datum/blooper/radio/short
	name = "Radio 2"
	id = "radio2"
	soundpath = 'goon/sounds/radio2.ogg'

/datum/blooper/radio/ai
	name = "Radio (AI)"
	id = "radio_ai"
	soundpath = 'goon/sounds/radio_ai.ogg'

/datum/blooper/roach //Turkish characters be like
	name = "Roach"
	id = "roach"
	soundpath = 'goon/sounds/roach.ogg'

/datum/blooper/skelly
	name = "Skelly"
	id = "skelly"
	soundpath = 'goon/sounds/skelly.ogg'

/datum/blooper/speak
	name = "Speak 1"
	id = "speak1"
	soundpath = 'goon/sounds/speak_1.ogg'

/datum/blooper/speak/alt1
	name = "Speak 2"
	id = "speak2"
	soundpath = 'goon/sounds/speak_2.ogg'

/datum/blooper/speak/alt2
	name = "Speak 3"
	id = "speak3"
	soundpath = 'goon/sounds/speak_3.ogg'

/datum/blooper/speak/alt3
	name = "Speak 4"
	id = "speak4"
	soundpath = 'goon/sounds/speak_4.ogg'

/datum/blooper/chitter/alt
	name = "Chittery Alt"
	id = "chitter2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/moth/mothchitter2.ogg'

// The Mayhem Special
/datum/blooper/whistle
	name = "Whistle 1"
	id = "whistle1"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/birdwhistle.ogg'

/datum/blooper/whistle/alt1
	name = "Whistle 2"
	id = "whistle2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/birdwhistle2.ogg'

/datum/blooper/caw/alt1
	name = "Caw 2"
	id = "caw2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/caw.ogg'
	minspeed = 4
	maxspeed = 9

/datum/blooper/caw/alt2
	name = "Caw 3"
	id = "caw3"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/caw2.ogg'
	minspeed = 3
	maxspeed = 9

/datum/blooper/caw/alt3
	name = "Caw 4"
	id = "caw4"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/caw3.ogg'
	minspeed = 3
	maxspeed = 9

/datum/blooper/ehh
	name = "Ehh 1"
	id = "ehh1"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/ehh.ogg'
	minspeed = 3
	maxspeed = 9

/datum/blooper/ehh/alt1
	name = "Ehh 2"
	id = "ehh2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/ehh2.ogg'

/datum/blooper/ehh/alt2
	name = "Ehh 3"
	id = "ehh3"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/ehh3.ogg'

/datum/blooper/ehh/alt3
	name = "Ehh 4"
	id = "ehh4"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/ehh4.ogg'
	minspeed = 3
	maxspeed = 9

/datum/blooper/ehh/alt5
	name = "Ehh 5"
	id = "ehh5"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/ehh5.ogg'

/datum/blooper/faucet
	name = "Faucet 1"
	id = "faucet1"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/faucet.ogg'

/datum/blooper/faucet/alt1
	name = "Faucet 2"
	id = "faucet2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/faucet2.ogg'

/datum/blooper/ribbit
	name = "Ribbit"
	id = "ribbit"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/ribbit.ogg'

/datum/blooper/hoot
	name = "Hoot"
	id = "hoot"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/hoot.ogg'
	minspeed = 4
	maxspeed = 9

/datum/blooper/tweet
	name = "Tweet"
	id = "tweet"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/tweet.ogg'

/datum/blooper/dwoop
	name = "Dwoop"
	id = "dwoop"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/dwoop.ogg'
	minspeed = 3
	maxspeed = 9

/datum/blooper/uhm
	name = "Uhm"
	id = "uhm"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/uhm.ogg'

/datum/blooper/wurtesh
	name = "Wurtesh"
	id = "wurtesh"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/wurble1.ogg'

/datum/blooper/chitter2
	name = "Chitter2"
	id = "chitter2"
	soundpath = 'modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/chitter1.ogg'
