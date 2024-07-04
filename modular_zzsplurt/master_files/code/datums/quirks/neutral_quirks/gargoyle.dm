/datum/quirk/gargoyle
	name = "Gargoyle"
	desc = "TEXT"
	icon = FA_ICON_HILL_ROCKSLIDE
	value = 0
	var/energy = 0
	var/transformed = 0
	var/cooldown = 0
	var/paused = 0
	var/turf/position
	var/obj/structure/statue/gargoyle/current = null

/datum/quirk/gargoyle/process()
	var/mob/living/carbon/human/H = quirk_holder
	if (!H)
		return

	if(paused && H.loc != position)
		paused = 0
		energy -= 20

	if(cooldown > 0)
		cooldown--

	if(!transformed && !paused && energy > 0)
		energy -= 0.05

	if(transformed)
		energy = min(energy + 0.3, 100)
		if (H.getBruteLoss() > 0 || H.getFireLoss() > 0)
			H.adjustBruteLoss(-0.5, forced = TRUE)
			H.adjustFireLoss(-0.5, forced = TRUE)
		else if (H.getOxyLoss() > 0 || H.getToxLoss() > 0)
			H.adjustToxLoss(-0.3, forced = TRUE)
			H.adjustOxyLoss(-0.5, forced = TRUE) //oxyloss heals by itself, doesn't need a nerfed heal

/datum/quirk/gargoyle/add(client/client_source)
	var/mob/living/carbon/human/H = quirk_holder
	if (isdummy(quirk_holder))
		return
	var/datum/action/gargoyle/transform/T = new
	var/datum/action/gargoyle/check/C = new
	var/datum/action/gargoyle/pause/P = new
	energy = 100
	cooldown = 30
	T.Grant(H)
	C.Grant(H)
	P.Grant(H)

	if(!transformed && energy <= 0)
		T = locate() in H.actions
		if (!T)
			T = new
			T.Grant(H)
		cooldown = 0
		T?.Trigger()

/datum/quirk/gargoyle/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if (!H)
		return ..()
	var/datum/action/gargoyle/transform/T = locate() in H.actions
	var/datum/action/gargoyle/check/C = locate() in H.actions
	var/datum/action/gargoyle/pause/P = locate() in H.actions
	T?.Remove(H)
	C?.Remove(H)
	P?.Remove(H)
	. = ..()

/datum/action/gargoyle/transform
	name = "Transform"
	desc = "Transform into a statue, regaining energy in the process. Additionally, you will slowly heal while in statue form."
	button_icon_state = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "ling_camouflage"

/datum/action/gargoyle/transform/Trigger()
	.=..()
	var/mob/living/carbon/human/H = owner
	var/datum/quirk/gargoyle/T = locate() in H.quirks
	var/obj/structure/statue/petrified/S = new(H.loc, H)
	if(!T.cooldown)
		if(!T.transformed)
			if(!isturf(H.loc))
				return 0
			H.petrify()
			T.transformed = 1
			T.cooldown = 30
			T.paused = 0
			return 1
		else
			S.Destroy()
			T.transformed = 0
			T.cooldown = 30
			T.paused = 0
			H.visible_message(span_warning("[H]'s skin rapidly softens, returning them to normal!"), span_userdanger("Your skin softens, freeing your movement once more!"))
	else
		to_chat(H, span_warning("You have transformed too recently; you cannot yet transform again!"))
		return 0

/datum/action/gargoyle/check
	name = "Check"
	desc = "Check your current energy levels."
	button_icon_state = null
	button_icon_state = "Linked Vanguard"

/datum/action/gargoyle/check/Trigger()
	.=..()
	var/mob/living/carbon/human/H = owner
	var/datum/quirk/gargoyle/T = locate() in H.quirks
	to_chat(H, span_warning("You have [T.energy]/100 energy remaining!"))

/datum/action/gargoyle/pause
	name = "Preserve"
	desc = "Become near-motionless, thusly conserving your energy until you move from your current tile. Note, you will lose a chunk of energy when you inevitably move from your current position, so you cannot abuse this!"
	button_icon_state = null
	button_icon_state = "flightsuit_lock"

/datum/action/gargoyle/pause/Trigger()
	.=..()
	var/mob/living/carbon/human/H = owner
	var/datum/quirk/gargoyle/T = locate() in H.quirks

	if(!T.paused)
		T.paused = 1
		T.position = H.loc
		to_chat(H, span_warning("You are now conserving your energy; this effect will end the moment you move from your current position!"))
		return
	else
		to_chat(H, span_warning("You are already conserving your energy!"))
