// Damage is technically 10 by default since that's the max you get from perfect hits when crafting. Find a non-third-of-sth value for the multiplier to get to 18, I'll wait
/obj/item/forging/reagent_weapon
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_worn.dmi'
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	obj_flags = UNIQUE_RENAME
	skyrat_obj_flags = ANVIL_REPAIR

/obj/item/forging/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)

/obj/item/forging/reagent_weapon/examine(mob/user)
	. = ..()
	. += span_notice("Using a hammer on [src] will repair its damage!")

/obj/item/forging/reagent_weapon/sword
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
	var/wielded = FALSE
	var/unwielded_block_chance = 30
	var/wielded_block_chance = 45

/obj/item/forging/reagent_weapon/sword/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/forging/reagent_weapon/sword/proc/on_wield()
	wielded = TRUE
	block_chance = wielded_block_chance

/obj/item/forging/reagent_weapon/sword/proc/on_unwield()
	wielded = FALSE
	block_chance = unwielded_block_chance

/obj/item/forging/reagent_weapon/katana
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

/obj/item/forging/reagent_weapon/katana/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/forging/reagent_weapon/dagger
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
	wound_bonus = 5
	exposed_wound_bonus = 30
	var/bonus_damage = 10

/datum/embedding/forged_dagger
	embed_chance = 50
	fall_chance = 1
	pain_mult = 2

/obj/item/forging/reagent_weapon/dagger/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, speed = 10 SECONDS, effectiveness = 70)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)


//We're not reinventing the wheel, give it extra wounding if you land it, either you do or you dont, no dmg ups. Nullblade code but modified

/obj/item/forging/reagent_weapon/dagger/attack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
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

/obj/item/forging/reagent_weapon/dagger/proc/check_for_sneak_attack(mob/living/carbon/carbon_target, mob/user)
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

/obj/item/forging/reagent_weapon/dagger/proc/critical_hit(mob/living/carbon/carbon_target, mob/user)
	var/obj/item/bodypart/affecting = carbon_target.get_bodypart(user.get_random_valid_zone(user.zone_selected))
	var/armor_block = carbon_target.run_armor_check(affecting, MELEE, armour_penetration = armour_penetration)

	carbon_target.apply_damage(bonus_damage, BRUTE, def_zone = affecting, blocked = armor_block, wound_bonus = exposed_wound_bonus, sharpness = SHARP_EDGED)
	carbon_target.balloon_alert(user, "sneak attack!")
	playsound(carbon_target, 'sound/items/weapons/guillotine.ogg', 50, TRUE)

/obj/item/forging/reagent_weapon/staff //doesn't do damage. Useful for healing reagents.
	name = "reagent staff"
	desc = "A staff most notably capable of being imbued with reagents, especially useful alongside its otherwise harmless nature."
	force = 0
	icon_state = "staff"
	inhand_icon_state = "staff"
	worn_icon_state = "staff_back"
	throwforce = 0
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("bonks", "bashes", "whacks", "pokes", "prods")
	attack_verb_simple = list("bonk", "bash", "whack", "poke", "prod")

/obj/item/forging/reagent_weapon/staff/attack(mob/living/M, mob/living/user, params)
	. = ..()
	user.changeNext_move(CLICK_CD_RANGE)

/obj/item/forging/reagent_weapon/spear
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

/obj/item/forging/reagent_weapon/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/jousting, max_tile_charge = 9, min_tile_charge = 6)
	AddComponent(/datum/component/butchering, speed = 10 SECONDS, effectiveness = 70)
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/two_hand_reach, unwield_reach = 1, wield_reach = 2)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/forging/reagent_weapon/axe
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

/datum/embedding/forged_axe
	embed_chance = 65
	fall_chance = 10
	pain_mult = 2

/obj/item/forging/reagent_weapon/axe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, speed = 10 SECONDS, effectiveness = 70)
	AddComponent(/datum/component/two_handed, force_multiplier = 2)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)


/obj/item/forging/reagent_weapon/axe/pre_attack(mob/living/M, mob/living/user, params)
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

/obj/item/forging/reagent_weapon/hammer
	name = "reagent hammer"
	desc = "A heavy, weighted hammer that packs an incredible punch but can prove to be unwieldy. Useful for forging!"
	force = 7 //strong when wielded, but boring.
	armour_penetration = 10
	wound_bonus = -5
	icon_state = "crush_hammer"
	inhand_icon_state = "crush_hammer"
	worn_icon_state = "hammer_back"
	throwforce = 10
	slot_flags = ITEM_SLOT_BACK
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

/obj/item/forging/reagent_weapon/hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)
	AddComponent(/datum/component/two_handed, force_multiplier = 2.4)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/forging/reagent_weapon/hammer/attack(mob/living/M, mob/living/user, params)
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
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_AFFECT_STATISTICS
	skyrat_obj_flags = ANVIL_REPAIR
	shield_break_sound = 'sound/effects/bang.ogg'
	shield_break_leftover = /obj/item/forging/complete/plate

/obj/item/shield/buckler/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/shield/buckler/reagent_weapon/examine(mob/user)
	. = ..()
	. += span_notice("Using a hammer on [src] will repair its damage!")

/obj/item/shield/buckler/reagent_weapon/attackby(obj/item/attacking_item, mob/user, params)
	if(atom_integrity >= max_integrity)
		return ..()
	if(istype(attacking_item, /obj/item/forging/hammer))
		var/obj/item/forging/hammer/attacking_hammer = attacking_item
		var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * attacking_hammer.toolspeed
		while(atom_integrity < max_integrity)
			if(!do_after(user, skill_modifier, src))
				return
			var/fixing_amount = min(max_integrity - atom_integrity, 5)
			atom_integrity += fixing_amount
			user.mind.adjust_experience(/datum/skill/smithing, 5) //useful heating means you get some experience
			balloon_alert(user, "partially repaired!")
		return
	return ..()

/obj/item/shield/buckler/reagent_weapon/pavise //similar to the adamantine shield. Huge, slow, lets you soak damage and packs a wallop.
	name = "reagent plated pavise shield"
	desc = "An oblong shield used by ancient crossbowmen as cover while reloading. Probably just as useful with an actual gun."
	force = 10
	icon_state = "pavise"
	inhand_icon_state = "pavise"
	worn_icon_state = "pavise_back"
	block_chance = 75
	item_flags = SLOWS_WHILE_IN_HAND
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	max_integrity = 300 //tanky

/obj/item/shield/buckler/reagent_weapon/pavise/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_multiplier = 1.5)
	AddComponent(/datum/component/mindless_killer, mindless_force_override = 0, mindless_multiplier_override = 2)

/obj/item/pickaxe/reagent_weapon
	name = "reagent pickaxe"

/obj/item/pickaxe/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)

/obj/item/shovel/reagent_weapon
	name = "reagent shovel"

/obj/item/shovel/reagent_weapon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reagent_weapon)

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

/obj/item/forging/reagent_weapon/bokken
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
	attack_verb_continuous = list("bonks", "bashes", "whacks", "pokes", "prods")
	attack_verb_simple = list("bonk", "bash", "whack", "poke", "prod")
	var/wielded = FALSE
	var/unwielded_block_chance = 20
	var/wielded_block_chance = 40

/obj/item/forging/reagent_weapon/bokken/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed,\
		force_multiplier = 2, \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)

/obj/item/forging/reagent_weapon/bokken/proc/on_wield()
	wielded = TRUE
	block_chance = wielded_block_chance

/obj/item/forging/reagent_weapon/bokken/proc/on_unwield()
	wielded = FALSE
	block_chance = unwielded_block_chance

/obj/item/forging/reagent_weapon/bokken/attack(mob/living/carbon/target_mob, mob/living/user, params)
	. = ..()
	if(!iscarbon(target_mob))
		user.visible_message(span_warning("The [src] seems to be ineffective against the [target_mob]!"))
		playsound(src, 'sound/items/weapons/genhit.ogg', 75, TRUE)
		return
	playsound(src, pick('sound/items/weapons/genhit1.ogg', 'sound/items/weapons/genhit2.ogg', 'sound/items/weapons/genhit3.ogg'), 100, TRUE)

/obj/item/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_hand_reach, unwield_reach = 1, wield_reach = 2)
