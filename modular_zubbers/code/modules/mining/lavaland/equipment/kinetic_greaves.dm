#define NO_DEBUG_GUH(var) message_admins("[var] [__FILE__]-[__LINE__]")
#warn REMOVE BITCHASS
/obj/item/clothing/gloves/kinetic_greaves
	name = "kinetic greaves"
	desc = "Nanotrasen's take on the power-fist, originally designed to help the security department but ultimately scrapped due to causing too much collateral damage. \
	Later on, repurposed into a pair of mining tools after a disgruntled shaft miner complained to R&D about mining \"not being metal enough\"."
	icon = 'icons/obj/mining.dmi'
	inhand_icon_state = "kinetic_greaves_off"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'

	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 2.075) //copied from kc, idk

	throwforce = 3 //why doesnt this have an underscore i hate this
	throw_speed = 2

	actions_types = list(/datum/action/item_action/extend_greaves)
	attack_verb_continuous = list("slaps", "challenges")
	attack_verb_simple = list("slap", "challenge")
	equip_delay_self = 2 SECONDS //that's a lot of bulky
	force = 3 //i guess?
	hitsound = 'sound/weapons/cqchit1.ogg'
	obj_flags = UNIQUE_RENAME
	slot_flags = ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_BULKY

	var/obj/item/kinetic_greave/left_greave = null
	var/obj/item/kinetic_greave/right/right_greave = null

/obj/item/clothing/gloves/kinetic_greaves/Initialize(mapload)
	. = ..()
	left_greave = new(src)
	right_greave = new(src)

	var/datum/component/crusher_comp = AddComponent(/datum/component/kinetic_crusher, 50, 30, 1.5 SECONDS, CALLBACK(src, PROC_REF(attack_check)), CALLBACK(src, PROC_REF(detonate_check)), CALLBACK(src, PROC_REF(after_detonate)))
	crusher_comp.RegisterWithParent(left_greave)
	crusher_comp.RegisterWithParent(right_greave)


/obj/item/clothing/gloves/kinetic_greaves/ui_action_click(mob/user, datum/action/actiontype)
	switch(actiontype.type)
		if(/datum/action/item_action/toggle_light)
			right_greave?.attack_self(user) //the light is stored in the right_greave
		if(/datum/action/item_action/extend_greaves)
			toggle_greaves()

/obj/item/clothing/gloves/kinetic_greaves/proc/attack_check(mob/living/user)
	return left_greave?.loc == user || right_greave?.loc == user

/obj/item/clothing/gloves/kinetic_greaves/proc/detonate_check(mob/living/user)
	var/both_greaves_deployed = left_greave?.loc == user && right_greave?.loc == user
	if(both_greaves_deployed)
		var/checked_time = world.time - 0.5 SECONDS //give them a lil leeway
		NO_DEBUG_GUH("WE DOING TIME. WORD:[world.time], MEASURED:[checked_time], BALLS:[left_greave.next_attack], [right_greave.next_attack]")
		return left_greave.next_attack <= checked_time && right_greave.next_attack <= checked_time

	NO_DEBUG_GUH("HOW ARE WE HERE.")
	return FALSE //you WILL glass cannon and you WILL like it.

/obj/item/clothing/gloves/kinetic_greaves/proc/after_detonate(mob/living/user, mob/living/target)
	var/old_dir_user = user.dir
	var/old_dir_target = user.dir
	step(user, get_dir(target, user))
	step(target, get_dir(user, target))
	user.dir = old_dir_user
	target.dir = old_dir_target


/obj/item/clothing/gloves/kinetic_greaves/proc/toggle_greaves()
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer))
		return

	if(left_greave.loc == src || right_greave.loc == src)
		deploy_greaves()
	else
		retract_greaves()

/obj/item/clothing/gloves/kinetic_greaves/proc/deploy_greaves()
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer))
		return

	if(wearer.gloves != src)
		to_chat(wearer, span_warning("You must be wearing these to do this!"))
		return

	var/left_deployed = isnull(left_greave) || left_greave.loc == wearer
	var/right_deployed = isnull(right_greave) || right_greave.loc == wearer
	if(left_deployed && right_deployed)
		return //nothing to do

	var/can_deploy = TRUE
	if(!left_deployed && !wearer.can_put_in_hand(left_greave, 1))
		can_deploy = FALSE
	if(!right_deployed && !wearer.can_put_in_hand(right_greave, 2))
		can_deploy = FALSE

	if(!can_deploy)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You need both free hands to deploy [src]!"))
		return

	// equipping/unequipping shall take time
	wearer.add_movespeed_modifier(/datum/movespeed_modifier/equipping_greaves)
	if(!do_after(wearer, 1.5 SECONDS, src, IGNORE_USER_LOC_CHANGE))
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You fail to deploy [src]!"))
		wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_greaves)
		return

	wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_greaves)

	if(!left_deployed && !wearer.can_put_in_hand(left_greave, 1))
		can_deploy = FALSE
	if(!right_deployed && !wearer.can_put_in_hand(right_greave, 2))
		can_deploy = FALSE

	if(!can_deploy)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You need both free hands to deploy [src]!"))
		return

	if(!left_deployed)
		wearer.put_in_l_hand(left_greave)

	if(!right_deployed)
		wearer.put_in_r_hand(right_greave)

	ADD_TRAIT(src, TRAIT_NODROP, type)

	playsound(src, 'sound/mecha/mechmove03.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(src, 'sound/mecha/mechmove01.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	to_chat(wearer, span_notice("You deploy [src]."))

/obj/item/clothing/gloves/kinetic_greaves/proc/retract_greaves()
	var/mob/living/carbon/human/wearer = loc
	if(!istype(wearer))
		return

	if(wearer.gloves != src)
		to_chat(wearer, span_warning("You must be wearing these to do this!"))
		return

	if(left_greave?.loc == src && right_greave?.loc == src)
		return

	wearer.add_movespeed_modifier(/datum/movespeed_modifier/equipping_greaves)
	if(!do_after(wearer, 1.5 SECONDS, src, IGNORE_USER_LOC_CHANGE))
		wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_greaves)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		to_chat(wearer, span_warning("You fail to retract [src]!"))
		return

	wearer.remove_movespeed_modifier(/datum/movespeed_modifier/equipping_greaves)

	left_greave?.forceMove(src)
	right_greave?.forceMove(src)

	REMOVE_TRAIT(src, TRAIT_NODROP, type)
	playsound(src, 'sound/mecha/powerloader_turn2.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	playsound(src, 'sound/mecha/mechmove01.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	to_chat(wearer, span_notice("You retract [src]."))


/obj/item/kinetic_greave
	name = "kinetic greaves"
	desc = "Okay, these <i>are</i> pretty metal."
	icon = 'icons/obj/antags/syndicate_tools.dmi'
	icon_state = "powerfist"
	force = 15 // double hit -> 30 dmg per volley, same as crusher
	var/obj/item/clothing/gloves/kinetic_greaves/linked_greaves = null
	var/next_attack = 0

/obj/item/kinetic_greave/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, type)
	linked_greaves = loc

/obj/item/kinetic_greave/Destroy(force)
	linked_greaves = null
	return ..()

/obj/item/kinetic_greave/melee_attack_chain(mob/user, atom/target, params)
	if(next_attack > world.time)
		return

	next_attack = world.time + 0.8 SECONDS // same as a crusher
	return ..()

/obj/item/kinetic_greave/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	playsound(src, 'sound/weapons/resonator_blast.ogg', 40, TRUE)
	playsound(src, 'sound/weapons/genhit2.ogg', 40, TRUE)
	user.changeNext_move(CLICK_CD_HYPER_RAPID) //forgive me
	user.swap_hand()

/obj/item/kinetic_greave/right
	light_on = FALSE
	light_power = 5
	light_range = 4
	light_system = MOVABLE_LIGHT_DIRECTIONAL

	actions_types = list(/datum/action/item_action/toggle_light)

/obj/item/kinetic_greave/right/Initialize(mapload)
	. = ..()
	RegisterSignal(linked_greaves, COMSIG_HIT_BY_SABOTEUR, PROC_REF(on_saboteur))

/obj/item/kinetic_greave/right/attack_self(mob/user, modifiers)
	set_light_on(!light_on)
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()

/obj/item/kinetic_greave/right/proc/on_saboteur(datum/source, disrupt_duration)
	set_light_on(FALSE)
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	return COMSIG_SABOTEUR_SUCCESS
