/datum/quirk/gargoyle //Mmmm yes stone time
	name = "Gargoyle"
	desc = "You are some form of gargoyle! You can only leave your stone form for so long, and will have to return to it to regain energy. On the bright side, you heal in statue form!"
	value = 0
	quirk_flags = /datum/quirk::quirk_flags | QUIRK_PROCESSES
	var/energy = 0
	var/transformed = 0
	var/cooldown = 0
	var/paused = 0
	var/turf/position
	var/obj/structure/statue/gargoyle/current = null

/datum/quirk/gargoyle/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if (!H)
		return
	var/datum/action/gargoyle/transform/T = new
	var/datum/action/gargoyle/check/C = new
	var/datum/action/gargoyle/pause/P = new
	energy = 100
	cooldown = 30
	T.Grant(H)
	C.Grant(H)
	P.Grant(H)

/datum/quirk/gargoyle/process(seconds_per_tick)
	. = ..()

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
		var/integrity = current.get_integrity()
		energy = min(energy + 0.3, 100)
		if (H.getBruteLoss() > 0 || H.getFireLoss() > 0)
			H.adjustBruteLoss(-0.5, forced = TRUE)
			H.adjustFireLoss(-0.5, forced = TRUE)
		else if (H.getOxyLoss() > 0 || H.getToxLoss() > 0)
			H.adjustToxLoss(-0.3, forced = TRUE)
			H.adjustOxyLoss(-0.5, forced = TRUE) //oxyloss heals by itself, doesn't need a nerfed heal
		/*else if (H.getCloneLoss() > 0)
			H.adjustCloneLoss(-0.3, forced = TRUE)*/
		else if (current && integrity < current.max_integrity) //health == maxHealth is true since we checked all damages above
			current.update_integrity(min(integrity + 0.1, current.max_integrity))

	if(!transformed && energy <= 0)
		var/datum/action/gargoyle/transform/T = locate() in H.actions
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
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "ling_camouflage"
	var/obj/structure/statue/gargoyle/current = null

/datum/action/gargoyle/transform/Trigger(trigger_flags)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/datum/quirk/gargoyle/T = H.get_quirk(/datum/quirk/gargoyle)
	if(!T.cooldown)
		if(!T.transformed)
			if(!isturf(H.loc))
				return 0
			var/obj/structure/statue/gargoyle/S = new(H.loc, H)
			S.name = "statue of [H.name]"
			ADD_TRAIT(H, TRAIT_NOBLOOD, ACTION_TRAIT)
			S.copy_overlays(H)
			var/newcolor = list(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0))
			S.add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
			current = S
			T.transformed = 1
			T.cooldown = 30
			T.paused = 0
			S.dir = H.dir
			return 1
		else
			qdel(current)
			T.transformed = 0
			T.cooldown = 30
			T.paused = 0
			REMOVE_TRAIT(H, TRAIT_NOBLOOD, ACTION_TRAIT)
			H.visible_message(span_warning("[H]'s skin rapidly softens, returning them to normal!"), span_userdanger("Your skin softens, freeing your movement once more!"))
	else
		to_chat(H, span_warning("You have transformed too recently; you cannot yet transform again!"))
		return 0

/datum/action/gargoyle/check
	name = "Check"
	desc = "Check your current energy levels."
	button_icon = 'modular_skyrat/modules/clock_cult/icons/actions_clock.dmi'
	button_icon_state = "Linked Vanguard"

/datum/action/gargoyle/check/Trigger(trigger_flags)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/datum/quirk/gargoyle/T = H.get_quirk(/datum/quirk/gargoyle)
	to_chat(H, span_warning("You have [T.energy]/100 energy remaining!"))

/datum/action/gargoyle/pause
	name = "Preserve"
	desc = "Become near-motionless, thusly conserving your energy until you move from your current tile. Note, you will lose a chunk of energy when you inevitably move from your current position, so you cannot abuse this!"
	button_icon = 'modular_zzplurt/icons/mob/actions/actions_flightsuit.dmi'
	button_icon_state = "flightsuit_lock"

/datum/action/gargoyle/pause/Trigger(trigger_flags)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/datum/quirk/gargoyle/T = H.get_quirk(/datum/quirk/gargoyle)

	if(!T.paused)
		T.paused = 1
		T.position = H.loc
		to_chat(H, span_warning("You are now conserving your energy; this effect will end the moment you move from your current position!"))
		return
	else
		to_chat(H, span_warning("You are already conserving your energy!"))

/obj/structure/statue/gargoyle
	name = "statue"
	desc = "An incredibly intricate statue, which... almost seems alive!"
	icon = 'modular_zzplurt/icons/obj/art/statue.dmi'
	icon_state = "gargoyle" //empty sprite because it's supposed to copy over the overlays anyway, and otherwise, you end up with a white human male underlay beneath the statue.
	density = TRUE
	anchored = TRUE
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	max_integrity = 200
	var/mob/living/carbon/human/petrified_mob
	var/old_max_health
	var/old_size
	var/was_tilted
	var/was_lying
	var/was_lying_prev
	var/deconstructed = FALSE

/obj/structure/statue/gargoyle/Initialize(mapload, mob/living/L)
	. = ..()
	var/mob/living/carbon/human/H = L
	if(L)
		petrified_mob = L
		if(L.buckled)
			L.buckled.unbuckle_mob(L,force=1)
		L.visible_message(span_warning("[L]'s skin rapidly turns to stone!"), span_warning("Your skin abruptly hardens as you turn to stone once more!"))
		dir = L.dir
		transform = L.transform
		pixel_x = L.pixel_x
		pixel_y = L.pixel_y
		layer = L.layer
		var/datum/component/pixel_shift/comp = H.GetComponent(/datum/component/pixel_shift)
		if(comp)
			was_tilted = comp.how_tilted
		was_lying = L.body_position == LYING_DOWN
		was_lying_prev = L.lying_prev
		L.forceMove(src)
		ADD_TRAIT(L, TRAIT_MUTE, STATUE_MUTE)
		ADD_TRAIT(L, TRAIT_IMMOBILIZED, STATUE_MUTE)
		ADD_TRAIT(L, TRAIT_HANDS_BLOCKED, STATUE_MUTE)
		//ADD_TRAIT(L, TRAIT_MOBILITY_NOUSE, STATUE_MUTE)
		ADD_TRAIT(L, TRAIT_NOBREATH, STATUE_MUTE)
		ADD_TRAIT(L, TRAIT_NOHUNGER, STATUE_MUTE)
		//ADD_TRAIT(L, TRAIT_NOTHIRST, STATUE_MUTE)
		ADD_TRAIT(L, TRAIT_NOFIRE, STATUE_MUTE) //OH GOD HELP I'M ON FIRE INSIDE THE STATUE I CAN'T MOVE AND I CAN'T STOP IT HAAAAALP - person who experienced this
		L.click_intercept = src
		L.faction |= FACTION_MIMIC //Stops mimics from instaqdeling people in statues
		L.status_flags |= GODMODE
		old_max_health = L.maxHealth
		old_size = H.dna.features["body_size"]
		atom_integrity = L.health + 100 //stoning damaged mobs will result in easier to shatter statues
		max_integrity = atom_integrity

/obj/structure/statue/gargoyle/proc/InterceptClickOn(mob/living/caller, params, atom/A) //technically could be bypassed by doing something that also uses click intercept but shrug
	var/atom/movable/screen/movable/action_button/ab = A
	if (istype(ab))
		if (istype(ab.linked_action, /datum/action/gargoyle))
			return FALSE
	var/list/modifiers = params2list(params)
	if (modifiers["shift"] && !modifiers["ctrl"] && !modifiers["middle"])
		return FALSE
	return TRUE

/obj/structure/statue/gargoyle/examine_more(mob/user) //something about the funny signals doesn't work here no matter how much I fucked around with it (ie registering to COMSIG_PARENT_EXAMINE_MORE doesn't do anything), so we have to overwrite the proc
	. = ..()
	if (petrified_mob)
		SEND_SIGNAL(petrified_mob, COMSIG_ATOM_EXAMINE, user, .)
		. -= span_notice("<i>You examine [src] closer, but find nothing of interest...</i>")

/obj/structure/statue/gargoyle/handle_atom_del(atom/A)
	if(A == petrified_mob)
		petrified_mob = null

/obj/structure/statue/gargoyle/Destroy()
	if(petrified_mob)
		petrified_mob.status_flags &= ~GODMODE
		petrified_mob.forceMove(loc)
		REMOVE_TRAIT(petrified_mob, TRAIT_MUTE, STATUE_MUTE)
		REMOVE_TRAIT(petrified_mob, TRAIT_IMMOBILIZED, STATUE_MUTE)
		REMOVE_TRAIT(petrified_mob, TRAIT_HANDS_BLOCKED, STATUE_MUTE)
		//REMOVE_TRAIT(petrified_mob, TRAIT_MOBILITY_NOUSE, STATUE_MUTE)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOBREATH, STATUE_MUTE)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOHUNGER, STATUE_MUTE)
		//REMOVE_TRAIT(petrified_mob, TRAIT_NOTHIRST, STATUE_MUTE)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOFIRE, STATUE_MUTE)
		petrified_mob.faction -= FACTION_MIMIC
		petrified_mob.click_intercept = null
		petrified_mob.dir = dir
		petrified_mob.dna.features["body_size"] = old_size
		petrified_mob.dna.update_body_size()
		var/damage = deconstructed ? petrified_mob.health : petrified_mob.health*(old_max_health/petrified_mob.maxHealth) - atom_integrity + 100
		petrified_mob.take_overall_damage(damage) //any new damage the statue incurred is transfered to the mob
		petrified_mob.transform = transform
		if(was_lying)
			petrified_mob.set_body_position(LYING_DOWN)
		petrified_mob.lying_prev = was_lying_prev
		petrified_mob.pixel_x = pixel_x
		petrified_mob.pixel_y = pixel_y
		petrified_mob.layer = layer
		var/datum/component/pixel_shift/comp = petrified_mob.GetComponent(/datum/component/pixel_shift)
		if(comp)
			comp.is_shifted = TRUE //just prevents bad things tbh
			comp.how_tilted = was_tilted
		if (pulledby && pulledby.pulling == src) //gotta checked just in case
			INVOKE_ASYNC(pulledby, PROC_REF(start_pulling), petrified_mob, supress_message = TRUE)
		var/datum/quirk/gargoyle/T = petrified_mob.get_quirk(/datum/quirk/gargoyle)
		if (T)
			T.transformed = 0
		petrified_mob = null
	return ..()

/obj/structure/statue/gargoyle/atom_deconstruct(disassembled)
	. = ..()

	deconstructed = TRUE
	visible_message(span_danger("[src] shatters!"))
	qdel(src)

/obj/structure/statue/gargoyle/attackby(obj/item/W, mob/living/user, params)
	add_fingerprint(user)
	//if(!(flags_1 & NODECONSTRUCT_1)) //Doesn't exist in this codebase?
	if(default_unfasten_wrench(user, W))
		return
	if(W.tool_behaviour == TOOL_WELDER)
		if(!W.tool_start_check(user, amount=0))
			return FALSE

		if (petrified_mob && alert(user, "You are slicing apart a gargoyle! Are you sure you want to continue? This will severely harm them, if not outright kill them.",, "Continue", "Cancel") == "Cancel")
			return

		user.visible_message(span_notice("[user] is slicing apart the [name]."), \
							span_notice("You are slicing apart the [name]..."))
		if (petrified_mob)
			to_chat(petrified_mob, span_userdanger("You are being sliced apart by [user]!"))
		if(W.use_tool(src, user, 40, volume=50))
			user.visible_message(span_notice("[user] slices apart the [name]."), \
								span_notice("You slice apart the [name]!"))
			deconstruct(TRUE)
		return
	return ..()
