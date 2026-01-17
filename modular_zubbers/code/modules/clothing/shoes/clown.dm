/obj/item/clothing/shoes/clown_shoes/bubber
	name = "official bubberstation chat mod shoes"
	desc = "Finally, you can be an unpaid Discord moderator in space. Clean it up Jannie!"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	icon_state = null

//Clussy and Jester shoes from Splurt.
/obj/item/clothing/shoes/clown_shoes/bubber/clussy
	name = "squeaky clown heels"
	desc = "Some Clowns have been throwing away their shoes to wear heels. This corrects that through painful nerve implanting needles! And squeaking heels. May have went a bit far in a few places..."
	icon_state = "clussy_heels"

//No waddle and no squeak version for all use.
/obj/item/clothing/shoes/latex_heels/bubber/clussy/mute
	name = "pink heels"
	desc = "Annoyed scientists have finally stolen the clowns shoes as an act of revenge and ripped out these heels capabilities to waddle and squeak. Unfortunately, they still barely fit on anyone's feet!"
	icon = 'modular_zubbers/icons/obj/clothing/feet/feet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/feet/feet.dmi'
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/feet/feet_digi.dmi'
	icon_state = "clussy_heels"
	worn_icon_state = "clussy_heels"

/obj/item/clothing/shoes/latex_heels/bubber/clussy/mute/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_zubbers/sound/effects/footstep/highheel1.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel2.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel3.ogg' = 1, 'modular_zubbers/sound/effects/footstep/highheel4.ogg' = 1), 70)

/obj/item/clothing/shoes/clown_shoes/bubber/jester
	name = "amazing jester shoes"
	desc = "As if two jester shoes weren't enough, here's a third. Never ask Clown Planet for anything again."
	icon_state = "striped_jester_shoes"
	squeak_sound = list('sound/effects/jingle.ogg'=1)
