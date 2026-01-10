/obj/item/clicker
	name = "clicker"
	desc = "A small clicking tool that fits in one's palm. It is said that the sound of the clicker can condition certain individuals into obedience."
	icon = 'modular_zubbers/icons/obj/lewd.dmi'
	icon_state = "clicker_pink"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY

	unique_reskin = list(
		"Pink" = "clicker_pink",
		"Teal" = "clicker_teal",
	)

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
			for(var/mob/living/carbon/human/sub in hearers(world.view, living_user / 0.5))
				if(!sub.has_quirk(/datum/quirk/well_trained) || sub == living_user || sub.stat == DEAD)
					continue
// Tajarans and Felinids are affected at /1.5 the range instead of /2
				if(get_dist(sub, living_user) > (sub.dna.species.type in list(/datum/species/tajaran, /datum/species/human/felinid) ? world.view / 1.5 : world.view / 2))
					continue
				sub.dir = get_dir(sub, living_user)
				sub.emote("me", 1, "instinctively hunches down in response to the click!", TRUE)
				to_chat(sub, span_purple("You instinctively hunch down to <b>[living_user]</b>."))

			for(var/mob/living/silicon/robot/borg_sub in hearers(world.view / 2, living_user))
				if(!borg_sub.has_quirk(/datum/quirk/well_trained) || borg_sub == living_user || borg_sub.stat == DEAD)
					continue
				borg_sub.dir = get_dir(borg_sub, living_user)
				borg_sub.emote("me", 1, "instinctively hunches down in response to the click!", TRUE)
				to_chat(borg_sub, span_purple("You instinctively hunch down to <b>[living_user]</b>."))
// Shares cooldown with the dominant aura snap
			TIMER_COOLDOWN_START(living_user, DOMINANT_COOLDOWN_SNAP, 10 SECONDS)


