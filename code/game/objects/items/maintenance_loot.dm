//The items defined in this file are intended be scarce maintenance loot items some of these items are used as a non-renewable resource in crafting or ghetto chem.
//Exercise good judgement and don't add these to a lathe willy nilly.

//Saw-tier bulky & blunt weapon. A decent bone breaker. Source of lead reagent.
//Add lead material to this once implemented.
/obj/item/lead_pipe
	name = "lead pipe"
	icon = 'icons/obj/maintenance_loot.dmi'
	icon_state = "lead_pipe"
	inhand_icon_state = "lead_pipe"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	//wow, lore
	desc = "A hefty lead pipe.\nLead is an uncommon sight in this sector after being phased out due to employee health concerns. \
	\nThose of a more cynical disposition have claimed that the NT lead ban is a scheme to prevent diversion to Syndicate ammunition factories."
	force = 15
	throwforce = 12
	throw_range = 4
	w_class = WEIGHT_CLASS_BULKY
	wound_bonus = 20
	demolition_mod = 1.25
	pickup_sound = 'sound/items/handling/lead_pipe/lead_pipe_pickup.ogg'
	drop_sound = 'sound/items/handling/materials/metal_drop.ogg'
	throw_drop_sound = 'sound/items/handling/lead_pipe/lead_pipe_drop.ogg'
	hitsound = 'sound/items/lead_pipe_hit.ogg'

/obj/item/lead_pipe/grind_results()
	return list(/datum/reagent/lead = 20)

//A good battery early in the shift. Source of lead & sulfuric acid reagents.
//Add lead material to this once implemented.
/obj/item/stock_parts/power_store/cell/lead
	name = "lead-acid battery"
	desc = "A primitive battery. It is quite large and feels unexpectedly heavy."
	icon = 'icons/obj/maintenance_loot.dmi'
	icon_state = "lead_battery"
	force = 10 // double the force of a normal cell
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	maxcharge = STANDARD_CELL_CHARGE * 100 // megawatt capacity fixed
	chargerate = STANDARD_CELL_RATE * 0.2 // charging reduced from 70% reduction to 80%
	emp_damage_modifier = 5 // slight increase, 4 to 5.
	charge_light_type = null
	connector_type = "leadacid"

/obj/item/stock_parts/power_store/cell/lead/grind_results()
	return list(/datum/reagent/lead = 15, /datum/reagent/toxin/acid = 15, /datum/reagent/water = 20)

//starts partially discharged
/obj/item/stock_parts/power_store/cell/lead/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	var/initial_percent = rand(20, 50) / 100 // 200kJ to 500kJ
	charge = initial_percent * maxcharge
	ADD_TRAIT(src, TRAIT_FISHING_BAIT, INNATE_TRAIT)
	AddComponent(/datum/component/loads_avatar_gear, \
		load_callback = CALLBACK(src, PROC_REF(shockingly_improve_avatar)), \
	)

// Give our owner shock touch when entering the digital realm
/obj/item/stock_parts/power_store/cell/lead/proc/shockingly_improve_avatar(mob/living/carbon/human/neo, mob/living/carbon/human/avatar, domain_flags)
	if(domain_flags & DOMAIN_FORBIDS_ABILITIES)
		return BITRUNNER_GEAR_LOAD_BLOCKED

	if(!avatar.can_mutate())
		return BITRUNNER_GEAR_LOAD_FAILED

	if(avatar.dna.mutation_in_sequence(/datum/mutation/shock))
		avatar.dna.activate_mutation(/datum/mutation/shock)
	else
		avatar.dna.add_mutation(/datum/mutation/shock, MUTATION_SOURCE_MUTATOR)

// gote addition
/obj/item/stock_parts/power_store/battery/lead
	name = "lead-acid cell array"
	desc = "a heavy array of lead-acid batteries."
	icon = 'icons/obj/maintenance_loot.dmi'
	icon_state = "lead_battery"
	force = 10 // double the force of a normal cell
	throwforce = 10
	w_class = WEIGHT_CLASS_BULKY
	maxcharge = STANDARD_BATTERY_CHARGE * 100 // FAT fucking megacell.
	chargerate = STANDARD_BATTERY_RATE * 0.05 // basically unable to do anything but tricke charge in/out, though.
	emp_damage_modifier = 10 // its literally multiple car batteries wired together
	charge_light_type = null
	connector_type = "leadacid"

/obj/item/stock_parts/power_store/battery/lead/grind_results()
	return list(/datum/reagent/lead = 80, /datum/reagent/copper = 25, /datum/reagent/iron = 20) // the cells have been dried, no more soggy battery

/obj/item/stock_parts/power_store/battery/lead/Initialize(mapload)
	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	var/initial_percent = rand(20, 50) / 100 // 200kJ to 500kJ
	charge = initial_percent * maxcharge
