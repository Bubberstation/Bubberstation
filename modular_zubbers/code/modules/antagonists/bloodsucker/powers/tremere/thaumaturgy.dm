/**
 *	# Thaumaturgy
 *
 *	Level 1 - One shot bloodbeam spell
 *	Level 2 - Bloodbeam spell - Gives them a Blood shield until they use Bloodbeam
 *	Level 3 - Bloodbeam spell that breaks open lockers/doors - Gives them a Blood shield until they use Bloodbeam
 *	Level 4 - Bloodbeam spell that breaks open lockers/doors + double damage to victims - Gives them a Blood shield until they use Bloodbeam
 *	Level 5 - Bloodbeam spell that breaks open lockers/doors + double damage & steals blood - Gives them a Blood shield until they use Bloodbeam
 */

#define BLOOD_SHIELD_BLOCK_CHANCE 75
#define BLOOD_SHIELD_BLOOD_COST 15
/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy
	name = "Thaumaturgy"
	level_current = 1
	button_icon_state = "power_thaumaturgy"
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED
	bloodcost = 20
	constant_bloodcost = 0
	cooldown_time = 30 SECONDS
	click_cd_override = 2 SECONDS
	prefire_message = "Right click where you wish to fire."
	click_to_activate = TRUE // you pay to replenish charges
	unset_after_click = FALSE // Lets us cast multiple times
	// how many times you can shoot before you need to recast
	var/charges = 0
	///Blood shield given while this Power is active.
	var/datum/weakref/blood_shield

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/upgrade_power()
	. = ..()
	click_cd_override = get_shot_cooldown()
	bloodcost = get_max_charges() * 10

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/get_power_desc()
	. = ..()
	var/current_desc = .
	var/append_string = ""
	if(level_current >= 3)
		append_string = " and opening doors/lockers"
	if(level_current >= 5)	
		append_string = ", stealing blood" + append_string
	return "[level_current > 2 ? "Create a Blood shield and fire a blood bolt" : "Fire a blood bolt at your enemy"], \
		dealing [get_blood_bolt_damage()] Burn damage[append_string].\n\
		[current_desc]"

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/get_power_explanation()
	return "Level [level_current]: [src]: \n\
		Activating Thaumaturgy will temporarily give you a Blood Shield,\n\
		The blood shield has a [BLOOD_SHIELD_BLOCK_CHANCE]% block chance, but costs [BLOOD_SHIELD_BLOOD_COST] Blood per hit to maintain.\n\
		You will also have the ability to fire a Blood blast.\n\
		If the Blood blast hits a person, it will deal [get_blood_bolt_damage()] Burn damage.\n\
		You can use Blood blast [get_max_charges()] times before needing to recast Thaumaturgy. After each shot you will have to wait [DisplayTimeText(get_shot_cooldown())].\n\
		At level 3 or above, it will also break open lockers and doors.\n\
		At level 5, it will also steal blood to feed yourself, though at a net-negative."

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/Activate(trigger_flags)
	. = ..()
	owner.balloon_alert(owner, "you start thaumaturgy")
	charges = get_max_charges()
	if(level_current >= 2) // Only if we're at least level 2.
		var/obj/item/shield/bloodsucker/new_shield = new
		blood_shield = WEAKREF(new_shield)
		if(!owner.put_in_inactive_hand(new_shield))
			owner.balloon_alert(owner, "off hand is full!")
			to_chat(owner, span_notice("Blood shield couldn't be activated as your off hand is full."))
			return FALSE
		owner.visible_message(
			span_warning("[owner]\'s hands begins to bleed and forms into a blood shield!"),
			span_warning("We activate our Blood shield!"),
			span_hear("You hear liquids forming together."),
		)

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/DeactivatePower()
	var/shield = blood_shield?.resolve()
	if(shield)
		qdel(shield)
		blood_shield = null
	return ..()

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/get_blood_bolt_damage()
	if(level_current >= 4)
		return 40
	return 20

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/get_max_charges()
	return level_current * 2

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/proc/get_shot_cooldown()
	return max(2 - (level_current * 0.1), 0)

/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/FireSecondaryTargetedPower(atom/target, params)
	var/mob/living/user = owner
	owner.balloon_alert(owner, "you fire a blood bolt!")
	owner.visible_message(
		span_warning("[owner] fires a blood bolt at [target]!"),
		span_warning("You fire a blood bolt at [target]!"),
		span_hear("You hear a loud crackling sound."),
	)
	user.changeNext_move(CLICK_CD_RANGE)
	user.newtonian_move(get_dir(target, user))
	user.face_atom(target)
	var/obj/projectile/magic/arcane_barrage/bloodsucker/magic_9ball = new(user.loc)
	magic_9ball.power_ref = WEAKREF(src)
	if(level_current >= 4)
		magic_9ball.damage = 40
	magic_9ball.firer = user
	magic_9ball.def_zone = ran_zone(user.zone_selected)
	magic_9ball.preparePixelProjectile(target, user)
	INVOKE_ASYNC(magic_9ball, TYPE_PROC_REF(/obj/projectile, fire))
	playsound(user, 'sound/magic/wand_teleport.ogg', 60, TRUE)
	charges -= 1
	if(charges <= 0)
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/atom, balloon_alert), owner, "no charges left!"), 1 SECONDS)
		PowerActivatedSuccesfully()

/**
 * 	# Blood Bolt
 *
 *	This is the projectile this Power will fire.
 */
/obj/projectile/magic/arcane_barrage/bloodsucker
	name = "blood bolt"
	icon_state = "mini_leaper"
	damage = 20
	var/datum/weakref/power_ref

/obj/projectile/magic/arcane_barrage/bloodsucker/on_hit(target, blocked = 0, pierce_hit)
	var/datum/action/cooldown/bloodsucker/targeted/tremere/thaumaturgy/bloodsucker_power = power_ref?.resolve()
	if(!bloodsucker_power)
		return ..()
	if(istype(target, /obj/structure/closet) && bloodsucker_power.level_current >= 3)
		var/obj/structure/closet/hit_closet = target
		if(hit_closet)
			hit_closet.welded = FALSE
			hit_closet.locked = FALSE
			hit_closet.broken = TRUE
			hit_closet.update_appearance()
			return ..()
	if(istype(target, /obj/machinery/door) && bloodsucker_power.level_current >= 3)
		var/obj/machinery/door/hit_airlock = target
		hit_airlock.open(2)
		qdel(src)
		return ..()
	if(ismob(target))
		if(bloodsucker_power.level_current >= 5)
			var/mob/living/person_hit = target
			person_hit.blood_volume -= 60
			bloodsucker_power.bloodsuckerdatum_power.AdjustBloodVolume(60)
		return ..()
	. = ..()

/**
 *	# Blood Shield
 *
 *	The shield spawned when using Thaumaturgy when strong enough.
 *	Copied mostly from '/obj/item/shield/changeling'
 */

/obj/item/shield/bloodsucker
	name = "blood shield"
	desc = "A shield made out of blood, requiring blood to sustain hits."
	item_flags = ABSTRACT | DROPDEL
	icon = 'modular_zubbers/icons/obj/structures/vamp_obj.dmi'
	icon_state = "blood_shield"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/bloodsucker_righthand.dmi'
	block_chance = BLOOD_SHIELD_BLOCK_CHANCE

/obj/item/shield/bloodsucker/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, BLOODSUCKER_TRAIT)

/obj/item/shield/bloodsucker/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum)
		bloodsuckerdatum.AdjustBloodVolume(-BLOOD_SHIELD_BLOOD_COST)
	return ..()

#undef BLOOD_SHIELD_BLOCK_CHANCE
#undef BLOOD_SHIELD_BLOOD_COST
