/obj/item/toy/plush/chaotic_toaster
	name = "Chaotic toaster"
	desc = "You arent sure if this plushie want a hug, or harvest your organs, or both."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "chaotic_toaster"
	attack_verb_simple = list("beeped", "booped", "pinged")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)

/obj/item/toy/plush/Synth
	name = "Synth plushie"
	desc = "An adorable stuffed toy that resembles a very happy synth."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "plushie_synth"

/obj/item/toy/plush/mal0
	name = "Mal0 plushie"
	desc = "An adorable stuffed toy that resembles something you download on your pda."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "plushie_mal0"

/obj/item/toy/plush/nobl
	name = "fluffy skog plushie"
	desc = "It seems to be a small canine, not necessarily latex like you would suspect for some reason, but extremely squishy."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "nobl"
	squeak_override = list('modular_zubbers/sound/misc/dog_toy.ogg' = 1)

/obj/item/toy/plush/chirp_plush
	name = "chirping synth Plushie"
	desc = "It's warm to the touch."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "chirp"//Sprited by Kan3/kaylexi
	attack_verb_continuous = list("chirps", "chimes")
	attack_verb_simple = list("chirps")
	squeak_override = list('sound/machines/beep/beep.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/bigdeer
	name = "big deer plushie"
	desc = "An incredibly round deer plush. It appears to have had too many berries for snack time."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bigdeer" //sprited by Gavla
	attack_verb_simple = list("puff", "smother")
	squeak_override = list('modular_zubbers/sound/misc/squeakle.ogg' = 1)
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	inhand_icon_state = "bigdeer"

/obj/item/toy/plush/bubbledragon
	name = "bubbledragon plushie"
	desc = "This plush of a regal dragon seems to clean every surface it touches. When hugged, it squeaks and blows bubbles! An excellent companion for when TamaGoSlep"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bubbledragon"
	squeak_override = list('modular_zubbers/sound/misc/squeakle.ogg' = 1)

/obj/item/toy/plush/bubbledragon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/cleaner, 3 SECONDS, pre_clean_callback=CALLBACK(src, PROC_REF(should_clean)))

/obj/item/toy/plush/bubbledragon/proc/should_clean(datum/cleaning_source, atom/atom_to_clean, mob/living/cleaner)
	return (src in cleaner)

/obj/item/toy/plush/headcrab
	name = "headcrab plushie"
	desc = "A small, parasitic alien from the borderworld of Xen, this one is fake."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "headcrab"

/obj/item/toy/plush/bellybird
	name = "bellybird plushie"
	desc = "It has a tag on the back. 'You seen the opera, now get ready for the theatrical release with the new Bellybird plushie. House Feather's patented design allows this plushie to feel almost lifelike with its synthetic feathers and smoothed scales, glow in the dark eyes and a round tummy to rest your head on, not to mention it comes complete with Autumn the snake tail! Witness Autumn in action as this flexible tail is able to snap her jaws and hiss at any opponent with such realism. Order now for only two low payments of 19.95!'"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bellybird"
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/hiss.ogg' = 1)

/obj/item/toy/plush/tiredtesh
	name = "tired tesh plushie"
	desc = "He looks very eepy. A tag on the back of the plushie reads, 'Happy birthday, big guy.'"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "tiredtesh"
	squeak_override = list('modular_zubbers/sound/emotes/nose_boop.ogg' = 1)

/obj/item/toy/plush/xenoplush
	name = "xenomorph plushie"
	desc = "A cute rendition of the notorious xenomorph. Its stuffing is an acidic green colour."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "xenoplush"
	squeak_override = list('sound/mobs/non-humanoids/hiss/hiss6.ogg' = 1)
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	inhand_icon_state = "xenoplush"
	attack_verb_continuous = list("hisses at", "bites", "chews", "chomps", "tail stabs")
	attack_verb_simple = list("hiss at", "bite", "chew", "chomp", "tail stab")

/obj/item/toy/plush/xenoplush/xenomaidplush
	name = "xenomorph maid plushie"
	desc = "A cute rendition of the notorious xenomorph, but in a maid costume. It's eager to help you clean the station."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "xenomaidplush"
	attack_verb_continuous = list("polishes", "cleans", "tidies", "washes")
	attack_verb_simple = list("polish", "clean", "tidy", "wash")

/obj/item/toy/plush/skyrat/jecca
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'

/obj/item/toy/plush/purplecat
	name = "Purple cat plushie"
	desc = "A small, fluffy purple cat with an even purpler collar and bell. It also has a translucent green tail that rubbery to the touch."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "purplecat" //sprited by Bit_Synergy
	attack_verb_simple = list("mew", "mow")
	attack_verb_continuous = list("mews", "mows")
	squeak_override = list('modular_zubbers/sound/misc/moew.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/largeredslime
	name = "large red slime plushie" //Donator item exclusive for Blovy. Sprited by Casey/Keila.
	desc = "The plushie is squishy to touch and smells strongly of strawberry."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "blovyplushie"
	attack_verb_continuous = list("blorbles", "slimes", "absorbs")
	attack_verb_simple = list("blorble", "slime", "absorb")
	squeak_override = list('sound/effects/blob/blobattack.ogg' = 1)

/obj/item/toy/plush/tunafish
	name = "Piscene Paddle" //Donator plush for Astroturf, sprited by Crumpaloo
	desc = "Useful for more than just sashimi."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "tunafish"
	attack_verb_continuous = list("slaps", "whacks")
	attack_verb_simple = list("slap", "whack")
	squeak_override = list('sound/items/weapons/slap.ogg' = 1)
	lefthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/items/plushes_righthand.dmi'
	inhand_icon_state = "tunafish"

/obj/item/toy/plush/secoff
	name = "GalFed Secoff"
	desc = "A soft toy representing a popular, young officer, representing the alliance between GalFed and NT. The bottom of his work boot says 'Andy'"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "secoff"
	attack_verb_continuous = list("shoots (and misses)", "batongs", "annoys", "harmbatons", "magdumps")
	attack_verb_simple = list("shot (and missed)", "batong", "annoy", "harmbaton", "magdump")
	squeak_override = list('sound/items/weapons/gun/general/bolt_rack.ogg' = 1)

/obj/item/toy/plush/cescrewsplush
	name = "Chief Screws Plush" //Plush for Steals The Screwdriver/SteamStucKobold, sprited by stickygoat. and Amorbis
	desc = "An adorable blue Lizard plushie wearing a Chief Engineer's Uniform, Rocket Boots, and Meson Goggles. It has a strange, silicone pocket on its underside..."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "cescrewsplush"
	attack_verb_continuous = list("slaps", "plaps", "smears")
	attack_verb_simple = list("slap", "plap", "smear")
	gender = FEMALE
	squeak_override = list('sound/misc/soggy.ogg'=1)

/obj/item/toy/plush/cescrewsplush/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to take a look under her skirt.")

/obj/item/toy/plush/cescrewsplush/click_alt(mob/user)
	user.visible_message(span_notice("[user] turns [src], revealing the hole underneath."), span_notice("You turn [src], revealing a tight, lubed hole."))
	playsound(user, 'sound/effects/blob/blobattack.ogg', 50, TRUE)
	var/obj/item/toy/plush/fleshlight/screws/toy = new(null)
	qdel(src)
	user.put_in_hands(toy)
	return TRUE

/obj/item/toy/plush/internshiba
	name = "Intern Shiba Plush" //Plush for Kazumi Hasegawa/sprited by Amorbis
	desc = "An adorable shiba inu plushie of a well-known intern mutt."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "internshiba"
	attack_verb_continuous = list("baps", "paws", "claws")
	attack_verb_simple = list("bap", "paw", "claw")
	gender = MALE
	squeak_override = list('sound/mobs/non-humanoids/dog/growl2.ogg' = 1)

/obj/item/toy/plush/bottomsynf
	name = "CentCom Synth Fox Plush"
	desc = "The plush of a synth fox who enjoys being high in the chain of command. Or so it seems. It's wearing its favourite CentCom formal coat."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bottomsynf"
	attack_verb_continuous = list("emags", "hacks", "geckers")
	attack_verb_simple = list("beeps", "boops", "pings", "geckers")
	gender = MALE
	squeak_override = list('sound/machines/terminal_alert_short.ogg' = 1)

// Silly plush for kurzaen, sprited and coded by Waterpig
// Spontaneously combusts when touched by other plushies
/obj/item/toy/plush/cat_annoying
	name = "\improper Annoying Cat Plush"
	desc = "This plush reeks of Green apples, and HATES physical affection. You can feel it looking at you with a judgmental gaze.."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "annoyingcat"
	gender = MALE
	squeak_override = list(
		'modular_skyrat/modules/emotes/sound/voice/scream_m1.ogg' = 1,
		'modular_skyrat/modules/emotes/sound/voice/scream_m2.ogg' = 1,
	)

/obj/item/toy/plush/cat_annoying/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/toy/plush))
		combust()
	return ..()

/obj/item/toy/plush/cat_annoying/pre_attack(atom/A, mob/living/user, params)
	if(istype(A, /obj/item/toy/plush))
		combust()
	return ..()

/obj/item/toy/plush/cat_annoying/proc/combust()
	src.fire_act(5000)
	src.visible_message(span_notice("The [src.name] spontaneously combusts from physical affection!"))
	addtimer(CALLBACK(src, PROC_REF(ash)), 2 SECONDS)

/obj/item/toy/plush/cat_annoying/proc/ash()
	new /obj/effect/decal/cleanable/ash(get_turf(src))
	src.visible_message(span_warning("The [src.name] turns to ash!"))
	qdel(src)

// Plush for Vanilla
/obj/item/toy/plush/suspicious_protogen
	name = "\improper Suspicious protogen plush"
	desc = "A suspicious pink looking protogen plushie commonly seen roaming the station almost everywhere, \
			perfect for cuddling when you feel upset at something."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "pinkproot"
	gender = FEMALE
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg' = 1)

// Plush for ZeferwasnttakenFR
/obj/item/toy/plush/foxy_plush
	name = "tiny prankster fox plush"
	desc = "A fox plush made to look like a certain prankster fox. Unsuprisingly it also smells like ocean breeze and a nice warm forge. \ Batteries not included for the plastic arm!"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "FoxyPlush"
	gender = MALE
	squeak_override = list('modular_zubbers/sound/emotes/claponce1.ogg' = 1)

// Rin/Yayyay007's plush
/obj/item/toy/plush/squeaky_toy
	name = "squeaky rat plushie"
	desc = "A plush made to order of a particular rodent. Smells like an awful lover. \ A small sticker says, TUG MY EARS!"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "squeaky_toy"
	gender = MALE
	squeak_override = list('sound/mobs/non-humanoids/mouse/mousesqueek.ogg' = 1)

// Sophie/Cydia's plush
/obj/item/toy/plush/androiddog
	name = "android dog plushie"
	desc = "A faded plushie toy of an android dog. Will not bite. \ A sticker says 'Push me!' on a little heart on the hand."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "androiddog"
	gender = FEMALE
	squeak_override = list('modular_zubbers/sound/emotes/arf.ogg' = 1)

// xPokee's plush
/obj/item/toy/plush/ghoul
	name = "intern ghoul plushie"
	desc = "Even the marketable plushie of this thing is utterly terrifying. At least it's cuddly..."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "johnghoul"
	attack_verb_continuous = list("ghouls")
	attack_verb_simple = list("ghoul")
	squeak_override = list('modular_zubbers/code/modules/blooper/voice/bloopers/kazooie/ehh.ogg' = 1)

// plushie for BeoTheKobold
// sprite by Cepha, code by Mitryll
/obj/item/toy/plush/mold_kobold
	name = "hemophage awareness kobold"
	desc = "A cuddly kobold plushie. Produced by Nanotrasen in the soft likeness of a hemophage employee; \
			focus groups thought this design played less into hemophage stereotypes as opposed to the previous iteration, \
			Lord Grog the Vile Parasite. A tag on the left leg says 10% of proceeds go to blood banks!"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "themold"
	attack_verb_continuous = list("bites", "curses", "drains")
	attack_verb_simple = list("bite", "invoke", "claw")
	gender = FEMALE

// Plushie for Decinomics
/obj/item/toy/plush/sinvox
	name = "sinister vox plushie"
	desc = "An evil looking toy. It's got a vox beak that splits into mandibles like a bug;\
		its tail looks like a copy of the xenomorph plushie stitched together poorly.\
		Property and copyright of VOXXXED Studios..."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "sinvox"
	attack_verb_continuous = list("hisses at", "bites", "mauls", "quills", "tail stabs")
	attack_verb_simple = list("hiss at", "bite", "maul", "quill", "tail stab")
	gender = MALE
	squeak_override = list(
		'sound/mobs/non-humanoids/hiss/hiss2.ogg' = 1,
		'modular_skyrat/modules/emotes/sound/emotes/voxrustle.ogg' = 1,
	)

/obj/item/toy/plush/mothroach_plush
	name = "mothroach plush"
	desc = "A plushie featuring the likeness everyone's favorite genetic freak-turned station pet. Do not soak it in milk and throw it against a wall."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "mothroach"
	attack_verb_continuous = list("mothroaches", "moths", "roaches")
	attack_verb_simple = list("mothroach", "moth", "roach")
	gender = MALE
	squeak_override = list( 'sound/mobs/humanoids/moth/scream_moth.ogg' = 1, )

/obj/item/toy/plush/moth/lovers
	name = "lovers moth plushie"
	desc = "An adorable mothperson plushie. It's a lovely bug!"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "moffplush_lovers"

/obj/item/toy/plush/lazy_synth
	name = "lazy synth plush"
	desc = "A soft plush of an extremely lazy synth. Might be found loafing in random places."
	attack_verb_continuous = list("squishes", "loafs on", "sleeps on", "eggs")
	attack_verb_simple = list("squish", "loaf on", "sleep on", "egg")
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "lazy_synth"
	squeak_override = list('modular_zubbers/sound/misc/squeakle.ogg' = 1)


/obj/item/toy/plush/tian_plush
	name = "bureaucratic goat plush"
	desc = "A big, soft plush of a goat-carp creature, that clearly hasn't slept in a lot. It has a faint smell of ink and weed."
	attack_verb_continuous = list("chomps", "nibbles", "gnashes", "bites")
	attack_verb_simple = list("gnashes")
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "tian_plush"
	squeak_override = list('modular_skyrat/modules/emotes/sound/voice/baa.ogg' = 1)

/obj/item/toy/plush/goatplushie
	name = "strange goat plushie"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "goat"
	desc = "Despite its cuddly appearance and plush nature, it will beat you up all the same. Goats never change."
	squeak_override = list('sound/items/weapons/punch1.ogg'=1)
	/// Whether or not this goat is currently taking in a monsterous doink
	var/going_hard = FALSE
	/// Whether or not this goat has been flattened like a funny pancake
	var/splat = FALSE

/obj/item/toy/plush/goatplushie/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_TURF_INDUSTRIAL_LIFT_ENTER = PROC_REF(splat),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/plush/goatplushie/attackby(obj/item/cigarette/rollie/fat_dart, mob/user, list/modifiers, list/attack_modifiers)
	if(!istype(fat_dart))
		return ..()
	if(splat)
		to_chat(user, span_notice("[src] doesn't seem to be able to go hard right now."))
		return
	if(going_hard)
		to_chat(user, span_notice("[src] is already going too hard!"))
		return
	if(!fat_dart.lit)
		to_chat(user, span_notice("You'll have to light that first!"))
		return
	to_chat(user, span_notice("You put [fat_dart] into [src]'s mouth."))
	qdel(fat_dart)
	going_hard = TRUE
	update_icon(UPDATE_OVERLAYS)

/obj/item/toy/plush/goatplushie/proc/splat(datum/source)
	SIGNAL_HANDLER
	if(splat)
		return
	if(going_hard)
		going_hard = FALSE
		update_icon(UPDATE_OVERLAYS)
	icon_state = "goat_splat"
	playsound(src, SFX_DESECRATION, 50, TRUE)
	visible_message(span_danger("[src] gets absolutely flattened!"))
	splat = TRUE

/obj/item/toy/plush/goatplushie/examine()
	. = ..()
	if(splat)
		. += span_notice("[src] might need medical attention.")
	if(going_hard)
		. += span_notice("[src] is going so hard, feel free to take a picture.")

/obj/item/toy/plush/goatplushie/update_overlays()
	. = ..()
	if(going_hard)
		. += "goat_dart"

/obj/item/toy/plush/sunny_plush
	name = "weighty moostoat plushie"
	desc = "A soft, weighted plushie of a moostoat. Very comfortable to hug and have lying on you. It smells of fresh milk."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "sunny_plush"
	squeak_override = list(
		'modular_skyrat/modules/emotes/sound/voice/moo.ogg' = 1,
		'sound/mobs/non-humanoids/stoat/stoat_sounds.ogg' = 1,
	)

//Plushie for and by Lazhannya
//Original Design by Cepha
/obj/item/toy/plush/amber_shadekin_plush
	name = "Squishy Shadekin Plush"
	desc = "A plushie featuring the likeness of a certain self declared mad genius shadekin. It smells faintly of cinnamon."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "amberalert"
	attack_verb_continuous = list("mars at", "bites", "chomps", "paws at", "fwoomps", "marmars")
	attack_verb_simple = list("mar", "bite", "chomp", "paw", "fwoomp", "marmar")
	gender = FEMALE
	squeak_override = list('modular_zubbers/sound/emotes/sound_voice_mar.ogg' = 1)
