#define CUM_VOLUME_MULTIPLIER 10

/datum/emote/living/lewd/fap
	key = "fap"
	key_third_person = "faps" // ?
	hands_use_check = TRUE
	cooldown = 3 SECONDS // probably for the best
	mob_type_allowed_typecache = list(/mob/living/carbon/human)

/datum/emote/living/lewd/fap/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/obj/item/hand_item/coom/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, span_notice("You ready your hand."))
	else
		qdel(N)
		to_chat(user, span_warning("You're incapable of masturbating in your current state."))

/obj/item/hand_item/coom
	name = "cum"
	desc = "C-can I watch...?" // 💀
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "eggplant" // 🍆
	inhand_icon_state = "nothing"

// Jerk off into bottles and onto people.
/obj/item/hand_item/coom/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	do_masturbate(interacting_with, user)

/// Handles masturbation onto a living mob, or an atom.
/// Attempts to fill the atom's reagent container, if it has one, and it isn't full.
/obj/item/hand_item/coom/proc/do_masturbate(atom/target, mob/living/carbon/human/user)
	if (CONFIG_GET(flag/disable_erp_preferences) || user.stat >= DEAD)
		return

	var/mob/living/carbon/human/affected_human = user
	var/obj/item/organ/genital/testicles/mob_testicles = affected_human.get_organ_slot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/penis/mob_penis = affected_human.get_organ_slot(ORGAN_SLOT_PENIS)
	var/self_their = p_their()

	// do you have a penis?
	if(!user.has_penis())
		to_chat(user, span_danger("You can't stroke your penis if you don't have one."))
		qdel(src)
		return

	// is the penis exposed?
	if(!user.has_penis(required_state = REQUIRE_GENITAL_EXPOSED))
		to_chat(user, span_danger("You need to expose your penis in order to masturbate."))
		qdel(src)
		return

	if(target == user)
		user.visible_message(span_warning("[user] starts masturbating onto [target.p_them()]self!"), span_danger("You start masturbating onto yourself!"))

	else if(target.is_refillable() && target.is_drainable())
		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target] is full."))
			return
		user.visible_message(span_warning("[user] starts masturbating into [target]!"), span_danger("You start masturbating into [target]!"))
	else
		user.visible_message(span_warning("[user] starts masturbating onto [target]!"), span_danger("You start masturbating onto [target]!"))

	if(do_after(user, 6 SECONDS, target))
		if(!user.has_balls())
			user.visible_message(span_warning("[user] tries to cum, but nothing comes out!"), span_danger("You try to cum, but nothing comes out!"))
		else if(user.is_wearing_condom()) // copied over from climax, but it doesnt fucking work?
			var/obj/item/clothing/sextoy/condom/condom = mob_penis // bruh 💀⚰️💀⚰️💀⚰️💀⚰️💀
			condom.condom_use()
			visible_message(span_userlove("[user] shoots [self_their] load into the [condom], filling it up!"), \
				span_userlove("You shoot your thick load into the [condom] and it catches it all!"))
		else if(target == user)
			user.visible_message(span_warning("[user] cums on [target.p_them()]self!"), span_danger("You cum on yourself!"))

		else if(target.is_refillable() && target.is_drainable())
			var/cum_volume = mob_testicles.genital_size * CUM_VOLUME_MULTIPLIER
			var/datum/reagents/applied_reagents = new/datum/reagents(50)
			applied_reagents.add_reagent(/datum/reagent/consumable/cum, cum_volume) // probably should check what the target is actually cumming but we dont have custom cum settings enabled anyways...
			user.visible_message(span_warning("[user] cums into [target]!"), span_danger("You cum into [target]!"))
			conditional_pref_sound(target, SFX_DESECRATION, 50, TRUE)
			applied_reagents.trans_to(target, cum_volume)
		else
			user.visible_message(span_warning("[user] cums on [target]!"), span_danger("You cum on [target]!"))
			conditional_pref_sound(target, SFX_DESECRATION, 50, TRUE)
			affected_human.add_cum_splatter_floor(get_turf(target))
		log_combat(user, target, "came on")
		if(prob(40))
			affected_human.try_lewd_autoemote("moan")
		qdel(src)

#undef CUM_VOLUME_MULTIPLIER
