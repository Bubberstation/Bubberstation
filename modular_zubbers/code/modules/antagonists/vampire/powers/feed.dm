#define FEED_SILENT_NOTICE_RANGE 1
#define FEED_DEFAULT_TIME 10 SECONDS
#define FEED_FRENZY_TIME 2 SECONDS
#define FEED_MESMERIZE_TIME 2 SECONDS
#define FEED_BLOOD_FROM_MICE 25
/// How much vitae a vampire makes out of each unit of blood drunk
#define FEED_VITAE_PER_BLOOD 4

/datum/action/cooldown/vampire/targeted/feed
	name = "Feed"
	desc = "Feed blood off of a living creature."
	button_icon_state = "power_feed"
	power_explanation = "Activate Feed and select a target to start draining their blood.\n\
		You will begin to entrance them into accepting your advances.\n\
		The time needed before you start feeding decreases the higher level you are.\n\
		If you are feeding normally they will forget that they were ever fed off.\n\
		Mice can be fed off if you are in desperate need of blood.\n\
		<b>Feeding off of someone while you have them aggressively grabbed while in combat mode, will put them to sleep and make you feed faster</b>. \
		This is very obvious and the radius in which you can be detected is much larger!\n\
		<b>IMPORTANT:</b> Should you drain another vampire, you will absorb their power!"
	vampire_power_flags = BP_AM_TOGGLE | BP_AM_STATIC_COOLDOWN
	vampire_check_flags = BP_CANT_USE_IN_TORPOR | BP_CANT_USE_WHILE_STAKED | BP_CAN_USE_HEARTLESS
	special_flags = VAMPIRE_DEFAULT_POWER
	cooldown_time = 1 SECONDS
	target_range = 1
	prefire_message = "Select a target."
	power_activates_immediately = FALSE
	ranged_mousepointer = 'modular_zubbers/icons/effects/mouse_pointers/vampire_feed.dmi'
	/// Amount of blood taken, reset after each Feed. Used for logging.
	var/blood_taken = 0
	/// The amount of Blood a target has since our last feed, this loops and lets us not spam alerts of low blood.
	var/warning_target_bloodvol = BLOOD_VOLUME_MAXIMUM
	/// Reference to the target we've fed off of
	var/datum/weakref/target_ref
	/// Are we feeding with passive grab or not?
	var/silent_feed = TRUE

	/// Have we fed till fatal?
	var/feed_fatal = FALSE
	/// Was the target already dead when we started? Draining a corpse is free, killing someone isn't.
	var/target_was_dead = FALSE
	/// Did the target die while we were feeding on them?
	var/target_died = FALSE
	/// Letting go before this finishes is free, so nobody can stick you with a kill by succumbing the instant they can.
	COOLDOWN_DECLARE(release_grace)
	/// Has the bite actually started, as opposed to still mesmerizing them?
	var/currently_feeding = FALSE
	/// Did we complete the thirster objective this drain?
	/// We won't give a bad moodlet for dead bodies if so.
	var/completing_thirster = FALSE

/datum/action/cooldown/vampire/targeted/feed/get_power_explanation_extended()
	. = list()
	. += "Activate Feed and select a target to start draining their blood."
	. += "You will begin to entrance them into accepting your advances. This takes [DisplayTimeText(FEED_MESMERIZE_TIME + get_feed_time())], or [DisplayTimeText(get_feed_time(feeding_on_vassal = TRUE))] on a vassal."
	. += "The time needed before you start feeding decreases the higher level you are."
	. += "If you are feeding normally they will forget that they were ever fed off."
	. += "Mice can be fed off if you are in desperate need of blood."
	. += "<b>Feeding off of someone while you have them aggressively grabbed while in combat mode, will stun them for [DisplayTimeText(get_combat_stun_time())] and make you feed faster</b>. \
		This is very obvious and the radius in which you can be detected is much larger!"
	if(vampiredatum_power)
		. += "<b>IMPORTANT:</b> Should you drain another vampire, you will absorb their power!"

/// How long the bite takes to land once the target is subdued
/datum/action/cooldown/vampire/targeted/feed/proc/get_feed_time(feeding_on_vassal = FALSE)
	var/feed_time = (HAS_TRAIT(owner, TRAIT_FRENZY) ? FEED_FRENZY_TIME : clamp(round(FEED_DEFAULT_TIME / (1.25 * (level_current || 1))), 1, FEED_DEFAULT_TIME)) / 2
	if(feeding_on_vassal)
		feed_time /= 4
	return feed_time

/// How long a combat feed stuns the victim
/datum/action/cooldown/vampire/targeted/feed/proc/get_combat_stun_time()
	return (5 + level_current) SECONDS

/datum/action/cooldown/vampire/targeted/feed/can_use()
	. = ..()
	if(!.)
		return FALSE

	// Already feeding
	if(target_ref)
		return FALSE
	// Mouth covered
	var/mob/living/carbon/user = owner
	if(user?.is_mouth_covered() && !isplasmaman(user))
		owner.balloon_alert(owner, "mouth covered!")
		return FALSE

/datum/action/cooldown/vampire/targeted/feed/continue_active()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/target = target_ref?.resolve()
	if(!target)
		return FALSE
	if(!owner.Adjacent(target))
		return FALSE

	return TRUE

/datum/action/cooldown/vampire/targeted/feed/check_valid_target(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE

	// Must be living
	if(!isliving(target_atom))
		return FALSE
	var/mob/living/target = target_atom
	// Mice check
	if(ismouse(target))
		if(vampiredatum_power?.my_clan?.blood_drink_type == VAMPIRE_DRINK_SNOBBY)
			owner.balloon_alert(owner, "too disgusting!")
			return FALSE
		else
			return TRUE
	// Has to be human or a monkey
	if(!ishuman(target))
		owner.balloon_alert(owner, "cant feed off!")
		return FALSE
	// Mindless and snobby?
	if(!target.mind && vampiredatum_power?.my_clan?.blood_drink_type == VAMPIRE_DRINK_SNOBBY && !HAS_TRAIT(owner, TRAIT_FRENZY))
		owner.balloon_alert(owner, "ew, no!")
		return FALSE
	// Cannot be a curator
	if(IS_VAMPIRE_HUNTER(target))
		owner.balloon_alert(owner, "[target] is too powerful!")
		return FALSE
	// Human checks
	if(ishuman(target))
		// Cannot drink from inorganics
		var/mob/living/carbon/human/human_target = target
		if(!human_target.dna?.species || HAS_TRAIT(human_target, TRAIT_NOBLOOD))
			owner.balloon_alert(owner, "no blood!")
			return FALSE
		// Cannot be wearing super thick gear
		if(!human_target.can_inject(owner, BODY_ZONE_HEAD, INJECT_CHECK_PENETRATE_THICK))
			owner.balloon_alert(owner, "suit too thick!")
			return FALSE

	if(max_blood_reached(target))
		owner.balloon_alert(owner, "too full to drink more!")
		return FALSE

	if(isliving(owner))
		var/mob/living/living_owner = owner
		if(living_owner.body_position != STANDING_UP)
			living_owner.balloon_alert(living_owner, "must be standing!")
			return FALSE

	if(iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		if(carbon_owner.handcuffed)
			carbon_owner.balloon_alert(carbon_owner, "can't feed while restrained!")
			return FALSE

	silent_feed = TRUE

/datum/action/cooldown/vampire/targeted/feed/fire_targeted_power(atom/target_atom, list/modifiers)
	. = ..()
	var/mob/living/feed_target = target_atom
	var/mob/living/living_owner = owner
	target_ref = WEAKREF(feed_target)

	// Mice
	if(ismouse(feed_target))
		to_chat(owner, span_warning("You recoil at the taste of a lesser lifeform."))
		absorb_blood(feed_target, FEED_BLOOD_FROM_MICE, FEED_BLOOD_FROM_MICE)
		power_activated_sucessfully()
		feed_target.death()
		return

	//////////////////////////
	//We start here properly//
	//////////////////////////

	currently_feeding = FALSE
	target_was_dead = feed_target.stat == DEAD
	target_died = FALSE

	if(!living_owner.combat_mode)

		// Don't allow normal feed on vamps. It's too easy and feels unfair.
		if(IS_VAMPIRE(feed_target))
			owner.balloon_alert(owner, "too powerful, knock them out and combat feed on them!")
			deactivate_power()
			return

		var/feeding_on_vassal = !!IS_VASSAL(feed_target)
		if(!feeding_on_vassal) // Vassals don't need all this shit.
			owner.balloon_alert(owner, "mesmerizing [feed_target]...")

			// Initial ""mesmerize""
			if(!do_after(owner, FEED_MESMERIZE_TIME, feed_target, cog_icon = null))
				owner.balloon_alert(owner, "interrupted!")
				deactivate_power()
				return

		// Succesful. Start feeding process by getting feed time.
		var/feed_time = get_feed_time(feeding_on_vassal)

		feed_target.playsound_local(null, 'modular_zubbers/sound/effects/vampires/mesmerize.ogg', 100, FALSE, pressure_affected = FALSE)
		feed_target.Stun(feed_time, TRUE)
		feed_target.become_blind(REF(src))
		ADD_TRAIT(feed_target, TRAIT_DEAF, REF(src))

		to_chat(feed_target, span_hypnophrase("You suddenly fall into a deep trance..."), type = MESSAGE_TYPE_WARNING)
		owner.balloon_alert(owner, "subdued! starting feed...")

		// Do the pre-feed.
		if(!do_after(owner, feed_time, feed_target, cog_icon = null))
			owner.balloon_alert(owner, "interrupted!")
			deactivate_power()
			return

		// It begins...
		currently_feeding = TRUE
		living_owner.playsound_local(null, 'modular_zubbers/sound/effects/vampires/drinkblood1.ogg', 100, FALSE, pressure_affected = FALSE)

		// Just to make sure
		living_owner.stop_pulling()
		feed_target.stop_pulling()

		// omega switch
		switch(get_dir(owner.loc, feed_target.loc))
			if(NORTH)
				owner.dir = WEST
				feed_target.dir = EAST
				animate(owner, 0.2 SECONDS, pixel_x = 8, pixel_y = 16)
				animate(feed_target, 0.2 SECONDS, pixel_x = -8, pixel_y = -16)
			if(NORTHEAST)
				owner.dir = EAST
				feed_target.dir = WEST
				animate(owner, 0.2 SECONDS, pixel_x = 8, pixel_y = 16)
				animate(feed_target, 0.2 SECONDS, pixel_x = -8, pixel_y = -16)
			if(EAST)
				owner.dir = EAST
				feed_target.dir = WEST
				animate(owner, 0.2 SECONDS, pixel_x = 8)
				animate(feed_target, 0.2 SECONDS, pixel_x = -8)
			if(SOUTH)
				owner.dir = EAST
				feed_target.dir = WEST
				animate(owner, 0.2 SECONDS, pixel_x = -8, pixel_y = -16)
				animate(feed_target, 0.2 SECONDS, pixel_x = 8, pixel_y = 16)
			if(SOUTHEAST)
				owner.dir = EAST
				feed_target.dir = WEST
				animate(owner, 0.2 SECONDS, pixel_x = 8, pixel_y = -16)
				animate(feed_target, 0.2 SECONDS, pixel_x = -8, pixel_y = 16)
			if(SOUTHWEST)
				owner.dir = WEST
				feed_target.dir = EAST
				animate(owner, 0.2 SECONDS, pixel_x = -8, pixel_y = -16)
				animate(feed_target, 0.2 SECONDS, pixel_x = 8, pixel_y = 16)
			if(WEST)
				owner.dir = WEST
				feed_target.dir = EAST
				animate(owner, 0.2 SECONDS, pixel_x = -8)
				animate(feed_target, 0.2 SECONDS, pixel_x = 8)
			if(NORTHWEST)
				owner.dir = WEST
				feed_target.dir = EAST
				animate(owner, 0.2 SECONDS, pixel_x = -8, pixel_y = 16)
				animate(feed_target, 0.2 SECONDS, pixel_x = 8, pixel_y = -16)
			if(0)	// We are on the same tile. Just move them a bit so they don't overlap
				owner.dir = WEST
				feed_target.dir = EAST
				animate(owner, 0.2 SECONDS, pixel_x = 8,)
				animate(feed_target, 0.2 SECONDS, pixel_x = -8)

		owner.visible_message(
			span_notice("[owner] grabs [feed_target] tightly, biting into [feed_target.p_their()] neck!"),
			span_notice("You slip your fangs into [feed_target]'s neck."),
			vision_distance = FEED_SILENT_NOTICE_RANGE, ignored_mobs = feed_target
		)

	else if(owner.pulling == feed_target && owner.grab_state == GRAB_AGGRESSIVE) // COMBAT FEED BELOW HERE!!!!!!!!!!

		playsound(living_owner, 'modular_zubbers/sound/effects/vampires/drinkblood1.ogg', 50)

		feed_target.Stun(get_combat_stun_time())
		feed_target.set_jitter_if_lower(get_combat_stun_time())

		owner.visible_message(
			span_warning("[owner] closes [owner.p_their()] mouth around [feed_target]'s neck!"),
			span_warning("You sink your fangs into [feed_target]'s neck."), ignored_mobs = feed_target
		)

		to_chat(feed_target, span_bolddanger("[owner] seizes you with incredible strength, sinking [owner.p_their()] fangs into your neck!"), type = MESSAGE_TYPE_WARNING)

		to_chat(owner, span_announce("* Vampire Tip: Combat feeding does not erase their memories!"))

		currently_feeding = TRUE
		silent_feed = FALSE

	// Garlic in 'em
	var/mob/living/smacked = feed_target
	if(smacked.reagents?.has_reagent(/datum/reagent/consumable/garlic, 2))

		// We check which turf is one step away from our target, in the direction of the angle of the bullet. Christ. We do this twice, for range.
		var/target_turf = get_step_away(smacked.loc, owner, 2)

		to_chat(owner, span_hypnophrase(span_big("eugh.. garlic...")))

		living_owner.Stun(5 SECONDS)
		living_owner.set_dizzy_if_lower(1 SECONDS)
		living_owner.set_jitter_if_lower(1.5 SECONDS)
		living_owner.set_eye_blur_if_lower(0.5 SECONDS)

		smacked.Unconscious(1 SECONDS)
		smacked.throw_at(target_turf, 2, 1, spin = TRUE)
		playsound(smacked, 'sound/items/weapons/cqchit2.ogg', 80)
		deactivate_power()
		return
	else if(istype(smacked.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/clothing/neck/crucifix))
		owner.visible_message(
			span_warning("[owner] recoils, quickly releasing [smacked] from [owner.p_their()] grip!"),
			span_userdanger("The Faith burns you, preventing you from feeding!"),
		)
		living_owner.take_overall_damage(burn = rand(5, 15))
		living_owner.set_jitter_if_lower(5 SECONDS)
		living_owner.set_eye_blur_if_lower(2 SECONDS)
		playsound(
			owner,
			pick('sound/effects/wounds/sizzle1.ogg', 'sound/effects/wounds/sizzle2.ogg'),
			vol = 50,
			vary = TRUE,
			extrarange = SHORT_RANGE_SOUND_EXTRARANGE,
		)
		deactivate_power()
		if(owner.pulling == smacked)
			owner.stop_pulling()
		return

	if(currently_feeding) // Check if we actually started successfully.
		owner.add_traits(list(TRAIT_IMMOBILIZED, TRAIT_MUTE, TRAIT_HANDS_BLOCKED), REF(src))
		feed_target.add_traits(list(TRAIT_IMMOBILIZED, TRAIT_MUTE, TRAIT_HANDS_BLOCKED), REF(src))

		// Normally removed traits are done. Now we give the victim a lil something to remember us by.
		feed_target.apply_status_effect(/datum/status_effect/feed_marked)
	else
		owner.balloon_alert(owner, "combat feed requires aggressive grab!")
		deactivate_power()
		return FALSE

/datum/action/cooldown/vampire/targeted/feed/use_power(mob/living/source, seconds_per_tick)
	var/mob/living/user = owner

	// A bite that never landed leaves us listening, that must not end or drain whatever was started since
	if(!target_ref)
		stop_upkeep()
		return
	var/mob/living/feed_target = target_ref.resolve()
	if(!feed_target)
		power_activated_sucessfully()
		return
	if(!currently_feeding)
		return

	if(!continue_active())
		if(!silent_feed)
			user.visible_message(
				span_warning("[user] is ripped from [feed_target]'s throat. [feed_target.p_Their()] blood sprays everywhere!"),
				span_warning("Your teeth are ripped from [feed_target]'s throat. [feed_target.p_Their()] blood sprays everywhere!"))

			// Time to start bleeding
			if(iscarbon(feed_target))
				var/mob/living/carbon/carbon_target = feed_target
				carbon_target.bleed(15)
			playsound(get_turf(feed_target), 'sound/effects/splat.ogg', 40, TRUE)

			feed_target.add_splatter_floor(get_turf(feed_target))

			// Cover both parties in blood
			if(ishuman(user))
				var/mob/living/carbon/human/human_user = user
				human_user.add_blood_DNA_to_items(feed_target.get_blood_dna_list(), ITEM_SLOT_ICLOTHING|ITEM_SLOT_OCLOTHING)

			if(ishuman(feed_target))
				var/mob/living/carbon/human/target_user = feed_target
				target_user.add_blood_DNA_to_items(target_user.get_blood_dna_list(), ITEM_SLOT_ICLOTHING|ITEM_SLOT_OCLOTHING)
				var/obj/item/bodypart/head_part = target_user.get_bodypart(BODY_ZONE_HEAD)
				if(head_part)
					head_part.adjustBleedStacks(10)

			// Ow
			feed_target.apply_damage(10, BRUTE, BODY_ZONE_HEAD)
			INVOKE_ASYNC(feed_target, TYPE_PROC_REF(/mob, emote), "scream")

		power_activated_sucessfully()
		return

	if(!target_was_dead && !target_died && feed_target.stat == DEAD)
		target_died = TRUE
		COOLDOWN_START(src, release_grace, 3 SECONDS)
		owner.balloon_alert(owner, "they're dead, let go!")

	// Adjust blood
	var/feed_strength_mult = 0.3
	if(HAS_TRAIT(user, TRAIT_FRENZY))
		feed_strength_mult = 2
	else if(!silent_feed)
		feed_strength_mult = 1

	handle_feeding(feed_target, feed_strength_mult * seconds_per_tick / VAMPIRE_LIFE_TICK_SECONDS)
	// They struggled free
	if(!currently_active)
		return

	// Mood events
	if(vampiredatum_power?.my_clan?.blood_drink_type == VAMPIRE_DRINK_SNOBBY && !feed_target.mind) // Snobby
		user.add_mood_event("drankblood", /datum/mood_event/drankblood_bad)
	else if(feed_target.stat == DEAD) // Dead
		user.add_mood_event("drankblood", /datum/mood_event/drankblood_dead)
	else // Normal
		user.add_mood_event("drankblood", /datum/mood_event/drankblood)

	// Alert the vampire to the target's blood level
	if(feed_target.get_blood_volume() <= BLOOD_VOLUME_BAD && warning_target_bloodvol > BLOOD_VOLUME_BAD)
		owner.balloon_alert(owner, "your victim's blood is fatally low!")
		feed_fatal = TRUE
	else if(feed_target.get_blood_volume() <= BLOOD_VOLUME_OKAY && warning_target_bloodvol > BLOOD_VOLUME_OKAY)
		owner.balloon_alert(owner, "your victim's blood is dangerously low.")
	else if(feed_target.get_blood_volume() <= BLOOD_VOLUME_SAFE && warning_target_bloodvol > BLOOD_VOLUME_SAFE)
		owner.balloon_alert(owner, "your victim's blood is at an unsafe level.")
	warning_target_bloodvol = feed_target.get_blood_volume()

	// Check if full on blood
	if(vampiredatum_power)
		if(vampiredatum_power.current_vitae >= vampiredatum_power.max_vitae)
			if(IS_VAMPIRE(feed_target))
				owner.balloon_alert(owner, "we are full on blood, but we can continue feeding to absorb [feed_target.p_their()] power!")
			else
				owner.balloon_alert(owner, "we are full on blood!")
	else if(max_blood_reached(feed_target))
		owner.balloon_alert(owner, "full on blood!")
		power_activated_sucessfully()
		return

	// Check if target has an acceptable amount of blood left
	if(feed_target.get_blood_volume() <= 10)
		owner.balloon_alert(owner, "no blood left!")
		if(feed_target.client && vampiredatum_power)
			var/datum/objective/vampire/hedonism/thirster/yumy = locate() in vampiredatum_power.objectives
			if(yumy && !yumy.completed)
				yumy.completed = TRUE
				completing_thirster = TRUE
		power_activated_sucessfully()
		return

	var/datum/antagonist/vampire/target_vampire = IS_VAMPIRE(feed_target)
	if(target_vampire && target_vampire.current_vitae <= 50)
		if(vampiredatum_power)
			diablerie(feed_target)
		power_activated_sucessfully()
		return

	// Play heartbeat sound effect to vampire and target
	owner.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
	feed_target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)

/// We assume the target is a vampire.
/datum/action/cooldown/vampire/targeted/feed/proc/diablerie(mob/living/poor_sap)
	var/datum/antagonist/vampire/victim = IS_VAMPIRE(poor_sap)

	var/levels_absorbed = ceil((victim.vampire_level + victim.vampire_level_unspent) / DIABLERIE_DIVISOR)

	vampiredatum_power.rank_up(levels_absorbed, TRUE)
	vampiredatum_power.adjust_humanity(-round(victim.humanity / 3))
	vampiredatum_power.diablerie_count++

	victim.final_death()

/datum/action/cooldown/vampire/targeted/feed/deactivate_power(successful = FALSE)
	. = ..()
	REMOVE_TRAITS_IN(owner, REF(src))

	var/mob/living/feed_target = target_ref?.resolve()
	var/mob/living/living_owner = owner

	if(feed_target)
		// Call cure_blind after a (truly tiny) delay to make sure they don't see NOTHING
		addtimer(CALLBACK(feed_target, TYPE_PROC_REF(/mob/living, remove_status_effect), /datum/status_effect/grouped/blindness, REF(src)), 1 SECONDS)
		REMOVE_TRAITS_IN(feed_target, REF(src))
		if(currently_feeding)

			animate(owner, 0.2 SECONDS, pixel_x = owner.base_pixel_x, pixel_y = owner.base_pixel_y)
			animate(feed_target, 0.2 SECONDS, pixel_x = feed_target.base_pixel_x, pixel_y = feed_target.base_pixel_y)

			log_combat(owner, feed_target, "fed on blood [silent_feed ? "silently" : "aggressively"]", addition = "(and took [blood_taken] blood)")

			to_chat(owner, span_notice("You slowly release [feed_target]."))

			if(feed_target.stat != DEAD && silent_feed)
				to_chat(owner, span_notice("<i>[feed_target.p_They()] look[feed_target.p_s()] dazed, and will not remember this.</i>"), type = MESSAGE_TYPE_INFO)
				if(!IS_VASSAL(feed_target))
					to_chat(feed_target, span_awe(span_reallybig("You wake from your trance. Everything is so... hazy... You don't remember the last few moments...")), type = MESSAGE_TYPE_INFO)
					to_chat(feed_target, span_warning(" * You do not remember that you have been fed on, the identity of the person who just fed on you, or the fact that they are a vampire."), type = MESSAGE_TYPE_INFO)
					to_chat(feed_target, span_notice(" * If you already knew this person was a vampire from before your current encounter with them, however, you retain memory of that."), type = MESSAGE_TYPE_INFO)
				else
					to_chat(feed_target, span_awe(span_reallybig("You wake from your trance. Everything is so... hazy...")), type = MESSAGE_TYPE_INFO)
				if(feed_target.get_blood_volume() >= BLOOD_VOLUME_OKAY)
					to_chat(feed_target, span_announce("You feel dizzy, but it will probably pass by itself!"), type = MESSAGE_TYPE_INFO)

			if(!completing_thirster)
				if(feed_target.stat == DEAD)
					living_owner.add_mood_event("drankblood", /datum/mood_event/drankkilled)
					if(target_died && COOLDOWN_FINISHED(src, release_grace))
						vampiredatum_power?.adjust_humanity(-1)
				else if(feed_fatal)
					living_owner.add_mood_event("drankblood", /datum/mood_event/drankkilled)
					to_chat(owner, span_userdanger("No way will [feed_target.p_they()] survive that..."))
					vampiredatum_power?.adjust_humanity(-1)

/*
		if(iscarbon(feed_target))
			var/mob/living/carbon/carbon_target = feed_target
			// More/less humanity adds/deducts bleedy.
			switch(vampiredatum_power.humanity)
				if(0 to 2)
					carbon_target.bleed(BLEED_CRITICAL)
				if(3 to 4)
					carbon_target.bleed(BLEED_DEEP_WOUND)
				if(5 to 6)
					carbon_target.bleed(BLEED_CUT)
				if(7 to 8)
					carbon_target.bleed(BLEED_SURFACE)
				if(9 to 10)
					carbon_target.bleed(BLEED_SCRATCH)
*/

	currently_feeding = FALSE
	feed_fatal = FALSE
	target_was_dead = FALSE
	target_died = FALSE
	completing_thirster = FALSE

	target_ref = null

	warning_target_bloodvol = BLOOD_VOLUME_MAXIMUM
	blood_taken = 0

/datum/action/cooldown/vampire/targeted/feed/proc/handle_feeding(mob/living/carbon/target, mult = 1)
	var/mob/living/living_owner = owner
	var/feed_amount = 50 + (level_current * 2)

	// If we are already at fatal, we speed up more.
	if(feed_fatal)
		feed_amount *= 1.5

	// But, if we are in combat we want to get them some time to react.
	if(!silent_feed)
		feed_amount *= 0.3

	var/blood_to_take = min(feed_amount * mult, target.get_blood_volume())

	// Remove target's blood
	target.adjust_blood_volume(-blood_to_take)

	// Shift body temperature (toward target's temp, by volume taken)
	// ((vamp_blood_volume * vamp_temp) + (target_blood_volume * target_temp)) / (vamp_blood_volume + blood_to_take)
	// owner.bodytemperature = ((vampiredatum_power.current_vitae * owner.bodytemperature) + (blood_to_take * target.bodytemperature)) / (vampiredatum_power.current_vitae + blood_to_take)

	// Penalty for dead blood(at least it's still human, right?)
	if(target.stat == DEAD)
		blood_to_take /= 3
	// Penalty for non-human blood
	if(!ishuman(target) || ismonkey(target))
		blood_to_take /= 10
	// Penalty for frenzy(messy eater)
	if(HAS_TRAIT(living_owner, TRAIT_FRENZY))
		blood_to_take /= 2

	// Give vampire the blood^
	var/vitae_absorbed = blood_to_take * FEED_VITAE_PER_BLOOD

	/// Tracking of the vitae goal
	if(vampiredatum_power && target.client && !HAS_MIND_TRAIT(target, TRAIT_VAMPIRE_ALIGNED) && !target.mind?.has_antag_datum(/datum/antagonist/changeling))
		vampiredatum_power.vitae_goal_progress += vitae_absorbed

	absorb_blood(target, blood_to_take, vitae_absorbed)

	// Diablerie takes vitae directly
	var/datum/antagonist/vampire/vampire_target = IS_VAMPIRE(target)
	if(vampire_target)
		vampire_target.adjust_blood_volume(- (blood_to_take * FEED_VITAE_PER_BLOOD))

	// Transfer the target's reagents into the vampire's blood
	if(target.reagents?.total_volume)
		target.reagents.trans_to(owner, 1, methods = INGEST) // Run transfer of 1 unit of reagent from them to me.

	// Play heartbeat sound for flavor
	owner.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)

	if(vampiredatum_power)
		vampiredatum_power.total_blood_drank += blood_to_take
	blood_taken += blood_to_take

	// If we are on combat feed, we only want it to take a bit and then stop. Except if they are not conscious or if they're restrained.
	if(!silent_feed && blood_taken >= 60 && target.stat <= SOFT_CRIT && !HAS_TRAIT(target, TRAIT_RESTRAINED))

		playsound(target, 'sound/items/weapons/cqchit2.ogg', 80)

		owner.visible_message(
			span_warning("[target] struggles, pushing [owner] away!"),
			span_warning("[target] manages to struggle free from your grip!"), ignored_mobs = target
		)

		var/shove_dir = get_dir(target.loc, owner.loc)
		var/turf/target_shove_turf = get_step(owner.loc, shove_dir)
		owner.Move(target_shove_turf, shove_dir)

		target.SetStun(0 SECONDS)
		living_owner.Stun(1 SECONDS)

		owner.balloon_alert(owner, "struggles free!")
		deactivate_power()

/// A vampire turns what they drink into vitae. Anyone else (hemophages) keeps it as plain blood.
/datum/action/cooldown/vampire/targeted/feed/proc/absorb_blood(mob/living/target, blood_amount, vitae_amount)
	if(vampiredatum_power)
		vampiredatum_power.adjust_blood_volume(vitae_amount)
		return
	var/mob/living/living_owner = owner
	if(SEND_SIGNAL(living_owner, COMSIG_MOB_FEED_DRINK, target, blood_amount, blood_taken) & FEED_CANCEL_BLOOD_TRANSFER)
		return
	if(!HAS_TRAIT(living_owner, TRAIT_NOBLOOD))
		living_owner.adjust_blood_volume(blood_amount)

/// Vampires can always drink more. Anyone else stops once their own veins are full.
/datum/action/cooldown/vampire/targeted/feed/proc/max_blood_reached(mob/living/target)
	if(vampiredatum_power)
		return FALSE
	var/mob/living/living_owner = owner
	if(!isliving(living_owner) || HAS_TRAIT(living_owner, TRAIT_NOBLOOD))
		return FALSE
	if(SEND_SIGNAL(living_owner, COMSIG_MOB_REACHED_MAX_BLOOD, target) & REACHED_MAX_BLOOD)
		return TRUE
	return living_owner.get_blood_volume() >= BLOOD_VOLUME_MAXIMUM

#undef FEED_SILENT_NOTICE_RANGE
#undef FEED_DEFAULT_TIME
#undef FEED_FRENZY_TIME
#undef FEED_MESMERIZE_TIME
#undef FEED_BLOOD_FROM_MICE
#undef FEED_VITAE_PER_BLOOD

/datum/status_effect/feed_marked
	id = "feed marked"
	tick_interval = STATUS_EFFECT_NO_TICK
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null
	remove_on_fullheal = TRUE
	heal_flag_necessary = HEAL_WOUNDS

/datum/status_effect/feed_marked/on_apply()
	if(!iscarbon(owner))
		return FALSE
	RegisterSignal(owner, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	return TRUE

/datum/status_effect/feed_marked/on_remove()
	UnregisterSignal(owner, COMSIG_ATOM_EXAMINE)

/datum/status_effect/feed_marked/on_creation(mob/living/new_owner, ...)
	duration = rand(5 MINUTES, 10 MINUTES)
	return ..()

/datum/status_effect/feed_marked/refresh(effect, ...)
	duration = max(duration, rand(5 MINUTES, 10 MINUTES))

/datum/status_effect/feed_marked/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(isobserver(user) || (get_dist(user, owner) <= 3 && !user.is_nearsighted_currently()))
		examine_list += span_warning("There are two strange punctures on [owner.p_their()] neck.")
