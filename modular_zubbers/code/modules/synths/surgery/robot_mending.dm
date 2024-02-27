
/////ROBOT BLUNT WOUND FIXING SURGERIES//////

///// Repair Detached Fastenings (Severe)
/datum/surgery/robot/repair_detached_fastenings
	name = "Repair detached fastenings"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB
	targetable_wound = /datum/wound/blunt/robotic/secures_internals/severe
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG,
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/repair_detached_fastenings,
		/datum/surgery_step/mechanic_close,
	)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	//target_mobtypes = list(/mob/living/carbon/human) // shouldn't be needed?
	num_opening_steps = 1
	num_steps_until_closing = 3
	close_surgery = /datum/surgery/robot/close_repair_detached_fastenings

/datum/surgery/robot/close_repair_detached_fastenings
	name = "Close Surgery (Repair detached fastenings)"
	steps = list(
		/datum/surgery_step/mechanic_close,
	)
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB
	targetable_wound = /datum/wound/blunt/robotic/secures_internals/severe
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG,
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	is_closer = TRUE

/datum/surgery/robot/repair_detached_fastenings/can_start(mob/living/user, mob/living/carbon/target)
	. = ..()
	if(.)
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		return(targeted_bodypart.get_wound_type(targetable_wound))

///// Repair Collapsed Superstructure (Critical)
/datum/surgery/robot/repair_collapsed_superstructure
	name = "Repair collapsed superstructure"
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB
	targetable_wound = /datum/wound/blunt/robotic/secures_internals/critical
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG,
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/pry_off_plating,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/reset_collapsed_superstructure,
		/datum/surgery_step/repair_collapsed_superstructure,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	requires_bodypart_type = BODYTYPE_ROBOTIC
	//target_mobtypes = list(/mob/living/carbon/human) // shouldn't be needed?
	num_opening_steps = 3
	num_steps_until_closing = 6
	close_surgery = /datum/surgery/robot/close_repair_collapsed_superstructure

/datum/surgery/robot/close_repair_collapsed_superstructure
	name = "Close Surgery (Repair detached fastenings)"
	steps = list(
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/reattach_plating,
		/datum/surgery_step/mechanic_close,
	)
	is_closer = TRUE
	surgery_flags = SURGERY_REQUIRE_RESTING | SURGERY_REQUIRE_LIMB
	targetable_wound = /datum/wound/blunt/robotic/secures_internals/critical
	possible_locs = list(
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG,
		BODY_ZONE_CHEST,
		BODY_ZONE_HEAD,
	)
	requires_bodypart_type = BODYTYPE_ROBOTIC

/datum/surgery/robot/repair_collapsed_superstructure/can_start(mob/living/user, mob/living/carbon/target)
	. = ..()
	if(.)
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		return(targeted_bodypart.get_wound_type(targetable_wound))

//SURGERY STEPS

///// Reset Detached Fastenings (Severe)
/datum/surgery_step/reset_detached_fastenings
	name = "reset internal components (crowbar)"
	implements = list(
		TOOL_CROWBAR = 100,
		/obj/item/bonesetter = 50,
		/obj/item/stack/sticky_tape/surgical = 30,
		/obj/item/stack/sticky_tape/super = 20,
		/obj/item/stack/sticky_tape = 10)
	time = 20 // TODO add unit

/datum/surgery_step/reset_detached_fastenings/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(
			user,
			target,
			span_notice("You begin to reset the internal components in [target]'s [parse_zone(user.zone_selected)]..."),
			span_notice("[user] begins to reset the internal components in [target]'s [parse_zone(user.zone_selected)] with [tool]."),
			span_notice("[user] begins to reset the internal components in [target]'s [parse_zone(user.zone_selected)]."),
		)
		display_pain(target, "The aching pain in your [parse_zone(user.zone_selected)] is overwhelming!")
	else
		user.visible_message(span_notice("[user] looks for [target]'s [parse_zone(user.zone_selected)]."), span_notice("You look for [target]'s [parse_zone(user.zone_selected)]..."))

/datum/surgery_step/reset_detached_fastenings/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(isstack(tool))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(
			user,
			target,
			span_notice("You successfully reset the internal components in [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] successfully resets the internal components in [target]'s [parse_zone(target_zone)] with [tool]!"),
			span_notice("[user] successfully resets the internal components in [target]'s [parse_zone(target_zone)]!"),
		)
		log_combat(user, target, "reset detached fastenings in", addition="COMBAT MODE: [uppertext(user.combat_mode)]")
	else
		to_chat(user, span_warning("[target] has no detached fastenings there!"))
	return ..()

/datum/surgery_step/reset_detached_fastenings/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	..()
	if(isstack(tool))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)

///// Repair Detached fastenings (Severe)
/datum/surgery_step/repair_detached_fastenings
	name = "repair detached_fastenings (wrench/welder)"
	implements = list(
		TOOL_WRENCH = 100,
		TOOL_WELDER = 100,
		/obj/item/bonesetter = 50,
		/obj/item/stack/medical/bone_gel = 50,
		/obj/item/stack/sticky_tape/surgical = 50,
		/obj/item/stack/sticky_tape/super = 25,
		/obj/item/stack/sticky_tape = 15,)
	time = 20 // TODO add unit

/datum/surgery_step/repair_detached_fastenings/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(
			user,
			target,
			span_notice("You begin to repair the fastenings in [target]'s [parse_zone(user.zone_selected)]..."),
			span_notice("[user] begins to repair the fastenings in [target]'s [parse_zone(user.zone_selected)] with [tool]."),
			span_notice("[user] begins to repair the fastenings in [target]'s [parse_zone(user.zone_selected)]."),
		)
		display_pain(target, "Your [parse_zone(user.zone_selected)] aches with pain!")
	else
		user.visible_message(span_notice("[user] looks for [target]'s [parse_zone(user.zone_selected)]."), span_notice("You look for [target]'s [parse_zone(user.zone_selected)]..."))

/datum/surgery_step/repair_detached_fastenings/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(isstack(tool))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(
			user,
			target,
			span_notice("You successfully repair the fastenings in [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] successfully repairs the fastenings in [target]'s [parse_zone(target_zone)] with [tool]!"),
			span_notice("[user] successfully repairs the fastenings in [target]'s [parse_zone(target_zone)]!"),
		)
		log_combat(user, target, "repaired detached fastenings in", addition="COMBAT_MODE: [uppertext(user.combat_mode)]")
		qdel(surgery.operated_wound)
	else
		to_chat(user, span_warning("[target] has no detached fastenings there!"))
	return ..()

/datum/surgery_step/repair_detached_fastenings/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	..()
	if(isstack(tool))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)

///// Reset Collapsed Superstructure (Crticial)
/datum/surgery_step/reset_collapsed_superstructure
	name = "reset superstructure (crowbar)"
	implements = list(
		TOOL_CROWBAR = 100,
		/obj/item/bonesetter = 50,
		/obj/item/stack/sticky_tape/surgical = 30,
		/obj/item/stack/sticky_tape/super = 20,
		/obj/item/stack/sticky_tape = 10)
	time = 40 // TODO add unit

/datum/surgery_step/reset_collapsed_superstructure/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(
			user,
			target,
			span_notice("You begin to reset the superstructure in [target]'s [parse_zone(user.zone_selected)]..."),
			span_notice("[user] begins to reset the superstructure in [target]'s [parse_zone(user.zone_selected)] with [tool]."),
			span_notice("[user] begins to reset the superstructure in [target]'s [parse_zone(user.zone_selected)]."),
		)
		display_pain(target, "The aching pain in your [parse_zone(user.zone_selected)] is overwhelming!")
	else
		user.visible_message(span_notice("[user] looks for [target]'s [parse_zone(user.zone_selected)]."), span_notice("You look for [target]'s [parse_zone(user.zone_selected)]..."))

/datum/surgery_step/reset_collapsed_superstructure/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(isstack(tool))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(
			user,
			target,
			span_notice("You successfully reset the superstructure in [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] successfully resets the superstructure in [target]'s [parse_zone(target_zone)] with [tool]!"),
			span_notice("[user] successfully resets the superstructure in [target]'s [parse_zone(target_zone)]!"),
		)
		log_combat(user, target, "reset a collapsed superstructure in", addition="COMBAT MODE: [uppertext(user.combat_mode)]")
	else
		to_chat(user, span_warning("[target] has no collapsed superstructure there!"))
	return ..()

/datum/surgery_step/reset_collapsed_superstructure/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	..()
	if(isstack(tool))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)

///// Repair Collapsed Superstructure (Crticial)
/datum/surgery_step/repair_collapsed_superstructure
	name = "repair superstructure (welder)"
	implements = list(
		TOOL_WELDER = 100,
		/obj/item/bonesetter = 50,
		/obj/item/stack/medical/bone_gel = 50,
		/obj/item/stack/sticky_tape/surgical = 50,
		/obj/item/stack/sticky_tape/super = 25,
		/obj/item/stack/sticky_tape = 15,)
	time = 40 // TODO add unit

/datum/surgery_step/repair_collapsed_superstructure/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(surgery.operated_wound)
		display_results(
			user,
			target,
			span_notice("You begin to repair the superstructure in [target]'s [parse_zone(user.zone_selected)]..."),
			span_notice("[user] begins to repair the superstructure in [target]'s [parse_zone(user.zone_selected)] with [tool]."),
			span_notice("[user] begins to repair the superstructure in [target]'s [parse_zone(user.zone_selected)]."),
		)
		display_pain(target, "The aching pain in your [parse_zone(user.zone_selected)] is overwhelming!")
	else
		user.visible_message(span_notice("[user] looks for [target]'s [parse_zone(user.zone_selected)]."), span_notice("You look for [target]'s [parse_zone(user.zone_selected)]..."))

/datum/surgery_step/repair_collapsed_superstructure/success(mob/living/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	if(surgery.operated_wound)
		if(isstack(tool))
			var/obj/item/stack/used_stack = tool
			used_stack.use(1)
		display_results(
			user,
			target,
			span_notice("You successfully repair the superstructure in [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] successfully repairs the superstructure in [target]'s [parse_zone(target_zone)] with [tool]!"),
			span_notice("[user] successfully repairs the superstructure in [target]'s [parse_zone(target_zone)]!"),
		)
		log_combat(user, target, "repaired a collapsed superstructure in", addition="COMBAT MODE: [uppertext(user.combat_mode)]")
		qdel(surgery.operated_wound)
	else
		to_chat(user, span_warning("[target] has no collapsed superstructure there!"))
	return ..()

/datum/surgery_step/repair_collapsed_superstructure/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	..()
	if(isstack(tool))
		var/obj/item/stack/used_stack = tool
		used_stack.use(1)
