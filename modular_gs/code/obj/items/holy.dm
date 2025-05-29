/obj/item/nullrod/attack(mob/target, mob/living/user)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/T = target
		for(var/hider in T.fat_hiders)
			if(isitem(hider))
				var/obj/item/O = hider
				T.dropItemToGround(O)
		if(T.cursed_fat == 1)
			T.cursed_fat = 0
			T.fattening_steps_left = 0

/obj/item/storage/book/bible/attack(mob/living/M, mob/living/carbon/human/user, heal_mode = TRUE)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/T = M
		for(var/hider in T.fat_hiders)
			if(isitem(hider))
				var/obj/item/O = hider
				T.dropItemToGround(O)
		if(T.cursed_fat == 1)
			T.cursed_fat = 0
			T.fattening_steps_left = 0

/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/M)
	. = ..()
	for(var/hider in M.fat_hiders)
		if(isitem(hider))
			var/obj/item/O = hider
			M.dropItemToGround(O)
	if(M.cursed_fat == 1)
		M.cursed_fat = 0
		M.fattening_steps_left = 0

/obj/item/nullrod/dream_breaker
	name = "dream breaker"
	desc = "A cross-shaped weapon emitting a faint, dream-like light. Its blows will wake any dreamer."
	icon = 'GainStation13/icons/obj/dreambreaker.dmi'
	icon_state = "dreambreaker"
	item_state = "dreambreaker"
	lefthand_file = 'GainStation13/icons/obj/dreambreaker_left.dmi'
	righthand_file = 'GainStation13/icons/obj/dreambreaker_right.dmi'

	actions_types = list(/datum/action/item_action/db_slide)
	var/slidedistance = 2
	var/slidespeed = 3
	var/stamina_cost = 34

	force = 20
	throwforce = 25
	throw_range = 10
	throw_speed = 2
	var/click_delay = 2

	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("smashed", "whacked", "smacked", "bonked")
	hitsound = "swing_hit"

	var/l_range = 3
	var/l_power = 0.8
	light_color = "#FFCC66"

/obj/item/nullrod/dream_breaker/Initialize(mapload)
	. = ..()
	set_light(l_range, l_power, light_color)

/*
/obj/item/nullrod/dream_breaker/attack(mob/living/target, mob/living/user)
	. = ..()
	user.changeNext_move(CLICK_CD_MELEE * click_delay)
*/

/obj/item/nullrod/dream_breaker/ui_action_click(mob/user, action)
	if(!isliving(user))
		return

	var/atom/target = get_edge_target_turf(user, user.dir) //gets the user's direction
	user.resting = TRUE
	if(user:getStaminaLoss() < 100)
		if (user.throw_at(target, slidedistance, slidespeed, spin = FALSE, diagonals_first = TRUE))
			user:adjustStaminaLoss(stamina_cost) //reduce stamina loss by 0.3 per tick, 6 per 2 seconds
			user.visible_message("<span class='warning'>[usr] slides forward!</span>")
			user.resting = FALSE
		else
			to_chat(user, "<span class='warning'>Something prevents you from sliding forward!</span>")
	else
		to_chat(user, "<span class='warning'>You fall down when attempting to slide!</span>")

/datum/action/item_action/db_slide
	name = "Dream Breaker Slide"
	desc = "Use dream-like atheletics to slide forward, but don't wear yourself out!."
	icon_icon = 'GainStation13/icons/obj/dreambreaker.dmi'
	button_icon_state = "dreambreaker"
