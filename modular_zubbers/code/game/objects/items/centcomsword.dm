/obj/item/melee/sabre/centcom
	name = "Commander's sabre"
	desc = "An even more elegant weapon with a purer golden grip guard, with even rarer redwood wooden grip. The blade is made of plasteel infused gold, which makes it incredibly good at cutting."
	icon = 'modular_zubbers/icons/obj/weapons/melee/swords.dmi'
	icon_state = "cent_sabre"
	inhand_icon_state = "cent_sabre"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	force = 15
	throwforce = 10
	demolition_mod = 0.75 //but not metal
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 50
	armour_penetration = 75
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	block_sound = 'sound/weapons/parry.ogg'
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	wound_bonus = 10
	bare_wound_bonus = 25

/obj/item/melee/sabre/centcom/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/jousting)
	//fast and effective, but as a sword, it might damage the results.
	AddComponent(/datum/component/butchering, \
		speed = 3 SECONDS, \
		effectiveness = 95, \
		bonus_modifier = 5, \
	)
	// The weight of authority comes down on the tider's crimes.
	AddElement(/datum/element/bane, target_type = /mob/living/carbon/human, damage_multiplier = 0.35)
	RegisterSignal(src, COMSIG_OBJECT_PRE_BANING, PROC_REF(attempt_bane))
	RegisterSignal(src, COMSIG_OBJECT_ON_BANING, PROC_REF(bane_effects))

/**
 * If the target reeks of maintenance, the blade can tear through their body with a total of 20 damage.
 */
/obj/item/melee/sabre/centcom/proc/attempt_bane(element_owner, mob/living/carbon/criminal)
	SIGNAL_HANDLER
	var/obj/item/organ/internal/liver/liver = criminal.get_organ_slot(ORGAN_SLOT_LIVER)
	if(isnull(liver) || !HAS_TRAIT(liver, TRAIT_MAINTENANCE_METABOLISM))
		return COMPONENT_CANCEL_BANING

/**
 * Assistants should fear this weapon.
 */
/obj/item/melee/sabre/centcom/proc/bane_effects(element_owner, mob/living/carbon/human/baned_target)
	SIGNAL_HANDLER
	baned_target.visible_message(
		span_warning("[src] tears through [baned_target] with unnatural ease!"),
		span_userdanger("As [src] tears into your body, you feel the weight of authority collapse into your wounds!"),
	)
	INVOKE_ASYNC(baned_target, TYPE_PROC_REF(/mob/living/carbon/human, emote), "scream")

/obj/item/melee/sabre/centcom/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight
	return ..()

/obj/item/melee/sabre/centcom/on_exit_storage(datum/storage/container)
	var/obj/item/storage/belt/sabre/centcom/sabre = container.real_location?.resolve()
	if(istype(sabre))
		playsound(sabre, 'sound/items/unsheath.ogg', 25, TRUE)

/obj/item/melee/sabre/centcom/on_enter_storage(datum/storage/container)
	var/obj/item/storage/belt/sabre/centcom/sabre = container.real_location?.resolve()
	if(istype(sabre))
		playsound(sabre, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/melee/sabre/centcom/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is trying to cut off all [user.p_their()] limbs with [src]! it looks like [user.p_theyre()] trying to commit suicide!"))
	var/i = 0
	ADD_TRAIT(src, TRAIT_NODROP, SABRE_SUICIDE_TRAIT)
	if(iscarbon(user))
		var/mob/living/carbon/Cuser = user
		var/obj/item/bodypart/holding_bodypart = Cuser.get_holding_bodypart_of_item(src)
		var/list/limbs_to_dismember
		var/list/arms = list()
		var/list/legs = list()
		var/obj/item/bodypart/bodypart

		for(bodypart in Cuser.bodyparts)
			if(bodypart == holding_bodypart)
				continue
			if(bodypart.body_part & ARMS)
				arms += bodypart
			else if (bodypart.body_part & LEGS)
				legs += bodypart

		limbs_to_dismember = arms + legs
		if(holding_bodypart)
			limbs_to_dismember += holding_bodypart

		var/speedbase = abs((4 SECONDS) / limbs_to_dismember.len)
		for(bodypart in limbs_to_dismember)
			i++
			addtimer(CALLBACK(src, PROC_REF(suicide_dismember), user, bodypart), speedbase * i)
	addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), (5 SECONDS) * i)
	return MANUAL_SUICIDE

/obj/item/melee/sabre/centcom/proc/suicide_dismember(mob/living/user, obj/item/bodypart/affecting)
	if(!QDELETED(affecting) && !(affecting.bodypart_flags & BODYPART_UNREMOVABLE) && affecting.owner == user && !QDELETED(user))
		playsound(user, hitsound, 25, TRUE)
		affecting.dismember(BRUTE)
		user.adjustBruteLoss(20)

/obj/item/melee/sabre/centcom/proc/manual_suicide(mob/living/user, originally_nodropped)
	if(!QDELETED(user))
		user.adjustBruteLoss(200)
		user.death(FALSE)
	REMOVE_TRAIT(src, TRAIT_NODROP, SABRE_SUICIDE_TRAIT)
