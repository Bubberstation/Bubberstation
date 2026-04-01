#define MAX_QUENCH_HEAT 600
#define MIN_VOLUME_TO_QUENCH 300
#define MIN_VOLUME_TO_IMBUE 300
//incomplete pre-complete items
/obj/item/forging/incomplete
	name = "parent dev item"
	desc = "An incomplete forge item, continue to work hard to be rewarded for your efforts."
	//the time remaining that you can hammer before too cool
	COOLDOWN_DECLARE(heating_remainder)

	///the quality points of the incomplete item; goes up on good/perfect hits, goes down on bad hits
	var/quality_points = 0
	///the quality points required for it to be considered usable for crafting
	var/completion_quality_points = 30
	///the required time before each strike to prevent spamming
	var/average_wait = 1 SECONDS
	///total current bad hits
	var/bad_hits_total = 0
	///the bad hits required for it to break; exceeding this will break the item
	var/bad_hit_maximum = 5

	///the number of current perfect hits
	var/current_perfects = 0
	///maximum number of perfect hits before perfect hits no longer improve the quality
	var/max_perfect_hits = 20

	///the path of the item that will be spawned upon completion
	var/spawn_item
	///does this item break if it's not finished hammering when it's quenched?
	//this is mostly for working on stuff that has no effect based on completion amount, preventing cheesing
	var/break_on_early_quench = FALSE
	//because who doesn't want to have a plasma sword?
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/forging/incomplete/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "tongs are full already!")
		return
	forceMove(tool)
	tool.icon_state = "tong_full"

/obj/item/forging/incomplete/proc/good_hit(amount = 1, playsound = FALSE)
	quality_points += amount
	if(playsound)
		conditional_pref_sound(src, 'sound/items/weapons/parry.ogg', vary = TRUE, frequency = 1.2, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, pref_to_check = /datum/preference/numeric/volume/sound_ambience_volume)

/obj/item/forging/incomplete/proc/perfect_hit(amount = 1, playsound = FALSE)
	good_hit(amount, FALSE)
	if(playsound)
		conditional_pref_sound(src, 'sound/items/weapons/parry.ogg', vary = TRUE, frequency = 1.0, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, pref_to_check = /datum/preference/numeric/volume/sound_ambience_volume)
	if(current_perfects < max_perfect_hits)
		current_perfects += amount

/obj/item/forging/incomplete/proc/bad_hit(amount = 2, playsound = FALSE)
	bad_hits_total += amount
	if(check_for_breakage())
		forging_breakage()
	else
		if(playsound)
			conditional_pref_sound(src, 'sound/items/weapons/parry.ogg', vol = 35, vary = TRUE, frequency = 2.2, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, pref_to_check = /datum/preference/numeric/volume/sound_ambience_volume)

/obj/item/forging/incomplete/proc/check_for_breakage()
	if(bad_hits_total > bad_hit_maximum)
		return TRUE
	return FALSE

/obj/item/forging/incomplete/proc/forging_breakage(playsound = TRUE)
	if(playsound)
		conditional_pref_sound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', vol = 35, vary = TRUE, extrarange = MEDIUM_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE, pref_to_check = /datum/preference/numeric/volume/sound_ambience_volume)

	balloon_alert_to_viewers("the [name] shattered!")
	qdel(src)

/obj/item/forging/incomplete/proc/is_finished_smithing()
	if(quality_points >= completion_quality_points)
		return TRUE
	return FALSE

/obj/item/forging/incomplete/proc/quench_item(datum/reagents/dunk_reagents, mob/living/quencher)
	if(dunk_reagents.chem_temp > MAX_QUENCH_HEAT)
		balloon_alert(quencher, "This is too hot to cool [src]!")
		return
	if(dunk_reagents.total_volume < MIN_VOLUME_TO_QUENCH)
		balloon_alert(quencher, "This doesn't contain enough fluid to immerse [src]!")
		return

	playsound(src, 'modular_skyrat/modules/reagent_forging/sound/hot_hiss.ogg', 50, TRUE)
	var/obj/spawned_obj = new item.spawn_item(get_turf(src))
	if(is_finished_smithing())
		to_chat(quencher, span_notice("You cool down [src] to produce a [spawned_obj]."))
		quencher.mind.adjust_experience(/datum/skill/smithing, 10)
	else
		if(break_on_early_quench)
			to_chat(quencher, span_warning("The [src] breaks from the thermal shock! Metalworking this type of object requires it to be hammered into completion."))
			qdel(src)
			return
		else
			to_chat(quencher, span_warning("You cool down [src] to produce a [spawned_obj]. You're not sure if it was ready yet..."))

	if(custom_materials)
		spawned_obj.set_custom_materials(custom_materials, 1) //lets set its material

	if(istype(spawned_obj, /obj/item/forging/complete))
		var/obj/item/forging/complete/complete_spawned = spawned_obj
		complete_spawned.perfect_ratio = current_perfects / max_perfect_hits
		complete_spawned.hammer_completion_amount = quality_points / completion_quality_points

	var/datum/component/reagent_imbued/new_reagent_component = spawned_obj.GetComponent(/datum/component/reagent_imbued)
	if(!isnull(new_reagent_component) && HAS_TRAIT(quencher, TRAIT_KNOW_ADVANCED_SMITHING))
		new_reagent_component.set_reagent_imbue(dunk_reagents, FALSE, TRUE)
		to_chat(quencher, span_notice("The [spawned_obj] is imbued with reagents."))

	qdel(src)
	return spawned_obj

/obj/item/forging/incomplete/pickup(mob/living/user)
	var/hand_protected = FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user) || HAS_TRAIT(human_user, TRAIT_RESISTHEAT) || HAS_TRAIT(human_user, TRAIT_RESISTHEATHANDS))
		hand_protected = TRUE
	else if(!istype(human_user.gloves, /obj/item/clothing/gloves))
		hand_protected = FALSE
	else
		var/obj/item/clothing/gloves/gloves = human_user.gloves
		if(gloves.max_heat_protection_temperature)
			hand_protected = (gloves.max_heat_protection_temperature > 360)

	..()
	if(hand_protected)
		var/hitzone = user.held_index_to_dir(user.active_hand_index) == "r" ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND
		user.apply_damage(5, BURN, hitzone)
		to_chat(user, span_danger("You burn your hand trying to pick up [src]!"))
		user.add_mood_event("burnt_thumb", /datum/mood_event/burnt_thumb)
		user.dropItemToGround(src)

/obj/item/forging/incomplete/can_be_pulled(user, force) // no drag memes
	return FALSE

/obj/item/forging/incomplete/chain
	name = "incomplete chain"
	icon_state = "hot_chain"
	completion_quality_points = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/chain
	break_on_early_quench = TRUE

/obj/item/forging/incomplete/plate
	name = "incomplete plate"
	icon_state = "hot_plate"
	completion_quality_points = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/plate

/obj/item/forging/incomplete/sword
	name = "incomplete sword blade"
	icon_state = "hot_blade"
	spawn_item = /obj/item/forging/complete/sword

/obj/item/forging/incomplete/katana
	name = "incomplete katana blade"
	icon_state = "hot_katanablade"
	spawn_item = /obj/item/forging/complete/katana

/obj/item/forging/incomplete/rapier
	name = "incomplete rapier blade"
	icon_state = "hot_rapierblade"
	spawn_item = /obj/item/forging/complete/rapier

/obj/item/forging/incomplete/dagger
	name = "incomplete dagger blade"
	icon_state = "hot_daggerblade"
	spawn_item = /obj/item/forging/complete/dagger

/obj/item/forging/incomplete/staff
	name = "incomplete staff head"
	icon_state = "hot_staffhead"
	spawn_item = /obj/item/forging/complete/staff

/obj/item/forging/incomplete/spear
	name = "incomplete spear head"
	icon_state = "hot_spearhead"
	spawn_item = /obj/item/forging/complete/spear

/obj/item/forging/incomplete/axe
	name = "incomplete axe head"
	icon_state = "hot_axehead"
	spawn_item = /obj/item/forging/complete/axe

/obj/item/forging/incomplete/hammer
	name = "incomplete hammer head"
	icon_state = "hot_hammerhead"
	spawn_item = /obj/item/forging/complete/hammer

/obj/item/forging/incomplete/pickaxe
	name = "incomplete pickaxe head"
	icon_state = "hot_pickaxehead"
	spawn_item = /obj/item/forging/complete/pickaxe

/obj/item/forging/incomplete/shovel
	name = "incomplete shovel head"
	icon_state = "hot_shovelhead"
	spawn_item = /obj/item/forging/complete/shovel

/obj/item/forging/incomplete/arrowhead
	name = "incomplete arrowhead"
	icon_state = "hot_arrowhead"
	completion_quality_points = 12
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/arrowhead

/obj/item/forging/incomplete/rail_nail
	name = "incomplete rail nail"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_nail"
	completion_quality_points = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/rail_nail
	break_on_early_quench = TRUE

/obj/item/forging/incomplete/rail_cart
	name = "incomplete rail cart"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_cart"
	spawn_item = /obj/vehicle/ridden/rail_cart
	break_on_early_quench = TRUE

//"complete" pre-complete items
/obj/item/forging/complete
	///the path of the item that will be created
	var/spawning_item
	///how many perfect hits did we get, out of the max?
	var/perfect_ratio = 0
	///when this was worked at an anvil, how many hits were actually applied of the max?
	var/hammer_completion_amount = 0
	//because who doesn't want to have a plasma sword?
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR
	///does it cut the user's hand when used as a weapon?
	var/double_edged_damage = 0
	var/has_reagent_component = TRUE

/obj/item/forging/complete/Initialize(mapload)
	. = ..()
	if(has_reagent_component)
		AddComponent(/datum/component/reagent_imbued)

/obj/item/forging/complete/examine(mob/user)
	. = ..()
	if(spawning_item)
		. += span_notice("<br>In order to finish this item, a workbench will be necessary!")

/obj/item/forging/complete/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(double_edged_damage <= 0)
		return

	if(!iscarbon(user) || !user.is_holding(src))
		return

	var/mob/living/carbon/jab = user
	if(jab.get_all_covered_flags() & HANDS)
		return

	to_chat(user, span_warning("[src] cuts into your hand!"))
	jab.apply_damage(double_edged_damage * hammer_completion_amount, BRUTE, user.get_active_hand(), attacking_item = src)

/obj/item/forging/complete/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "tongs are full already!")
		return
	forceMove(tool)
	tool.icon_state = "tong_full"



/obj/item/forging/complete/chain
	name = "chain"
	desc = "A singular chain, best used in combination with multiple chains."
	icon_state = "chain"

/obj/item/forging/complete/plate
	name = "plate"
	desc = "A plate, best used in combination with multiple plates."
	icon_state = "plate"

/obj/item/forging/complete/sword
	name = "sword blade"
	desc = "A sword blade, ready to get some wood for completion."
	icon_state = "blade"
	spawning_item = /obj/item/forging/reagent_weapon/sword
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/katana
	name = "katana blade"
	desc = "A katana blade, ready to get some wood for completion."
	icon_state = "katanablade"
	spawning_item = /obj/item/forging/reagent_weapon/katana
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/rapier
	name = "rapier blade"
	desc = "A rapier blade, ready to get some wood for completion."
	icon_state = "rapierblade"
	spawning_item = /obj/item/forging/reagent_weapon/rapier
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/dagger
	name = "dagger blade"
	desc = "A dagger blade, ready to get some wood for completion."
	icon_state = "daggerblade"
	spawning_item = /obj/item/forging/reagent_weapon/dagger
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/staff
	name = "staff head"
	desc = "A staff head, ready to get some wood for completion."
	icon_state = "staffhead"
	spawning_item = /obj/item/forging/reagent_weapon/staff

/obj/item/forging/complete/spear
	name = "spear head"
	desc = "A spear head, ready to get some wood for completion."
	icon_state = "spearhead"
	spawning_item = /obj/item/forging/reagent_weapon/spear
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/axe
	name = "axe head"
	desc = "An axe head, ready to get some wood for completion."
	icon_state = "axehead"
	spawning_item = /obj/item/forging/reagent_weapon/axe
	force = 5

/obj/item/forging/complete/hammer
	name = "hammer head"
	desc = "A hammer head, ready to get some wood for completion."
	icon_state = "hammerhead"
	spawning_item = /obj/item/forging/reagent_weapon/hammer
	force = 5

/obj/item/forging/complete/pickaxe
	name = "pickaxe head"
	desc = "A pickaxe head, ready to get some wood for completion."
	icon_state = "pickaxehead"
	spawning_item = /obj/item/pickaxe/reagent_weapon
	force = 5

/obj/item/forging/complete/shovel
	name = "shovel head"
	desc = "A shovel head, ready to get some wood for completion."
	icon_state = "shovelhead"
	spawning_item = /obj/item/shovel/reagent_weapon

/obj/item/forging/complete/arrowhead
	name = "arrowhead"
	desc = "An arrowhead, ready to get some wood for completion."
	icon_state = "arrowhead"
	spawning_item = /obj/item/arrow_spawner
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/rail_nail
	name = "rail nail"
	desc = "A nail, ready to be used with some wood in order to make tracks."
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "nail"
	spawning_item = /obj/item/stack/rail_track/ten
	force = 3

/obj/item/forging/coil
	name = "coil"
	desc = "A simple coil, comprised of coiled iron rods."
	icon_state = "coil"

/obj/item/forging/incomplete_bow
	name = "incomplete longbow"
	desc = "A wooden bow that has yet to be strung."
	icon_state = "nostring_bow"

/obj/item/forging/incomplete_bow/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/weaponcrafting/silkstring))
		new /obj/item/gun/ballistic/bow/longbow(get_turf(src))
		qdel(attacking_item)
		qdel(src)
		return
	return ..()

/obj/item/arrow_spawner
	name = "arrow spawner"
	desc = "You shouldn't see this."
	/// the amount of arrows that are spawned from the spawner
	var/spawning_amount = 8

/obj/item/arrow_spawner/Initialize(mapload)
	. = ..()
	var/turf/src_turf = get_turf(src)
	for(var/i in 1 to spawning_amount)
		new /obj/item/ammo_casing/arrow/(src_turf)
	qdel(src)

/obj/item/stock_parts/power_store/cell/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/forging/coil))
		var/obj/item/stock_parts/power_store/cell/crank/new_crank = new(get_turf(src))
		new_crank.maxcharge = maxcharge
		new_crank.charge = charge
		qdel(attacking_item)
		qdel(src)
		return
	return ..()

/obj/item/stack/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(amount < 1)
		user.balloon_alert(user, "not enough material in the stack!")
		return FALSE
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "tongs are full already!")
		return FALSE
	if(!material_type && !custom_materials)
		user.balloon_alert(user, "invalid material!")
		return

	if(amount == 1)
		forceMove(tool)
	else
		var/obj/item/stack/newstack = split_stack(1)
		newstack.forceMove(tool)
	tool.icon_state = "tong_full"

/obj/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents))
		user.balloon_alert(user, "tongs are full already!")
		return FALSE
	if(skyrat_obj_flags & ANVIL_REPAIR)
		forceMove(tool)
		tool.icon_state = "tong_full"

/obj/item/empty_circuit
	name = "empty circuit"
	desc = "This is a circuit that is close to being finished; it just requires some forethought and gold."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	icon_state = "circuit"
	var/static/recycleable_circuits = typecacheof(list(
		/obj/item/electronics/airalarm,
		/obj/item/electronics/firealarm,
		/obj/item/electronics/apc,
	))//A typecache of circuits consumable for material

/obj/item/empty_circuit/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/gold))
		var/obj/item/stack/attacking_stack = attacking_item

		if(user.mind.get_skill_level(/datum/skill/research) < SKILL_LEVEL_JOURNEYMAN)
			to_chat(user, span_warning("You are not skilled enough in research to create a circuit!"))
			return

		var/choice = tgui_input_list(user, "Which circuit are you thinking about?", "Circuit Creation", recycleable_circuits)
		if(!choice)
			to_chat(user, span_notice("You decide against creating the circuit..."))
			return

		if(!do_after(user, 5 SECONDS, src))
			to_chat(user, span_warning("You moved around, destroying the circuit!"))
			qdel(src)
			return

		if(!attacking_stack.use(1))
			to_chat(user, span_warning("You weren't able to use the gold, destroying the circuit!"))
			qdel(src)
			return

		new choice(get_turf(src))
		qdel(src)
		return

	return ..()
