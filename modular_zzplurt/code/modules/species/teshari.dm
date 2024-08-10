/datum/species/teshari

/datum/species/teshari/on_species_gain(mob/living/carbon/human/new_teshari, datum/species/old_species, pref_load)
	. = ..()
	var/datum/action/cooldown/sonar_ping/sonar_ping = new(new_teshari)
	sonar_ping.Grant(new_teshari)

	new_teshari.setMaxHealth(50)
	new_teshari.physiology.hunger_mod *= 2
	new_teshari.add_movespeed_modifier(/datum/movespeed_modifier/teshari)


/datum/movespeed_modifier/teshari
	multiplicative_slowdown = -0.2


/datum/action/cooldown/sonar_ping
	name = "Listen In"
	desc = "Allows you to listen in to movement and noises around you."
	button_icon = 'icons/obj/medical/organs/organs.dmi'
	button_icon_state = "ears"
	cooldown_time = 10 SECONDS

/datum/action/cooldown/sonar_ping/IsAvailable(feedback)
	var/mob/living/carbon/owner = src.owner
	return ..() && owner.can_hear()


/datum/action/cooldown/sonar_ping/Activate(atom/target)
	var/heard_something = FALSE
	to_chat(owner, span_notice("You take a moment to listen in to your environment..."))
	for(var/mob/living/living in range(owner.client?.view, owner))
		if(living == owner || living.stat == DEAD)
			continue

		var/turf/source_turf = get_turf(living)
		if(!source_turf)
			continue

		var/feedback = list()
		feedback += "There are noises of movement "
		var/direction = get_dir(src, living)
		if(direction)
			feedback += "towards the [dir2text(direction)], "
			switch(get_dist(src, living) / 7)
				if(0 to 0.2)
					feedback += "very close by."
				if(0.2 to 0.4)
					feedback += "close by."
				if(0.4 to 0.6)
					feedback += "some distance away."
				if(0.6 to 0.8)
					feedback += "further away."
				else
					feedback += "far away."
		else // No need to check distance if they're standing right on-top of us
			feedback += "right on top of you."

		heard_something = TRUE
		to_chat(owner, span_notice(jointext(feedback, null)))

	if(!heard_something)
		to_chat(owner, span_notice("You hear no movement but your own."))

	StartCooldown()
	return TRUE




