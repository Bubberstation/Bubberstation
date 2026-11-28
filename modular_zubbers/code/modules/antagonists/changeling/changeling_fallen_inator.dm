/obj/machinery/changeling_discombobulator
	name = "\improper Changeling discombobulator"
	desc = "Blasts its victim with so much bioscrambling radiation that it destroys overtly-complex genomes, primarily those of Changelings."

	icon = 'modular_zubbers/icons/obj/machines/changeling_discombobulator.dmi'
	icon_state = "discombobulator"
	occupant_typecache = list(/mob/living/carbon) //todo make occupant_typecache per type
	state_open = TRUE
	circuit = /obj/item/circuitboard/machine/changeling_discombobulator
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 3

	//bioscrambler that we are using to de-ling the lings
	//var/obj/item/assembly/signaler/anomaly/bioscrambler/bioscrambler
	var/delay_to_de_ling = 5 SECONDS

/obj/machinery/changeling_discombobulator/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/machinery/changeling_discombobulator/examine(mob/user)
	. = ..()
	//. += span_warning("[src] requires a bioscrambler anomaly to function!")

/obj/machinery/changeling_discombobulator/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	context[SCREENTIP_CONTEXT_LMB] = "[state_open ? "Close" : "Open"] machine"

/obj/machinery/changeling_discombobulator/update_icon_state()
	icon_state = initial(icon_state)
	if(state_open)
		icon_state += "_open"
	else if(occupant)
		icon_state += "_occupied"
	return ..()

/obj/machinery/changeling_discombobulator/update_overlays()
	. = ..()
	//if(!isnull(bioscrambler))
	. += "bioscrambler_overlay"

/obj/machinery/changeling_discombobulator/interact(mob/user)
	. = ..()
	/*if(isnull(bioscrambler))
		to_chat(user,span_warning("[src] requires a bioscrambler anomaly core to function."))
		return*/
	playsound(src, 'sound/machines/click.ogg', 50)
	toggle_open()

/obj/machinery/changeling_discombobulator/proc/toggle_open(mob/user)
	state_open ? close_machine() : open_machine()

/*
/obj/machinery/changeling_discombobulator/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool,/obj/item/assembly/signaler/anomaly/bioscrambler))
		return NONE
	if(!isnull(bioscrambler))
		to_chat(user,span_notice("There's already a bioscrambler inside."))
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	bioscrambler = tool
	to_chat(user,span_notice("You insert the bioscrambler core."))
	update_appearance()
4	return ITEM_INTERACT_SUCCESS*/

/obj/machinery/changeling_discombobulator/close_machine(atom/movable/target, density_to_set = TRUE)
	. = ..()
	if(occupant)
		say("Preparing anti-Changeling radio-biotic pulse; ETA 8 seconds.")
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/machinery/changeling_discombobulator, try_de_lingify)), 8 SECONDS)

/*
/obj/machinery/changeling_discombobulator/dump_contents()
	. = ..()
	bioscrambler = null
	update_appearance()

/obj/machinery/changeling_discombobulator/dump_inventory_contents(list/subset = null)
	// Don't drop the bioscrambler, it's directly inserted into the machine.
	// dump_contents() will drop everything including the skillchip as an alternative to this.
	return ..(contents - bioscrambler)
*/

/obj/machinery/changeling_discombobulator/proc/try_de_lingify()
	if(isnull(occupant))
		return

	var/output_message
	if(!use_energy(active_power_usage))
		output_message = "Procedure unsuccessful; not enough power. Aborting..."
	else
		var/mob/living/victim_living = occupant
		var/datum/antagonist/changeling/target_ling = IS_CHANGELING(victim_living)
		if(!isnull(target_ling))//If the target was a changeling, suck out their extra juice and objective points!
			var/list/copied_objectives = target_ling.objectives.Copy()
			victim_living.mind.remove_antag_datum(/datum/antagonist/changeling)
			var/datum/antagonist/fallen_changeling/fallen = victim_living.mind.add_antag_datum(/datum/antagonist/fallen_changeling)
			fallen.objectives = copied_objectives

		output_message = "Procedure successful! Releasing occupant..."

		//You probably don't want to be stuck in this, regardless of who you are
		playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
		if(istype(victim_living))
			victim_living.apply_damage(15, BURN, BODY_ZONE_HEAD, wound_bonus = 7)
			victim_living.apply_damage(15, BURN, BODY_ZONE_CHEST, wound_bonus = 21)
			victim_living.apply_damage(15, BURN, BODY_ZONE_L_LEG, wound_bonus = 14)
			victim_living.apply_damage(15, BURN, BODY_ZONE_R_LEG, wound_bonus = 14)
			victim_living.apply_damage(15, BURN, BODY_ZONE_L_ARM, wound_bonus = 14)
			victim_living.apply_damage(15, BURN, BODY_ZONE_R_ARM, wound_bonus = 14)

			victim_living.Knockdown(15 SECONDS)

		SSradiation.irradiate(occupant)
		//overkill solutions on changeling simplemobs
		if(istype(victim_living, /mob/living/basic/headslug) \
			|| istype(victim_living, /mob/living/simple_animal/hostile/true_changeling) \
			|| istype(victim_living, /mob/living/basic/boss/thing))
			output_message = "Procedure successful! Eliminating excessive biotic hazard substance..."
			victim_living.gib()

	if(!isnull(output_message))
		say(output_message)
	open_machine()

/obj/item/circuitboard/machine/changeling_discombobulator
	name = "Changeling discombobulator"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/changeling_discombobulator
	req_components = list(
		/datum/stock_part/micro_laser = 6,
		/obj/item/stock_parts/power_store/cell = 1,
		/datum/stock_part/capacitor = 1)

/datum/design/board/changeling_discombobulator
	name = "Machine Design (Changeling discombobulator)"
	desc = "The circuit board used to build machines to destroy changelings."
	build_path = /obj/item/circuitboard/machine/changeling_discombobulator
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_GENETICS)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_SCIENCE
