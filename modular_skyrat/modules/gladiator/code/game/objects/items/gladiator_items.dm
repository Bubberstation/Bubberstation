#define BERSERK_MAX_CHARGE 100
#define PROJECTILE_HIT_MULTIPLIER 1.5
#define DAMAGE_TO_CHARGE_SCALE 1
#define CHARGE_DRAINED_PER_SECOND 3
#define BERSERK_MELEE_ARMOR_ADDED 50
#define BERSERK_ATTACK_SPEED_MODIFIER 0.25

/obj/item/crusher_trophy/gladiator
	name = "ashen bones"
	desc = "A set of soot-coated ribs from a worthy warrior. Suitable as a trophy for a kinetic crusher."
	icon_state = "demon_claws"
	color = "#808080"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/gladiator
	bonus_value = 15

/obj/item/crusher_trophy/gladiator/effect_desc()
	return "the crusher to have a <b>[bonus_value]%</b> chance to block incoming attacks."

/obj/item/crusher_trophy/gladiator/add_to(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance += bonus_value

/obj/item/crusher_trophy/gladiator/remove_from(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance -= bonus_value

/obj/item/clothing/neck/warrior_cape
	name = "cloak of the marked one"
	desc = "A cloak worn by those that have faced death in the eyes and prevailed."
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	icon_state = "berk_cape"
	inhand_icon_state = "" //lul
	resistance_flags = INDESTRUCTIBLE

/obj/item/clothing/neck/warrior_cape/loadout //Subtype for loadout item so i can make it not "indestructible"
	name = "tattered cloak"
	desc = "A cloak from a once feared foe now worn by those that have faced death in the eyes and prevailed, it looks rather worn as not as pristine as it used to be"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/warrior_cape/examine()
	. = ..()
	. += span_warning("Struggle against the tide, no matter how strong it may be.")

/obj/item/clothing/suit/hooded/berserker/gatsu
	name = "berserker armor"
	desc = "A suit of ancient body armor imbued with potent spiritual magnetism, capable of massively boosting a wearer's close combat skills at the cost of ravaging their mind and overexerting their body."
	icon_state = "berk_suit"
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	worn_icon_digi = 'modular_skyrat/modules/gladiator/icons/berserk_suit_digi.dmi'
	hoodtype = /obj/item/clothing/head/hooded/berserker/gatsu
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/berserker_gatsu
	resistance_flags = INDESTRUCTIBLE

/datum/armor/berserker_gatsu
	melee = 40
	bullet = 10
	laser = 10
	energy = 10
	bomb = 70
	bio = 70
	fire = 100
	acid = 100
	wound = -5

/datum/armor/drake_empowerment //Modular Override: nerfs beserker armour so I can keep this armour balanced
	laser = 10
	energy = 0

/datum/armor/drake_empowerment_gatsu
	melee = 30
	laser = 10
	bomb = 20

/obj/item/clothing/suit/hooded/berserker/gatsu/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, maxamount = 1, upgrade_item = /obj/item/drake_remains, armor_mod = /datum/armor/drake_empowerment_gatsu, upgrade_prefix = "empowered")
	allowed = GLOB.mining_suit_allowed

/obj/item/clothing/suit/hooded/berserker/gatsu/examine()
	. = ..()
	. += span_warning("Berserk mode requires the suit's helmet to be equipped, and can only be charged by taking damage.")

/obj/item/clothing/head/hooded/berserker/gatsu
	name = "berserker helmet"
	desc = "A uniquely styled helmet with ghastly red eyes that seals it's user inside."
	icon_state = "berk_helm"
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	armor_type = /datum/armor/berserker_gatsu
	resistance_flags = INDESTRUCTIBLE
	actions_types = list(/datum/action/item_action/berserk_mode)

/obj/item/clothing/head/hooded/berserker/gatsu/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, LOCKED_HELMET_TRAIT)
	AddComponent(/datum/component/anti_magic, ALL, inventory_flags = ITEM_SLOT_OCLOTHING)
	AddComponent(/datum/component/armor_plate, maxamount = 1, upgrade_item = /obj/item/drake_remains, armor_mod = /datum/armor/drake_empowerment_gatsu, upgrade_prefix = "empowered")

/obj/item/clothing/head/hooded/berserker/gatsu/examine()
	. = ..()
	. += span_warning("Berserk mode is usable at 100% charge and requires the helmet to be closed in order to remain active.") //woag!!!

/obj/item/clothing/head/hooded/berserker/gatsu/process(seconds_per_tick)
	if(berserk_active)
		berserk_charge = clamp(berserk_charge - CHARGE_DRAINED_PER_SECOND * seconds_per_tick, 0, BERSERK_MAX_CHARGE)
	if(!berserk_charge)
		if(ishuman(loc))
			end_berserk(loc)

/obj/item/clothing/head/hooded/berserker/gatsu/dropped(mob/user)
	. = ..()
	end_berserk(user)

/obj/item/clothing/head/hooded/berserker/gatsu/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(berserk_active)
		return
	var/berserk_value = damage * DAMAGE_TO_CHARGE_SCALE
	if(attack_type == PROJECTILE_ATTACK)
		berserk_value *= PROJECTILE_HIT_MULTIPLIER
	berserk_charge = clamp(round(berserk_charge + berserk_value), 0, BERSERK_MAX_CHARGE)
	if(berserk_charge >= BERSERK_MAX_CHARGE)
		balloon_alert(owner, "berserk charged")

/obj/item/clothing/head/hooded/berserker/gatsu/IsReflect()
	if(berserk_active)
		return TRUE

/obj/item/claymore/dragonslayer
	name = "\proper Dragonslayer"
	desc = "A blade that seems too big to be called a sword. Too big, too thick, too heavy, and too rough, it's more like a large hunk of raw iron."
	icon = 'modular_skyrat/modules/gladiator/icons/dragonslayer.dmi'
	icon_state = "dragonslayer"
	inhand_icon_state = "dragonslayer"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/64x64_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	force = 20
	wound_bonus = 10
	exposed_wound_bonus = 5
	resistance_flags = INDESTRUCTIBLE
	armour_penetration = 35 //this boss is really hard and this sword is really big
	block_chance = 25
	sharpness = SHARP_EDGED
	item_flags = NO_BLOOD_ON_ITEM
	// aughhghghgh this really should be elementized but this works for now
	var/faction_bonus_force = 40
	var/static/list/nemesis_factions = list("mining", "boss")
	/// how much stamina does it cost to roll
	var/roll_stamcost = 10
	/// how far do we roll?
	var/roll_range = 3
	var/roll_delay = 2 SECONDS
	// prevents you from becoming a bayblade
	COOLDOWN_DECLARE(dodgeroll_cooldown)

/obj/item/claymore/dragonslayer/examine()
	. = ..()
	. += span_warning("Tempered against lavaland foes and bosses through supernatural energies. Right click to dodge at the cost of stamina.")

/obj/item/claymore/dragonslayer/attack(mob/living/target, mob/living/carbon/human/user)
	var/is_nemesis_faction = FALSE
	for(var/found_faction in target.faction)
		if(found_faction in nemesis_factions)
			is_nemesis_faction = TRUE
			force += faction_bonus_force
			break
	. = ..()
	if(is_nemesis_faction)
		force -= faction_bonus_force

/obj/item/claymore/dragonslayer/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.IsImmobilized() || !COOLDOWN_FINISHED(src, dodgeroll_cooldown)) // can't dodge
		return NONE
	var/turf/where_to = get_turf(interacting_with)
	COOLDOWN_START(src, dodgeroll_cooldown, roll_delay)
	user.apply_damage(damage = roll_stamcost, damagetype = STAMINA)
	user.Immobilize(0.1 SECONDS) // you dont get to adjust your roll
	user.throw_at(where_to, range = roll_range, speed = 1, force = MOVE_FORCE_NORMAL)
	user.apply_status_effect(/datum/status_effect/dodgeroll_iframes)
	playsound(user, SFX_BODYFALL, 50, TRUE)
	playsound(user, SFX_RUSTLE, 50, TRUE)
	return ITEM_INTERACT_SUCCESS

/datum/status_effect/dodgeroll_iframes
	id = "dodgeroll_dodging"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH
	duration = 1 SECONDS // worth tweaking?

/datum/status_effect/dodgeroll_iframes/on_apply()
	RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(whiff))
	return TRUE

/datum/status_effect/dodgeroll_iframes/on_remove()
	UnregisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK)
	return ..()

/datum/status_effect/dodgeroll_iframes/proc/whiff()
	SIGNAL_HANDLER
	owner.balloon_alert_to_viewers("MISS!")
	playsound(src, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
	return SUCCESSFUL_BLOCK

/obj/item/claymore/dragonslayer/very_fucking_loud
	name = "\proper Tempered Dragonslayer"
	desc = null
	hitsound = 'modular_skyrat/modules/gladiator/Clang_cut.ogg'

/obj/item/claymore/dragonslayer/very_fucking_loud/examine()
	. = ..()
	. += span_userdanger("CLANG")

/obj/structure/closet/crate/necropolis/gladiator
	name = "gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/crusher
	name = "dreadful gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	if(prob(5))
		new /obj/item/claymore/dragonslayer/very_fucking_loud(src)
	else
		new /obj/item/claymore/dragonslayer(src)
	new /obj/item/clothing/suit/hooded/berserker/gatsu(src)
	new /obj/item/clothing/neck/warrior_cape(src)

/obj/structure/closet/crate/necropolis/gladiator/crusher/PopulateContents()
	if(prob(5))
		new /obj/item/claymore/dragonslayer/very_fucking_loud(src)
	else
		new /obj/item/claymore/dragonslayer(src)
	new /obj/item/clothing/suit/hooded/berserker/gatsu(src)
	new /obj/item/clothing/neck/warrior_cape(src)
	new /obj/item/crusher_trophy/gladiator(src)

#undef BERSERK_MAX_CHARGE
#undef PROJECTILE_HIT_MULTIPLIER
#undef DAMAGE_TO_CHARGE_SCALE
#undef CHARGE_DRAINED_PER_SECOND
#undef BERSERK_MELEE_ARMOR_ADDED
#undef BERSERK_ATTACK_SPEED_MODIFIER
