/datum/component/changeling_zombie_infection
	var/zombified = FALSE
	var/obj/item/melee/arm_blade_zombie/arm_blade
	var/obj/item/clothing/suit/armor/changeling_zombie/armor
	var/revival_timer

/datum/component/changeling_zombie_infection/Initialize()
	. = ..()
	if(!ishuman(parent) || HAS_TRAIT(parent,TRAIT_UNHUSKABLE) || HAS_TRAIT(parent,TRAIT_GENELESS))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/carbon/human/host = parent

	if(!host.dna)
		return COMPONENT_INCOMPATIBLE

	var/datum/species/host_species = host.dna.species

	if(host_species.no_equip_flags & ITEM_SLOT_OCLOTHING)
		return COMPONENT_INCOMPATIBLE

	if(length(host_species.custom_worn_icons) && host_species.custom_worn_icons[LOADOUT_ITEM_SUIT])
		return COMPONENT_INCOMPATIBLE

	START_PROCESSING(SSobj, src)

/datum/component/changeling_zombie_infection/Destroy(force, silent)

	QDEL_NULL(arm_blade)
	QDEL_NULL(armor)

	if(revival_timer)
		deltimer(revival_timer)

	STOP_PROCESSING(SSobj, src)

	if(parent)
		var/mob/living/carbon/human/host = parent
		UnregisterSignal(host, COMSIG_LIVING_DEATH)
		if(zombified)
			playsound(parent, 'sound/magic/demon_consume.ogg', 50, TRUE)
		REMOVE_TRAITS_IN(host,CHANGELING_ZOMBIE_TRAIT)

	zombified = FALSE

	. = ..()

/datum/component/changeling_zombie_infection/process(seconds_per_tick)

	var/mob/living/carbon/human/host = parent

	if(zombified)
		var/list/healing_options = list()
		if(host.getBruteLoss() > 0)
			healing_options += BRUTE
		if(host.getFireLoss() > 0)
			healing_options += BURN
		if(host.getToxLoss() > 0)
			healing_options += TOX
		if(host.getOxyLoss() > 0)
			healing_options += OXY
		if(length(healing_options))
			host.heal_damage_type(CHANGELING_ZOMBIE_PASSIVE_HEALING,pick(healing_options))
	else
		var/current_toxin_damage = host.getToxLoss()
		var/tox_to_remove = round(CHANGELING_ZOMBIE_BASE_TOXINS_PER_SECOND + current_toxin_damage*CHANGELING_ZOMBIE_TOXINS_PER_1_TOXIN_PER_SECOND,1)
		host.adjustToxLoss(seconds_per_tick * tox_to_remove)
		if(SPT_PROB(8, seconds_per_tick))
			if(current_toxin_damage > 50)
				var/obj/item/bodypart/wound_area = host.get_bodypart(pick(BODY_ZONE_L_ARM,BODY_ZONE_R_ARM))
				if(wound_area)
					var/datum/wound/slash/flesh/moderate/rotting_wound = new
					rotting_wound.apply_wound(wound_area)
					host.visible_message(
						span_danger("[host]\s [wound_area] twists and contorts violently, like something is trying to break free!"),
						span_userdanger("Your [wound_area] twists and contorts violently! What's going on?!"),
						span_hear("You hear flesh breaking!"),
						COMBAT_MESSAGE_RANGE
					)
					host.emote("scream")
				else
					host.emote("groan")
			else if(current_toxin_damage > 25)
				host.visible_message(
					span_warning("[host] doesn't look too good..."),
					span_warning("You don't feel too good...")
				)
				host.emote("cough")




/datum/component/changeling_zombie_infection/proc/make_zombie()

	if(zombified)
		return FALSE

	if(revival_timer)
		deltimer(revival_timer)

	var/mob/living/carbon/human/host = parent

	if(!host.mind)
		var/mob/canidate = SSpolling.poll_ghosts_for_target(
			"Do you want to play as a changeling zombie ([host.name])?", checked_target = host)
		if(istype(canidate))
			host.key = canidate.key
	else
		host.grab_ghost()

	to_chat(host, span_notice("You feel an itching, both inside and outside as your tissues knit and reknit."))

	host.revive(TRUE, TRUE)

	host.add_traits(
		list(
			TRAIT_HANDS_BLOCKED,
			TRAIT_ILLITERATE,
			TRAIT_HUSK,
			TRAIT_CHUNKYFINGERS,
			TRAIT_DISCOORDINATED_TOOL_USER,
			TRAIT_IGNOREDAMAGESLOWDOWN,
			TRAIT_NO_TRANSFORM,
			TRAIT_AIRLOCK_SHOCKIMMUNE,
			TRAIT_RESISTCOLD,
			TRAIT_RESISTLOWPRESSURE,
			TRAIT_NOHUNGER,
			TRAIT_NO_ZOMBIFY,
			TRAIT_TOXIMMUNE,
			TRAIT_THERMAL_VISION,
			TRAIT_STRONG_GRABBER,
			TRAIT_NEARSIGHTED_CORRECTED,
			TRAIT_TUMOR_SUPPRESSED,
			TRAIT_RDS_SUPPRESSED,
			TRAIT_SNEAK,
			TRAIT_SPACEBREATHING
		),
		CHANGELING_ZOMBIE_TRAIT
	)

	host.do_jitter_animation(10 SECONDS)
	playsound(host, 'sound/hallucinations/far_noise.ogg', 50, TRUE)

	host.dropItemToGround(host.get_active_held_item())
	host.dropItemToGround(host.get_inactive_held_item())

	var/found_right_hand = host.get_empty_held_index_for_side(RIGHT_HANDS)
	if(found_right_hand)
		arm_blade = new(host.loc)
		ADD_TRAIT(arm_blade, TRAIT_NODROP, CHANGELING_ZOMBIE_TRAIT)
		host.put_in_hand(arm_blade,found_right_hand)

	if(host.wear_suit)
		host.temporarilyRemoveItemFromInventory(host.wear_suit,TRUE)
	armor = new(host.loc)
	ADD_TRAIT(armor, TRAIT_NODROP, CHANGELING_ZOMBIE_TRAIT)
	host.equip_to_slot_if_possible(armor,ITEM_SLOT_OCLOTHING,TRUE,TRUE,TRUE)

	//var/found_left_hand = host.get_empty_held_index_for_side(LEFT_HANDS)

	host.SetKnockdown(0)
	host.setStaminaLoss(0)
	host.set_resting(FALSE)
	host.reagents.add_reagent(/datum/reagent/medicine/changelingadrenaline, 4)
	host.reagents.add_reagent(/datum/reagent/medicine/changelinghaste, 3)

	RegisterSignal(host, COMSIG_LIVING_DEATH, PROC_REF(on_owner_died))

	zombified = TRUE

	return TRUE

/datum/component/changeling_zombie_infection/proc/on_owner_died()
	//The only cure is death.
	if(zombified)
		qdel(src)
	else if(!revival_timer)
		revival_timer = addtimer(CALLBACK(src, PROC_REF(make_zombie), parent), CHANGELING_ZOMBIE_REVIVAL_TIME, TIMER_STOPPABLE)
