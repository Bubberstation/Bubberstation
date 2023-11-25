/obj/item/toy/plush/chaotic_toaster
	name = "Chaotic toaster"
	desc = "You arent sure if this plushie want a hug, or harvest your organs, or both."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "chaotic_toaster"
	attack_verb_simple = list("beeped", "booped", "pinged")
	squeak_override = list('sound/machines/beep.ogg' = 1)

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
	squeak_override = list('sound/machines/beep.ogg' = 1)
	gender = FEMALE

/obj/item/toy/plush/bigdeer_plush
	name = "big deer plushie"
	desc = "An incredibly round deer plush. It appears to have had too many berries for snack time."
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "bigdeer" //sprited by Gavla
	attack_verb_simple = list("puff", "smother")
	squeak_override = list('modular_zubbers/sound/misc/squeakle.ogg' = 1)

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
	squeak_override = list('modular_skyrat/modules/emotes/sound/emotes/Nose_boop.ogg' = 1)
