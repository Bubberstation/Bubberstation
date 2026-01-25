/obj/item/clicker
	name = "clicker"
	desc = "A small clicking toy that fits in the palm of your hand, typically used to condition pets into obedience. It makes a satisfying 'click' sound when pressed."
	icon = 'modular_zubbers/icons/obj/lewd.dmi'
	icon_state = "clicker_pink"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/clicker/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/clicker)

/datum/atom_skin/clicker
	abstract_type = /datum/atom_skin/clicker

/datum/atom_skin/clicker/pink
	preview_name = "Pink"
	new_icon_state = "clicker_pink"

/datum/atom_skin/clicker/teal
	preview_name = "Teal"
	new_icon_state = "clicker_teal"

/obj/item/clicker/proc/click(atom/source, mob/user)
	SIGNAL_HANDLER
	source.balloon_alert(user, "click!")
	playsound(source, "modular_zubbers/sound/lewd/clicker.ogg", 40, FALSE)

/obj/item/clicker/attack_self(mob/user)
	. = ..()
	click(src, user)

// If the user has the dominant aura quirk, nearby bottoms will react to the click.
	if(istype(user, /mob/living))
		var/mob/living/living_user = user
		if(living_user.has_quirk(/datum/quirk/dominant_aura) && TIMER_COOLDOWN_FINISHED(living_user, DOMINANT_COOLDOWN_SNAP))
			for(var/mob/living/carbon/human/sub in hearers(world.view / 2, living_user))
				if(!sub.has_quirk(/datum/quirk/well_trained) || sub == living_user || sub.stat == DEAD)
					continue

				if(get_dist(sub, living_user) > world.view / 2)
					continue
				sub.dir = get_dir(sub, living_user)
				sub.emote("me", 1, "suddenly perks up in attention!", TRUE)
				to_chat(sub, span_purple("You perk up in attention hearing <b>[living_user]</b>'s click!"))
// Short mood boost for flavour
				sub.add_mood_event("good_pet", /datum/mood_event/good_pet)
// Shivering animation
				animate(sub, pixel_w = 1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
				for(var/i in 1 to 1 SECONDS / (0.2 SECONDS))
					animate(pixel_w = -2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
					animate(pixel_w = 2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
				animate(pixel_w = -1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)

//For the borgs
			for(var/mob/living/silicon/robot/borg_sub in hearers(world.view / 2, living_user))
				if(!borg_sub.has_quirk(/datum/quirk/well_trained) || borg_sub == living_user || borg_sub.stat == DEAD)
					continue
				borg_sub.dir = get_dir(borg_sub, living_user)
				borg_sub.emote("me", 1, "suddenly perks up in attention!", TRUE)
				to_chat(borg_sub, span_purple("You perk up in attention hearing <b>[living_user]</b>'s click!"))
// Shivering animation
				animate(borg_sub, pixel_w = 1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
				for(var/i in 1 to 1 SECONDS / (0.2 SECONDS))
					animate(pixel_w = -2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
					animate(pixel_w = 2, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_CONTINUE)
				animate(borg_sub, pixel_w = -1, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)

// Shares cooldown with the dominant aura snap
			TIMER_COOLDOWN_START(living_user, DOMINANT_COOLDOWN_SNAP, 10 SECONDS)

/datum/mood_event/good_pet
	description = span_nicegreen("Being obedient feels rewarding!")
	mood_change = 2
	timeout = 2 MINUTES
