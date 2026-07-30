//incomplete pre-complete items
/obj/item/forging/incomplete
	name = "incomplete forging item"
	desc = "you shouldn't be seeing this!"
	abstract_type = /obj/item/forging/incomplete

	///the quality points required for it to be considered usable for crafting
	var/completion_quality_points = 40
	///the required time before each strike to prevent spamming
	var/average_wait = 1 SECONDS
	///the bad hits required for it to break; exceeding this will break the item
	var/bad_hit_maximum = 5
	///maximum number of perfect hits before perfect hits no longer improve the quality
	var/max_perfect_hits = 20

	///the path of the item that will be spawned upon completion
	var/spawn_item
	///does this item break if it's not finished hammering when it's quenched?
	//this is mostly for working on stuff that has no effect based on completion amount, preventing cheesing
	var/break_on_early_quench = FALSE
	//because who doesn't want to have a plasma sword?
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR

/obj/item/forging/incomplete/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/forge_smithable, completion_quality_points, TRUE, max_perfect_hits, bad_hit_maximum, average_wait, CALLBACK(src, TYPE_PROC_REF(/obj/item/forging/incomplete, quench_item)), color = "")// TYPE_PROC_REF(/obj/item/forging/incomplete/, quench_item))

/obj/item/forging/incomplete/proc/quench_item(datum/reagents/dunk_reagents, dunk_object, mob/living/quencher)
	SIGNAL_HANDLER

	var/datum/component/forge_smithable/forge_component = GetComponent(/datum/component/forge_smithable)
	if(forge_component.is_finished_smithing())
		to_chat(quencher, span_notice("You cool down [src]."))
		quencher.mind.adjust_experience(/datum/skill/smithing, 5)
	else
		if(break_on_early_quench)
			to_chat(quencher, span_warning("The [src] breaks from the thermal shock! Metalworking this type of object requires it to be hammered into completion."))
			qdel(src)
			return
		else
			to_chat(quencher, span_warning("You cool down [src]. You're not sure if it was ready yet..."))

	var/obj/spawned_obj = new spawn_item(get_turf(dunk_object))
	if(custom_materials)
		spawned_obj.set_custom_materials(custom_materials, 1) //lets set its material

	if(istype(spawned_obj, /obj/item/forging/complete))
		var/obj/item/forging/complete/complete_spawned = spawned_obj
		complete_spawned.perfect_ratio = forge_component.get_perfect_ratio()
		complete_spawned.hammer_completion_amount = forge_component.get_completion_ratio()

	var/datum/component/reagent_imbued/new_reagent_component = spawned_obj.GetComponent(/datum/component/reagent_imbued)
	if(!isnull(new_reagent_component) && USER_CAN_REAGENT_IMBUE(quencher))
		new_reagent_component.set_reagent_imbue(dunk_reagents, FALSE, TRUE)
		to_chat(quencher, span_notice("The [spawned_obj] is imbued with reagents."))

	qdel(src)
	return spawned_obj

/obj/item/forging/incomplete/tong_act(mob/living/user, obj/item/tool)
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "tongs are full already!")
		return
	forceMove(tool)
	tool.icon_state = "tong_full"


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
	if(!hand_protected)
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
	completion_quality_points = 40
	max_perfect_hits = 15
	spawn_item = /obj/item/forging/complete/chain
	break_on_early_quench = TRUE
	desc = "A length of chain. Used in crafting recipes at your crafting table."

/obj/item/forging/incomplete/plate
	name = "incomplete plate"
	icon_state = "hot_plate"
	completion_quality_points = 40
	max_perfect_hits = 15
	spawn_item = /obj/item/forging/complete/plate
	desc = "A sturdy plate of material. Used in many crafting recipies at your crafting table, most notably that of armor."

/obj/item/forging/incomplete/sword
	name = "incomplete sword blade"
	icon_state = "hot_blade"
	spawn_item = /obj/item/forging/complete/sword
	desc = "A longsword. Practically requires a two-handed stance for effective use, but is very adept at blocking strikes."

/obj/item/forging/incomplete/katana
	name = "incomplete katana blade"
	icon_state = "hot_katanablade"
	spawn_item = /obj/item/forging/complete/katana
	desc = "A katana blade. Unwieldy if not carried with both hands, but careful metalworking makes it cut through armor more effectively."

/obj/item/forging/incomplete/rapier
	name = "incomplete rapier blade"
	icon_state = "hot_rapierblade"
	spawn_item = /obj/item/forging/complete/rapier
	desc = "A rapier blade. A classical go-to self-defense weapon, it requires only one hand to use."

/obj/item/forging/incomplete/dagger
	name = "incomplete dagger blade"
	icon_state = "hot_daggerblade"
	completion_quality_points = 22
	max_perfect_hits = 10
	spawn_item = /obj/item/forging/complete/dagger
	desc = "A small, sleek dagger. Can be easily hid, and can critially-strike vulnerable opponents."

/obj/item/forging/incomplete/staff
	name = "incomplete staff head"
	icon_state = "hot_staffhead"
	spawn_item = /obj/item/forging/complete/staff
	desc = "A staff that can be imbued with reagents. Not very useful in direct combat."

/obj/item/forging/incomplete/spear
	name = "incomplete spear head"
	completion_quality_points = 18 ///crazy low completion required (spears are historically an easy weapon to make that are used for widespread arming)
	max_perfect_hits = 8
	icon_state = "hot_spearhead"
	spawn_item = /obj/item/forging/complete/spear
	desc = "A short spearhead. The weapon of commoners, it strikes from further away and can be made extremely quickly compared to other weapons."

/obj/item/forging/incomplete/axe
	name = "incomplete axe head"
	icon_state = "hot_axehead"
	completion_quality_points = 22
	max_perfect_hits = 14
	spawn_item = /obj/item/forging/complete/axe
	desc = "A heavy axehead. Hits from this can potentially bypass shields and other forms of protection."

/obj/item/forging/incomplete/hammer
	name = "incomplete hammer head"
	icon_state = "hot_hammerhead"
	spawn_item = /obj/item/forging/complete/hammer
	desc = "A heavy hammerhead. Can be used like a forging hammer -- and a two-handed stance can bust through doors."

/obj/item/forging/incomplete/pickaxe
	name = "incomplete pickaxe head"
	icon_state = "hot_pickaxehead"
	spawn_item = /obj/item/forging/complete/pickaxe
	desc = "A pickaxe. Used for digging."

/obj/item/forging/incomplete/shovel
	name = "incomplete shovel head"
	icon_state = "hot_shovelhead"
	spawn_item = /obj/item/forging/complete/shovel
	desc = "A shovel. Used for digging."

/obj/item/forging/incomplete/arrowhead
	name = "incomplete arrowhead"
	icon_state = "hot_arrowhead"
	completion_quality_points = 12
	spawn_item = /obj/item/forging/complete/arrowhead
	desc = "A number of small arrowheads, used to create arrows."

/obj/item/forging/incomplete/revolver_cylinder
	name = "incomplete revolver cylinder"
	icon_state = "hot_revolver_cylinder"
	completion_quality_points = 60
	max_perfect_hits = 70
	spawn_item = /obj/item/forging/complete/revolver_cylinder
	desc = "The cylinder of a classical single-action revolver."

/obj/item/forging/incomplete/revolver_frame
	name = "incomplete revolver frame"
	icon_state = "hot_revolver_frame"
	completion_quality_points = 90
	max_perfect_hits = 110
	spawn_item = /obj/item/forging/complete/revolver_frame
	desc = "The frame of a classical single-action revolver."

/obj/item/forging/incomplete/rail_nail
	name = "incomplete rail nail"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_nail"
	completion_quality_points = 10
	spawn_item = /obj/item/forging/complete/rail_nail
	break_on_early_quench = TRUE
	desc = "A rail nail used to build rail tracks."

/obj/item/forging/incomplete/rail_cart
	name = "incomplete rail cart"
	icon = 'modular_skyrat/modules/ashwalkers/icons/railroad.dmi'
	icon_state = "hot_cart"
	spawn_item = /obj/vehicle/ridden/rail_cart
	break_on_early_quench = TRUE
	desc = "A minecart that can be ridden along rail tracks."

//"complete" pre-complete items
/obj/item/forging/complete
	abstract_type = /obj/item/forging/complete
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
	spawning_item = /obj/item/melee/forged_reagent_weapon/sword
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/katana
	name = "katana blade"
	desc = "A katana blade, ready to get some wood for completion."
	icon_state = "katanablade"
	spawning_item = /obj/item/melee/forged_reagent_weapon/katana
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/rapier
	name = "rapier blade"
	desc = "A rapier blade, ready to get some wood for completion."
	icon_state = "rapierblade"
	spawning_item = /obj/item/melee/forged_reagent_weapon/rapier
	force = 5
	double_edged_damage = 3

/obj/item/forging/complete/dagger
	name = "dagger blade"
	desc = "A dagger blade, ready to get some wood for completion."
	icon_state = "daggerblade"
	spawning_item = /obj/item/melee/forged_reagent_weapon/dagger
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/staff
	name = "staff head"
	desc = "A staff head, ready to get some wood for completion."
	icon_state = "staffhead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/staff

/obj/item/forging/complete/spear
	name = "spear head"
	desc = "A spear head, ready to get some wood for completion."
	icon_state = "spearhead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/spear
	force = 3
	double_edged_damage = 2

/obj/item/forging/complete/axe
	name = "axe head"
	desc = "An axe head, ready to get some wood for completion."
	icon_state = "axehead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/axe
	force = 5

/obj/item/forging/complete/hammer
	name = "hammer head"
	desc = "A hammer head, ready to get some wood for completion."
	icon_state = "hammerhead"
	spawning_item = /obj/item/melee/forged_reagent_weapon/hammer
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

/obj/item/forging/complete/revolver_cylinder
	name = "single-action revolver cylinder"
	icon_state = "revolver_cylinder"

/obj/item/forging/complete/revolver_frame
	name = "single-action revolver frame"
	icon_state = "revolver_frame"

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
	name = "arrows"
	desc = "You shouldn't see this."
	/// the amount of arrows that are spawned from the spawner
	var/spawning_amount = 4

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
	if(amount < 1)
		user.balloon_alert(user, "not enough material in the stack!")
		return FALSE
	if(length(tool.contents) > 0)
		user.balloon_alert(user, "tongs are full already!")
		return FALSE
	if(!material_type && !custom_materials)
		user.balloon_alert(user, "invalid material!")
		return

	var/obj/item/stack/stack_to_move
	if(amount == 1)
		stack_to_move = src
	else
		stack_to_move = split_stack(1)

	if(!isnull(stack_to_move))
		stack_to_move.forceMove(tool)
		user.balloon_alert(user, "took one")
		tool.icon_state = "tong_full"
	else
		stack_trace("[src] was grabbed by [tool] and couldn't pull one sheet!")

/obj/tong_act(mob/living/user, obj/item/tool)
	. = ..()
	if(length(tool.contents))
		user.balloon_alert(user, "tongs are full already!")
		return FALSE
	if(!isnull(GetComponent(/datum/component/forge_smithable/)) || !isnull(GetComponent(/datum/component/reagent_imbued)))
		forceMove(tool)
		tool.icon_state = "tong_full"
		user.balloon_alert(user, "took [src]")

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

/obj/item/
