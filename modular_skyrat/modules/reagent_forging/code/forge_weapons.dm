#define STUN_ATTACK "stun attack"

// Damage is technically 10 by default since that's the max you get from perfect hits when crafting. Find a non-third-of-sth value for the multiplier to get to 18, I'll wait
/obj/item/melee/forged_reagent_weapon
	name = "forged reagent weapon"
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_worn.dmi'
	integrity_failure = 0.5
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	obj_flags = UNIQUE_RENAME
	abstract_type = /obj/item/melee/forged_reagent_weapon

	//keeps track of how much force was taken away from incomplete forging
	var/completion_force_penalty = 0
	//keeps track of how much force was given from perfect hammering
	var/perfect_forging_bonus = 0

	//chance to self damage from being clumsy
	var/clumsy_backfire_chance = 70

	//vars for nonlethal strikes
	//can this item nonlethal attack?
	var/can_nonlethal_altfire = TRUE
	//time between nonlethal attacks
	var/nonlethal_strike_cooldown = 4 SECONDS
	COOLDOWN_DECLARE(nonlethal_strike_cooldown_timer)
	/// The path of the default sound to play when we stun something.
	var/on_stun_sound = 'sound/effects/woodhit.ogg'
	//verbs to use when secondary attacking
	var/list/secondary_attack_verb_continuous = list("shaft-strikes")
	var/list/secondary_attack_verb_simple = list("shaft-strike")

	//below numbers are multiplied by the weapon's force
	//how much stamina damage to apply on a rightclick
	var/stamina_damage_multiplier = 2
	//how long the victim should be knockdowned
	var/knockdown_time_multiplier = 0.5 DECISECONDS


/obj/item/melee/forged_reagent_weapon/examine(mob/user)
	. = ..()
	var/healthpercent = round((atom_integrity/max_integrity) * 100, 1)
	switch(healthpercent)
		if(50 to 99)
			. += span_info("It looks slightly damaged.")
		if(25 to 50)
			. += span_info("It appears heavily damaged.")
		if(0 to 25)
			. += span_warning("It's falling apart!")

/obj/item/melee/forged_reagent_weapon/Initialize(mapload)
	. = ..()
	if (length(secondary_attack_verb_continuous) != length(secondary_attack_verb_simple))
		stack_trace("[src] doesn't have equal secondary attack verb lengths, please fix!")
	apply_reagent_component()
	apply_smithing_component()

/* needs updating to the new bane component, todo later by the person who actually knows how to handle such a thing
/obj/item/melee/forged_reagent_weapon/set_custom_materials(list/materials, multiplier = 1)
	if(/datum/material/silver in materials)
		AddComponent(/datum/component/bane, affected_biotypes = MOB_MINING, added_damage = 80) //For killing really big monsters.
		AddElement(/datum/element/bane, /datum/species/lycan, damage_multiplier = 3, requires_combat_mode = FALSE)
	else
		RemoveComponent(/datum/component/bane)
		*/

/obj/item/melee/forged_reagent_weapon/change_material_integrity(datum/material/material, amount, multiplier, removing = FALSE)
	blacksmithing_change_material_integrity(src, material, amount, multiplier, removing)

/obj/item/melee/forged_reagent_weapon/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

/obj/item/melee/forged_reagent_weapon/proc/apply_reagent_component()
	AddComponent(/datum/component/reagent_imbued/weapon, oil_effects = list(FORGE_EFFECT_ARMORPEN = 10))

/obj/item/melee/forged_reagent_weapon/proc/apply_smithing_component()
	AddComponent(/datum/component/forge_smithable, \
		FORGING_WEAPON_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS, \
		FORGING_WEAPON_REFORGING_MAX_BAD_HITS, \
		FORGING_WEAPON_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_FORCE = MAX_PERFECT_FORCE_BONUS), \
		incompletion_effects = list(FORGE_EFFECT_FORCE, FORGE_EFFECT_ARMORPEN))

// nonlethal secondary attack
/obj/item/melee/forged_reagent_weapon/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return TRUE
	if(!ishuman(target))
		return FALSE // bashing objects

	// clumsy people redirect this attack - yes, this bypasses IWASBATONED and such
	if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		user.visible_message(
			span_danger("[user] accidentally hits [user.p_them()]self over the head with [src]! What a doofus!"),
			span_userdanger("You accidentally hit yourself over the head with [src]!"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

		finalize_nonlethal_strike(user, user, clumsy = TRUE)
		user.apply_damage(2 * force, BRUTE, BODY_ZONE_HEAD, attacking_item = src)
		log_combat(user, user, "accidentally stun attacked [user.p_them()]self due to their clumsiness", src)
		user.do_attack_animation(user)
		user.changeNext_move(attack_speed)
		return TRUE // you hit yourself, nerd

	var/right_clicked = LAZYACCESS(modifiers, RIGHT_CLICK)
	if(can_nonlethal_altfire && right_clicked)
		if(COOLDOWN_FINISHED(src, nonlethal_strike_cooldown_timer))
			// when we continue to attack, deal 0 (brute) damage (just stun)
			SET_ATTACK_FORCE(attack_modifiers, 0)
			MUTE_ATTACK_HITSOUND(attack_modifiers)
			HIDE_ATTACK_MESSAGES(attack_modifiers)
			LAZYSET(attack_modifiers, STUN_ATTACK, TRUE)
		else
			return TRUE //if we cannot nonlethal and the player is attempting, cancel the attack
	return FALSE

/obj/item/melee/forged_reagent_weapon/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(QDELETED(target) || !LAZYACCESS(attack_modifiers, STUN_ATTACK))
		return

	finalize_nonlethal_strike(target, user)

	var/list/desc = get_stun_description(target, user)

	if(desc)
		target.visible_message(desc["visible"], desc["local"], visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE)

/// Wrapper for calling "stun()" and doing relevant vfx/sfx
/obj/item/melee/forged_reagent_weapon/proc/finalize_nonlethal_strike(mob/living/target, mob/living/user, clumsy = FALSE)
	COOLDOWN_START(src, nonlethal_strike_cooldown_timer, nonlethal_strike_cooldown)
	if(on_stun_sound)
		playsound(src, on_stun_sound, 30, TRUE, -1)
	if(baton_effect(target, user, null, clumsy) && user)
		set_batoned(target, user, nonlethal_strike_cooldown)
		log_combat(user, target, "stunned", src.name)

/obj/item/melee/forged_reagent_weapon/proc/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	if(iscyborg(target))
		return

	var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if(prob(70))
			human_target.force_say()

	var/stamina_damage = force * stamina_damage_multiplier
	var/knockdown_time = force * knockdown_time_multiplier
	var/armour_block = target.run_armor_check(BODY_ZONE_CHEST, MELEE, null, null, armour_penetration)

	target.apply_damage(stamina_damage, STAMINA, blocked = armour_block)
	if(!trait_check)
		target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
	SEND_SIGNAL(target, COMSIG_MOB_BATONED, user, src)
	return TRUE

/// Used in marking a target as being hit by a baton
/obj/item/melee/forged_reagent_weapon/proc/set_batoned(mob/living/target, mob/living/user, cooldown)
	PRIVATE_PROC(TRUE)
	if(!cooldown)
		return
	var/user_ref = REF(user) // avoids harddels.
	ADD_TRAIT(target, TRAIT_IWASBATONED, user_ref)
	addtimer(TRAIT_CALLBACK_REMOVE(target, TRAIT_IWASBATONED, user_ref), cooldown)

/obj/item/melee/forged_reagent_weapon/proc/get_stun_description(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	. = list()
	if(length(secondary_attack_verb_continuous) >= 1)
		var/random = rand(1, length(secondary_attack_verb_continuous))
		.["visible"] = span_danger("[user] [secondary_attack_verb_continuous[random]] [target] with [src]!")
		.["local"] = span_userdanger("[user] [secondary_attack_verb_continuous[random]] you with [src]!")

/obj/item/melee/forged_reagent_weapon/add_item_context(datum/source, list/context, atom/target, mob/living/user)
	if (isturf(target))
		return NONE

	if (isobj(target))
		context[SCREENTIP_CONTEXT_LMB] = "Attack"
	else
		context[SCREENTIP_CONTEXT_LMB] = "Attack"
		if(can_nonlethal_altfire && ishuman(target))
			context[SCREENTIP_CONTEXT_RMB] = "Non-lethally Attack"

	return CONTEXTUAL_SCREENTIP_SET

/obj/item/melee/forged_reagent_weapon/sword
	name = "reagent sword"
	desc = "A sharp, maneuverable bastard sword most adept at blocking opposing melee strikes."
	force = 7
	armour_penetration = 10
	wound_bonus = -5
	icon_state = "sword"
	inhand_icon_state = "sword"
	worn_icon_state = "sword_back"
	inside_belt_icon_state = "sword_belt"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	throwforce = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	block_chance = 30
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	max_integrity = 150
	stamina_damage_multiplier = 1.75
	knockdown_time_multiplier = 1 DECISECONDS
	secondary_attack_verb_continuous = list("pommel-strikes")
	secondary_attack_verb_simple = list("pommel-strike")
	var/wielded = FALSE
	var/unwielded_block_chance = 30
	var/wielded_block_chance = 45

/obj/item/melee/forged_reagent_weapon/sword/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/melee/forged_reagent_weapon/sword/proc/on_wield()
	wielded = TRUE
	block_chance = wielded_block_chance

/obj/item/melee/forged_reagent_weapon/sword/proc/on_unwield()
	wielded = FALSE
	block_chance = unwielded_block_chance

/obj/item/melee/forged_reagent_weapon/katana
	name = "reagent katana"
	desc = "A katana sharp enough to penetrate body armor, but not quite million-times-folded sharp."
	force = 7
	armour_penetration = 25 //Slices through armour like butter, but can't quite bisect a knight like the real thing.
	wound_bonus = -5
	icon_state = "katana"
	inhand_icon_state = "katana"
	worn_icon_state = "katana_back"
	inside_belt_icon_state = "katana_belt"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	throwforce = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	stamina_damage_multiplier = 1.5
	knockdown_time_multiplier = 0.6 DECISECONDS
	secondary_attack_verb_continuous = list("pommel-strikes")
	secondary_attack_verb_simple = list("pommel-strike")

/obj/item/melee/forged_reagent_weapon/katana/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/melee/forged_reagent_weapon/dagger
	name = "reagent dagger"
	desc = "A lightweight dagger historically used to stab at the gaps in armour of fallen knights of old."
	force = 5
	icon_state = "dagger"
	inhand_icon_state = "dagger"
	worn_icon_state = "dagger_back"
	inside_belt_icon_state = "dagger_belt"
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	embed_type = /datum/embedding/forged_dagger
	throwforce = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	can_nonlethal_altfire = FALSE
	wound_bonus = 5
	exposed_wound_bonus = 30
	var/bonus_damage = 10

/datum/embedding/forged_dagger
	embed_chance = 50
	fall_chance = 1
	pain_mult = 2

/obj/item/melee/forged_reagent_weapon/dagger/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, speed = 10 SECONDS, effectiveness = 70)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)


//We're not reinventing the wheel, give it extra wounding if you land it, either you do or you dont, no dmg ups. Nullblade code but modified

/obj/item/melee/forged_reagent_weapon/dagger/attack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	//Wounds scale off damage applied, so we're going to give the illusion of damaging people with the swing, when in reality it's all in the proc.
	if(!isliving(target))
		return

	var/mob/living/carbon/living_target = target //Only wounds, so we don't care about mobs

	if(user == living_target)
		return

	if(living_target.stat == DEAD)
		return

	if(check_for_sneak_attack(living_target, user) == TRUE)
		critical_hit(living_target)

/obj/item/melee/forged_reagent_weapon/dagger/proc/check_for_sneak_attack(mob/living/carbon/carbon_target, mob/user)
	// Check chaplain_nullrod.dm for original comments, I'm only leaving new ones in
	var/successful_sneak_attack = FALSE

	var/sneak_attack_fail_message = FALSE

	if(carbon_target.is_blind())
		successful_sneak_attack = TRUE

	else if(carbon_target.get_timed_status_effect_duration(/datum/status_effect/staggered))
		successful_sneak_attack = TRUE

	else if(carbon_target.get_timed_status_effect_duration(/datum/status_effect/confusion))
		successful_sneak_attack = TRUE

	else if(carbon_target.pulledby && carbon_target.pulledby.grab_state >= GRAB_AGGRESSIVE)
		successful_sneak_attack = TRUE

	else if(HAS_TRAIT(carbon_target, TRAIT_HANDS_BLOCKED))
		successful_sneak_attack = TRUE

	else if(check_behind(user, carbon_target))
		successful_sneak_attack = TRUE

	else if(HAS_TRAIT(carbon_target, TRAIT_MIND_READER) && !user.can_block_magic(MAGIC_RESISTANCE_MIND, charge_cost = 0))
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	else if(user.is_blind())
		successful_sneak_attack = FALSE
		sneak_attack_fail_message = TRUE

	if(!successful_sneak_attack)
		if(sneak_attack_fail_message)
			user.balloon_alert(carbon_target, "sneak attack avoided!")
		return FALSE
	return TRUE

/obj/item/melee/forged_reagent_weapon/dagger/proc/critical_hit(mob/living/carbon/carbon_target, mob/user)
	var/obj/item/bodypart/affecting = carbon_target.get_bodypart(user.get_random_valid_zone(user.zone_selected))
	var/armor_block = carbon_target.run_armor_check(affecting, MELEE, armour_penetration = armour_penetration)

	carbon_target.apply_damage(bonus_damage, BRUTE, def_zone = affecting, blocked = armor_block, wound_bonus = exposed_wound_bonus, sharpness = SHARP_EDGED)
	carbon_target.balloon_alert(user, "sneak attack!")
	playsound(carbon_target, 'sound/items/weapons/guillotine.ogg', 50, TRUE)

/obj/item/melee/forged_reagent_weapon/rapier
	name = "reagent rapier"
	desc = "A lightweight rapier. Usually kept as a self-defense weapon; good at parrying attacks but cannot be two-handed for extra power."
	force = 10
	block_chance = 30
	icon_state = "rapier"
	inhand_icon_state = "sabre"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	worn_icon_state = "sword_back"
	inside_belt_icon_state = "rapier_belt"
	block_sound = 'sound/items/weapons/parry.ogg'
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	throwforce = 10
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "pierces", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_POINTY
	stamina_damage_multiplier = 1.5
	knockdown_time_multiplier = 1.4
	secondary_attack_verb_continuous = list("hilt-strikes")
	secondary_attack_verb_simple = list("hilt-strike")

/obj/item/melee/forged_reagent_weapon/rapier/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/melee/forged_reagent_weapon/rapier/apply_reagent_component()
	AddComponent(/datum/component/reagent_imbued/weapon, list(FORGE_EFFECT_BLOCKCHANCE = 5))

/obj/item/melee/forged_reagent_weapon/staff //doesn't do damage. Useful for healing reagents.
	name = "reagent staff"
	desc = "A staff most notably capable of being imbued with reagents, especially useful alongside its otherwise harmless nature."
	force = 0
	icon_state = "staff"
	inhand_icon_state = "staff"
	worn_icon_state = "staff_back"
	hitsound = 'sound/effects/magic/staff_healing.ogg'
	throwforce = 0
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("reagent casts on", "waves a staff over")
	attack_verb_simple = list("reagent cast on", "wave a staff over")

/obj/item/melee/forged_reagent_weapon/staff/apply_reagent_component()
	AddComponent(/datum/component/reagent_imbued/weapon, list(FORGE_EFFECT_REAGENT_INJECT = 3), 0.7)

/obj/item/melee/forged_reagent_weapon/staff/apply_smithing_component()
	AddComponent(/datum/component/forge_smithable, \
		FORGING_WEAPON_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS, \
		FORGING_WEAPON_REFORGING_MAX_BAD_HITS, \
		FORGING_WEAPON_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_REAGENT_INJECT = 3), \
		incompletion_effects = list(FORGE_EFFECT_REAGENT_INJECT, FORGE_EFFECT_DURABILITY))

/obj/item/melee/forged_reagent_weapon/staff/attack(mob/living/M, mob/living/user, params)
	. = ..()
	user.changeNext_move(CLICK_CD_RANGE)

/obj/item/melee/forged_reagent_weapon/spear
	name = "reagent spear"
	desc = "A long spear that can be wielded in two hands to boost damage at the cost of single-handed versatility."
	force = 7
	throwforce = 22
	armour_penetration = 10
	icon_state = "spear"
	inhand_icon_state = "spear"
	worn_icon_state = "spear_back"
	throwforce = 15 //not a javelin, throwing specialty is for the axe.
	embed_data = /datum/embedding/spear
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("attack", "poke", "jab", "tear", "lacerate", "gore")
	wound_bonus = -10
	exposed_wound_bonus = 20
	sharpness = SHARP_POINTY
	stamina_damage_multiplier = 2
	knockdown_time_multiplier = 0.2
	secondary_attack_verb_continuous = list("shaft-strikes")
	secondary_attack_verb_simple = list("shaft-strike")

/obj/item/melee/forged_reagent_weapon/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/jousting, max_tile_charge = 9, min_tile_charge = 6)
	AddComponent(/datum/component/butchering, speed = 10 SECONDS, effectiveness = 70)
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/two_hand_reach, unwield_reach = 2, wield_reach = 1)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/melee/forged_reagent_weapon/spear/proc/on_wield(obj/item/source, mob/living/carbon/user)
	armour_penetration *= 2

/obj/item/melee/forged_reagent_weapon/spear/proc/on_unwield(obj/item/source, mob/living/carbon/user)
	armour_penetration /= 2

/obj/item/melee/forged_reagent_weapon/axe
	name = "reagent axe"
	desc = "An axe especially balanced for throwing and embedding into fleshy targets, yet also effective at destroying shields of all sorts."
	force = 7
	armour_penetration = 10
	wound_bonus = -5
	icon_state = "axe"
	inhand_icon_state = "axe"
	worn_icon_state = "axe_back"
	throwforce = 22 //ouch
	throw_speed = 4
	embed_type = /datum/embedding/forged_axe
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("slashes", "bashes")
	attack_verb_simple = list("slash", "bash")
	sharpness = SHARP_EDGED
	stamina_damage_multiplier = 3
	knockdown_time_multiplier = 0.7
	secondary_attack_verb_continuous = list("blunt-strikes")
	secondary_attack_verb_simple = list("blunt-strike")

/datum/embedding/forged_axe
	embed_chance = 65
	fall_chance = 10
	pain_mult = 2

/obj/item/melee/forged_reagent_weapon/axe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, speed = 10 SECONDS, effectiveness = 70)
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)


/obj/item/melee/forged_reagent_weapon/axe/pre_attack(mob/living/M, mob/living/user, params)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/obj/item/shield/I in H.held_items)
			if(I.breakable_by_damage)
				user.balloon_alert(user, "devastating blow!")
				playsound(src, 'sound/effects/bang.ogg', 30)
				I.take_damage(15, BRUTE, 0, FALSE, get_dir(user, H))
			else
				user.balloon_alert(user, "crippling blow!")
				playsound(src, 'sound/effects/tableheadsmash.ogg', 30)
				H.apply_damage(15, STAMINA)

/obj/item/melee/forged_reagent_weapon/hammer
	name = "reagent hammer"
	desc = "A heavy, weighted hammer that packs an incredible punch but can prove to be unwieldy. Useful for forging!"
	force = 6 //strong when wielded, but boring.
	armour_penetration = 10
	wound_bonus = -5
	icon_state = "crush_hammer"
	inhand_icon_state = "crush_hammer"
	worn_icon_state = "hammer_back"
	throwforce = 10
	demolition_mod = 1.5
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("bashes", "whacks")
	attack_verb_simple = list("bash", "whack")
	tool_behaviour = TOOL_HAMMER
	///the list of things that, if attacked, will set the attack speed to rapid
	var/static/list/fast_attacks = list(
		/obj/structure/reagent_anvil,
		/obj/structure/reagent_crafting_bench
	)
	stamina_damage_multiplier = 1.8
	knockdown_time_multiplier = 0.6
	secondary_attack_verb_continuous = list("shaft-strikes")
	secondary_attack_verb_simple = list("shaft-strike")

/obj/item/melee/forged_reagent_weapon/hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)
	AddComponent(/datum/component/two_handed, force_multiplier = 2.4)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/melee/forged_reagent_weapon/hammer/apply_smithing_component()
	AddComponent(/datum/component/forge_smithable, \
		FORGING_WEAPON_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS, \
		FORGING_WEAPON_REFORGING_MAX_BAD_HITS, \
		FORGING_WEAPON_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_FORCE = MAX_PERFECT_FORCE_BONUS, FORGE_EFFECT_TOOLSPEED = -0.2), \
		incompletion_effects = list(FORGE_EFFECT_FORCE, FORGE_EFFECT_ARMORPEN, FORGE_EFFECT_TOOLSPEED))

/obj/item/melee/forged_reagent_weapon/hammer/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	. = ..()
	var/density = material.get_property(MATERIAL_DENSITY)
	var/hardness = material.get_property(MATERIAL_HARDNESS)
	var/toolspeed_bonus = (density + hardness - 12) / 12
	if(!remove)
		toolspeed -= toolspeed_bonus
	else
		toolspeed += toolspeed_bonus

/obj/item/melee/forged_reagent_weapon/hammer/attack(mob/living/M, mob/living/user, params)
	. = ..()
	user.changeNext_move(CLICK_CD_SLOW) //The hammer attacks slower but has more damage, that's it's thing now

/obj/item/shield/buckler/reagent_weapon //Same as a buckler, but metal.
	name = "reagent plated buckler shield"
	desc = "A small, round shield best used in tandem with a melee weapon in close-quarters combat."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_worn.dmi'
	icon_state = "buckler"
	inhand_icon_state = "buckler"
	worn_icon_state = "buckler_back"
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	custom_materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT)
	resistance_flags = FIRE_PROOF
	block_chance = 30
	transparent = FALSE
	max_integrity = 150 //over double that of a wooden one
	w_class = WEIGHT_CLASS_NORMAL
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_AFFECT_STATISTICS | MATERIAL_COLOR
	shield_break_sound = 'sound/effects/bang.ogg'
	shield_break_leftover = /obj/item/forging/complete/plate

/obj/item/shield/buckler/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/weapon, oil_effects = list(FORGE_EFFECT_BLOCKCHANCE = 5, FORGE_EFFECT_DURABILITY = 20))
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)
	apply_smithing_component()

/obj/item/shield/buckler/reagent_weapon/change_material_integrity(datum/material/material, amount, multiplier, removing = FALSE)
	blacksmithing_change_material_integrity(src, material, amount, multiplier, removing)

/obj/item/shield/buckler/reagent_weapon/change_material_strength(datum/material/material, mat_amount, multiplier, remove = FALSE)
	blacksmithing_change_material_strength(src, material, mat_amount, multiplier, remove)

/obj/item/shield/buckler/reagent_weapon/proc/apply_smithing_component()
	AddComponent(/datum/component/forge_smithable, \
		FORGING_WEAPON_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS, \
		FORGING_WEAPON_REFORGING_MAX_BAD_HITS, \
		FORGING_WEAPON_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_BLOCKCHANCE = 5), \
		incompletion_effects = list(FORGE_EFFECT_BLOCKCHANCE, FORGE_EFFECT_FORCE))

/obj/item/shield/buckler/reagent_weapon/pavise //similar to the adamantine shield. Huge, slow, lets you soak damage and packs a wallop.
	name = "reagent plated pavise shield"
	desc = "An large wall-like shield. Very heavy, but extremely protective."
	force = 10
	icon_state = "pavise"
	inhand_icon_state = "pavise"
	worn_icon_state = "pavise_back"
	block_chance = 55
	item_flags = SLOWS_WHILE_IN_HAND | IMMUTABLE_SLOW
	slowdown = 2.0
	drag_slowdown = 3.5
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	max_integrity = 300 //tanky

/obj/item/shield/buckler/reagent_weapon/pavise/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/shield/buckler/reagent_weapon/pavise/apply_smithing_component()
	AddComponent(/datum/component/forge_smithable, \
		FORGING_WEAPON_REFORGING_MAX_QUALITY, \
		TRUE, \
		FORGING_WEAPON_REFORGING_MAX_PERFECT_HITS, \
		FORGING_WEAPON_REFORGING_MAX_BAD_HITS, \
		FORGING_WEAPON_REFORGING_AVERAGE_WAIT, \
		perfection_effects = list(FORGE_EFFECT_BLOCKCHANCE = 10), \
		incompletion_effects = list(FORGE_EFFECT_BLOCKCHANCE, FORGE_EFFECT_FORCE))

/obj/item/pickaxe/reagent_weapon
	name = "reagent pickaxe"

/obj/item/pickaxe/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/weapon)

/obj/item/shovel/reagent_weapon
	name = "reagent shovel"

/obj/item/shovel/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_imbued/weapon)

/obj/item/ammo_casing/arrow/attackby(obj/item/attacking_item, mob/user, params)
	var/spawned_item
	if(istype(attacking_item, /obj/item/stack/sheet/sinew))
		spawned_item = /obj/item/ammo_casing/arrow/ash

	if(istype(attacking_item, /obj/item/stack/sheet/bone))
		spawned_item = /obj/item/ammo_casing/arrow/bone

	if(istype(attacking_item, /obj/item/stack/tile/bronze))
		spawned_item = /obj/item/ammo_casing/arrow/bronze

	if(!spawned_item)
		return ..()

	var/obj/item/stack/stack_item = attacking_item
	if(!stack_item.use(1))
		return

	var/obj/item/ammo_casing/arrow/converted_arrow = new spawned_item(get_turf(src))
	transfer_fingerprints_to(converted_arrow)
	remove_item_from_storage(user)
	user.put_in_hands(converted_arrow)
	qdel(src)

/obj/item/melee/forged_reagent_weapon/bokken
	name = "bokken"
	desc = "A wooden sword that is capable of wielded in two hands. It seems to be made to prevent permanent injuries."
	force = 10
	armour_penetration = 40
	icon_state = "bokken"
	inhand_icon_state = "bokken"
	worn_icon_state = "bokken_back"
	block_chance = 20
	block_sound = 'sound/items/weapons/parry.ogg'
	damtype = STAMINA
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	stamina_damage_multiplier = 1.5
	knockdown_time_multiplier = 0.6 DECISECONDS
	attack_verb_continuous = list("bonks", "bashes", "whacks", "pokes", "prods")
	attack_verb_simple = list("bonk", "bash", "whack", "poke", "prod")
	var/wielded = FALSE
	var/unwielded_block_chance = 20
	var/wielded_block_chance = 40

/obj/item/melee/forged_reagent_weapon/bokken/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed,\
		force_multiplier = 2, \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)

/obj/item/melee/forged_reagent_weapon/bokken/proc/on_wield()
	wielded = TRUE
	block_chance = wielded_block_chance

/obj/item/melee/forged_reagent_weapon/bokken/proc/on_unwield()
	wielded = FALSE
	block_chance = unwielded_block_chance

/obj/item/melee/forged_reagent_weapon/bokken/attack(mob/living/carbon/target_mob, mob/living/user, params)
	. = ..()
	if(!iscarbon(target_mob))
		user.visible_message(span_warning("The [src] seems to be ineffective against the [target_mob]!"))
		playsound(src, 'sound/items/weapons/genhit.ogg', 75, TRUE)
		return
	playsound(src, pick('sound/items/weapons/genhit1.ogg', 'sound/items/weapons/genhit2.ogg', 'sound/items/weapons/genhit3.ogg'), 100, TRUE)

/obj/item/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_hand_reach, unwield_reach = 1, wield_reach = 2)

#undef STUN_ATTACK
