/obj/item/grenade/c4/
	var/datum/component/c4_body_tracker/body_tracker

/obj/item/grenade/c4/plant_c4(atom/bomb_target, mob/living/user)

	if(active)
		return FALSE

	if(isliving(bomb_target) && bomb_target.GetComponent(/datum/component/c4_body_tracker))
		to_chat(user,span_warning("There is already an explosive charge planted on [bomb_target]!"))
		return FALSE

	. = ..()

	if(. && isliving(bomb_target))
		body_tracker = bomb_target.AddComponent(/datum/component/c4_body_tracker,src)

/obj/item/grenade/c4/proc/unstick()

	if(!target)
		CRASH("Called c4 on_unstick() without a valid target!")

	target.cut_overlay(plastic_overlay, TRUE)

	var/turf/our_turf = get_turf(target)

	forceMove(our_turf)

	plastic_overlay.layer = HIGH_OBJ_LAYER

	target = null

	icon_state = "[inhand_icon_state]2"

	QDEL_NULL(body_tracker)


/obj/item/grenade/c4/Destroy()
	. = ..()
	QDEL_NULL(body_tracker)

/datum/component/c4_body_tracker
	var/obj/item/grenade/c4/stored_bomb

/datum/component/c4_body_tracker/Initialize(bomb_to_track)

	. = ..()

	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	stored_bomb = bomb_to_track


/datum/component/c4_body_tracker/Destroy()
	stored_bomb.body_tracker = null
	stored_bomb = null
	return ..()


/datum/reagent/toxin/acid/c4_b_gone
	name = "c4-b-gone"
	description = "A patented acidic compound by HugBox incorporated that is designed to (unsafely) remove c4 from most living beings."

	color = "#C6BED8" // rgb: 198, 190, 216

	taste_description = "a box of acidic hugs"

	reagent_weight = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

	penetrates_skin = VAPOR

/datum/reagent/toxin/acid/c4_b_gone/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)

	if(methods & (VAPOR|TOUCH))
		var/datum/component/c4_body_tracker/c4_tracker = exposed_mob.GetComponent(/datum/component/c4_body_tracker)
		if(c4_tracker && c4_tracker.stored_bomb)
			c4_tracker.stored_bomb.unstick()

	. = ..()

/datum/chemical_reaction/c4_b_gone
	results = list(/datum/reagent/toxin/acid/c4_b_gone = 3)
	required_reagents = list(/datum/reagent/space_cleaner = 1, /datum/reagent/drying_agent = 1, /datum/reagent/lube = 1)
	rate_up_lim = 40
	required_temp = 374
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_UNIQUE
