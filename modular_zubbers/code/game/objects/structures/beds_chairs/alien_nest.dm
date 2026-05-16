//Variant of the alien nest that's harder to buckle people to, easier to escape, and easier to destroy. Also gives a nutrition buff instead of outright healing.

#define BUCKLE_DURATION 10 SECONDS
#define UNBUCKLE_DURATION 20 SECONDS
/obj/structure/bed/nest/xenohybrid
	name = "xenohybrid nest"
	desc = "It's a gruesome pile of thick, sticky resin shaped like a nest. It seems weaker than what a true xenomorph would make."
	max_integrity = 30 // 0.25x the normal nest

/obj/structure/bed/nest/xenohybrid/user_unbuckle_mob(mob/living/captive, mob/living/hero)
	if(!length(buckled_mobs))
		return

	if(hero.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		unbuckle_mob(captive)
		add_fingerprint(hero)
		return

	if(captive != hero)
		captive.visible_message(span_notice("[hero.name] pulls [captive.name] free from the sticky nest!"),
			span_notice("[hero.name] pulls you free from the gelatinous resin."),
			span_hear("You hear squelching..."))
		unbuckle_mob(captive)
		add_fingerprint(hero)
		return

	captive.visible_message(span_warning("[captive.name] struggles to break free from the gelatinous resin!"),
		span_notice("You struggle to break free from the gelatinous resin... (Stay still for about [UNBUCKLE_DURATION/10] seconds.)"),
		span_hear("You hear squelching..."))

	if(!do_after(captive, UNBUCKLE_DURATION, target = src, hidden = TRUE)) //The change in question: Escape time down to 20 seconds from 100
		if(captive.buckled)
			to_chat(captive, span_warning("You fail to unbuckle yourself!"))
		return

	captive.visible_message(span_warning("[captive.name] breaks free from the gelatinous resin!"),
		span_notice("You break free from the gelatinous resin!"),
		span_hear("You hear squelching..."))

	unbuckle_mob(captive)
	add_fingerprint(hero)

/obj/structure/bed/nest/xenohybrid/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	if ( !ismob(M) || (get_dist(src, user) > 1) || (M.loc != src.loc) || user.incapacitated || M.buckled )
		return

	//Change from base bed: Removes immunity to being buckled by others if you have a plasmavessel.
	if(!user.get_organ_by_type(/obj/item/organ/alien/plasmavessel))
		return

	if(has_buckled_mobs())
		unbuckle_all_mobs()

	if(!do_after(user, BUCKLE_DURATION, M)) // Another change from the base bed: Added a doafter so that you can't insta-trap people in your nests
		to_chat(user, span_warning("You fail to capture [M] in [src]!"))
		return

	if(buckle_mob(M))
		M.visible_message(span_notice("[user.name] secretes a thick vile goo, securing [M.name] into [src]!"),\
			span_danger("[user.name] drenches you in a foul-smelling resin, trapping you in [src]!"),\
			span_hear("You hear squelching..."))

/obj/structure/bed/nest/xenohybrid/post_buckle_mob(mob/living/M)
	ADD_TRAIT(M, TRAIT_HANDS_BLOCKED, type)
	M.add_offsets(type, x_add = 2)
	M.layer = BELOW_MOB_LAYER
	add_overlay(nest_overlay)

	if(ishuman(M))
		var/mob/living/carbon/human/victim = M //Change from base bed: Removes check for xenopregnancy or facehugger.
		victim.apply_status_effect(/datum/status_effect/nest_sustenance_xenohybrid) //Change from base bed: special sustenance subtype.

/obj/structure/bed/nest/xenohybrid/post_unbuckle_mob(mob/living/M)
	REMOVE_TRAIT(M, TRAIT_HANDS_BLOCKED, type)
	M.remove_offsets(type)
	M.layer = initial(M.layer)
	cut_overlay(nest_overlay)
	M.remove_status_effect(/datum/status_effect/nest_sustenance_xenohybrid) //Change from base bed: special sustenance subtype.

/datum/status_effect/nest_sustenance_xenohybrid
	id = "nest_sustenance_xenohybrid"
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = 0.4 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/nest_sustenance_xenohybrid

/datum/status_effect/nest_sustenance_xenohybrid/tick(seconds_between_ticks)
	if(owner.stat == DEAD) //If the victim has died due to complications in the nest
		qdel(src)
		return

	owner.adjust_nutrition(1 * seconds_between_ticks)
	if(owner.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
		owner.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL) //Change from base bed: refills hunger instead of healing and normalizing body temperature.

/atom/movable/screen/alert/status_effect/nest_sustenance_xenohybrid
	name = "Xenohybrid Nest Vitalization"
	desc = "The resin pulsates around you, sending sustenance through your skin. It'd almost be comfortable, if you could just move enough to plug your nose..."
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "nest_life"
